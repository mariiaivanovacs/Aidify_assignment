# Aidify Visitor and Authentication Functionality Test Description

## Purpose

This document defines the detailed test plan for the **Visitor** role and public authentication flow in Aidify. It is based on:

- `C:\Users\superstar umzi\Downloads\original_plan_aidify.md`
- `C:\Users\superstar umzi\Downloads\Aidify\FLOWCHART_DESCRIPTIONS.md`
- The current `Aidify_assigment` Web Forms implementation.

The goal is to verify that unauthenticated visitors can safely browse public content, preview selected modules and quizzes without saved attempts, register, confirm email, log in, reset passwords, and receive clear prompts when attempting restricted actions.

## Test Environment

Use this baseline before testing:

- Solution: `C:\Users\superstar umzi\Downloads\Aidify_assigment\Aidify_assigment.sln`
- Web project: `C:\Users\superstar umzi\Downloads\Aidify_assigment`
- Browser: Google Chrome
- Base URL: `http://localhost:8080`
- Database server: `(LocalDB)\AidifyLocalDB`
- Database name: `AidifyDB`
- Visitor state: logged out / incognito Chrome window
- Test learner after registration: create a fresh unique email such as `visitor.test.{timestamp}@aidify.local`

Before testing:

1. Restore NuGet packages.
2. Build the solution in Debug mode.
3. Run ASP.NET precompile.
4. Start IIS Express or the configured local web server.
5. Confirm seed data exists for published preview modules, preview quizzes, FAQs, and test users.
6. Use Chrome for all visual and functional checks.

## Visitor Routes

Public routes to smoke-test:

- `/Default.aspx`
- `/Public/About.aspx`
- `/Public/Contact.aspx`
- `/Public/FAQ.aspx`
- `/Public/PreviewModules.aspx`
- `/Public/PreviewQuiz.aspx`
- `/Public/PreviewQuiz.aspx?moduleId={id}`
- `/Public/PreviewQuiz.aspx?quizId={id}`
- `/Auth/Register.aspx`
- `/Auth/Login.aspx`
- `/Auth/ConfirmEmail.aspx?t={token}`
- `/Auth/ResendConfirmation.aspx`
- `/Auth/ForgotPassword.aspx`
- `/Auth/ResetPassword.aspx?t={token}`
- `/Auth/Logout.aspx`

Expected result:

- Public pages load without login.
- Auth pages load without login.
- Protected Admin, Instructor, and Learner pages redirect visitors to login or block access.
- No visitor action writes learner progress, quiz attempts, badges, certificates, or league points.

## Requirement Coverage Matrix

| Requirement | Expected Behavior | Test Priority | Current Implementation Risk |
| --- | --- | --- | --- |
| FR-V01 | Public Home page has hero, mission, featured module previews, and register CTA. | Critical | `Default.aspx` exists and loads preview modules through `GetHomeData`. Verify visible content and CTA. |
| FR-V02 | Public About, Contact with form, and FAQ pages. | Critical | Pages exist under `/Public`; Contact uses `EmailService`, FAQ loads from `FAQs`. |
| FR-V03 | Emergency Awareness content available without login. | High | No obvious `EmergencyAwareness.aspx` page found; likely missing. |
| FR-V04 | Limited preview modules and preview quizzes; attempts are not saved. | Critical | `PreviewModules.aspx` and `PreviewQuiz.aspx` exist; verify no `QuizAttempts` rows are inserted. |
| FR-V05 | Login/register prompts appear for restricted routes. | Critical | Must verify protected pages redirect visitors correctly. |
| FR-V06 | Registration page has full name, email, password, confirm password, accept terms. | Critical | `Register.aspx` exists; verify all fields and terms checkbox. |
| FR-V07 | Password strength and email format validated client-side and server-side. | Critical | Server-side password regex exists; verify markup validators and client behavior. |
| FR-V08 | Email confirmation link sent; token expires after 24 hours; inactive until confirmed. | Critical | Confirm flow exists, but current registration creates a 1-minute confirm token, not 24 hours. |
| FR-V09 | Login accepts email/password, Remember me, Forgot password links. | Critical | `Login.aspx` supports remember me and role redirects; verify links. |
| FR-V10 | Passwords hashed with BCrypt work factor 11. | Critical | `AuthService` uses `BCrypt.HashPassword(password, 11)` and `BCrypt.Verify`. |
| FR-V11 | Forgot password flow: email -> reset link -> set new password. | Critical | Pages exist; verify token creation, expiry, email, and password update. |
| FR-V12 | Sessions managed by FormsAuthentication or Session; expire after 30 minutes inactivity. | High | Login sets Session and FormsAuthentication cookie; verify timeout config. |
| FR-V13 | Global Logout available from every page for logged-in users. | High | `Logout.aspx` exists; verify navbar and session clearing. |
| FR-V14 | Role-Based Access Control on every protected page. | Critical | Verify all role folders; Instructor pages need extra attention. |
| FR-V15 | Navbar changes by role through shared MasterPage/user control. | High | Verify visitor navbar and logged-in navbars. |
| FR-V16 | Successful and failed login attempts logged to `LoginHistory`. | Critical | `AuthService.Authenticate` logs success/failure; unknown-user failures log with null user id. |
| FR-V17 | reCAPTCHA v2 on registration and login. | High | Registration verifies reCAPTCHA; login code does not appear to verify reCAPTCHA. |

## Baseline Database Verification

Run before visitor testing:

```sql
SELECT COUNT(*) AS PublishedPreviewModules
FROM Modules
WHERE Status = 'Published' AND IsDeleted = 0 AND IsPreview = 1;

SELECT COUNT(*) AS PreviewQuizzes
FROM Quizzes q
JOIN Modules m ON m.ModuleId = q.ModuleId
WHERE q.IsPreview = 1
  AND m.Status = 'Published'
  AND m.IsDeleted = 0;

SELECT COUNT(*) AS FAQCount FROM FAQs;
SELECT COUNT(*) AS UsersCount FROM Users;
SELECT COUNT(*) AS EmailTokenCount FROM EmailTokens;
SELECT COUNT(*) AS LoginHistoryCount FROM LoginHistory;
SELECT COUNT(*) AS QuizAttemptCount FROM QuizAttempts;
```

Pass criteria:

- Queries execute without invalid table or invalid column errors.
- At least one published preview module and FAQ should exist for a full demo.
- Counts are recorded so later tests can prove visitor preview does not mutate learner data.

## Public Home Page Tests

### VIS-HOME-001: Home Page Loads For Visitor

Steps:

1. Open Chrome incognito.
2. Go to `/Default.aspx`.

Expected:

- Page loads without authentication.
- Hero banner, mission/value message, and register/login calls to action are visible.
- No server error or JavaScript console error blocks rendering.

### VIS-HOME-002: Featured Preview Modules Load From Database

Steps:

1. Open `/Default.aspx`.
2. Inspect featured module cards.
3. Compare displayed modules with SQL.

SQL:

```sql
SELECT TOP 3 m.ModuleId, m.Title, m.Description, m.DifficultyLevel,
       COUNT(l.LessonId) AS LessonCount,
       ISNULL(SUM(ISNULL(l.EstimatedMinutes, 0)), 0) AS EstimatedMinutes
FROM Modules m
LEFT JOIN Lessons l ON l.ModuleId = m.ModuleId
WHERE m.Status = 'Published'
  AND m.IsDeleted = 0
  AND m.IsPreview = 1
GROUP BY m.ModuleId, m.Title, m.Description, m.DifficultyLevel, m.CreatedAt
ORDER BY m.CreatedAt DESC;
```

Expected:

- Home page shows only published, non-deleted, preview-enabled modules.
- Draft, pending, rejected, deleted, and non-preview modules are hidden.
- Lesson count and estimated minutes match SQL.

### VIS-HOME-003: Home CTA Links

Steps:

1. Click Register CTA.
2. Click Login CTA.
3. Click Preview Modules CTA if present.

Expected:

- Register links to `/Auth/Register.aspx`.
- Login links to `/Auth/Login.aspx`.
- Preview links to `/Public/PreviewModules.aspx`.

## About, FAQ, and Contact Tests

### VIS-INFO-001: About Page

Steps:

1. Open `/Public/About.aspx`.

Expected:

- Page loads for logged-out visitors.
- Content explains Aidify purpose and emergency-learning mission.
- Navbar and footer remain consistent with public pages.

### VIS-FAQ-001: FAQ Loads From Database

Steps:

1. Open `/Public/FAQ.aspx`.
2. Expand FAQ items.
3. Compare with SQL.

SQL:

```sql
SELECT FaqId, Question, Answer, Category, SortOrder
FROM FAQs
ORDER BY SortOrder, FaqId;
```

Expected:

- FAQ questions and answers match database.
- FAQ order follows `SortOrder`, then `FaqId`.
- Empty FAQ table shows a graceful empty state.

### VIS-FAQ-002: FAQ Content Safety

Steps:

1. Insert or edit a test FAQ containing HTML/script-like text if admin tooling allows it.
2. Open `/Public/FAQ.aspx`.

Expected:

- FAQ content does not execute unsafe scripts.
- Layout remains intact.

### VIS-CONTACT-001: Contact Form Required Field Validation

Steps:

1. Open `/Public/Contact.aspx`.
2. Submit with missing name, email, subject, or message.

Expected:

- Form shows a clear error.
- No email is sent.
- Page redirects back cleanly without duplicate submission.

### VIS-CONTACT-002: Contact Form Successful Send

Steps:

1. Enter valid name, email, subject, and message.
2. Submit.

Expected:

- User sees success message.
- Email is sent to configured `SmtpUser`, or failure is handled gracefully if SMTP is not configured.
- Message body HTML-encodes visitor input.

Implementation note:

- The current contact form sends by email and does not appear to store contact submissions in the database. That is acceptable only if the assignment requires email-only contact.

## Emergency Awareness Tests

### VIS-EMERG-001: Emergency Awareness Page Exists

Steps:

1. Try opening `/Public/EmergencyAwareness.aspx`.
2. Try any navigation link named Emergency Awareness, Safety Tips, or First Response.

Expected:

- Visitor can access basic emergency awareness content without login.
- Content includes safety tips or universal first-response guidelines.

Current implementation risk:

- No obvious `EmergencyAwareness.aspx` file was found. If the page is absent, record this as a missing FR-V03 feature.

## Preview Module Tests

### VIS-PMOD-001: Preview Modules Page Loads

Steps:

1. Open `/Public/PreviewModules.aspx`.

Expected:

- Page loads for visitor.
- Up to six published preview modules appear.
- Cards show title, description, difficulty, lesson count, estimated minutes, and preview/quiz actions when available.

SQL:

```sql
SELECT TOP 6 m.ModuleId, m.Title, m.Description, m.DifficultyLevel,
       COUNT(l.LessonId) AS LessonCount,
       ISNULL(SUM(ISNULL(l.EstimatedMinutes, 0)), 0) AS EstimatedMinutes,
       MAX(CASE WHEN q.IsPreview = 1 THEN q.QuizId END) AS PreviewQuizId
FROM Modules m
LEFT JOIN Lessons l ON l.ModuleId = m.ModuleId
LEFT JOIN Quizzes q ON q.ModuleId = m.ModuleId
WHERE m.Status = 'Published'
  AND m.IsDeleted = 0
  AND m.IsPreview = 1
GROUP BY m.ModuleId, m.Title, m.Description, m.DifficultyLevel, m.CreatedAt
ORDER BY m.CreatedAt DESC;
```

### VIS-PMOD-002: Non-Public Modules Are Hidden

Steps:

1. Ensure database has draft, pending review, rejected, deleted, and non-preview modules.
2. Open `/Public/PreviewModules.aspx`.

Expected:

- Only modules where `Status = 'Published'`, `IsDeleted = 0`, and `IsPreview = 1` are visible.

### VIS-PMOD-003: Preview Module Links

Steps:

1. Click preview content action for a module.
2. Click preview quiz action for a module with preview quiz.

Expected:

- Preview content opens `/Public/PreviewQuiz.aspx?moduleId={id}` or equivalent.
- Preview quiz opens `/Public/PreviewQuiz.aspx?quizId={id}` or equivalent.
- Invalid links do not show server errors.

## Preview Quiz Tests

### VIS-PQUIZ-001: Load Preview By Module Id

Steps:

1. Open `/Public/PreviewQuiz.aspx?moduleId={publishedPreviewModuleId}`.

Expected:

- Module title, description, and difficulty appear.
- Lesson previews load in sequence order.
- Preview quiz appears if the module has one.
- Questions and answer options load.

### VIS-PQUIZ-002: Load Preview By Quiz Id

Steps:

1. Open `/Public/PreviewQuiz.aspx?quizId={previewQuizId}`.

Expected:

- System derives the module from the quiz.
- Correct module and quiz content load.

### VIS-PQUIZ-003: Default Preview Fallback

Steps:

1. Open `/Public/PreviewQuiz.aspx` without query string.

Expected:

- First available published preview module loads.
- If no preview module exists, the page shows a graceful empty state.

### VIS-PQUIZ-004: Reject Non-Preview Or Unpublished Quiz

Steps:

1. Open `/Public/PreviewQuiz.aspx?quizId={nonPreviewQuizId}`.
2. Open `/Public/PreviewQuiz.aspx?moduleId={draftModuleId}`.

Expected:

- Non-preview quiz questions are not exposed.
- Draft/pending/rejected/deleted module content is not exposed.

Important technical check:

- Current `PreviewQuiz.GetPreviewContent` validates module published/deleted status but should also ensure the module is preview-enabled when a module id is supplied.

### VIS-PQUIZ-005: Preview Attempt Is Not Saved

Steps:

1. Record baseline counts.
2. Open preview quiz.
3. Select answers and submit preview.
4. Recheck counts.

SQL before and after:

```sql
SELECT COUNT(*) AS QuizAttemptCount FROM QuizAttempts;
SELECT COUNT(*) AS AttemptAnswerCount FROM AttemptAnswers;
SELECT COUNT(*) AS ProgressCount FROM Progress;
SELECT COUNT(*) AS UserBadgeCount FROM UserBadges;
SELECT COUNT(*) AS CertificateCount FROM Certificates;
```

Expected:

- Counts do not increase.
- Visitor receives prompt to register for full scoring, tracking, and certificates.

### VIS-PQUIZ-006: Preview Does Not Reveal Correct Answers

Steps:

1. Open preview quiz.
2. Inspect visible question data.

Expected:

- Visitors see question text and answer options.
- Correct answer flags are not visible in the page or API response.
- Explanation/scoring is not shown unless intentionally public.

## Registration Tests

### VIS-REG-001: Registration Page Fields

Steps:

1. Open `/Auth/Register.aspx`.

Expected:

- Full name, email, password, confirm password, terms checkbox, and Register button exist.
- Link to Login exists.
- reCAPTCHA is displayed or intentionally bypassed only in local development.

### VIS-REG-002: Required Field Validation

Steps:

1. Submit empty form.
2. Submit without terms checkbox.

Expected:

- Required field errors appear.
- Terms error appears.
- No user row is inserted.

### VIS-REG-003: Email Format Validation

Steps:

1. Enter invalid email such as `not-an-email`.
2. Submit.

Expected:

- Client-side or ASP.NET validation blocks submission.
- Server-side validation also blocks if JavaScript is disabled.

### VIS-REG-004: Password Strength Validation

Steps:

Try passwords:

- `short`
- `lowercaseonly`
- `NoNumber!`
- `NoSymbol1`
- `Valid123!`

Expected:

- Only password with at least 8 characters, uppercase, lowercase, digit, and symbol is accepted.
- Confirm password must match.

### VIS-REG-005: Successful Registration Creates Inactive Learner

Steps:

1. Register a unique email with valid password and terms accepted.
2. Check database.

Expected:

- User row is inserted with Learner role.
- Password is BCrypt hash, not plain text.
- `IsEmailConfirmed = 0` until confirmation.
- Confirmation token is inserted into `EmailTokens`.
- Confirmation email is attempted.

SQL:

```sql
SELECT u.UserId, u.FullName, u.Email, u.PasswordHash, u.RoleId, u.IsActive, u.IsEmailConfirmed, u.CreatedAt
FROM Users u
WHERE u.Email = @Email;

SELECT TokenId, UserId, Purpose, ExpiresAt, UsedAt
FROM EmailTokens
WHERE UserId = @UserId
ORDER BY TokenId DESC;
```

Critical expected:

- BCrypt hashes usually start with `$2a$`, `$2b$`, or `$2y$`.
- Assignment requires confirmation token expiry of 24 hours.

Current implementation risk:

- Current registration code creates confirmation tokens with `CreateEmailTokenMinutes(..., 1)`, so expiry is 1 minute, not 24 hours.

### VIS-REG-006: Duplicate Email Handling

Steps:

1. Register using an email that is already confirmed.
2. Register using an email that exists but is unconfirmed.

Expected:

- Confirmed duplicate shows an error and does not create another user.
- Unconfirmed duplicate may resend/replace confirmation token without duplicating user.

### VIS-REG-007: reCAPTCHA Registration Behavior

Steps:

1. Test with valid captcha.
2. Test with missing captcha.
3. Test with invalid captcha if keys are configured.

Expected:

- Valid captcha allows registration.
- Missing/invalid captcha blocks registration.

Implementation note:

- In development, current `AuthService.VerifyRecaptcha` returns true when secret key is empty or placeholder. That is acceptable for local testing only and should be documented.

## Email Confirmation Tests

### VIS-CONF-001: Confirm Valid Token

Steps:

1. Register new visitor.
2. Get confirmation token from email or database.
3. Open `/Auth/ConfirmEmail.aspx?t={token}`.

Expected:

- Email becomes confirmed.
- Token `UsedAt` is set.
- User can now log in.

SQL:

```sql
SELECT IsEmailConfirmed FROM Users WHERE UserId = @UserId;
SELECT Purpose, ExpiresAt, UsedAt FROM EmailTokens WHERE Token = @Token;
```

### VIS-CONF-002: Reject Missing, Invalid, Used, Or Expired Token

Steps:

1. Open `/Auth/ConfirmEmail.aspx`.
2. Open with fake token.
3. Reuse a token after successful confirmation.
4. Use an expired token.

Expected:

- Confirmation fails safely.
- No unrelated account is confirmed.
- User receives clear message or resend option.

## Login Tests

### VIS-LOGIN-001: Login Page Content

Steps:

1. Open `/Auth/Login.aspx`.

Expected:

- Email and password fields exist.
- Remember me checkbox exists.
- Forgot password link exists.
- Register link exists.
- reCAPTCHA appears if required by FR-V17.

Current implementation risk:

- Login code does not appear to call `VerifyRecaptcha`; if no login captcha exists, record as FR-V17 gap.

### VIS-LOGIN-002: Successful Login Redirects By Role

Steps:

1. Log in as learner.
2. Log out.
3. Log in as instructor.
4. Log out.
5. Log in as admin.

Expected:

- Learner redirects to `/Learner/Dashboard.aspx`.
- Instructor redirects to `/Instructor/Dashboard.aspx`.
- Admin redirects to `/Admin/Dashboard.aspx`.
- Session contains user id, role, name, and email.

### VIS-LOGIN-003: Failed Login Logged

Steps:

1. Try invalid password for an existing user.
2. Try invalid email.
3. Check `LoginHistory`.

SQL:

```sql
SELECT TOP 20 LoginId, UserId, Success, IPAddress, CreatedAt
FROM LoginHistory
ORDER BY LoginId DESC;
```

Expected:

- Failed attempts are logged.
- Existing-user failure includes user id.
- Unknown-user failure logs with null user id if schema allows it.

### VIS-LOGIN-004: Lockout After Five Failed Attempts

Steps:

1. Attempt five failed logins for the same email within 5 minutes.
2. Try again with correct password.

Expected:

- Account is temporarily locked.
- Lockout message appears.
- Correct password is blocked until lockout window expires.

### VIS-LOGIN-005: Unconfirmed User Cannot Login

Steps:

1. Register new user but do not confirm email.
2. Try logging in.

Expected:

- Login is blocked.
- Message asks user to confirm email.

### VIS-LOGIN-006: Disabled User Cannot Login

Steps:

1. Disable a user through admin.
2. Try logging in.

Expected:

- Login is blocked.
- Message says account is disabled.

## Forgot and Reset Password Tests

### VIS-FORGOT-001: Forgot Password Page

Steps:

1. Open `/Auth/ForgotPassword.aspx`.
2. Enter confirmed user email.
3. Submit.

Expected:

- Reset token is inserted with `Purpose = 'Reset'`.
- Reset email is attempted.
- User-facing message does not leak whether email exists unless intentionally allowed.

SQL:

```sql
SELECT TOP 5 TokenId, UserId, Purpose, ExpiresAt, UsedAt
FROM EmailTokens
WHERE Purpose = 'Reset'
ORDER BY TokenId DESC;
```

### VIS-RESET-001: Reset Password With Valid Token

Steps:

1. Open `/Auth/ResetPassword.aspx?t={resetToken}`.
2. Enter valid new password and confirm password.
3. Submit.
4. Log in with new password.

Expected:

- Password hash changes.
- Token is marked used.
- Old password no longer works.
- New password works.

### VIS-RESET-002: Reject Weak Password

Steps:

1. Use weak new password during reset.

Expected:

- Weak password is rejected using the same policy as registration.
- Password hash remains unchanged.

### VIS-RESET-003: Reject Invalid, Used, Or Expired Reset Token

Steps:

1. Open reset page with fake token.
2. Reuse token after successful reset.
3. Use expired token.

Expected:

- Reset is blocked.
- No password changes occur.

## Logout and Session Tests

### VIS-SESS-001: Logout Clears Session

Steps:

1. Log in as learner.
2. Click logout or open `/Auth/Logout.aspx`.
3. Try opening `/Learner/Dashboard.aspx`.

Expected:

- Session is cleared.
- FormsAuthentication cookie is removed or invalidated.
- Protected page redirects to login.

### VIS-SESS-002: Remember Me Cookie

Steps:

1. Log in with Remember me unchecked.
2. Inspect session/cookie behavior after browser close.
3. Repeat with Remember me checked.

Expected:

- Remember me creates persistent authentication behavior if intended.
- No sensitive user data is stored in client-side cookies.

### VIS-SESS-003: 30-Minute Inactivity Timeout

Steps:

1. Confirm Web.config or runtime session timeout.
2. Leave session idle beyond 30 minutes or temporarily reduce timeout for testing.
3. Open protected page.

Expected:

- User is required to log in again after timeout.

## Restricted Route Prompt Tests

### VIS-RBAC-001: Visitor Access To Learner Pages

Steps:

1. In incognito, open `/Learner/Dashboard.aspx`.
2. Open `/Learner/Courses/Catalogue.aspx`.

Expected:

- Visitor is redirected to login or shown a clear login/register prompt.
- No learner data is visible.

### VIS-RBAC-002: Visitor Access To Instructor Pages

Steps:

1. In incognito, open `/Instructor/Dashboard.aspx`.
2. Open `/Instructor/Modules/List.aspx`.

Expected:

- Visitor is redirected or blocked.
- No instructor data is visible.

### VIS-RBAC-003: Visitor Access To Admin Pages

Steps:

1. In incognito, open `/Admin/Dashboard.aspx`.
2. Open `/Admin/Users/List.aspx`.

Expected:

- Visitor is redirected or blocked.
- No admin data is visible.

## Navbar and Layout Tests

### VIS-NAV-001: Visitor Navbar

Steps:

1. Open public pages while logged out.

Expected:

- Navbar shows visitor-appropriate links only: Home, About, FAQ, Contact, Preview Modules, Login/Register.
- No Admin, Instructor, or Learner-only links appear.

### VIS-NAV-002: Role Navbar Changes After Login

Steps:

1. Log in as learner, instructor, and admin in separate test cycles.
2. Observe navbar.

Expected:

- Navbar changes based on role.
- Logout is available to logged-in users.
- Visitor login/register links disappear after login.

## Security and Validation Tests

### VIS-SEC-001: SQL Injection Inputs

Use these in login email, registration fields, contact form, and public query strings:

```text
' OR 1=1 --
```

Expected:

- Input is rejected or treated as text.
- No unauthorized login occurs.
- No extra data is exposed.
- No database corruption occurs.

### VIS-SEC-002: XSS Inputs

Use these in registration full name, contact form fields, and query string parameters:

```html
<script>alert('xss')</script>
```

Expected:

- Script does not execute.
- Output is encoded or rejected.

### VIS-SEC-003: Preview Query Tampering

Steps:

1. Use negative ids, non-numeric ids, very large ids, and ids for private content:
   - `/Public/PreviewQuiz.aspx?moduleId=-1`
   - `/Public/PreviewQuiz.aspx?moduleId=abc`
   - `/Public/PreviewQuiz.aspx?quizId=999999`

Expected:

- Page handles invalid input gracefully.
- No stack trace or SQL error appears.
- Private content is not exposed.

### VIS-SEC-004: Authentication Cookie Safety

Steps:

1. Log in.
2. Inspect auth cookie flags in browser dev tools.

Expected:

- Auth cookie is HTTP-only.
- Secure flag should be enabled when deployed over HTTPS.
- Cookie does not contain password, role secrets, or personal data.

## Public Data Integrity Tests

### VIS-DATA-001: Visitor Preview Does Not Mutate Learner Tables

Before and after browsing public pages, compare:

```sql
SELECT COUNT(*) AS Enrollments FROM Enrollments;
SELECT COUNT(*) AS ProgressRows FROM Progress;
SELECT COUNT(*) AS QuizAttempts FROM QuizAttempts;
SELECT COUNT(*) AS AttemptAnswers FROM AttemptAnswers;
SELECT COUNT(*) AS UserBadges FROM UserBadges;
SELECT COUNT(*) AS Certificates FROM Certificates;
SELECT COUNT(*) AS LeagueRows FROM League;
```

Expected:

- Counts remain unchanged unless a registration/login/password operation intentionally modifies auth tables.

### VIS-DATA-002: Registration Only Creates Auth Rows

After successful registration, expected changes:

- `Users`: plus one row.
- `EmailTokens`: plus one confirmation token.
- `LoginHistory`: unchanged until login attempt.
- No `Enrollments`, `Progress`, `QuizAttempts`, `UserBadges`, `Certificates`, or `League` rows unless the system intentionally seeds learner profile data.

## Professor Demo Review

Recommended visitor demo path:

1. Open Home page in Chrome.
2. Show hero, mission, CTA, and featured preview modules.
3. Open Preview Modules.
4. Open a module preview and preview quiz.
5. Submit preview quiz and show registration prompt.
6. Open FAQ and show database-loaded accordion.
7. Open Contact and submit a test message if SMTP is configured.
8. Register a new visitor account.
9. Show email confirmation behavior.
10. Log in and show role-based redirect to Learner dashboard.
11. Log out and show protected route redirects back to login.

Visual checks:

- Public pages are responsive on desktop and mobile widths.
- No text overlaps.
- CTA buttons are visible.
- Preview module cards show useful content.
- FAQ accordion expands cleanly.
- Forms show validation errors near relevant controls.
- Login/register pages look consistent with the rest of the site.

Visual Studio Designer note:

- Use Visual Studio Designer only for static `.aspx` layout explanation.
- Use Chrome for real testing because public pages use database-loaded AJAX/web methods, sessions, postbacks, and authentication cookies.

## Known Gaps To Verify Or Fix

These are the main Visitor/Auth risk areas discovered from the current implementation review:

1. `EmergencyAwareness.aspx` was not found, so FR-V03 may be missing.
2. Registration confirmation token currently appears to expire after 1 minute, while the assignment requires 24 hours.
3. Registration reCAPTCHA is implemented, but local placeholder/missing secret bypasses verification.
4. Login reCAPTCHA does not appear in the current login code path, so FR-V17 may be incomplete.
5. Preview quiz should be verified to avoid exposing non-preview quizzes or unpublished modules through query string tampering.
6. Confirm whether email-format validation is both client-side and server-side.
7. Confirm whether session timeout is exactly 30 minutes in `Web.config`.
8. Confirm public navbar truly changes by role through a shared layout/control.
9. Contact form sends email but does not appear to store submissions; this is acceptable only if email-only contact meets the project requirement.

## Final Visitor Acceptance Checklist

Mark the Visitor role complete only when all critical items below pass:

- Home page loads publicly and shows mission, CTA, and featured preview modules.
- About, Contact, and FAQ load publicly.
- Emergency Awareness content exists or the missing feature is explicitly accepted.
- Preview Modules shows only published, non-deleted, preview-enabled modules.
- Preview Quiz loads by module id and quiz id.
- Preview attempts do not save quiz attempts, progress, badges, certificates, or league points.
- Visitors are prompted to register/login for restricted content.
- Registration validates all fields, password strength, email format, terms, and reCAPTCHA.
- Registration stores BCrypt password hash and creates confirmation token.
- Email confirmation activates account and marks token used.
- Login validates credentials, blocks unconfirmed/disabled accounts, supports Remember me, and redirects by role.
- Failed and successful login attempts are recorded in `LoginHistory`.
- Lockout after repeated failed attempts works.
- Forgot/reset password flow works and reuses BCrypt hashing.
- Logout clears session and blocks protected pages after logout.
- Visitor, learner, instructor, and admin navbars render correctly by role.
- Public pages pass SQL injection, XSS, and query tampering checks.
- Chrome visual review passes for public pages and auth pages.
