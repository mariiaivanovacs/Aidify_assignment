// PASSWORD HASHING: currently using plain-text comparison for development.
// See HASHING_GUIDE.md to add BCrypt when ready — no other files need changing.
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net.Http;

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
            bool ok = (password == user.PasswordHash);
            _repo.LogLoginAttempt(user.UserId, ok, ipAddress);
            if (!ok || !user.IsActive) return null;
            return user;
        }

        public int RegisterUser(string fullName, string email, string password)
        {
            if (_repo.EmailExists(email))
                throw new InvalidOperationException("An account with that email already exists.");
            return _repo.Insert(fullName, email, password, Constants.RoleLearner);
        }

        public bool IsAccountLocked(string email)
        {
            return _repo.GetRecentFailCount(email, withinMinutes: 15) >= 5;
        }

        // reCAPTCHA v2 server-side verify. Returns true in dev when key is a placeholder.
        public bool VerifyRecaptcha(string responseToken)
        {
            string secret = ConfigurationManager.AppSettings["RecaptchaSecretKey"] ?? "";
            if (string.IsNullOrEmpty(secret) || secret.StartsWith("YOUR_"))
                return true;  // dev mode: skip check
            if (string.IsNullOrWhiteSpace(responseToken)) return false;
            try
            {
                using (var http = new HttpClient())
                {
                    var resp = http.PostAsync(
                        "https://www.google.com/recaptcha/api/siteverify",
                        new FormUrlEncodedContent(new[] {
                            new KeyValuePair<string,string>("secret",   secret),
                            new KeyValuePair<string,string>("response", responseToken)
                        })).GetAwaiter().GetResult();
                    var json   = resp.Content.ReadAsStringAsync().GetAwaiter().GetResult();
                    var parsed = Newtonsoft.Json.Linq.JObject.Parse(json);
                    return parsed["success"]?.Value<bool>() ?? false;
                }
            }
            catch { return true; }  // network failure → don't block users
        }

        public string CreateEmailToken(int userId, string purpose, int expiryHours = 24)
        {
            string token = Guid.NewGuid().ToString("N");
            _repo.InsertEmailToken(userId, token, purpose, DateTime.UtcNow.AddHours(expiryHours));
            return token;
        }

        public bool ConfirmEmail(string token)
        {
            var row = _repo.GetValidEmailToken(token, "Confirm");
            if (row == null) return false;
            _repo.ConfirmEmail(Convert.ToInt32(row["UserId"]));
            _repo.MarkTokenUsed(Convert.ToInt32(row["TokenId"]));
            return true;
        }

        public bool ResetPassword(string token, string newPassword)
        {
            var row = _repo.GetValidEmailToken(token, "Reset");
            if (row == null) return false;
            _repo.UpdatePasswordHash(Convert.ToInt32(row["UserId"]), newPassword);
            _repo.MarkTokenUsed(Convert.ToInt32(row["TokenId"]));
            return true;
        }
    }
}
