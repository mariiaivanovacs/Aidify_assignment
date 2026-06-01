# Aidify Instructor Functionality and Technical Test Description

## Purpose

This document defines the detailed test plan for the **Instructor** role in Aidify. It is based on:

- `C:\Users\superstar umzi\Downloads\original_plan_aidify.md`
- `C:\Users\superstar umzi\Downloads\Aidify\FLOWCHART_DESCRIPTIONS.md`
- The current `Aidify_assigment` Web Forms implementation.

The goal is to verify that instructors can create and manage course content, lessons, materials, quizzes, AI-generated questions, discussions, events, challenges, and learner performance data while preserving security, database consistency, and the required approval workflow.

## Test Environment

Use this baseline before testing:

- Solution: `C:\Users\superstar umzi\Downloads\Aidify_assigment\Aidify_assigment.sln`
- Web project: `C:\Users\superstar umzi\Downloads\Aidify_assigment`
- Browser: Google Chrome
- Base URL: `http://localhost:8080`
- Database server: `(LocalDB)\AidifyLocalDB`
- Database name: `AidifyDB`
- Instructor login: `instructor@aidify.edu / Admin123!`
- Admin login for approval checks: `admin@aidify.edu / Admin123!`
- Learner login for visibility checks: `learner@aidify.edu / Admin123!`

Before functional testing:

1. Restore NuGet packages.
2. Build the solution in Debug mode.
3. Run ASP.NET precompile.
4. Start IIS Express or the configured local web server.
5. Confirm the database exists and seed data is loaded.
6. Use Chrome for all browser tests.

## Core Instructor Routes

Smoke-test these pages after every major change:

- `/Instructor/Dashboard.aspx`
- `/Instructor/Modules/List.aspx`
- `/Instructor/Modules/Edit.aspx`
- `/Instructor/Lessons/List.aspx`
- `/Instructor/Lessons/Edit.aspx`
- `/Instructor/Materials/Upload.aspx`
- `/Instructor/Quizzes/List.aspx`
- `/Instructor/Quizzes/Edit.aspx`
- `/Instructor/Quizzes/Questions.aspx`
- `/Instructor/Quizzes/GenerateWithAI.aspx`
- `/Instructor/Performance.aspx`
- `/Instructor/Discussions.aspx`
- `/Instructor/Challenges.aspx`
- `/Instructor/Events.aspx`

Expected result:

- Pages load without parser errors, server errors, missing-control errors, or broken postbacks.
- Instructor navigation works between all pages.
- Data displayed belongs to the instructor's own modules.
- Wrong-role users cannot access instructor-only functionality.

## Requirement Coverage Matrix

| Requirement | Expected Behavior | Test Priority | Current Implementation Risk |
| --- | --- | --- | --- |
| FR-I01 | Instructor can log in with email/password. | Critical | Must verify route protection because several Instructor pages appear to inherit `System.Web.UI.Page` directly. |
| FR-I02 | Dashboard shows owned courses, enrolled learners, pending discussion questions, and AI shortcut. | High | Dashboard exists; all widgets must be verified against database values. |
| FR-I03 | Instructor can create, edit, delete, publish, and save draft learning modules. | Critical | Module CRUD exists; verify draft and pending review statuses. |
| FR-I04 | Instructor can create, edit, reorder, and delete lessons inside modules. | Critical | Lesson CRUD exists; verify sequence ordering and ownership checks. |
| FR-I05 | Instructor can edit rich lesson body content with formatting, images, and video URLs. | High | Verify whether UI is true WYSIWYG or plain HTML editor. |
| FR-I06 | Instructor can upload PDFs, images, and video materials up to 50 MB. | High | Upload page exists; verify extension, size, storage path, and DB row. |
| FR-I07 | Instructor can create quizzes with title, description, time limit, and passing percentage. | Critical | Quiz page exists; verify validation and persistence. |
| FR-I08 | Instructor can add MCQ, true/false, and short-answer questions. | Critical | MCQ is clearly supported; true/false and short-answer require verification. |
| FR-I09 | Instructor can upload `.txt` or `.md` file and generate AI questions. | High | AI page exists and validates `.txt`/`.md`. |
| FR-I10 | Instructor can preview, edit/keep/discard AI questions before saving. | High | Preview, save, and discard exist; individual edit/keep/discard may be missing. |
| FR-I11 | Instructor can set or modify quiz passing criteria. | High | Verify `PassingPct` or equivalent column updates. |
| FR-I12 | Instructor can view learner performance, attempts, average score, completion, weak questions. | High | Performance page exists; analytics depth must be verified. |
| FR-I13 | Instructor can list unanswered discussion questions and reply. | High | Discussions page exists; verify thread/reply persistence. |
| FR-I14 | Instructor content actions are logged to `AuditLogs`. | Critical | Likely incomplete; must verify every create/update/delete/publish action. |
| FR-I15 | Instructor can save draft or submit content for admin approval. | Critical | Module draft and pending review flow exists; verify admin approval integration. |
| FR-I16 | Instructor can create challenges and events that admin approves before live. | High | Pages exist; approval workflow and learner visibility must be verified. |

## Baseline Database Verification

Run these checks before testing and record counts:

```sql
SELECT COUNT(*) AS UsersCount FROM Users;
SELECT COUNT(*) AS InstructorModules FROM Modules WHERE CreatedBy = 2 AND IsDeleted = 0;
SELECT COUNT(*) AS LessonsCount FROM Lessons;
SELECT COUNT(*) AS MaterialsCount FROM LearningMaterials;
SELECT COUNT(*) AS QuizzesCount FROM Quizzes;
SELECT COUNT(*) AS QuestionsCount FROM Questions;
SELECT COUNT(*) AS OptionsCount FROM Options;
SELECT COUNT(*) AS AITaskCount FROM AIGeneratedTasks;
SELECT COUNT(*) AS DiscussionThreadCount FROM DiscussionThreads;
SELECT COUNT(*) AS DiscussionReplyCount FROM DiscussionReplies;
SELECT COUNT(*) AS ChallengeCount FROM Challenges;
SELECT COUNT(*) AS EventCount FROM Events;
SELECT COUNT(*) AS AuditLogCount FROM AuditLogs;
```

Pass criteria:

- Queries execute without invalid table or invalid column errors.
- Counts are recorded so later tests can prove inserts, updates, and deletes.

## Authentication and Authorization Tests

### IN-AUTH-001: Instructor Login Success

Steps:

1. Open `/Login.aspx`.
2. Log in with `instructor@aidify.edu / Admin123!`.
3. Navigate to `/Instructor/Dashboard.aspx`.

Expected:

- Login succeeds.
- Session is created.
- User lands on or can access the Instructor dashboard.
- No admin or learner-only dashboard is shown.

Database checks:

```sql
SELECT UserId, Email, RoleId, IsActive, IsEmailConfirmed
FROM Users
WHERE Email = 'instructor@aidify.edu';
```

### IN-AUTH-002: Wrong Role Cannot Access Instructor Pages

Steps:

1. Log out.
2. Log in as `learner@aidify.edu`.
3. Open `/Instructor/Modules/List.aspx`.
4. Repeat as admin if the platform expects admin separation.

Expected:

- Learner is redirected or blocked.
- No instructor data is visible.
- No instructor content can be created or changed.

Implementation note:

- Current Instructor code should be checked carefully because many pages appear to use a hardcoded instructor id and direct `System.Web.UI.Page` inheritance. If wrong-role access succeeds, this is a critical bug.

### IN-AUTH-003: Direct URL Access Without Login

Steps:

1. Clear session or open incognito Chrome.
2. Open each Instructor route directly.

Expected:

- User is redirected to login.
- No page content or data is rendered before authentication.

## Instructor Dashboard Tests

### IN-DASH-001: Dashboard Loads Owned Course Summary

Steps:

1. Log in as instructor.
2. Open `/Instructor/Dashboard.aspx`.
3. Compare displayed course/module counts with SQL.

SQL:

```sql
SELECT COUNT(*) AS OwnedModules
FROM Modules
WHERE CreatedBy = 2 AND IsDeleted = 0;
```

Expected:

- Dashboard count matches SQL.
- Deleted modules are not counted.
- Modules owned by another instructor are not counted.

### IN-DASH-002: Dashboard Shows Enrolled Learners Per Course

Steps:

1. On dashboard, inspect enrolled learner statistics.
2. Compare with enrollment rows for instructor-owned modules.

SQL:

```sql
SELECT m.ModuleId, m.Title, COUNT(e.EnrollmentId) AS EnrolledLearners
FROM Modules m
LEFT JOIN Enrollments e ON e.ModuleId = m.ModuleId
WHERE m.CreatedBy = 2 AND m.IsDeleted = 0
GROUP BY m.ModuleId, m.Title
ORDER BY m.Title;
```

Expected:

- UI counts match database counts.
- Empty courses show `0`, not blank errors.

### IN-DASH-003: Dashboard Shows Pending Discussion Questions

Steps:

1. Ensure at least one discussion thread exists for an instructor-owned module without an instructor reply.
2. Open dashboard.

Expected:

- Pending discussion count or list appears.
- Clicking it opens `/Instructor/Discussions.aspx`.

### IN-DASH-004: AI Generation Shortcut

Steps:

1. Click the dashboard AI generation shortcut.

Expected:

- User is taken to `/Instructor/Quizzes/GenerateWithAI.aspx`.
- Existing instructor quizzes are selectable.

## Module Management Tests

### IN-MOD-001: Create Draft Module

Steps:

1. Open `/Instructor/Modules/Edit.aspx`.
2. Enter title, description, difficulty, sequence/order if available, and preview flag if available.
3. Upload a valid cover image if the field is present.
4. Click Save Draft.

Expected:

- Success message appears.
- New module appears in `/Instructor/Modules/List.aspx`.
- Module status is `Draft`.
- `CreatedBy` is the instructor user id.
- `IsDeleted = 0`.

SQL:

```sql
SELECT TOP 5 ModuleId, Title, DifficultyLevel, CoverImagePath, Status, IsPreview, CreatedBy, IsDeleted, CreatedAt
FROM Modules
WHERE CreatedBy = 2
ORDER BY ModuleId DESC;
```

### IN-MOD-002: Submit Module For Admin Review

Steps:

1. Open a draft module in edit mode.
2. Click Submit For Review.
3. Log in as admin and open admin approval page.

Expected:

- Module status changes to `PendingReview`.
- Admin can approve or reject the module.
- Learner cannot see module while it is pending.

SQL:

```sql
SELECT ModuleId, Title, Status
FROM Modules
WHERE ModuleId = @ModuleId;
```

### IN-MOD-003: Admin Approval Makes Module Visible

Steps:

1. Submit module for review as instructor.
2. Approve it as admin.
3. Log in as learner.
4. Open course catalogue/public preview page.

Expected:

- Status changes to `Published`.
- Learner can see the module only after approval.
- Rejected module is not visible to learners.

### IN-MOD-004: Edit Existing Module

Steps:

1. Open `/Instructor/Modules/Edit.aspx?id={moduleId}` for an owned module.
2. Change title, description, difficulty, cover image, and preview flag.
3. Save.

Expected:

- Existing row is updated, not duplicated.
- List page shows updated values.
- Learner-facing pages reflect updates only when module is published.

### IN-MOD-005: Delete Module

Steps:

1. Delete an instructor-owned test module from the list page.
2. Refresh the module list.

Expected:

- Module disappears from active list.
- Database uses soft delete if supported.
- Related lessons/quizzes do not break list pages.

SQL:

```sql
SELECT ModuleId, Title, IsDeleted
FROM Modules
WHERE ModuleId = @ModuleId;
```

### IN-MOD-006: Module Ownership Protection

Steps:

1. Identify a module owned by another instructor if available.
2. Try opening `/Instructor/Modules/Edit.aspx?id={otherInstructorModuleId}`.

Expected:

- Access is denied or the module is not found.
- No update is possible.

## Lesson Management Tests

### IN-LESS-001: Create Lesson Under Owned Module

Steps:

1. Open `/Instructor/Lessons/Edit.aspx`.
2. Select an instructor-owned module.
3. Enter lesson title, body content, sequence order, and estimated minutes.
4. Save.

Expected:

- Lesson is saved.
- Lesson appears in `/Instructor/Lessons/List.aspx`.
- Lesson is attached to the selected module.

SQL:

```sql
SELECT TOP 5 l.LessonId, l.ModuleId, m.Title AS ModuleTitle, l.Title, l.SequenceOrder, l.EstimatedMinutes
FROM Lessons l
JOIN Modules m ON m.ModuleId = l.ModuleId
WHERE m.CreatedBy = 2
ORDER BY l.LessonId DESC;
```

### IN-LESS-002: Validate Required Lesson Fields

Steps:

1. Try saving a lesson with no module.
2. Try saving with no title.
3. Try saving with empty body.
4. Try sequence order `0` or negative.
5. Try negative estimated minutes.

Expected:

- Validation errors are shown.
- No invalid database rows are inserted.

### IN-LESS-003: Rich Lesson Body Persistence

Steps:

1. Create or edit a lesson body with:
   - Bold text
   - Numbered or bullet list
   - Image reference
   - Embedded video URL
2. Save the lesson.
3. Reopen the edit page.
4. Open the learner lesson page for that lesson after module is visible.

Expected:

- Formatting is preserved.
- HTML does not break the page layout.
- Unsafe script content is rejected or encoded.

Security test:

```html
<script>alert('xss')</script>
```

Expected:

- Script does not execute for learners or instructors.

### IN-LESS-004: Lesson Reordering

Steps:

1. Create at least three lessons in the same module.
2. Set sequence orders such as `1`, `2`, `3`.
3. Change order and save.
4. View lessons in instructor list and learner course detail page.

Expected:

- Lessons display in ascending sequence order.
- Duplicate sequence values are handled predictably.

## Learning Material Upload Tests

### IN-MAT-001: Upload Valid PDF Material

Steps:

1. Open `/Instructor/Materials/Upload.aspx`.
2. Select an instructor-owned module or lesson.
3. Upload a valid `.pdf` file below 50 MB.

Expected:

- Upload succeeds.
- File is stored in the configured upload folder.
- Database row is inserted.
- Learner can access material only through an enrolled/visible module if access control exists.

SQL:

```sql
SELECT TOP 10 *
FROM LearningMaterials
ORDER BY 1 DESC;
```

### IN-MAT-002: Upload Valid Image

Steps:

1. Upload `.jpg`, `.jpeg`, or `.png`.

Expected:

- Upload succeeds.
- Stored path is valid.
- UI shows or links the material.

### IN-MAT-003: Upload Valid Video

Steps:

1. Upload an allowed video file below 50 MB.

Expected:

- Upload succeeds if video extensions are supported.
- If unsupported, validation message clearly explains the allowed file types.

### IN-MAT-004: Reject Invalid File Type

Steps:

1. Try uploading `.exe`, `.js`, `.bat`, or another unsupported file.

Expected:

- Upload is rejected.
- No file remains in upload directory.
- No database row is inserted.

### IN-MAT-005: Reject Oversized File

Steps:

1. Try uploading a file larger than 50 MB.

Expected:

- Upload is rejected gracefully.
- User receives clear error message.
- Application does not crash.

## Quiz Management Tests

### IN-QUIZ-001: Create Quiz

Steps:

1. Open `/Instructor/Quizzes/Edit.aspx`.
2. Select an instructor-owned module.
3. Enter title, description, time limit, passing percentage, and preview flag if available.
4. Save.

Expected:

- Quiz row is inserted.
- Quiz appears in `/Instructor/Quizzes/List.aspx`.
- Quiz is associated with the selected module.

SQL:

```sql
SELECT TOP 10 q.QuizId, q.ModuleId, m.Title AS ModuleTitle, q.Title, q.Description, q.TimeLimitSec, q.PassingPct, q.IsPreview
FROM Quizzes q
JOIN Modules m ON m.ModuleId = q.ModuleId
WHERE m.CreatedBy = 2
ORDER BY q.QuizId DESC;
```

### IN-QUIZ-002: Validate Quiz Fields

Steps:

1. Try saving without module.
2. Try saving without title.
3. Try invalid time limit.
4. Try passing percentage below `0` or above `100`.

Expected:

- Validation errors are shown.
- Invalid quiz row is not inserted.

### IN-QUIZ-003: Edit Passing Criteria

Steps:

1. Open existing quiz.
2. Change passing percentage.
3. Save.
4. Take quiz as learner if applicable.

Expected:

- Passing percentage updates in database.
- Learner result pass/fail uses the new value.

## Question Management Tests

### IN-QST-001: Add MCQ Question

Steps:

1. Open `/Instructor/Quizzes/Questions.aspx?quizId={quizId}`.
2. Add a multiple-choice question with 2-5 options.
3. Mark exactly one correct option.
4. Save.

Expected:

- Question row is inserted.
- Option rows are inserted.
- Exactly one option has `IsCorrect = 1`.

SQL:

```sql
SELECT q.QuestionId, q.QuizId, q.QuestionText, q.QuestionType, q.Points,
       o.OptionId, o.OptionText, o.IsCorrect
FROM Questions q
JOIN Options o ON o.QuestionId = q.QuestionId
WHERE q.QuizId = @QuizId
ORDER BY q.QuestionId, o.OptionId;
```

### IN-QST-002: Reject Invalid MCQ

Steps:

1. Try saving a question with fewer than two options.
2. Try saving with no correct option.
3. Try saving with multiple correct options if UI allows it.

Expected:

- Validation blocks invalid question.
- No partial question/options remain in database.

### IN-QST-003: True/False Question Support

Steps:

1. Attempt to create a true/false question.
2. Save and reopen.
3. Take the quiz as learner.

Expected:

- If supported, two options are stored and grading works.
- If unsupported, record as missing against FR-I08.

### IN-QST-004: Short-Answer Question Support

Steps:

1. Attempt to create a short-answer question.
2. Save and reopen.
3. Take the quiz as learner.

Expected:

- If supported, answer text is stored and grading rules are clear.
- If unsupported, record as missing against FR-I08.

## AI Quiz Generation Tests

The flowchart requires a four-step AI generation process:

1. Select target quiz.
2. Configure question count and difficulty.
3. Upload `.txt` or `.md` knowledge file.
4. Generate, preview, edit/keep/discard, then save.

### IN-AI-001: AI Page Loads Instructor Quizzes

Steps:

1. Open `/Instructor/Quizzes/GenerateWithAI.aspx`.
2. Inspect quiz dropdown.

Expected:

- Only quizzes from instructor-owned modules are listed.
- Deleted or unauthorized quizzes are not listed.

### IN-AI-002: Validate Required AI Inputs

Steps:

1. Submit with no quiz selected.
2. Submit with no file.
3. Submit with question count `0`.
4. Submit with question count `21`.

Expected:

- Validation errors appear.
- No `AIGeneratedTasks`, `Questions`, or `Options` rows are inserted.

### IN-AI-003: Reject Invalid AI File Type

Steps:

1. Upload `.pdf`, `.docx`, `.exe`, or image file.
2. Click generate.

Expected:

- Upload is rejected.
- Message says only `.txt` and `.md` files are allowed.

### IN-AI-004: Generate Questions From Valid `.txt`

Steps:

1. Select quiz.
2. Set question count between `1` and `20`.
3. Select difficulty.
4. Upload valid `.txt`.
5. Generate.

Expected:

- Questions are generated or demo fallback questions appear if no Gemini API key is configured.
- Preview list displays generated question text and options.
- Generated content is stored in session before saving.
- `AIGeneratedTasks` records generation metadata if implemented before save.

SQL:

```sql
SELECT TOP 10 TaskId, QuizId, SourceFileName, CreatedBy, CreatedAt
FROM AIGeneratedTasks
ORDER BY TaskId DESC;
```

### IN-AI-005: Generate Questions From Valid `.md`

Steps:

1. Repeat AI generation using Markdown content.

Expected:

- Markdown file is accepted.
- UTF-8 text is read correctly.
- Generated questions are relevant to uploaded content.

### IN-AI-006: Large File Is Capped Safely

Steps:

1. Upload a `.txt` or `.md` file longer than 30,000 characters.
2. Generate questions.

Expected:

- Application does not crash.
- Content is capped or handled according to the flowchart.
- Error handling is graceful if AI service rejects the prompt.

### IN-AI-007: Preview, Save, And Database Transaction

Steps:

1. Generate AI questions.
2. Click Save Generated Questions.
3. Open question management page for the quiz.

Expected:

- All generated questions are saved.
- Each question has options.
- Each question has one correct answer.
- If any insert fails, transaction rolls back and no partial question set is left.

SQL:

```sql
SELECT q.QuestionId, q.QuestionText, q.QuestionType, q.Points,
       COUNT(o.OptionId) AS OptionCount,
       SUM(CASE WHEN o.IsCorrect = 1 THEN 1 ELSE 0 END) AS CorrectOptionCount
FROM Questions q
LEFT JOIN Options o ON o.QuestionId = q.QuestionId
WHERE q.QuizId = @QuizId
GROUP BY q.QuestionId, q.QuestionText, q.QuestionType, q.Points
ORDER BY q.QuestionId DESC;
```

### IN-AI-008: Discard Generated Questions

Steps:

1. Generate questions.
2. Click Discard.
3. Refresh page.
4. Check database.

Expected:

- Preview clears.
- Unsaved generated questions are not inserted into `Questions` or `Options`.

### IN-AI-009: Individual Edit/Keep/Discard Support

Steps:

1. Generate questions.
2. Try editing one generated question before save.
3. Try discarding one generated question while keeping others.

Expected:

- If supported, edited content is what gets saved.
- If unsupported, record as a gap against FR-I10.

### IN-AI-010: AI Rate Limiting

Steps:

1. Attempt more than the configured hourly generation limit.

Expected:

- Flowchart says rate limit should block after limit.
- If no rate limit exists, record as a technical gap.

## Performance Analytics Tests

### IN-PERF-001: Performance Page Loads Instructor Modules

Steps:

1. Open `/Instructor/Performance.aspx`.
2. Select an instructor-owned module if filtering exists.

Expected:

- Page loads without errors.
- Only instructor-owned module data is shown.

### IN-PERF-002: Attempt And Average Score Accuracy

Steps:

1. Have learner complete quiz attempts for an instructor-owned module.
2. Open performance page.
3. Compare UI values to SQL.

SQL:

```sql
SELECT q.QuizId, q.Title,
       COUNT(qa.AttemptId) AS AttemptCount,
       AVG(CAST(qa.Score AS decimal(10,2))) AS AverageScore
FROM Quizzes q
JOIN Modules m ON m.ModuleId = q.ModuleId
LEFT JOIN QuizAttempts qa ON qa.QuizId = q.QuizId
WHERE m.CreatedBy = 2
GROUP BY q.QuizId, q.Title;
```

Expected:

- Attempt count and average score match SQL.
- Empty quizzes show `0` or clear empty state.

### IN-PERF-003: Completion Rate Accuracy

Steps:

1. Ensure enrolled learners have mixed lesson completion.
2. Compare performance UI with progress data.

SQL:

```sql
SELECT m.ModuleId, m.Title,
       COUNT(DISTINCT e.UserId) AS EnrolledLearners,
       COUNT(DISTINCT p.UserId) AS LearnersWithProgress
FROM Modules m
LEFT JOIN Enrollments e ON e.ModuleId = m.ModuleId
LEFT JOIN Lessons l ON l.ModuleId = m.ModuleId
LEFT JOIN Progress p ON p.LessonId = l.LessonId AND p.UserId = e.UserId
WHERE m.CreatedBy = 2
GROUP BY m.ModuleId, m.Title;
```

Expected:

- Completion metrics are reasonable and match database logic.

### IN-PERF-004: Weakest Question Analytics

Steps:

1. Create quiz attempts with both correct and incorrect answers.
2. Open performance page.

Expected:

- Weakest question or question-level analytics appear.
- Chart.js chart renders if required by the original plan.
- If only summary metrics exist, record weaker analytics as a gap.

## Discussion Tests

### IN-DISC-001: List Unanswered Questions

Steps:

1. As learner, create a discussion thread or question under an instructor-owned module.
2. As instructor, open `/Instructor/Discussions.aspx`.

Expected:

- Thread appears for the instructor.
- Threads from unrelated modules do not appear.

SQL:

```sql
SELECT TOP 20 dt.ThreadId, dt.ModuleId, m.Title, dt.Title, dt.CreatedBy, dt.CreatedAt
FROM DiscussionThreads dt
JOIN Modules m ON m.ModuleId = dt.ModuleId
WHERE m.CreatedBy = 2
ORDER BY dt.CreatedAt DESC;
```

### IN-DISC-002: Reply To Learner Thread

Steps:

1. Select a thread.
2. Enter instructor reply.
3. Save.
4. Refresh learner discussion view.

Expected:

- Reply is inserted.
- Learner can see reply.
- Reply author is instructor.

SQL:

```sql
SELECT TOP 20 ReplyId, ThreadId, Body, CreatedBy, CreatedAt
FROM DiscussionReplies
WHERE ThreadId = @ThreadId
ORDER BY CreatedAt DESC;
```

### IN-DISC-003: Reject Empty Reply

Steps:

1. Try posting an empty reply.

Expected:

- Validation error is shown.
- No blank reply row is inserted.

## Challenge Tests

### IN-CHAL-001: Create Challenge

Steps:

1. Open `/Instructor/Challenges.aspx`.
2. Create challenge with title, description, points, start/end dates, and module if available.

Expected:

- Challenge row is inserted.
- Challenge is associated with the instructor or instructor-owned module.
- Status is pending approval if admin approval is required.

SQL:

```sql
SELECT TOP 20 *
FROM Challenges
ORDER BY 1 DESC;
```

### IN-CHAL-002: Challenge Approval Workflow

Steps:

1. Create challenge as instructor.
2. Log in as learner and check challenge page before approval.
3. Log in as admin and approve challenge.
4. Check learner challenge page again.

Expected:

- Challenge is hidden before approval.
- Challenge becomes visible after admin approval.
- Rejected challenge remains hidden.

### IN-CHAL-003: Edit Or Cancel Challenge

Steps:

1. Edit a created challenge.
2. Cancel/delete if supported.

Expected:

- Changes persist.
- Already joined learners are handled safely.
- Deleted or cancelled challenges are not visible to learners.

## Event Tests

### IN-EVT-001: Create Event

Steps:

1. Open `/Instructor/Events.aspx`.
2. Create event with title, description, location or URL, date/time, and capacity if available.

Expected:

- Event row is inserted.
- Status is pending approval if admin approval is required.

SQL:

```sql
SELECT TOP 20 *
FROM Events
ORDER BY 1 DESC;
```

### IN-EVT-002: Event Approval Workflow

Steps:

1. Create event as instructor.
2. Log in as learner before approval.
3. Approve as admin.
4. Log in as learner after approval.

Expected:

- Event is hidden before approval.
- Event appears after approval.
- Learner registration works only for approved event.

### IN-EVT-003: Edit Or Cancel Event

Steps:

1. Edit an event's title/date/location.
2. Cancel/delete if supported.

Expected:

- Changes persist.
- Registration rows remain consistent.
- Cancelled events are clearly marked or hidden.

## Audit Logging Tests

The original plan requires every instructor content action to be logged to `AuditLogs`.

### IN-AUD-001: Module Actions Are Logged

Steps:

1. Create module.
2. Edit module.
3. Submit module for review.
4. Delete module.

Expected:

- Each action creates an `AuditLogs` row.
- Row includes actor user id, action type, entity type/id, and timestamp.

SQL:

```sql
SELECT TOP 50 *
FROM AuditLogs
WHERE UserId = 2
ORDER BY 1 DESC;
```

### IN-AUD-002: Lesson, Material, Quiz, And Question Actions Are Logged

Steps:

1. Create lesson.
2. Upload material.
3. Create quiz.
4. Add question.
5. Generate AI questions.

Expected:

- Each content-changing action is logged.
- AI generation is logged either in `AuditLogs`, `AIGeneratedTasks`, or both.

Implementation risk:

- If no rows appear in `AuditLogs`, this is a major FR-I14 gap even if the functional action succeeds.

## Data Integrity Tests

### IN-DATA-001: No Orphan Lessons

SQL:

```sql
SELECT l.*
FROM Lessons l
LEFT JOIN Modules m ON m.ModuleId = l.ModuleId
WHERE m.ModuleId IS NULL;
```

Expected:

- Query returns zero rows.

### IN-DATA-002: No Orphan Quizzes

SQL:

```sql
SELECT q.*
FROM Quizzes q
LEFT JOIN Modules m ON m.ModuleId = q.ModuleId
WHERE m.ModuleId IS NULL;
```

Expected:

- Query returns zero rows.

### IN-DATA-003: No Orphan Questions Or Options

SQL:

```sql
SELECT q.*
FROM Questions q
LEFT JOIN Quizzes z ON z.QuizId = q.QuizId
WHERE z.QuizId IS NULL;

SELECT o.*
FROM Options o
LEFT JOIN Questions q ON q.QuestionId = o.QuestionId
WHERE q.QuestionId IS NULL;
```

Expected:

- Both queries return zero rows.

### IN-DATA-004: Published Content Has Required Learner Fields

SQL:

```sql
SELECT ModuleId, Title, Description, DifficultyLevel, Status
FROM Modules
WHERE Status = 'Published'
  AND (Title IS NULL OR LTRIM(RTRIM(Title)) = ''
       OR Description IS NULL OR LTRIM(RTRIM(Description)) = '');
```

Expected:

- Query returns zero rows.

## Security and Validation Tests

### IN-SEC-001: SQL Injection Resistance

Use these inputs in title, description, lesson body, quiz title, and search/filter fields:

```text
' OR 1=1 --
```

Expected:

- Input is treated as text or rejected.
- Database is not modified unexpectedly.
- No unauthorized data appears.

### IN-SEC-002: Stored XSS Resistance

Use this input in module title, lesson body, quiz title, discussion reply, event title, and challenge title:

```html
<script>alert('xss')</script>
```

Expected:

- Script does not execute on instructor, learner, admin, or public pages.
- Input is encoded, sanitized, or rejected.

### IN-SEC-003: File Upload Path Safety

Steps:

1. Upload files with names such as:
   - `normal.pdf`
   - `../../evil.pdf`
   - `file with spaces.pdf`
   - `very-long-file-name.pdf`
2. Inspect stored path.

Expected:

- File names are sanitized.
- Upload cannot write outside approved upload folder.
- Stored URL/path remains valid.

### IN-SEC-004: Ownership Tampering

Steps:

1. Change query string ids manually for module, lesson, quiz, and question edit pages.
2. Try ids that do not belong to the logged-in instructor.

Expected:

- Unauthorized records cannot be viewed or changed.
- Application returns not found, access denied, or redirect.

## Professor Demo Visual Review

Use Chrome for real behavior because Web Forms Designer may not show database-loaded content, session state, postback behavior, or AJAX/runtime rendering correctly.

Recommended demo path:

1. Instructor login.
2. Dashboard overview.
3. Create draft module.
4. Add lesson with formatted content.
5. Upload material.
6. Create quiz.
7. Add manual MCQ question.
8. Generate AI questions from `.txt` or `.md`.
9. Submit module for admin review.
10. Admin approval.
11. Learner sees module and quiz.
12. Instructor views performance and discussions.

Visual checks:

- No overlapping text.
- Navigation is understandable.
- Buttons are visible and labeled.
- Forms show validation messages clearly.
- Lists have useful empty states.
- AI preview is readable.
- Charts render cleanly if implemented.

Visual Studio Designer note:

- For static explanation, open `.aspx` files in Visual Studio and use `View Designer` or `View in Browser`.
- For actual grading/demo reliability, use Chrome at `http://localhost:8080/...`.

## Known Gaps To Verify Or Fix

These are the main risk areas discovered from the current implementation review:

1. Several Instructor pages appear to inherit `System.Web.UI.Page` directly instead of a role-protected base page.
2. Many Instructor operations appear to use hardcoded `InstructorUserId = 2`; this should be replaced with the logged-in user id for production-quality behavior.
3. Audit logging for instructor content actions may be incomplete or missing.
4. AI generation supports preview, save, and discard, but individual edit/keep/discard of generated questions may be missing.
5. AI generation rate limiting from the flowchart may be missing.
6. MCQ support exists, but true/false and short-answer support must be verified.
7. Lesson editing may store HTML, but a full WYSIWYG editor must be verified visually.
8. Challenge and event creation pages exist, but admin approval and learner visibility workflow must be verified end to end.
9. Performance analytics exist as a page, but weakest-question analytics and Chart.js visualization must be verified.

## Final Instructor Acceptance Checklist

Mark the Instructor role complete only when all critical items below pass:

- Instructor login works.
- Unauthenticated users cannot access instructor routes.
- Learner cannot access instructor routes.
- Instructor can create, edit, list, and delete modules.
- Draft and pending review statuses persist correctly.
- Admin approval makes submitted modules visible to learners.
- Instructor can create, edit, reorder, and delete lessons.
- Rich lesson content persists and renders safely.
- Instructor can upload allowed materials and invalid files are rejected.
- Instructor can create and edit quizzes.
- Instructor can create valid questions and invalid questions are blocked.
- AI generation accepts `.txt` and `.md`, previews generated questions, saves questions transactionally, and discards unsaved output.
- Performance page matches SQL counts and scores.
- Instructor can view and reply to learner discussions.
- Instructor can create challenges and events.
- Challenges and events follow admin approval before learner visibility.
- Instructor actions are logged in `AuditLogs` or documented as a remaining requirement gap.
- No orphan content rows are created.
- Chrome visual review passes for all main Instructor pages.
