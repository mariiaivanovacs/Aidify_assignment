// PASSWORD HASHING: BCrypt is used to hash passwords before saving
// and verify passwords during login.

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net.Http;
using Newtonsoft.Json.Linq;

namespace Aidify_assigment
{
    public class AuthService
    {
        private readonly UserRepository _repo = new UserRepository();

        public UserDto Authenticate(string email, string password, string ipAddress)
        {
            var user = _repo.GetByEmail(email);

            if (user == null)
            {
                _repo.LogLoginAttempt(null, false, ipAddress);
                return null;
            }

            // If account is disabled, return the user so Login.aspx.cs can show disabled message.
            // Do not log it as failed password because the account exists but is blocked.
            if (!user.IsActive)
            {
                return user;
            }

            bool ok = BCrypt.Net.BCrypt.Verify(password, user.PasswordHash);

            _repo.LogLoginAttempt(user.UserId, ok, ipAddress);

            if (!ok)
                return null;

            return user;
        }

        public int RegisterUser(string fullName, string email, string password)
        {
            if (_repo.EmailExists(email))
                throw new InvalidOperationException("An account with that email already exists.");

            string passwordHash = BCrypt.Net.BCrypt.HashPassword(password, 11);

            return _repo.Insert(fullName, email, passwordHash, Constants.RoleLearner);
        }

        public bool IsAccountLocked(string email)
        {
            return _repo.GetRecentFailCount(email, withinMinutes: 5) >= 5;
        }

        public bool VerifyRecaptcha(string responseToken)
        {
            string secret = ConfigurationManager.AppSettings["RecaptchaSecretKey"] ?? "";

            if (string.IsNullOrEmpty(secret) || secret.StartsWith("YOUR_"))
                return true;

            if (string.IsNullOrWhiteSpace(responseToken))
                return false;

            try
            {
                using (var http = new HttpClient())
                {
                    var resp = http.PostAsync(
                        "https://www.google.com/recaptcha/api/siteverify",
                        new FormUrlEncodedContent(new[]
                        {
                            new KeyValuePair<string, string>("secret", secret),
                            new KeyValuePair<string, string>("response", responseToken)
                        })).GetAwaiter().GetResult();

                    var json = resp.Content.ReadAsStringAsync().GetAwaiter().GetResult();
                    var parsed = Newtonsoft.Json.Linq.JObject.Parse(json);

                    return parsed["success"]?.Value<bool>() ?? false;
                }
            }
            catch
            {
                return true;
            }
        }

        public string CreateEmailToken(int userId, string purpose, int expiryHours = 24)
        {
            string token = Guid.NewGuid().ToString("N");

            _repo.InsertEmailToken(
                userId,
                token,
                purpose,
                DateTime.UtcNow.AddHours(expiryHours)
            );

            return token;
        }

        public bool ConfirmEmail(string token)
        {
            var row = _repo.GetValidEmailToken(token, "Confirm");

            if (row == null)
                return false;

            _repo.ConfirmEmail(Convert.ToInt32(row["UserId"]));
            _repo.MarkTokenUsed(Convert.ToInt32(row["TokenId"]));

            return true;
        }

        public bool ResetPassword(string token, string newPassword)
        {
            var row = _repo.GetValidEmailToken(token, "Reset");

            if (row == null)
                return false;

            string passwordHash = BCrypt.Net.BCrypt.HashPassword(newPassword, 11);

            _repo.UpdatePasswordHash(Convert.ToInt32(row["UserId"]), passwordHash);
            _repo.MarkTokenUsed(Convert.ToInt32(row["TokenId"]));

            return true;
        }

        public string CreateEmailTokenMinutes(int userId, string purpose, int expiryMinutes)
        {
            string token = Guid.NewGuid().ToString("N");
            _repo.InsertEmailToken(userId, token, purpose, DateTime.UtcNow.AddMinutes(expiryMinutes));
            return token;
        }
    }
}