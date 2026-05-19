-- Aidify Database Schema
-- Run against SQL Server Express / LocalDB in this exact order.
-- In Visual Studio: View > SQL Server Object Explorer > (localdb)\MSSQLLocalDB > New Query

CREATE DATABASE AidifyDB;
GO
USE AidifyDB;
GO

-- ── AUTH & USERS ────────────────────────────────────────────────────────────

CREATE TABLE Roles (
    RoleId   INT PRIMARY KEY IDENTITY,
    RoleName NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Users (
    UserId           INT PRIMARY KEY IDENTITY,
    FullName         NVARCHAR(150) NOT NULL,
    Email            NVARCHAR(255) NOT NULL UNIQUE,
    PasswordHash     NVARCHAR(255) NOT NULL,
    RoleId           INT NOT NULL REFERENCES Roles(RoleId),
    IsActive         BIT NOT NULL DEFAULT 1,
    IsEmailConfirmed BIT NOT NULL DEFAULT 0,
    AvatarPath       NVARCHAR(500),
    CreatedAt        DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);

CREATE TABLE EmailTokens (
    TokenId   INT PRIMARY KEY IDENTITY,
    UserId    INT NOT NULL REFERENCES Users(UserId),
    Token     NVARCHAR(100) NOT NULL UNIQUE,
    Purpose   NVARCHAR(20)  NOT NULL,   -- 'Confirm' | 'Reset'
    ExpiresAt DATETIME2 NOT NULL,
    UsedAt    DATETIME2
);

CREATE TABLE LoginHistory (
    LogId     INT PRIMARY KEY IDENTITY,
    UserId    INT REFERENCES Users(UserId),
    Success   BIT NOT NULL,
    IPAddress NVARCHAR(50),
    Timestamp DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);

-- ── AUDIT ───────────────────────────────────────────────────────────────────

CREATE TABLE AuditLogs (
    AuditId      INT PRIMARY KEY IDENTITY,
    UserId       INT REFERENCES Users(UserId),
    Action       NVARCHAR(100) NOT NULL,
    TargetEntity NVARCHAR(100),
    TargetId     INT,
    Timestamp    DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    IPAddress    NVARCHAR(50)
);

CREATE TABLE AIInsights (
    InsightId    INT PRIMARY KEY IDENTITY,
    Category     NVARCHAR(100),
    PromptUsed   NVARCHAR(MAX),
    ResponseText NVARCHAR(MAX),
    GeneratedAt  DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    CachedUntil  DATETIME2
);

-- ── CONTENT ─────────────────────────────────────────────────────────────────

CREATE TABLE Modules (
    ModuleId        INT PRIMARY KEY IDENTITY,
    Title           NVARCHAR(200) NOT NULL,
    Description     NVARCHAR(MAX),
    DifficultyLevel NVARCHAR(20),
    CoverImagePath  NVARCHAR(500),
    Status          NVARCHAR(20) NOT NULL DEFAULT 'Draft',
    IsPreview       BIT NOT NULL DEFAULT 0,
    CreatedBy       INT NOT NULL REFERENCES Users(UserId),
    CreatedAt       DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    IsDeleted       BIT NOT NULL DEFAULT 0
);

CREATE TABLE Lessons (
    LessonId         INT PRIMARY KEY IDENTITY,
    ModuleId         INT NOT NULL REFERENCES Modules(ModuleId),
    Title            NVARCHAR(200) NOT NULL,
    BodyHtml         NVARCHAR(MAX),
    SequenceOrder    INT NOT NULL DEFAULT 0,
    EstimatedMinutes INT
);

CREATE TABLE LearningMaterials (
    MaterialId INT PRIMARY KEY IDENTITY,
    ModuleId   INT REFERENCES Modules(ModuleId),
    LessonId   INT REFERENCES Lessons(LessonId),
    Type       NVARCHAR(20),
    FilePath   NVARCHAR(500),
    Caption    NVARCHAR(300)
);

CREATE TABLE Quizzes (
    QuizId      INT PRIMARY KEY IDENTITY,
    ModuleId    INT REFERENCES Modules(ModuleId),
    Title       NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    TimeLimitSec INT,
    PassingPct  INT NOT NULL DEFAULT 70,
    IsPreview   BIT NOT NULL DEFAULT 0
);

CREATE TABLE Questions (
    QuestionId   INT PRIMARY KEY IDENTITY,
    QuizId       INT NOT NULL REFERENCES Quizzes(QuizId),
    QuestionText NVARCHAR(MAX) NOT NULL,
    QuestionType NVARCHAR(10) NOT NULL DEFAULT 'MCQ',
    Points       INT NOT NULL DEFAULT 1
);

CREATE TABLE Options (
    OptionId   INT PRIMARY KEY IDENTITY,
    QuestionId INT NOT NULL REFERENCES Questions(QuestionId),
    OptionText NVARCHAR(500) NOT NULL,
    IsCorrect  BIT NOT NULL DEFAULT 0
);

CREATE TABLE AIGeneratedTasks (
    TaskId         INT PRIMARY KEY IDENTITY,
    QuizId         INT REFERENCES Quizzes(QuizId),
    SourceFileName NVARCHAR(300),
    PromptUsed     NVARCHAR(MAX),
    RawJson        NVARCHAR(MAX),
    CreatedBy      INT REFERENCES Users(UserId),
    CreatedAt      DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);

CREATE TABLE Events (
    EventId     INT PRIMARY KEY IDENTITY,
    Title       NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    EventDate   DATETIME2,
    Location    NVARCHAR(300),
    MeetingUrl  NVARCHAR(500),
    CreatedBy   INT REFERENCES Users(UserId),
    Status      NVARCHAR(20) DEFAULT 'Draft'
);

CREATE TABLE DiscussionThreads (
    ThreadId  INT PRIMARY KEY IDENTITY,
    ModuleId  INT REFERENCES Modules(ModuleId),
    UserId    INT REFERENCES Users(UserId),
    Title     NVARCHAR(300),
    Body      NVARCHAR(MAX),
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);

CREATE TABLE DiscussionReplies (
    ReplyId   INT PRIMARY KEY IDENTITY,
    ThreadId  INT NOT NULL REFERENCES DiscussionThreads(ThreadId),
    UserId    INT REFERENCES Users(UserId),
    Body      NVARCHAR(MAX),
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);

-- ── LEARNER PROGRESS & GAMIFICATION ─────────────────────────────────────────

CREATE TABLE Enrollments (
    EnrolId    INT PRIMARY KEY IDENTITY,
    UserId     INT NOT NULL REFERENCES Users(UserId),
    ModuleId   INT NOT NULL REFERENCES Modules(ModuleId),
    EnrolledAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    Status     NVARCHAR(20) DEFAULT 'Active',
    CONSTRAINT UQ_Enrollment UNIQUE (UserId, ModuleId)
);

CREATE TABLE Progress (
    ProgressId  INT PRIMARY KEY IDENTITY,
    EnrolId     INT NOT NULL REFERENCES Enrollments(EnrolId),
    LessonId    INT NOT NULL REFERENCES Lessons(LessonId),
    CompletedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);

CREATE TABLE QuizAttempts (
    AttemptId   INT PRIMARY KEY IDENTITY,
    UserId      INT NOT NULL REFERENCES Users(UserId),
    QuizId      INT NOT NULL REFERENCES Quizzes(QuizId),
    Score       DECIMAL(5,2),
    Passed      BIT,
    IsPopQuiz   BIT NOT NULL DEFAULT 0,
    SubmittedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);

CREATE TABLE AttemptAnswers (
    AnswerId         INT PRIMARY KEY IDENTITY,
    AttemptId        INT NOT NULL REFERENCES QuizAttempts(AttemptId),
    QuestionId       INT NOT NULL REFERENCES Questions(QuestionId),
    SelectedOptionId INT REFERENCES Options(OptionId),
    IsCorrect        BIT
);

CREATE TABLE Badges (
    BadgeId       INT PRIMARY KEY IDENTITY,
    Name          NVARCHAR(100) NOT NULL,
    IconPath      NVARCHAR(300),
    RuleType      NVARCHAR(50),
    RuleThreshold INT
);

CREATE TABLE UserBadges (
    UserBadgeId INT PRIMARY KEY IDENTITY,
    UserId      INT NOT NULL REFERENCES Users(UserId),
    BadgeId     INT NOT NULL REFERENCES Badges(BadgeId),
    AwardedAt   DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);

CREATE TABLE Certificates (
    CertId   INT PRIMARY KEY IDENTITY,
    UserId   INT NOT NULL REFERENCES Users(UserId),
    ModuleId INT NOT NULL REFERENCES Modules(ModuleId),
    PdfPath  NVARCHAR(500),
    IssuedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);

CREATE TABLE League (
    LeagueId  INT PRIMARY KEY IDENTITY,
    UserId    INT NOT NULL UNIQUE REFERENCES Users(UserId),
    Tier      NVARCHAR(20) NOT NULL DEFAULT 'Bronze',
    Points    INT NOT NULL DEFAULT 0,
    UpdatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);

CREATE TABLE Challenges (
    ChallengeId   INT PRIMARY KEY IDENTITY,
    Title         NVARCHAR(200) NOT NULL,
    Description   NVARCHAR(MAX),
    StartDate     DATETIME2,
    EndDate       DATETIME2,
    PointsReward  INT DEFAULT 0,
    BadgeRewardId INT REFERENCES Badges(BadgeId),
    Status        NVARCHAR(20) DEFAULT 'Draft'
);

CREATE TABLE ChallengeParticipation (
    CPId        INT PRIMARY KEY IDENTITY,
    ChallengeId INT NOT NULL REFERENCES Challenges(ChallengeId),
    UserId      INT NOT NULL REFERENCES Users(UserId),
    Status      NVARCHAR(20) DEFAULT 'Joined',
    CompletedAt DATETIME2
);

CREATE TABLE EventRegistrations (
    RegId        INT PRIMARY KEY IDENTITY,
    EventId      INT NOT NULL REFERENCES Events(EventId),
    UserId       INT NOT NULL REFERENCES Users(UserId),
    RegisteredAt DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);

CREATE TABLE Notifications (
    NotifId   INT PRIMARY KEY IDENTITY,
    UserId    INT NOT NULL REFERENCES Users(UserId),
    Title     NVARCHAR(200),
    Body      NVARCHAR(500),
    Url       NVARCHAR(500),
    IsRead    BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE()
);

CREATE TABLE FAQs (
    FaqId     INT PRIMARY KEY IDENTITY,
    Question  NVARCHAR(500) NOT NULL,
    Answer    NVARCHAR(MAX) NOT NULL,
    Category  NVARCHAR(100),
    SortOrder INT DEFAULT 0
);
