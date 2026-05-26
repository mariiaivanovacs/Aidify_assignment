# Adding BCrypt Password Hashing

Currently passwords are stored as plain text for development ease.
Follow these steps when you are ready to add proper hashing before submission.

---

## Step 1 — Install the package

Open `Aidify_assigment.sln` in Visual Studio.
**Tools → NuGet Package Manager → Manage NuGet Packages for Solution**
Search: `BCrypt.Net-Next` → Install.

---

## Step 2 — Update AuthService.cs

Open `Services/AuthService.cs` and make three replacements:

**Add the using at the top:**
```csharp
using BCrypt.Net;
```

**In `Authenticate()` — replace the comparison line:**
```csharp
// BEFORE (plain text):
bool ok = (password == user.PasswordHash);

// AFTER (BCrypt):
bool ok = BCrypt.Net.BCrypt.Verify(password, user.PasswordHash);
```

**In `RegisterUser()` — replace the insert line:**
```csharp
// BEFORE (plain text):
return _repo.Insert(fullName, email, password, Constants.RoleLearner);

// AFTER (BCrypt):
string hash = BCrypt.Net.BCrypt.HashPassword(password, workFactor: 11);
return _repo.Insert(fullName, email, hash, Constants.RoleLearner);
```

**In `ResetPassword()` — replace the update line:**
```csharp
// BEFORE (plain text):
_repo.UpdatePasswordHash(Convert.ToInt32(row["UserId"]), newPassword);

// AFTER (BCrypt):
string hash = BCrypt.Net.BCrypt.HashPassword(newPassword, workFactor: 11);
_repo.UpdatePasswordHash(Convert.ToInt32(row["UserId"]), hash);
```

---

## Step 3 — Re-hash the demo users in the database

After changing the code, existing plain-text passwords will no longer work.
Run this in SQL Server Object Explorer (inside AidifyDB):

```sql
USE AidifyDB;

-- Re-register each user through the app Register page (recommended)
-- OR run this script after generating hashes with your own BCrypt tool

-- To generate a hash: in any C# context after BCrypt is installed:
-- Console.WriteLine(BCrypt.Net.BCrypt.HashPassword("Admin123!", 11));
-- Paste the output below:

UPDATE Users SET PasswordHash = 'PASTE_BCRYPT_HASH_HERE'
WHERE Email = 'admin@aidify.edu';

UPDATE Users SET PasswordHash = 'PASTE_BCRYPT_HASH_HERE'
WHERE Email = 'instructor@aidify.edu';

UPDATE Users SET PasswordHash = 'PASTE_BCRYPT_HASH_HERE'
WHERE Email = 'learner@aidify.edu';
```

**Tip:** The easiest way to get a real hash is to register a new account through
the app after step 2 is done, then copy that user's `PasswordHash` from the DB
and paste it into the UPDATE statements above.

---

## That's it — only AuthService.cs changes. Nothing else in the codebase touches hashing.
