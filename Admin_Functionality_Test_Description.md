# Aidify Admin Functionality and Technical Test Description

## Purpose

This document defines how to test the Aidify Admin role against:

- `C:\Users\superstar umzi\Downloads\original_plan_aidify.md`
- `C:\Users\superstar umzi\Downloads\Aidify\FLOWCHART_DESCRIPTIONS.md`
- The current Web Forms implementation in `Aidify_assigment`

It is intended for manual QA, professor demonstration preparation, and technical verification that Admin actions are protected, persisted in SQL Server, reflected in the UI, and recorded in audit logs where required.

## Admin Scope Under Test

Primary Admin pages in the current solution:

- `/Admin/Dashboard.aspx`
- `/Admin/Users/List.aspx`
- `/Admin/Users/Create.aspx`
- `/Admin/Users/Edit.aspx?userId={id}`
- `/Admin/Content/ApprovalQueue.aspx`
- `/Admin/Analytics.aspx`
- `/Admin/AuditLogs.aspx`
- `/Admin/AI_Insights.aspx`
- `/Admin/Modules/Create.aspx`
- `/Admin/Events/Create.aspx`

Primary technical components:

- `Security/BaseRolePage.cs`
- `Security/AuthHelper.cs`
- `Services/AuthService.cs`
- `Services/AuditService.cs`
- `Services/AIInsightsService.cs`
- `Services/ReportService.cs`
- `DAL/AdminRepository.cs`
- `database/01_Schema.sql`

Primary database tables:

- `Users`, `Roles`, `LoginHistory`, `EmailTokens`
- `AuditLogs`
- `Modules`, `Lessons`, `Events`
- `AIInsights`
- `QuizAttempts`, `Enrollments`, `Progress`
- `Notifications`

## Test Environment

Use the current local Web Forms application:

- Base URL: `http://localhost:8080`
- Browser: Chrome
- Database: `(LocalDB)\AidifyLocalDB`, database `AidifyDB`
- Recommended Admin login: `admin@aidify.edu / Admin123!`

Before testing:

1. Build the solution in Debug mode.
2. Confirm LocalDB is running.
3. Confirm seed data exists for Admin, Instructor, Learner, Modules, Lessons, and Quizzes.
4. Use a test email domain for newly created users, for example `admin-test-{timestamp}@aidify.test`.
5. Record SQL row counts before and after destructive or write tests.

Useful SQL baseline:

```sql
SELECT COUNT(*) AS UsersCount FROM Users;
SELECT COUNT(*) AS AuditLogsCount FROM AuditLogs;
SELECT COUNT(*) AS PendingModules FROM Modules WHERE Status = 'PendingReview' AND IsDeleted = 0;
SELECT COUNT(*) AS PublishedModules FROM Modules WHERE Status = 'Published' AND IsDeleted = 0;
SELECT COUNT(*) AS PendingEvents FROM Events WHERE Status = 'PendingReview';
SELECT COUNT(*) AS FailedLogins24h
FROM LoginHistory
WHERE Success = 0 AND [Timestamp] >= DATEADD(HOUR, -24, GETUTCDATE());
```

## Requirement Coverage Matrix

| Requirement | Source expectation | Current test target | Evidence required |
|---|---|---|---|
| FR-A01 | Admin login with lockout after 5 failed attempts | `/Auth/Login.aspx`, `AuthService.IsAccountLocked`, `LoginHistory` | Failed attempts recorded; sixth attempt blocked within 5 minutes |
| FR-A02 | Dashboard totals and AI daily insight | `/Admin/Dashboard.aspx` WebMethods | Cards match SQL counts; AI summary returns text or graceful failure |
| FR-A03 | User list searchable/filterable with role/status/last login | `/Admin/Users/List.aspx` | User list renders role, status, last active; filters/search work in UI |
| FR-A04 | Create user with role assignment | `/Admin/Users/Create.aspx` | New `Users` row, role correct, reset token created, audit row written |
| FR-A05 | Edit user profile fields | `/Admin/Users/Edit.aspx` | `Users.FullName`, `Email`, `RoleId`, `IsActive` update correctly |
| FR-A06 | Disable/enable user | `/Admin/Users/List.aspx` WebMethod `SetUserActive` | `Users.IsActive` toggles; audit row written |
| FR-A07 | Delete user via soft delete | Requirement exists, no visible current Admin delete page/action found | Must be logged as coverage gap unless implemented later |
| FR-A08 | Force password reset | `/Admin/Users/Edit.aspx?userId={id}` | `EmailTokens` reset token created; audit row `ForceResetPassword` written |
| FR-A09 | Roles/permissions management | Requirement exists, no `Admin/Roles.aspx` found in current active solution | Must be logged as coverage gap unless implemented later |
| FR-A10 | Approve/reject content queue | `/Admin/Content/ApprovalQueue.aspx` | Module/event status changes; audit row written; redirect clears action URL |
| FR-A11 | Audit every Admin action | `AuditLogs`, `AuditService.Log` | Each create/update/enable/disable/approve/reject/reset writes a row |
| FR-A12 | Analytics charts | `/Admin/Analytics.aspx` WebMethod `GetAnalyticsData` | Chart payload matches SQL aggregate data |
| FR-A13 | Export analytics/report | `/Admin/Analytics.aspx?export=users_csv` | CSV downloads; PDF export should be logged as gap if not implemented |
| FR-A14 | AI daily summary cached 24h | `AIInsightsService.GetDailySummaryAsync` | Repeated call returns cached response or graceful unavailable message |
| FR-A15 | AI decision support Q&A | `/Admin/AI_Insights.aspx` WebMethod `AskAI` | Uses pre-aggregated stats JSON; rate limit blocks after 20 calls/hour |
| FR-A16 | Validation and success/warning messages | Admin forms | Required fields, duplicate email, invalid inputs, and action success messages visible |

## Functional Test Cases

### ADM-AUTH-001: Admin Login Success

Precondition: Admin user exists, active, email confirmed.

Steps:

1. Open `/Auth/Login.aspx`.
2. Enter `admin@aidify.edu`.
3. Enter `Admin123!`.
4. Click Login.

Expected result:

- User is redirected to `/Admin/Dashboard.aspx`.
- Session contains Admin role.
- Admin pages are accessible.
- `LoginHistory` records a successful login.

Technical verification:

```sql
SELECT TOP 5 lh.*
FROM LoginHistory lh
JOIN Users u ON u.UserId = lh.UserId
WHERE u.Email = 'admin@aidify.edu'
ORDER BY lh.[Timestamp] DESC;
```

### ADM-AUTH-002: Login Lockout After Failed Attempts

Precondition: Admin account is active.

Steps:

1. Submit the Admin email with a wrong password 5 times.
2. Submit the same email again.

Expected result:

- Each failed attempt is logged.
- After 5 recent failures, login is blocked with a lockout message.
- No Admin session is created.

Technical verification:

```sql
SELECT COUNT(*) AS RecentFailedAttempts
FROM LoginHistory lh
JOIN Users u ON u.UserId = lh.UserId
WHERE u.Email = 'admin@aidify.edu'
  AND lh.Success = 0
  AND lh.[Timestamp] >= DATEADD(MINUTE, -5, GETUTCDATE());
```

### ADM-AUTH-003: Role Protection For Admin Pages

Precondition: Browser is logged out, then separately logged in as Learner and Instructor.

Steps:

1. Open each Admin URL while logged out.
2. Repeat while logged in as Learner.
3. Repeat while logged in as Instructor.

Expected result:

- All protected Admin pages redirect to `/Auth/Login.aspx` or deny access.
- No Admin data is returned to wrong-role users.
- AJAX WebMethods must also return `null` or access-denied output for non-Admin sessions.

Pages to test:

- `/Admin/Dashboard.aspx`
- `/Admin/Users/List.aspx`
- `/Admin/Users/Create.aspx`
- `/Admin/Users/Edit.aspx?userId=1`
- `/Admin/Content/ApprovalQueue.aspx`
- `/Admin/Analytics.aspx`
- `/Admin/AuditLogs.aspx`
- `/Admin/AI_Insights.aspx`

Technical implementation check:

- Page classes must inherit `BaseRolePage`.
- Each page must set `RequiredRole => Constants.RoleAdmin`.
- WebMethods must check `Session[Constants.SessionRole]`.

### ADM-DASH-001: Dashboard Statistics Match Database

Steps:

1. Login as Admin.
2. Open `/Admin/Dashboard.aspx`.
3. Observe cards for users, active learners, pending modules, quiz attempts, completion rate, alerts.
4. Refresh the page.

Expected result:

- Dashboard loads without server errors.
- Counts match SQL aggregates.
- Pending-module alert appears when pending modules exist.
- Failed-login alert appears when failed login attempts exist in the last 24 hours.

Technical verification:

```sql
SELECT COUNT(*) AS ActiveUsers FROM Users WHERE IsActive = 1;
SELECT COUNT(*) AS ActiveLearners
FROM Users u JOIN Roles r ON r.RoleId = u.RoleId
WHERE r.RoleName = 'Learner' AND u.IsActive = 1;
SELECT COUNT(*) AS PendingModules
FROM Modules WHERE Status = 'PendingReview' AND IsDeleted = 0;
SELECT COUNT(*) AS TotalAttempts FROM QuizAttempts;
```

### ADM-DASH-002: Dashboard AI Daily Summary

Steps:

1. Login as Admin.
2. Open `/Admin/Dashboard.aspx`.
3. Trigger/load the daily AI insight card.
4. Refresh and trigger/load again.

Expected result:

- If Gemini key/network is configured, the insight summarizes real platform statistics.
- If AI is unavailable, UI displays `AI service temporarily unavailable — please try again.`
- No page crash occurs.
- Second successful call should use the 24-hour `HttpRuntime.Cache` value.

Technical verification:

- Confirm `AIInsightsService.GetDailySummaryAsync` builds JSON from `AdminRepository.GetPlatformStats`.
- Confirm prompt contains only aggregated numeric data, not raw names/emails.
- Confirm exception path returns a safe message.

### ADM-USR-001: User List Loads And Shows User Metadata

Steps:

1. Login as Admin.
2. Open `/Admin/Users/List.aspx`.
3. Confirm all users are listed with name, email, role, status, initials, last activity.
4. Use the UI search/filter controls if present.

Expected result:

- User rows render correctly.
- Active/disabled status is clear.
- Role badges show Admin, Instructor, Learner.
- Last login displays `Never` or relative time.

Technical verification:

```sql
SELECT u.UserId, u.FullName, u.Email, r.RoleName, u.IsActive,
       (SELECT MAX(lh.[Timestamp])
        FROM LoginHistory lh
        WHERE lh.UserId = u.UserId AND lh.Success = 1) AS LastLogin
FROM Users u
JOIN Roles r ON r.RoleId = u.RoleId
ORDER BY u.CreatedAt DESC;
```

### ADM-USR-002: Create User With Role

Steps:

1. Open `/Admin/Users/Create.aspx`.
2. Enter a unique full name and email.
3. Select role: Admin, Instructor, then Learner across separate test runs.
4. Choose Active status.
5. Submit.

Expected result:

- New user is inserted into `Users`.
- `RoleId` matches selected role.
- `IsEmailConfirmed = 1` for admin-created account.
- Temporary password is hashed with BCrypt.
- Reset token is inserted into `EmailTokens`.
- Reset email is attempted.
- Audit row `CreateUser` is written.
- Duplicate email shows validation error and does not insert a second user.

Technical verification:

```sql
SELECT u.UserId, u.FullName, u.Email, r.RoleName, u.IsActive, u.IsEmailConfirmed, u.CreatedAt
FROM Users u
JOIN Roles r ON r.RoleId = u.RoleId
WHERE u.Email = 'admin-test@example.test';

SELECT *
FROM EmailTokens
WHERE UserId = (SELECT UserId FROM Users WHERE Email = 'admin-test@example.test')
ORDER BY ExpiresAt DESC;

SELECT TOP 5 *
FROM AuditLogs
WHERE Action = 'CreateUser'
ORDER BY [Timestamp] DESC;
```

### ADM-USR-003: Edit User Details

Steps:

1. Open `/Admin/Users/Edit.aspx?userId={testUserId}`.
2. Change first name, last name, email, and role.
3. Save.
4. Return to the Users list.

Expected result:

- `Users.FullName`, `Email`, `RoleId`, and active status are updated.
- Page displays success message.
- Users list reflects changes.
- Audit row `UpdateUser` is written.

Technical verification:

```sql
SELECT u.UserId, u.FullName, u.Email, r.RoleName, u.IsActive
FROM Users u
JOIN Roles r ON r.RoleId = u.RoleId
WHERE u.UserId = {testUserId};

SELECT TOP 5 *
FROM AuditLogs
WHERE TargetEntity = 'Users'
  AND TargetId = {testUserId}
ORDER BY [Timestamp] DESC;
```

### ADM-USR-004: Enable And Disable User

Steps:

1. Open `/Admin/Users/List.aspx`.
2. Select a non-current test user.
3. Disable the account.
4. Attempt login as that user.
5. Enable the account again.

Expected result:

- Disable sets `Users.IsActive = 0`.
- Disabled user cannot log in.
- Enable sets `Users.IsActive = 1`.
- Audit rows `DisableUser` and `EnableUser` are written.

Technical verification:

```sql
SELECT UserId, Email, IsActive FROM Users WHERE UserId = {testUserId};

SELECT TOP 10 Action, TargetEntity, TargetId, [Timestamp]
FROM AuditLogs
WHERE TargetEntity = 'Users'
  AND TargetId = {testUserId}
ORDER BY [Timestamp] DESC;
```

### ADM-USR-005: Force Password Reset

Steps:

1. Open `/Admin/Users/Edit.aspx?userId={testUserId}`.
2. Trigger Force Reset Password.
3. Observe success or SMTP failure message.

Expected result:

- A reset token is inserted into `EmailTokens` with `Purpose = 'Reset'`.
- If SMTP is configured, email is sent.
- If SMTP is not configured, the page displays a graceful error.
- Audit row `ForceResetPassword` is written when reset action succeeds.

Technical verification:

```sql
SELECT TOP 5 *
FROM EmailTokens
WHERE UserId = {testUserId}
  AND Purpose = 'Reset'
ORDER BY ExpiresAt DESC;

SELECT TOP 5 *
FROM AuditLogs
WHERE Action = 'ForceResetPassword'
  AND TargetId = {testUserId}
ORDER BY [Timestamp] DESC;
```

### ADM-USR-006: Soft Delete User Requirement

Source requirement:

- FR-A07 says Admin must permanently delete a user with confirmation modal, implemented as soft-delete flag in DB.

Current implementation test:

1. Search Admin pages for a delete-user action.
2. Inspect `Users` schema for an `IsDeleted` flag.
3. Attempt to find delete UI on `/Admin/Users/List.aspx`.

Expected result:

- If implemented later: user should be marked deleted/disabled, never physically removed, and audit row written.
- In the current active implementation: this should be recorded as a coverage gap because no visible soft-delete user flow is present.

### ADM-ROLE-001: Roles And Permissions Requirement

Source requirement:

- FR-A09 says Admin can manage roles and permissions, with default roles view-only and custom roles editable.

Current implementation test:

1. Check for `/Admin/Roles.aspx`.
2. Check whether a permissions table exists.
3. Check whether roles can be created or edited in UI.

Expected result:

- If implemented later: role/permission changes persist and are audited.
- In the current active implementation: this should be recorded as a coverage gap because no active `Admin/Roles.aspx` page or permission-management schema was found.

### ADM-CONTENT-001: Pending Module Approval Queue

Source flow:

Instructor submits module for review, setting `Modules.Status = 'PendingReview'`. Admin queue displays pending modules. Admin approves or rejects. Approval publishes the module. Rejection should require a reason per FR-A10; the flowchart says reject changes status away from public visibility.

Steps:

1. Ensure at least one module has `Status = 'PendingReview'` and `IsDeleted = 0`.
2. Open `/Admin/Content/ApprovalQueue.aspx`.
3. Confirm module card shows title, difficulty, creator, submission date.
4. Click Approve.
5. Repeat with another pending module and click Reject.

Expected result:

- Pending modules are loaded from `GetPendingModules`.
- Approve changes status to `Published`.
- Reject removes module from queue and changes status to non-public.
- URL is redirected back to `ApprovalQueue.aspx` without action query parameters.
- Audit rows `ApproveModule` and `RejectModule` are written.
- Creator receives notification for approve/reject.

Important requirement check:

- FR-A10 requires rejection reason.
- Current code rejects without reason and sets module status to `Draft`, not `Rejected`.
- If professor expects exact flowchart wording, this must be logged as a requirement mismatch unless later changed.

Technical verification:

```sql
SELECT ModuleId, Title, Status, IsDeleted, CreatedBy
FROM Modules
WHERE ModuleId = {moduleId};

SELECT TOP 10 *
FROM AuditLogs
WHERE TargetEntity = 'Modules'
  AND TargetId = {moduleId}
ORDER BY [Timestamp] DESC;

SELECT TOP 10 *
FROM Notifications
WHERE UserId = (SELECT CreatedBy FROM Modules WHERE ModuleId = {moduleId})
ORDER BY CreatedAt DESC;
```

### ADM-CONTENT-002: Pending Event Approval Queue

Steps:

1. Ensure an event has `Status = 'PendingReview'`.
2. Open `/Admin/Content/ApprovalQueue.aspx`.
3. Confirm event appears with title, location, creator, date.
4. Approve the event.
5. Repeat with another event and reject it.

Expected result:

- Approve changes `Events.Status = 'Published'`.
- Reject changes `Events.Status = 'Draft'`.
- Audit rows `ApproveEvent` and `RejectEvent` are written.

Technical verification:

```sql
SELECT EventId, Title, Status, EventDate, Location
FROM Events
WHERE EventId = {eventId};

SELECT TOP 10 *
FROM AuditLogs
WHERE TargetEntity = 'Events'
  AND TargetId = {eventId}
ORDER BY [Timestamp] DESC;
```

### ADM-ANALYTICS-001: Analytics Dashboard Data

Steps:

1. Login as Admin.
2. Open `/Admin/Analytics.aspx`.
3. Confirm charts/cards load.
4. Compare totals with SQL.

Expected result:

- Analytics page loads without JavaScript/server errors.
- Payload includes total users, active learners, total attempts, completion rate, attempts by module, popular modules, score distribution.
- Chart values match database aggregates.

Technical verification:

```sql
SELECT COUNT(*) AS TotalUsers FROM Users WHERE IsActive = 1;

SELECT COUNT(*) AS ActiveLearners
FROM Users u
JOIN Roles r ON r.RoleId = u.RoleId
WHERE r.RoleName = 'Learner' AND u.IsActive = 1;

SELECT COUNT(*) AS TotalAttempts FROM QuizAttempts;

SELECT TOP 7 m.Title, COUNT(qa.AttemptId) AS Attempts
FROM Modules m
LEFT JOIN Quizzes q ON q.ModuleId = m.ModuleId
LEFT JOIN QuizAttempts qa ON qa.QuizId = q.QuizId
WHERE m.IsDeleted = 0
GROUP BY m.ModuleId, m.Title
ORDER BY Attempts DESC;
```

### ADM-ANALYTICS-002: CSV Export

Steps:

1. Login as Admin.
2. Open `/Admin/Analytics.aspx?export=users_csv`.
3. Save/open the downloaded file.

Expected result:

- Browser downloads a CSV file named like `users_YYYYMMDD.csv`.
- CSV contains header `UserId,FullName,Email,Role,Status`.
- Row count matches users returned by `AdminRepository.GetAllUsers`.

Technical verification:

```sql
SELECT COUNT(*) AS UsersCount FROM Users;
```

Requirement note:

- FR-A13 asks for PDF and CSV export for analytics reports.
- Current implementation confirms users CSV export. PDF export should be recorded as a coverage gap unless implemented later.

### ADM-AUDIT-001: Audit Logs Page

Steps:

1. Login as Admin.
2. Open `/Admin/AuditLogs.aspx`.
3. Filter by action and search text.
4. Change time window and page size.
5. Compare displayed records with SQL.

Expected result:

- Audit records display actor, action, target entity, target id, IP address, timestamp.
- Filtering and pagination work.
- Stats show failed logins, total actions, and password resets for the last 24 hours.

Technical verification:

```sql
SELECT TOP 100 a.AuditId, a.Action, a.TargetEntity, a.TargetId, a.IPAddress, a.[Timestamp],
       ISNULL(u.FullName, 'System') AS ActorName
FROM AuditLogs a
LEFT JOIN Users u ON u.UserId = a.UserId
WHERE a.[Timestamp] >= DATEADD(HOUR, -24, GETUTCDATE())
ORDER BY a.[Timestamp] DESC;
```

### ADM-AI-001: AI Insights Page Stats

Steps:

1. Login as Admin.
2. Open `/Admin/AI_Insights.aspx`.
3. Confirm stat cards load.

Expected result:

- Stats come from `AdminRepository.GetPlatformStats`.
- Values match Dashboard and SQL.
- Non-Admin sessions receive no data.

### ADM-AI-002: Admin Decision Support

Steps:

1. Open `/Admin/AI_Insights.aspx`.
2. Ask: `Which module has the worst completion rate?`
3. Ask: `How many learners and quiz attempts are currently recorded?`
4. Repeat up to 20 calls in one hour.

Expected result:

- AI answer is concise and cites available numbers.
- If data cannot answer the question, response says data is insufficient.
- No raw email/name PII is sent to Gemini; only aggregate JSON is included.
- After 20 calls in the session window, response says rate limit reached.
- If Gemini key/network fails, UI shows graceful unavailable message.

Technical implementation check:

- Prompt template: `AI/Prompts/AdminInsights.txt`
- Service: `Services/AIInsightsService.cs`
- Data source: `AdminRepository.GetPlatformStats`
- Rate limiter: session keys `AiCallCount` and `AiCallWindowStart`

### ADM-MOD-001: Admin Module Creation

Steps:

1. Login as Admin.
2. Open `/Admin/Modules/Create.aspx`.
3. Enter module title, description, difficulty, status, preview flag, and lesson details.
4. Submit.

Expected result:

- New `Modules` row is inserted.
- `CreatedBy` is the Admin user id.
- `IsDeleted = 0`.
- If lessons are provided, `Lessons` rows are inserted for that module.
- Page displays success or redirects as designed.

Technical verification:

```sql
SELECT TOP 5 *
FROM Modules
WHERE CreatedBy = (SELECT UserId FROM Users WHERE Email = 'admin@aidify.edu')
ORDER BY CreatedAt DESC;

SELECT *
FROM Lessons
WHERE ModuleId = {newModuleId}
ORDER BY SequenceOrder;
```

### ADM-EVT-001: Admin Event Creation

Steps:

1. Login as Admin.
2. Open `/Admin/Events/Create.aspx`.
3. Enter title, description, date, location, meeting URL, and status.
4. Submit.

Expected result:

- New `Events` row is inserted.
- `CreatedBy` is the Admin user id.
- Status persists as selected.

Technical verification:

```sql
SELECT TOP 5 *
FROM Events
WHERE CreatedBy = (SELECT UserId FROM Users WHERE Email = 'admin@aidify.edu')
ORDER BY EventId DESC;
```

## Data Persistence And Update Preservation Checklist

Run this checklist after every Admin write action:

1. Refresh the page and confirm the UI still shows the updated data.
2. Logout and login again as Admin; confirm the update remains.
3. Query SQL directly to confirm the expected row/column changed.
4. Confirm related data was not unintentionally deleted.
5. Confirm `AuditLogs` contains the Admin action.
6. Confirm wrong-role users cannot perform the same action.
7. Confirm browser refresh does not repeat approval/rejection actions because of Post-Redirect-Get.

## Access-Control Matrix

| Page/API | Logged out | Learner | Instructor | Admin |
|---|---|---|---|---|
| `/Admin/Dashboard.aspx` | Redirect | Redirect | Redirect | Allow |
| `/Admin/Dashboard.aspx/GetStats` | Null/deny | Null/deny | Null/deny | JSON stats |
| `/Admin/Users/List.aspx` | Redirect | Redirect | Redirect | Allow |
| `/Admin/Users/List.aspx/GetUsers` | Null/deny | Null/deny | Null/deny | JSON users |
| `/Admin/Users/Create.aspx` | Redirect | Redirect | Redirect | Allow |
| `/Admin/Users/Edit.aspx?userId=1` | Redirect | Redirect | Redirect | Allow |
| `/Admin/Content/ApprovalQueue.aspx` | Redirect | Redirect | Redirect | Allow |
| `/Admin/Analytics.aspx` | Redirect | Redirect | Redirect | Allow |
| `/Admin/AuditLogs.aspx` | Redirect | Redirect | Redirect | Allow |
| `/Admin/AI_Insights.aspx` | Redirect | Redirect | Redirect | Allow |

## Security And Validation Tests

### SQL Injection

Inputs to try:

- Login email: `' OR 1=1 --`
- User search: `' OR '1'='1`
- User edit email: `test@example.com'; DROP TABLE Users; --`

Expected result:

- No SQL error is shown.
- No unauthorized login occurs.
- No table is damaged.
- Parameterized SQL remains in use.

### XSS

Inputs to try in editable text fields:

```html
<script>alert('xss')</script>
```

Expected result:

- Script does not execute in Admin list/details pages.
- Data is encoded or safely rendered.
- If any script executes, log as Sev-1 security issue.

### Validation

Admin forms must reject:

- Empty required name/title/email fields.
- Duplicate email during user creation.
- Invalid email format.
- Invalid dates for events.
- Missing required role/status.

Expected result:

- Form displays validation or error message.
- No database write occurs for invalid input.
- No partial audit row is written for failed validation.

## Known Requirement Gaps To Track

These are requirements from the planning documents that require explicit pass/fail review:

1. `Admin/Roles.aspx` and editable role-permission management were required, but no active page/schema was found in the current solution.
2. User soft-delete with confirmation was required, but no visible Admin delete-user flow or `Users.IsDeleted` flag was found.
3. Rejection reason for content approval was required, but current module/event rejection does not capture a reason.
4. Flowchart says rejected modules should become `Rejected`; current code sets module status to `Draft`.
5. Analytics PDF export was required; current confirmed export path is users CSV.
6. AI daily summary is cached in `HttpRuntime.Cache`; the `AIInsights` table exists, but current service does not visibly persist every AI response/call to that table.
7. Admin Dashboard originally requested total modules, total quiz attempts, and AI insight; current implementation includes additional useful metrics, but all card labels should be visually confirmed.

## Final Admin Acceptance Criteria

Admin functionality can be considered demo-ready when:

- Admin login, lockout, and role protection pass.
- Dashboard cards match direct SQL counts.
- User create/edit/enable/disable/force-reset flows persist data and write audit logs.
- Approval queue publishes/rejects pending modules/events, writes audit logs, and avoids repeated actions on refresh.
- Analytics charts load from real SQL aggregates.
- CSV export works and PDF export status is clearly documented.
- Audit Logs page proves write actions are traceable.
- AI daily summary and decision support either work with Gemini or fail gracefully without breaking the page.
- All known requirement gaps are either fixed or documented honestly for the final report.

