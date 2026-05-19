// REQUIRES: BCrypt.Net-Next NuGet package
// Install via Visual Studio: Tools > NuGet Package Manager > Manage NuGet Packages for Solution
// Search "BCrypt.Net-Next" and install. This file will not compile without it.
using System;
using BCrypt.Net;

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
            bool ok = BCrypt.Net.BCrypt.Verify(password, user.PasswordHash);
            _repo.LogLoginAttempt(user.UserId, ok, ipAddress);
            if (!ok || !user.IsActive) return null;
            return user;
        }

        public int RegisterUser(string fullName, string email, string password)
        {
            if (_repo.EmailExists(email))
                throw new InvalidOperationException("An account with that email already exists.");
            string hash = BCrypt.Net.BCrypt.HashPassword(password, workFactor: 11);
            return _repo.Insert(fullName, email, hash, Constants.RoleLearner);
        }

        public bool IsAccountLocked(string email)
        {
            return _repo.GetRecentFailCount(email, withinMinutes: 15) >= 5;
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
            string hash = BCrypt.Net.BCrypt.HashPassword(newPassword, workFactor: 11);
            _repo.UpdatePasswordHash(Convert.ToInt32(row["UserId"]), hash);
            _repo.MarkTokenUsed(Convert.ToInt32(row["TokenId"]));
            return true;
        }
    }
}
