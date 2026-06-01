# Aidify Learner Functionality and Technical Test Description

## Purpose

This document defines how to test the Aidify Learner role against:

- `C:\Users\superstar umzi\Downloads\original_plan_aidify.md`
- `C:\Users\superstar umzi\Downloads\Aidify\FLOWCHART_DESCRIPTIONS.md`
- The current Web Forms implementation in `Aidify_assigment`

It covers functional tests, data-persistence checks, SQL verification queries, role protection, and known implementation gaps. It should be used as the Learner QA checklist and as supporting material for the final report/demo.

## Learner Scope Under Test

Primary Learner pages in the current solution:

- `/Learner/Dashboard.aspx`
- `/Learner/Profile.aspx`
- `/Learner/Courses/Catalogue.aspx`
- `/Learner/Courses/Details.aspx?moduleId={id}`
- `/Learner/Courses/Lesson.aspx?lessonId={id}`
- `/Learner/Quiz/Take.aspx?quizId={id}`
- `/Learner/Quiz/Results.aspx?attemptId={id}`
- `/Learner/Quiz/History.aspx`
- `/Learner/Progress.aspx`
- `/Learner/Badges.aspx`
- `/Learner/Certificate.aspx`
- `/Learner/League.aspx`
- `/Learner/Challenges.aspx`
- `/Learner/Events.aspx`
- `/Learner/Notification.aspx`

Primary technical components:

- `Security/BaseRolePage.cs`
- `Security/AuthHelper.cs`
- `Services/AuthService.cs`
- `Services/BadgeService.cs`
- `Services/NotificationService.cs`
- `Services/AuditService.cs`
- Learner code-behind files under `Learner/`
- Database schema under `database/01_Schema.sql`

Primary database tables:

- `Users`, `Roles`, `LoginHistory`
- `Modules`, `Lessons`, `Quizzes`, `Questions`, `Options`
- `Enrollments`, `Progress`
- `QuizAttempts`, `AttemptAnswers`
- `Badges`, `UserBadges`
- `Certificates`
- `League`
- `Challenges`, `ChallengeParticipation`
- `Events`, `EventRegistrations`
- `Notifications`
- `DiscussionThreads`, `DiscussionReplies`

## Test Environment

Use the current local Web Forms application:

- Base URL: `http://localhost:8080`
- Browser: Chrome
- Database: `(LocalDB)\AidifyLocalDB`, database `AidifyDB`
- Recommended Learner login: `learner@aidify.edu / Admin123!`

Before testing:

1. Build the solution in Debug mode.
2. Confirm LocalDB is running.
3. Confirm seed scripts have created published modules, lessons, quizzes, questions, options, and badges.
4. Use Chrome for visual/runtime testing.
5. Record SQL row counts before write-flow tests so persistence can be proven.

Useful SQL baseline:

```sql
DECLARE @LearnerId INT = (SELECT UserId FROM Users WHERE Email = 'learner@aidify.edu');

SELECT @LearnerId AS LearnerId;
SELECT COUNT(*) AS PublishedModules FROM Modules WHERE Status = 'Published' AND IsDeleted = 0;
SELECT COUNT(*) AS Enrollments FROM Enrollments WHERE UserId = @LearnerId;
SELECT COUNT(*) AS ProgressRows
FROM Progress p JOIN Enrollments e ON e.EnrolId = p.EnrolId
WHERE e.UserId = @LearnerId;
SELECT COUNT(*) AS QuizAttempts FROM QuizAttempts WHERE UserId = @LearnerId;
SELECT COUNT(*) AS UserBadges FROM UserBadges WHERE UserId = @LearnerId;
SELECT COUNT(*) AS Certificates FROM Certificates WHERE UserId = @LearnerId;
SELECT COUNT(*) AS LeagueRows FROM League WHERE UserId = @LearnerId;
SELECT COUNT(*) AS UnreadNotifications FROM Notifications WHERE UserId = @LearnerId AND IsRead = 0;
```

## Requirement Coverage Matrix

| Requirement | Source expectation | Current test target | Implementation status |
|---|---|---|---|
| FR-L01 | Dashboard shows enrolled courses, percentage complete, league rank, latest badge, next recommended module | `/Learner/Dashboard.aspx` | Partial: courses, progress, tier/points, next lesson exist; league rank/latest badge/recommended module are limited or not clearly bound |
| FR-L02 | Learner can view/edit profile, including avatar upload | `/Learner/Profile.aspx` | Implemented with name, email, avatar upload; needs duplicate-email validation testing |
| FR-L03 | Catalogue shows published courses with cover, description, difficulty, estimated time, enrol button | `/Learner/Courses/Catalogue.aspx` | Mostly implemented: published modules, cover, description, difficulty, enrol; estimated total time may be partial/not explicit |
| FR-L04 | Learner self-enrols and progress is initialized | Catalogue/Details enrollment | Partially implemented: `Enrollments` and `League` row created; no separate initial progress rows until lessons are completed |
| FR-L05 | Lesson content page-by-page with media and Mark Complete | `/Learner/Courses/Lesson.aspx` | Implemented for lesson HTML/body and completion; media depends on stored HTML content |
| FR-L06 | Scheduled quiz records attempt score/pass/timestamp | `/Learner/Quiz/Take.aspx` | Implemented with `QuizAttempts`; `AttemptAnswers` inserted |
| FR-L07 | Immediate feedback with per-question correctness, explanations, score | `/Learner/Quiz/Results.aspx` | Partial: score/verdict/per-question correctness; explanations empty; selected answer may not display because `SelectedOptionId` is not stored |
| FR-L08 | Random pop-up quizzes at 15% probability | No active PopQuiz page/control/API found | Missing |
| FR-L09 | Full quiz history and review past questions/correct answers | `/Learner/Quiz/History.aspx`, Results page | Partial: history exists; review via result link depends on UI; selected answer storage is incomplete |
| FR-L10 | Progress dashboard with completed/pending modules, badges, certificates | `/Learner/Progress.aspx` | Implemented for progress, badges, certificates listing; certificate generation missing |
| FR-L11 | Badge auto-award by rules, shown on profile | `BadgeService`, Progress/Badges pages | Partial: `BadgeService.Evaluate` runs after quiz only; lesson completion does not call it; notification push is stubbed |
| FR-L12 | Auto-generate PDF certificate on full course completion | `/Learner/Certificate.aspx`, `Certificates` table | Missing/partial: certificate listing exists, but no generation service/PDF creation hook found |
| FR-L13 | League tiers from points with promotions/demotions batch | `League` table, `Lesson`, `Quiz`, `/Learner/League.aspx` | Partial: points and tier update on lesson/quiz actions; no daily batch/demotion job |
| FR-L14 | Leaderboard top 20 learners | `/Learner/League.aspx` | Implemented, global top 20 by points |
| FR-L15 | Challenges list/join/completion points/badge | `/Learner/Challenges.aspx` | Partial: list and join implemented; completion, points award, badge trigger not implemented |
| FR-L16 | Events list/register/confirmation email | `/Learner/Events.aspx` | Partial: list/register implemented; confirmation email not found |
| FR-L17 | In-app notifications/bell for system events | `/Learner/Notification.aspx`, `NotificationBell.ascx` | Partial: unread count and read actions work; `NotificationService.Push` is currently stubbed |
| FR-L18 | Per-module discussion threads and replies | `DiscussionThreads`, `DiscussionReplies` tables | Missing from Learner UI |

## Functional Test Cases

### LRN-AUTH-001: Learner Login Success

Precondition: Learner user exists, active, email confirmed.

Steps:

1. Open `/Auth/Login.aspx`.
2. Enter `learner@aidify.edu`.
3. Enter `Admin123!`.
4. Click Login.

Expected result:

- Learner is redirected to `/Learner/Dashboard.aspx`.
- Session stores learner user id, name, and role.
- Protected Learner pages are accessible.
- `LoginHistory` records a successful login.

Technical verification:

```sql
SELECT TOP 5 lh.*
FROM LoginHistory lh
JOIN Users u ON u.UserId = lh.UserId
WHERE u.Email = 'learner@aidify.edu'
ORDER BY lh.[Timestamp] DESC;
```

### LRN-AUTH-002: Learner Access Control

Steps:

1. Open every Learner page while logged out.
2. Repeat while logged in as Admin.
3. Repeat while logged in as Instructor.
4. Login as Learner and repeat.

Expected result:

- Logged-out, Admin, and Instructor sessions are redirected/blocked.
- Learner session is allowed.
- Pages inherit `BaseRolePage` and set `RequiredRole = Constants.RoleLearner`.

Pages to test:

- `/Learner/Dashboard.aspx`
- `/Learner/Profile.aspx`
- `/Learner/Courses/Catalogue.aspx`
- `/Learner/Courses/Details.aspx?moduleId=1`
- `/Learner/Courses/Lesson.aspx?lessonId=1`
- `/Learner/Quiz/Take.aspx?quizId=1`
- `/Learner/Quiz/History.aspx`
- `/Learner/Progress.aspx`
- `/Learner/Badges.aspx`
- `/Learner/Certificate.aspx`
- `/Learner/Notification.aspx`
- `/Learner/League.aspx`
- `/Learner/Events.aspx`
- `/Learner/Challenges.aspx`

### LRN-DASH-001: Dashboard Loads Learner Data

Steps:

1. Login as Learner.
2. Open `/Learner/Dashboard.aspx`.
3. Confirm welcome message uses learner name.
4. Confirm enrolled courses display with progress bars.
5. Confirm league tier/points display.
6. Click Continue Learning.
7. Click Browse All.

Expected result:

- Enrolled courses come from `Enrollments`, `Modules`, `Lessons`, `Progress`.
- Progress percentage matches completed lessons divided by total lessons.
- Continue Learning goes to first incomplete lesson, or Catalogue if none exists.
- Browse All opens Catalogue.
- If no enrolled courses exist, empty-state course card appears.

Technical verification:

```sql
DECLARE @LearnerId INT = (SELECT UserId FROM Users WHERE Email = 'learner@aidify.edu');

SELECT m.ModuleId, m.Title,
       COUNT(DISTINCT l.LessonId) AS TotalLessons,
       COUNT(DISTINCT p.LessonId) AS CompletedLessons
FROM Enrollments e
JOIN Modules m ON m.ModuleId = e.ModuleId
LEFT JOIN Lessons l ON l.ModuleId = m.ModuleId
LEFT JOIN Progress p ON p.EnrolId = e.EnrolId AND p.LessonId = l.LessonId
WHERE e.UserId = @LearnerId AND m.IsDeleted = 0
GROUP BY m.ModuleId, m.Title;

SELECT Tier, Points FROM League WHERE UserId = @LearnerId;
```

Requirement note:

- Latest badge controls exist in markup, but current Dashboard code does not visibly bind latest badge data.
- League rank and next recommended module are not fully implemented as described in FR-L01.

### LRN-PROFILE-001: View And Edit Profile

Steps:

1. Login as Learner.
2. Open `/Learner/Profile.aspx`.
3. Confirm full name, email, avatar display.
4. Change full name.
5. Save.
6. Logout and login again.

Expected result:

- `Users.FullName` updates.
- Session display name updates.
- Success message appears.
- Change persists after reload/login.
- Audit row `UpdateProfile` is written.

Technical verification:

```sql
DECLARE @LearnerId INT = (SELECT UserId FROM Users WHERE Email = 'learner@aidify.edu');

SELECT UserId, FullName, Email, AvatarPath
FROM Users
WHERE UserId = @LearnerId;

SELECT TOP 5 *
FROM AuditLogs
WHERE Action = 'UpdateProfile'
  AND TargetEntity = 'Users'
  AND TargetId = @LearnerId
ORDER BY [Timestamp] DESC;
```

### LRN-PROFILE-002: Avatar Upload Validation

Steps:

1. Open `/Learner/Profile.aspx`.
2. Upload a valid `.png`, `.jpg`, or `.gif` file below 2 MB.
3. Save.
4. Upload a non-image file, for example `.txt`.
5. Upload an image larger than 2 MB.

Expected result:

- Valid image is saved under `/Uploads/Avatars/{userId}.{ext}`.
- `Users.AvatarPath` updates.
- Non-image is rejected with an error.
- File over 2 MB is rejected.

Technical verification:

```sql
SELECT AvatarPath
FROM Users
WHERE Email = 'learner@aidify.edu';
```

Risk note:

- Profile email update should be tested with another user's email. The current code does not visibly pre-check duplicate email before update, so SQL unique constraint may produce an unhandled or unfriendly error.

### LRN-CAT-001: Course Catalogue Lists Published Modules

Steps:

1. Login as Learner.
2. Open `/Learner/Courses/Catalogue.aspx`.
3. Confirm only published, non-deleted modules display.
4. Confirm each card shows title, description, difficulty, cover image/fallback, and Enrol button.
5. Search by keyword.
6. Filter by difficulty.

Expected result:

- SQL reads `Modules` where `Status = 'Published'` and `IsDeleted = 0`.
- Search applies to title/description.
- Difficulty filter applies to `DifficultyLevel`.
- No draft/pending/deleted modules appear.

Technical verification:

```sql
SELECT ModuleId, Title, DifficultyLevel, Description, CoverImagePath, Status, IsDeleted
FROM Modules
WHERE Status = 'Published' AND IsDeleted = 0
ORDER BY Title;
```

### LRN-ENROL-001: Enrol From Catalogue

Steps:

1. Pick a published module where the learner is not enrolled.
2. Open Catalogue.
3. Click Enrol.
4. Confirm redirect to Course Details.
5. Repeat Enrol for the same module if UI allows.

Expected result:

- First enrolment inserts exactly one `Enrollments` row.
- If learner has no `League` row, one is created with `Bronze`, `0`.
- Repeated enrolment does not create duplicate rows.
- Redirect goes to `/Learner/Courses/Details.aspx?moduleId={id}`.

Technical verification:

```sql
DECLARE @LearnerId INT = (SELECT UserId FROM Users WHERE Email = 'learner@aidify.edu');

SELECT *
FROM Enrollments
WHERE UserId = @LearnerId AND ModuleId = {moduleId};

SELECT *
FROM League
WHERE UserId = @LearnerId;
```

Requirement note:

- FR-L04 says progress should be initialized. Current implementation initializes enrollment and league, but `Progress` rows are created only when lessons are completed.

### LRN-DETAILS-001: Course Details And Lesson List

Steps:

1. Open `/Learner/Courses/Details.aspx?moduleId={moduleId}`.
2. Confirm module title, description, difficulty, cover image, progress bar.
3. Confirm lesson list appears in sequence order.
4. If not enrolled, click Enrol on this page.
5. Refresh page.

Expected result:

- Module details load from `Modules`.
- Progress bar matches `Progress` rows.
- Lessons come from `Lessons`.
- Enrolment from Details is duplicate-safe.

Technical verification:

```sql
SELECT ModuleId, Title, Description, DifficultyLevel, CoverImagePath
FROM Modules
WHERE ModuleId = {moduleId};

SELECT LessonId, Title, EstimatedMinutes, SequenceOrder
FROM Lessons
WHERE ModuleId = {moduleId}
ORDER BY SequenceOrder;

DECLARE @LearnerId INT = (SELECT UserId FROM Users WHERE Email = 'learner@aidify.edu');
SELECT *
FROM Enrollments
WHERE UserId = @LearnerId AND ModuleId = {moduleId};
```

### LRN-LESSON-001: Lesson Viewer

Steps:

1. Enrol in a module.
2. Open `/Learner/Courses/Lesson.aspx?lessonId={lessonId}`.
3. Confirm breadcrumb/module title.
4. Confirm lesson title and body render.
5. Confirm Next Lesson link.
6. Confirm Start Quiz link.

Expected result:

- Lesson loads from `Lessons`.
- Body HTML displays.
- Next Lesson navigates by `SequenceOrder`.
- Start Quiz links to first quiz for the module.

Technical verification:

```sql
SELECT l.LessonId, l.Title, l.BodyHtml, l.ModuleId, m.Title AS ModuleTitle
FROM Lessons l
JOIN Modules m ON m.ModuleId = l.ModuleId
WHERE l.LessonId = {lessonId};

SELECT TOP 1 QuizId
FROM Quizzes
WHERE ModuleId = {moduleId};
```

Security note:

- Lesson HTML is rendered through `Literal`. Test that unsafe `<script>` content is not present in seeded/instructor content, or record this as an XSS risk if rich text is not sanitized before storage.

### LRN-LESSON-002: Mark Lesson Complete

Steps:

1. Open an incomplete lesson for an enrolled module.
2. Click Mark Complete.
3. Refresh the page.
4. Click Mark Complete again if UI allows.

Expected result:

- One `Progress` row is inserted.
- UI changes to completed state.
- Learner receives +5 league points once.
- Repeated completion does not duplicate `Progress` or points.

Technical verification:

```sql
DECLARE @LearnerId INT = (SELECT UserId FROM Users WHERE Email = 'learner@aidify.edu');

SELECT p.*
FROM Progress p
JOIN Enrollments e ON e.EnrolId = p.EnrolId
WHERE e.UserId = @LearnerId AND p.LessonId = {lessonId};

SELECT Tier, Points
FROM League
WHERE UserId = @LearnerId;
```

Requirement note:

- Flowchart says badge evaluation is triggered after quiz submission and lesson completion. Current lesson completion adds league points but does not visibly call `BadgeService.Evaluate`.

### LRN-QUIZ-001: Quiz Load

Steps:

1. Open `/Learner/Quiz/Take.aspx?quizId={quizId}`.
2. Confirm quiz title, description, time limit.
3. Confirm questions and four options render.
4. Inspect page source or dev tools.

Expected result:

- Quiz metadata loads from `Quizzes`.
- Questions/options load from `Questions` and `Options`.
- Correct answer index is stored server-side in session, not rendered as a correct-answer flag.
- Countdown timer displays if `TimeLimitSec > 0`.

Technical verification:

```sql
SELECT QuizId, Title, Description, TimeLimitSec, PassingPct
FROM Quizzes
WHERE QuizId = {quizId};

SELECT q.QuestionId, q.QuestionText, o.OptionId, o.OptionText, o.IsCorrect
FROM Questions q
JOIN Options o ON o.QuestionId = q.QuestionId
WHERE q.QuizId = {quizId}
ORDER BY q.QuestionId, o.OptionId;
```

### LRN-QUIZ-002: Quiz Submit And Attempt Persistence

Steps:

1. Open a quiz.
2. Select one answer for every question.
3. Submit.
4. Confirm redirect to Results page.

Expected result:

- `QuizAttempts` row is inserted with user id, quiz id, score, pass/fail, timestamp.
- `AttemptAnswers` rows are inserted for each question.
- If passed, learner receives +10 league points.
- Badge evaluation runs after submission.
- Browser lands on `/Learner/Quiz/Results.aspx?attemptId={id}`.

Technical verification:

```sql
DECLARE @LearnerId INT = (SELECT UserId FROM Users WHERE Email = 'learner@aidify.edu');

SELECT TOP 5 *
FROM QuizAttempts
WHERE UserId = @LearnerId AND QuizId = {quizId}
ORDER BY SubmittedAt DESC;

SELECT aa.*
FROM AttemptAnswers aa
WHERE aa.AttemptId = {attemptId}
ORDER BY aa.AnswerId;

SELECT Tier, Points
FROM League
WHERE UserId = @LearnerId;
```

Important implementation issue:

- `AttemptAnswers.SelectedOptionId` exists in the schema, but current quiz submission inserts only `AttemptId`, `QuestionId`, and `IsCorrect`.
- Because of this, Results page may not display the learner's selected answer; it can show blank/dash for `YourAnswer`.

### LRN-QUIZ-003: Results Feedback

Steps:

1. Submit a quiz.
2. Open the Results page.
3. Confirm score, passing threshold, PASSED/FAILED verdict.
4. Confirm per-question feedback.
5. If failed, click Retake Quiz.
6. If passed, inspect certificate/download link behavior.

Expected result:

- Score and verdict match `QuizAttempts`.
- Per-question correct/incorrect values match `AttemptAnswers`.
- Correct answer is displayed.
- Retake link returns to Take Quiz.

Requirement gaps:

- Per-question explanation is currently empty.
- Selected answer may not display because `SelectedOptionId` is not persisted.
- Passed quiz certificate link currently points back to course details, not a generated PDF certificate.

Technical verification:

```sql
SELECT qa.AttemptId, qa.Score, qa.Passed, qa.SubmittedAt, q.Title, q.PassingPct
FROM QuizAttempts qa
JOIN Quizzes q ON q.QuizId = qa.QuizId
WHERE qa.AttemptId = {attemptId};

SELECT q.QuestionText, aa.SelectedOptionId, aa.IsCorrect
FROM AttemptAnswers aa
JOIN Questions q ON q.QuestionId = aa.QuestionId
WHERE aa.AttemptId = {attemptId};
```

### LRN-QUIZ-004: Quiz History

Steps:

1. Submit at least one quiz.
2. Open `/Learner/Quiz/History.aspx`.
3. Confirm attempts display with quiz title, score, pass/fail, submitted date.
4. Click any review/result link if available.

Expected result:

- History shows only the current learner's attempts.
- Attempts are ordered newest first.
- Wrong learner cannot see another user's attempts.

Technical verification:

```sql
DECLARE @LearnerId INT = (SELECT UserId FROM Users WHERE Email = 'learner@aidify.edu');

SELECT qa.AttemptId, q.Title, qa.Score, qa.Passed, qa.SubmittedAt
FROM QuizAttempts qa
JOIN Quizzes q ON q.QuizId = qa.QuizId
WHERE qa.UserId = @LearnerId
ORDER BY qa.SubmittedAt DESC;
```

### LRN-PROGRESS-001: Progress Dashboard

Steps:

1. Enrol in at least one module.
2. Complete at least one lesson.
3. Open `/Learner/Progress.aspx`.

Expected result:

- Module progress cards show completed lesson count, total lessons, and percentage.
- Badges section shows earned badges or empty state.
- Certificates section shows certificate rows or empty state.

Technical verification:

```sql
DECLARE @LearnerId INT = (SELECT UserId FROM Users WHERE Email = 'learner@aidify.edu');

SELECT m.Title,
       COUNT(DISTINCT l.LessonId) AS Total,
       COUNT(DISTINCT p.LessonId) AS Completed
FROM Enrollments e
JOIN Modules m ON m.ModuleId = e.ModuleId
LEFT JOIN Lessons l ON l.ModuleId = m.ModuleId
LEFT JOIN Progress p ON p.EnrolId = e.EnrolId AND p.LessonId = l.LessonId
WHERE e.UserId = @LearnerId AND m.IsDeleted = 0
GROUP BY m.ModuleId, m.Title;
```

### LRN-BADGE-001: Badge Auto-Award After Quiz

Steps:

1. Ensure `Badges` table has rules such as `QuizScore` and `ModulesCompleted`.
2. Submit a quiz with a high enough score for a badge rule.
3. Open `/Learner/Badges.aspx` and `/Learner/Progress.aspx`.

Expected result:

- Qualifying badge inserts into `UserBadges`.
- Badge appears in Badges and Progress views.
- Duplicate quiz submissions should not duplicate the same badge.

Technical verification:

```sql
DECLARE @LearnerId INT = (SELECT UserId FROM Users WHERE Email = 'learner@aidify.edu');

SELECT b.BadgeId, b.Name, b.RuleType, b.RuleThreshold, ub.AwardedAt
FROM UserBadges ub
JOIN Badges b ON b.BadgeId = ub.BadgeId
WHERE ub.UserId = @LearnerId
ORDER BY ub.AwardedAt DESC;
```

Implementation note:

- `NotificationService.Push` is currently a stub, so badge-award notifications are not actually inserted unless that service is completed later.

### LRN-CERT-001: Certificate Listing

Steps:

1. Ensure a `Certificates` row exists for the learner.
2. Open `/Learner/Certificate.aspx`.
3. Open `/Learner/Progress.aspx`.
4. Click certificate download link.

Expected result:

- Certificate rows display module title, issue date, and download path.
- Download link points to `PdfPath` if present.

Technical verification:

```sql
DECLARE @LearnerId INT = (SELECT UserId FROM Users WHERE Email = 'learner@aidify.edu');

SELECT c.CertId, m.Title, c.PdfPath, c.IssuedAt
FROM Certificates c
JOIN Modules m ON m.ModuleId = c.ModuleId
WHERE c.UserId = @LearnerId
ORDER BY c.IssuedAt DESC;
```

Requirement gap:

- FR-L12 requires automatic PDF generation on full course completion. Current code lists existing certificate rows but no automatic certificate/PDF generation hook was found.

### LRN-LEAGUE-001: League Points And Tier

Steps:

1. Enrol in a module.
2. Complete a lesson.
3. Submit and pass a quiz.
4. Open `/Learner/League.aspx`.

Expected result:

- Lesson completion adds +5 points once.
- Passed quiz adds +10 points.
- Tier updates according to thresholds:
  - `<100` Bronze
  - `>=100` Silver
  - `>=300` Gold
  - `>=500` Platinum
- Leaderboard shows top 20 learners ordered by points.

Technical verification:

```sql
DECLARE @LearnerId INT = (SELECT UserId FROM Users WHERE Email = 'learner@aidify.edu');

SELECT Tier, Points
FROM League
WHERE UserId = @LearnerId;

SELECT TOP 20 u.FullName, l.Tier, l.Points,
       ROW_NUMBER() OVER (ORDER BY l.Points DESC) AS Rank
FROM League l
JOIN Users u ON u.UserId = l.UserId
ORDER BY l.Points DESC;
```

Requirement note:

- The current implementation updates tier during point-awarding actions. No daily cron-style batch or demotion process was found.

### LRN-NOTIF-001: Notification List And Read State

Steps:

1. Ensure learner has at least one unread notification.
2. Open `/Learner/Notification.aspx`.
3. Confirm message and created date display.
4. Click Mark as Read.
5. Add another unread notification.
6. Click Mark All as Read.

Expected result:

- Notification list shows rows from `Notifications`.
- Mark as Read updates one row to `IsRead = 1`.
- Mark All updates all unread rows for current learner.
- Notification bell count decreases to zero.

Technical verification:

```sql
DECLARE @LearnerId INT = (SELECT UserId FROM Users WHERE Email = 'learner@aidify.edu');

SELECT NotifId, Title, Body, Url, IsRead, CreatedAt
FROM Notifications
WHERE UserId = @LearnerId
ORDER BY CreatedAt DESC;
```

Implementation note:

- Notification reading works.
- Automatic notification creation is incomplete because `NotificationService.Push` currently does nothing.

### LRN-EVENT-001: Events List And Registration

Steps:

1. Ensure at least one `Events` row has `Status = 'Published'` and future `EventDate`.
2. Open `/Learner/Events.aspx`.
3. Confirm event title, description, date, location, meeting URL.
4. Click Register.
5. Refresh and try registering again.

Expected result:

- Published future events display.
- One `EventRegistrations` row is inserted.
- UI changes to registered state.
- Duplicate registration is prevented.

Technical verification:

```sql
DECLARE @LearnerId INT = (SELECT UserId FROM Users WHERE Email = 'learner@aidify.edu');

SELECT er.*
FROM EventRegistrations er
JOIN Events e ON e.EventId = er.EventId
WHERE er.UserId = @LearnerId
ORDER BY er.RegisteredAt DESC;
```

Requirement gap:

- FR-L16 says confirmation email is sent. No event confirmation email call was found in current Learner event registration code.

### LRN-CHAL-001: Challenges List And Join

Steps:

1. Ensure at least one `Challenges` row has `Status = 'Published'` and non-expired end date.
2. Open `/Learner/Challenges.aspx`.
3. Confirm challenge title, description, date, points reward.
4. Click Join.
5. Refresh and try joining again.

Expected result:

- Published active challenges display.
- One `ChallengeParticipation` row is inserted.
- Duplicate join is prevented.
- UI changes to already joined state.

Technical verification:

```sql
DECLARE @LearnerId INT = (SELECT UserId FROM Users WHERE Email = 'learner@aidify.edu');

SELECT cp.*
FROM ChallengeParticipation cp
JOIN Challenges c ON c.ChallengeId = cp.ChallengeId
WHERE cp.UserId = @LearnerId
ORDER BY cp.JoinedAt DESC;
```

Requirement gaps:

- Joining does not award challenge completion points.
- Challenge completion workflow was not found.
- Challenge completion badge trigger was not found.

### LRN-DISC-001: Discussion Threads

Source requirement:

- FR-L18 requires learners to participate in per-module discussion threads with posts and replies.

Current implementation test:

1. Search Learner navigation and pages for discussion UI.
2. Attempt to find `/Learner/Discussions.aspx`.
3. Inspect `DiscussionThreads` and `DiscussionReplies` tables.

Expected result:

- If implemented later: learner can create thread/reply for a module; data persists in `DiscussionThreads`/`DiscussionReplies`.
- In the current active implementation: record as missing because no Learner discussion page/action was found.

### LRN-POPQUIZ-001: Random Pop-Up Quiz

Source requirement:

- FR-L08 requires random pop-up quizzes at default 15% probability when navigating between lessons.

Current implementation test:

1. Open lesson pages repeatedly.
2. Search for `PopQuizModal`, `PopQuiz.ashx`, or `PopQuiz` JavaScript/API.
3. Check `Web.config` for pop quiz probability setting.

Expected result:

- If implemented later: pop-up quiz appears around configured probability and awards points on correct answer.
- In the current active implementation: record as missing because no active pop-up quiz control/API was found.

## Data Persistence And Update Preservation Checklist

Run after each Learner write action:

1. Refresh the page and confirm the UI still shows the updated state.
2. Logout and login again; confirm the state remains.
3. Query SQL directly to confirm the expected row/column changed.
4. Repeat the same action and confirm duplicates are not created.
5. Confirm wrong-role users cannot perform the same action.
6. Confirm related counters update:
   - Dashboard progress
   - Progress page percentages
   - League points/tier
   - Quiz history
   - Notification unread count

Write actions to verify:

- Profile update
- Avatar upload
- Enrolment
- Lesson completion
- Quiz submission
- Notification mark read/all read
- Event registration
- Challenge join

## Access-Control Matrix

| Page | Logged out | Admin | Instructor | Learner |
|---|---|---|---|---|
| `/Learner/Dashboard.aspx` | Redirect | Redirect | Redirect | Allow |
| `/Learner/Profile.aspx` | Redirect | Redirect | Redirect | Allow |
| `/Learner/Courses/Catalogue.aspx` | Redirect | Redirect | Redirect | Allow |
| `/Learner/Courses/Details.aspx?moduleId=1` | Redirect | Redirect | Redirect | Allow |
| `/Learner/Courses/Lesson.aspx?lessonId=1` | Redirect | Redirect | Redirect | Allow |
| `/Learner/Quiz/Take.aspx?quizId=1` | Redirect | Redirect | Redirect | Allow |
| `/Learner/Quiz/Results.aspx?attemptId={ownAttemptId}` | Redirect | Redirect | Redirect | Allow |
| `/Learner/Quiz/History.aspx` | Redirect | Redirect | Redirect | Allow |
| `/Learner/Progress.aspx` | Redirect | Redirect | Redirect | Allow |
| `/Learner/Badges.aspx` | Redirect | Redirect | Redirect | Allow |
| `/Learner/Certificate.aspx` | Redirect | Redirect | Redirect | Allow |
| `/Learner/League.aspx` | Redirect | Redirect | Redirect | Allow |
| `/Learner/Events.aspx` | Redirect | Redirect | Redirect | Allow |
| `/Learner/Challenges.aspx` | Redirect | Redirect | Redirect | Allow |
| `/Learner/Notification.aspx` | Redirect | Redirect | Redirect | Allow |

## Security And Validation Tests

### SQL Injection

Inputs to try:

- Catalogue search: `' OR 1=1 --`
- Profile name: `Learner'; DROP TABLE Users; --`
- Query string: `/Learner/Courses/Details.aspx?moduleId=1 OR 1=1`

Expected result:

- No SQL error is shown.
- No unintended records are returned.
- No table is damaged.
- Parameterized SQL remains in use.

### XSS

Inputs to try:

```html
<script>alert('xss')</script>
```

Test fields:

- Profile full name
- Module/lesson content if instructor-created test content is available
- Notification body if a test row is inserted

Expected result:

- Script must not execute in Learner pages.
- If lesson `BodyHtml` intentionally allows HTML, confirm content is trusted/sanitized before storage.

### File Upload Validation

Test files:

- Valid: `.png`, `.jpg`, `.gif`, below 2 MB
- Invalid: `.txt`, `.exe`
- Too large: image above 2 MB

Expected result:

- Only valid images save to `/Uploads/Avatars/`.
- Invalid files do not save and do not change `Users.AvatarPath`.

### Quiz Tampering

Steps:

1. Inspect quiz page source.
2. Confirm correct answers are not rendered as hidden inputs.
3. Change radio button values in browser dev tools and submit.

Expected result:

- Server grades against session-side correct map, not client-provided correct answers.
- Invalid/no answers are handled without crashing.

## Known Requirement Gaps To Track

These items are required by the planning documents but are not fully implemented in the current active solution:

1. Dashboard does not fully implement latest badge, league rank, or next recommended module.
2. Course enrolment creates `Enrollments` and `League`, but not initial `Progress` rows.
3. Quiz results do not persist `SelectedOptionId`, so selected-answer review can be incomplete.
4. Quiz result explanations are empty.
5. Pop-up quizzes are missing.
6. Badge evaluation runs after quiz submission, but not visibly after lesson completion.
7. `NotificationService.Push` is a stub, so badge/system notifications are not automatically inserted.
8. Certificate listing exists, but automatic PDF certificate generation on full module completion is missing.
9. League points/tier updates happen during lesson/quiz actions, but no daily tier recalculation/demotion batch exists.
10. Challenge join exists, but challenge completion, points reward, and badge trigger are missing.
11. Event registration exists, but confirmation email is missing.
12. Learner discussion threads/replies are missing.
13. Real-time notifications/SignalR are not implemented.

## Final Learner Acceptance Criteria

Learner functionality can be considered demo-ready when:

- Learner login and role protection pass.
- Dashboard, Catalogue, Course Details, Lesson, Quiz Take, Quiz Results, Quiz History, Progress, Badges, Certificate, League, Events, Challenges, Notification, and Profile pages all load in Chrome.
- Catalogue shows only published non-deleted modules.
- Enrolment is duplicate-safe and persists in `Enrollments`.
- Lesson completion is duplicate-safe, persists in `Progress`, and awards league points once.
- Quiz submission inserts `QuizAttempts` and `AttemptAnswers`, redirects to Results, and records score/pass/fail.
- Progress dashboard reflects SQL completion data.
- Badges are awarded for quiz-based rules and displayed.
- Notifications can be viewed and marked read.
- Event registration and challenge join persist and avoid duplicates.
- Known gaps are either fixed or explicitly documented for the final report/demo.

