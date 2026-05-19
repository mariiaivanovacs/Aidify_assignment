USE AidifyDB;
GO

-- Demo users — password for all three: Admin123!
-- BCrypt hash at work factor 11. Regenerate with BCrypt.Net.BCrypt.HashPassword("Admin123!", 11) if needed.
DECLARE @hash NVARCHAR(255) = '$2a$11$rOzJqQKQ1CdhA9q.dX7LuOjG5lO.VkS4Wx0R4U8z9bA3SiNQkr.Hy';

INSERT INTO Users (FullName, Email, PasswordHash, RoleId, IsActive, IsEmailConfirmed)
SELECT 'Aidify Admin',    'admin@aidify.edu',      @hash, RoleId, 1, 1 FROM Roles WHERE RoleName = 'Admin';

INSERT INTO Users (FullName, Email, PasswordHash, RoleId, IsActive, IsEmailConfirmed)
SELECT 'Demo Instructor', 'instructor@aidify.edu', @hash, RoleId, 1, 1 FROM Roles WHERE RoleName = 'Instructor';

INSERT INTO Users (FullName, Email, PasswordHash, RoleId, IsActive, IsEmailConfirmed)
SELECT 'Demo Learner',    'learner@aidify.edu',    @hash, RoleId, 1, 1 FROM Roles WHERE RoleName = 'Learner';

DECLARE @InstructorId INT = (SELECT UserId FROM Users WHERE Email = 'instructor@aidify.edu');

-- Demo modules
INSERT INTO Modules (Title, Description, DifficultyLevel, Status, IsPreview, CreatedBy) VALUES
    ('CPR Fundamentals',
     'Learn the essentials of Cardiopulmonary Resuscitation for adults, children, and infants.',
     'Beginner', 'Published', 1, @InstructorId),
    ('Choking & Airway Management',
     'Recognise and respond to choking emergencies using the Heimlich manoeuvre and back blows.',
     'Beginner', 'Published', 1, @InstructorId),
    ('Trauma Response',
     'Managing severe bleeding, fractures, and shock in emergency situations.',
     'Intermediate', 'Published', 0, @InstructorId);

-- Sample FAQs
INSERT INTO FAQs (Question, Answer, Category, SortOrder) VALUES
    ('Is Aidify a certified first-aid course?',
     'Aidify is educational only and does not replace certified training from a recognised provider.',
     'General', 1),
    ('Do I need prior knowledge to start?',
     'No. Our Beginner modules assume no medical background.',
     'Getting Started', 2),
    ('How do I earn a certificate?',
     'Complete 100% of a module and pass its final quiz. The certificate is auto-generated.',
     'Certificates', 3),
    ('Can I preview content before registering?',
     'Yes. Preview Modules and Preview Quiz are available without an account.',
     'Access', 4),
    ('What should I do in a real emergency?',
     'Always call emergency services immediately. Aidify is for educational awareness only.',
     'Safety', 5);

-- Badges
INSERT INTO Badges (Name, IconPath, RuleType, RuleThreshold) VALUES
    ('First Responder',  '/Images/badges/first-responder.png', 'ModulesCompleted', 1),
    ('Quiz Ace',         '/Images/badges/quiz-ace.png',        'QuizScore',        90),
    ('CPR Hero',         '/Images/badges/cpr-hero.png',        'ModulesCompleted', 3),
    ('Knowledge Seeker', '/Images/badges/knowledge-seeker.png','ModulesCompleted', 2);
