-- Aidify — Realistic Demo Content Seed
-- Run AFTER 01_Schema.sql, 02_SeedRoles.sql, 03_SeedDemoContent.sql
-- Adds: modules with lessons, quizzes with questions/options, badges, FAQs
USE AidifyDB;
GO

DECLARE @InstructorId INT = (SELECT UserId FROM Users WHERE Email = 'instructor@aidify.edu');

-- ─────────────────────────────────────────────────────────────────────────────
-- MODULES
-- ─────────────────────────────────────────────────────────────────────────────

-- Remove placeholder modules from seed 03 and replace with richer content
DELETE FROM Modules WHERE CreatedBy = @InstructorId;

INSERT INTO Modules (Title, Description, DifficultyLevel, Status, IsPreview, CreatedBy) VALUES
    ('CPR Fundamentals',
     'A comprehensive guide to Cardiopulmonary Resuscitation for adults. Covers recognition of cardiac arrest, correct compression technique, rescue breathing, and AED use.',
     'Beginner', 'Published', 1, @InstructorId),

    ('Choking Response & Airway Management',
     'Learn to recognise and respond to mild and severe choking in adults, children, and infants using back blows and abdominal thrusts.',
     'Beginner', 'Published', 1, @InstructorId),

    ('Severe Bleeding Control',
     'Techniques for controlling life-threatening haemorrhage including direct pressure, wound packing, and tourniquet application based on Stop the Bleed principles.',
     'Intermediate', 'Published', 0, @InstructorId),

    ('Burns & Scalds First Aid',
     'Identification of burn depth and severity, correct cooling methods, dressing selection, and when to escalate to emergency services.',
     'Beginner', 'Published', 0, @InstructorId),

    ('Fractures, Sprains & Dislocations',
     'Recognition and immobilisation of suspected fractures and dislocations. Includes splinting principles and sling application.',
     'Intermediate', 'PendingReview', 0, @InstructorId);

DECLARE @CPR      INT = (SELECT ModuleId FROM Modules WHERE Title = 'CPR Fundamentals');
DECLARE @Choking  INT = (SELECT ModuleId FROM Modules WHERE Title = 'Choking Response & Airway Management');
DECLARE @Bleeding INT = (SELECT ModuleId FROM Modules WHERE Title = 'Severe Bleeding Control');
DECLARE @Burns    INT = (SELECT ModuleId FROM Modules WHERE Title = 'Burns & Scalds First Aid');
DECLARE @Fracture INT = (SELECT ModuleId FROM Modules WHERE Title = 'Fractures, Sprains & Dislocations');

-- ─────────────────────────────────────────────────────────────────────────────
-- LESSONS
-- ─────────────────────────────────────────────────────────────────────────────

-- CPR Lessons
INSERT INTO Lessons (ModuleId, Title, BodyHtml, SequenceOrder, EstimatedMinutes) VALUES
    (@CPR, 'Recognising Cardiac Arrest',
     '<h3>What is Cardiac Arrest?</h3><p>Cardiac arrest occurs when the heart suddenly stops beating effectively, cutting off blood supply to the brain and vital organs. It is a medical emergency requiring immediate action.</p><h4>Key Signs</h4><ul><li>The person is unresponsive</li><li>No normal breathing (gasping or no breath at all)</li><li>No pulse detectable</li></ul><p><strong>Important:</strong> Do not confuse cardiac arrest with a heart attack. A heart attack is a circulation problem; cardiac arrest is an electrical problem. Both are emergencies.</p>',
     1, 8),

    (@CPR, 'Chest Compressions Technique',
     '<h3>How to Perform Chest Compressions</h3><ol><li>Place the heel of your hand on the centre of the chest (lower half of the sternum).</li><li>Place your other hand on top and interlock your fingers.</li><li>Keep your arms straight, position your shoulders directly above your hands.</li><li>Compress the chest at least 5 cm (2 inches) deep.</li><li>Compress at a rate of 100–120 compressions per minute.</li><li>Allow full chest recoil between compressions — do not lean on the chest.</li></ol><p>The rhythm of the song <em>Stayin Alive</em> by the Bee Gees is approximately 100 bpm — a useful mental guide.</p>',
     2, 10),

    (@CPR, 'Rescue Breathing',
     '<h3>Mouth-to-Mouth Rescue Breaths</h3><p>After every 30 compressions, give 2 rescue breaths:</p><ol><li>Tilt the head back gently and lift the chin to open the airway.</li><li>Pinch the nose closed.</li><li>Create a seal over the mouth and breathe steadily for about 1 second.</li><li>Watch for the chest to rise.</li><li>Allow the chest to fall, then give the second breath.</li><li>Return immediately to compressions.</li></ol><p>If you are untrained or unwilling to give rescue breaths, hands-only CPR (continuous compressions) is still highly effective.</p>',
     3, 8),

    (@CPR, 'Using an AED',
     '<h3>Automated External Defibrillator (AED)</h3><p>An AED analyses the heart rhythm and delivers a shock if needed. They are designed for public use — follow the voice prompts.</p><ol><li>Turn on the AED and follow audio/visual instructions.</li><li>Attach the pads as shown on the diagrams (upper right chest and lower left side).</li><li>Ensure nobody is touching the patient while the AED analyses.</li><li>If a shock is advised, ensure all bystanders are clear, then press the shock button.</li><li>Immediately resume CPR for 2 minutes before the AED re-analyses.</li></ol>',
     4, 10);

-- Choking Lessons
INSERT INTO Lessons (ModuleId, Title, BodyHtml, SequenceOrder, EstimatedMinutes) VALUES
    (@Choking, 'Recognising a Choking Emergency',
     '<h3>Mild vs Severe Choking</h3><p><strong>Mild (partial blockage):</strong> The person can cough, speak, and breathe. Encourage forceful coughing. Do not intervene physically.</p><p><strong>Severe (complete blockage):</strong> The person cannot speak, cough effectively, or breathe. They may clutch their throat. Immediate intervention is required.</p><p>Always ask clearly: <em>"Are you choking?"</em> If they cannot answer, treat as severe.</p>',
     1, 6),

    (@Choking, 'Back Blows Technique',
     '<h3>5 Back Blows</h3><ol><li>Stand to the side and slightly behind the casualty.</li><li>Support the chest with one hand and lean them forward.</li><li>Use the heel of your other hand to deliver up to 5 sharp blows between the shoulder blades.</li><li>After each blow, check whether the obstruction has cleared.</li><li>Stop as soon as the obstruction clears.</li></ol><p>Each blow should be a firm, distinct strike — not a series of rapid taps.</p>',
     2, 7),

    (@Choking, 'Abdominal Thrusts (Heimlich Manoeuvre)',
     '<h3>5 Abdominal Thrusts</h3><ol><li>Stand behind the casualty and wrap your arms around their waist.</li><li>Make a fist with one hand and place it thumb-side against the abdomen, just above the navel and well below the breastbone.</li><li>Grasp your fist with your other hand.</li><li>Pull sharply inward and upward up to 5 times.</li></ol><p>Alternate between 5 back blows and 5 abdominal thrusts until the obstruction clears or the casualty becomes unconscious. If they lose consciousness, begin CPR.</p><p><strong>Do not use abdominal thrusts on infants under 1 year or on pregnant individuals.</strong></p>',
     3, 8);

-- Bleeding Lessons
INSERT INTO Lessons (ModuleId, Title, BodyHtml, SequenceOrder, EstimatedMinutes) VALUES
    (@Bleeding, 'Assessing Blood Loss',
     '<h3>Is This Life-Threatening?</h3><p>Severe haemorrhage can cause death within minutes. Rapidly assess the wound:</p><ul><li>Is blood spurting (arterial)? — Immediate action required.</li><li>Is the wound large, deep, or on a limb?</li><li>Has the casualty lost more than 500 ml (roughly a pint)?</li></ul><p>Signs of shock: pale/cold/clammy skin, rapid shallow breathing, confusion, weak pulse. Treat the wound and call emergency services.</p>',
     1, 7),

    (@Bleeding, 'Direct Pressure & Wound Packing',
     '<h3>Controlling Bleeding</h3><h4>Direct Pressure</h4><ol><li>Use a clean dressing or cloth — gloves if available.</li><li>Apply firm, continuous pressure directly on the wound.</li><li>Do not lift the dressing to check — add more on top if it soaks through.</li><li>Maintain pressure for at least 10 minutes.</li></ol><h4>Wound Packing (deep wounds)</h4><p>For deep wounds such as gunshot or stab wounds, pack gauze firmly into the wound cavity and apply sustained pressure.</p>',
     2, 10),

    (@Bleeding, 'Tourniquet Application',
     '<h3>When to Use a Tourniquet</h3><p>Use a tourniquet only when direct pressure has failed to control bleeding from a limb, or when direct pressure is not possible.</p><ol><li>Apply 5–8 cm above the wound (not on a joint).</li><li>Tighten until bleeding stops — this will be uncomfortable for the casualty.</li><li>Note the time of application on the tourniquet or the casualty''s skin.</li><li>Never remove a tourniquet once applied — leave that to medical professionals.</li></ol>',
     3, 8);

-- Burns Lessons
INSERT INTO Lessons (ModuleId, Title, BodyHtml, SequenceOrder, EstimatedMinutes) VALUES
    (@Burns, 'Types and Severity of Burns',
     '<h3>Classification of Burns</h3><p><strong>Superficial (1st degree):</strong> Affects only the outer skin layer. Red, dry, painful. e.g. sunburn.</p><p><strong>Partial thickness (2nd degree):</strong> Affects deeper layers. Red, blistered, wet-looking, very painful.</p><p><strong>Full thickness (3rd degree):</strong> Destroys all skin layers. May appear white, brown, or charred. Little or no pain at the burn site due to nerve damage. Always requires emergency treatment.</p>',
     1, 8),

    (@Burns, 'Cooling a Burn Correctly',
     '<h3>The 20-Minute Rule</h3><p>Cool the burn under cool (not cold) running water for a minimum of <strong>20 minutes</strong>. This is the single most important first aid step.</p><h4>Do</h4><ul><li>Use cool running water, 15°C is ideal</li><li>Remove jewellery and clothing near the burn (unless stuck)</li><li>Cover loosely with cling film or a clean non-fluffy material</li></ul><h4>Do NOT</h4><ul><li>Use ice, butter, toothpaste, or any cream</li><li>Burst blisters</li><li>Remove anything stuck to the burn</li></ul>',
     2, 7),

    (@Burns, 'When to Call Emergency Services',
     '<h3>Seek Immediate Help If</h3><ul><li>The burn is larger than the size of the casualty''s palm</li><li>It is a full-thickness burn</li><li>The burn is on the face, hands, feet, genitals, or a joint</li><li>The casualty is a child or elderly person</li><li>It was caused by chemicals or electricity</li><li>The casualty is showing signs of shock</li></ul><p>While waiting for help: keep the casualty warm, continue cooling the burn, and monitor breathing.</p>',
     3, 6);

-- ─────────────────────────────────────────────────────────────────────────────
-- QUIZZES
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO Quizzes (ModuleId, Title, Description, TimeLimitSec, PassingPct, IsPreview) VALUES
    (@CPR,      'CPR Knowledge Check',           'Test your understanding of CPR technique and AED use.',   300, 70, 1),
    (@Choking,  'Choking Response Assessment',   'Verify your ability to respond to choking emergencies.',  240, 70, 1),
    (@Bleeding, 'Bleeding Control Competency',   'Assess your knowledge of haemorrhage control techniques.',300, 75, 0),
    (@Burns,    'Burns & Scalds First Aid Test', 'Check your understanding of burn assessment and cooling.', 240, 70, 0);

DECLARE @QuizCPR      INT = (SELECT QuizId FROM Quizzes WHERE ModuleId = @CPR);
DECLARE @QuizChoking  INT = (SELECT QuizId FROM Quizzes WHERE ModuleId = @Choking);
DECLARE @QuizBleeding INT = (SELECT QuizId FROM Quizzes WHERE ModuleId = @Bleeding);
DECLARE @QuizBurns    INT = (SELECT QuizId FROM Quizzes WHERE ModuleId = @Burns);

-- ─────────────────────────────────────────────────────────────────────────────
-- QUESTIONS & OPTIONS — CPR Quiz
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
    (@QuizCPR, 'What is the correct compression rate for adult CPR?', 'MCQ', 1);
DECLARE @Q1 INT = SCOPE_IDENTITY();
INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
    (@Q1, '60–80 compressions per minute',  0),
    (@Q1, '100–120 compressions per minute',1),
    (@Q1, '80–100 compressions per minute', 0),
    (@Q1, '120–140 compressions per minute',0);

INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
    (@QuizCPR, 'How deep should chest compressions be for an adult?', 'MCQ', 1);
DECLARE @Q2 INT = SCOPE_IDENTITY();
INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
    (@Q2, 'At least 2 cm',  0),
    (@Q2, 'At least 5 cm',  1),
    (@Q2, 'At least 8 cm',  0),
    (@Q2, 'At least 10 cm', 0);

INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
    (@QuizCPR, 'What is the correct compression-to-breath ratio for single-rescuer adult CPR?', 'MCQ', 1);
DECLARE @Q3 INT = SCOPE_IDENTITY();
INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
    (@Q3, '15:2', 0),
    (@Q3, '30:2', 1),
    (@Q3, '20:2', 0),
    (@Q3, '30:1', 0);

INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
    (@QuizCPR, 'When should you stop CPR?', 'MCQ', 1);
DECLARE @Q4 INT = SCOPE_IDENTITY();
INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
    (@Q4, 'After exactly 10 minutes regardless of outcome',                          0),
    (@Q4, 'When the casualty shows signs of life, a professional takes over, or you are too exhausted to continue', 1),
    (@Q4, 'After 30 cycles of compressions',                                         0),
    (@Q4, 'When an AED arrives',                                                     0);

INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
    (@QuizCPR, 'Where should AED pads be placed on an adult?', 'MCQ', 1);
DECLARE @Q5 INT = SCOPE_IDENTITY();
INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
    (@Q5, 'Both pads on the left side of the chest',                     0),
    (@Q5, 'Upper right chest and lower left side (below armpit)',         1),
    (@Q5, 'Both pads on the upper chest',                                0),
    (@Q5, 'One on the chest and one on the back',                        0);

-- ─────────────────────────────────────────────────────────────────────────────
-- QUESTIONS & OPTIONS — Choking Quiz
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
    (@QuizChoking, 'A person grabs their throat and cannot speak or cough. What should you do FIRST?', 'MCQ', 1);
DECLARE @C1 INT = SCOPE_IDENTITY();
INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
    (@C1, 'Give abdominal thrusts immediately',                                0),
    (@C1, 'Give 5 back blows between the shoulder blades',                     1),
    (@C1, 'Encourage them to keep coughing',                                   0),
    (@C1, 'Place them on the floor and start CPR',                             0);

INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
    (@QuizChoking, 'For whom should you NOT perform abdominal thrusts?', 'MCQ', 1);
DECLARE @C2 INT = SCOPE_IDENTITY();
INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
    (@C2, 'Adults over 65',                             0),
    (@C2, 'Infants under 1 year and pregnant individuals', 1),
    (@C2, 'Persons wearing glasses',                    0),
    (@C2, 'Anyone over 80 kg',                         0);

INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
    (@QuizChoking, 'A choking person becomes unconscious. What do you do?', 'MCQ', 1);
DECLARE @C3 INT = SCOPE_IDENTITY();
INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
    (@C3, 'Continue abdominal thrusts on the floor',         0),
    (@C3, 'Lower them safely and begin CPR',                 1),
    (@C3, 'Call 999 and wait for paramedics to arrive',      0),
    (@C3, 'Perform a blind finger sweep of the mouth',       0);

INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
    (@QuizChoking, 'Mild choking — the person CAN cough. What is the correct response?', 'MCQ', 1);
DECLARE @C4 INT = SCOPE_IDENTITY();
INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
    (@C4, 'Immediately perform the Heimlich manoeuvre',                 0),
    (@C4, 'Encourage forceful coughing and monitor closely',            1),
    (@C4, 'Give 5 back blows straight away',                            0),
    (@C4, 'Give water to help dislodge the obstruction',                0);

-- ─────────────────────────────────────────────────────────────────────────────
-- QUESTIONS & OPTIONS — Bleeding Quiz
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
    (@QuizBleeding, 'The dressing over a wound soaks through with blood. What should you do?', 'MCQ', 1);
DECLARE @B1 INT = SCOPE_IDENTITY();
INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
    (@B1, 'Remove the soaked dressing and replace it with a fresh one', 0),
    (@B1, 'Add more dressing on top and continue firm pressure',        1),
    (@B1, 'Reduce the pressure to prevent further bleeding',            0),
    (@B1, 'Apply a tourniquet immediately',                              0);

INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
    (@QuizBleeding, 'Where should a tourniquet be placed on a bleeding arm?', 'MCQ', 1);
DECLARE @B2 INT = SCOPE_IDENTITY();
INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
    (@B2, 'Directly on the wound',                            0),
    (@B2, '5–8 cm above the wound, not on a joint',          1),
    (@B2, 'On the nearest joint above the wound',             0),
    (@B2, 'Anywhere that feels comfortable for the casualty', 0);

INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
    (@QuizBleeding, 'What is an early sign of hypovolemic shock from blood loss?', 'MCQ', 1);
DECLARE @B3 INT = SCOPE_IDENTITY();
INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
    (@B3, 'Flushed, hot skin and a slow heart rate',                          0),
    (@B3, 'Pale, cold, clammy skin with rapid shallow breathing',             1),
    (@B3, 'High blood pressure and strong bounding pulse',                    0),
    (@B3, 'Unconsciousness immediately following injury',                      0);

-- ─────────────────────────────────────────────────────────────────────────────
-- QUESTIONS & OPTIONS — Burns Quiz
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
    (@QuizBurns, 'How long should you cool a burn under running water?', 'MCQ', 1);
DECLARE @N1 INT = SCOPE_IDENTITY();
INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
    (@N1, '5 minutes',  0),
    (@N1, '10 minutes', 0),
    (@N1, '20 minutes', 1),
    (@N1, '30 minutes', 0);

INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
    (@QuizBurns, 'Which of the following should you NEVER apply to a burn?', 'MCQ', 1);
DECLARE @N2 INT = SCOPE_IDENTITY();
INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
    (@N2, 'Cool running water',    0),
    (@N2, 'Cling film',            0),
    (@N2, 'Butter or toothpaste',  1),
    (@N2, 'A clean dry dressing',  0);

INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
    (@QuizBurns, 'A full-thickness burn appears charred and the casualty reports no pain at the burn site. Why?', 'MCQ', 1);
DECLARE @N3 INT = SCOPE_IDENTITY();
INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
    (@N3, 'The burn is not serious',                                             0),
    (@N3, 'Nerve endings have been destroyed by the deep burn',                  1),
    (@N3, 'The casualty is in shock and cannot feel pain',                       0),
    (@N3, 'Superficial burns are always more painful than deep ones',            0);

INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
    (@QuizBurns, 'A burn covers the casualty''s entire hand. Should you call emergency services?', 'MCQ', 1);
DECLARE @N4 INT = SCOPE_IDENTITY();
INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
    (@N4, 'No — the hand is a small area, treat at home',                          0),
    (@N4, 'Yes — burns to the hand require emergency medical attention',           1),
    (@N4, 'Only if the burn is full thickness',                                    0),
    (@N4, 'Only if the casualty is a child',                                       0);

-- ─────────────────────────────────────────────────────────────────────────────
-- FAQs (extended from seed 03)
-- ─────────────────────────────────────────────────────────────────────────────

-- Remove placeholder FAQs and add richer content
DELETE FROM FAQs;

INSERT INTO FAQs (Question, Answer, Category, SortOrder) VALUES
    ('Is Aidify a certified first-aid course?',
     'Aidify is an educational awareness platform. It does not replace certified first-aid training from a recognised provider such as the British Red Cross or St John Ambulance. Always seek professional certification for workplace compliance.',
     'General', 1),

    ('Do I need any prior knowledge to start?',
     'No prior medical knowledge is needed. Our Beginner modules are designed for complete beginners and use plain English throughout.',
     'Getting Started', 2),

    ('How do I earn a certificate?',
     'Complete every lesson in a module and achieve a passing score on the final quiz (70% or higher by default). Your certificate is automatically generated as a PDF and available to download from your Profile page.',
     'Certificates', 3),

    ('Can I preview content before registering?',
     'Yes. The Preview Modules and Preview Quiz pages are fully accessible without an account. CPR Fundamentals and Choking Response modules are available as previews.',
     'Access', 4),

    ('What should I do in a real emergency?',
     'Always call your local emergency services immediately (999 in the UK, 911 in the US, 112 in Europe). Aidify content is for educational awareness only and is not a substitute for professional emergency response.',
     'Safety', 5),

    ('How is my quiz score calculated?',
     'Each question carries equal points unless otherwise stated. Your score is calculated as (correct answers ÷ total questions) × 100. You must achieve the module passing percentage to unlock your certificate.',
     'Quizzes', 6),

    ('Can I retake a quiz?',
     'Yes. There is no limit on quiz attempts. Previous attempts are saved in your Quiz History so you can review your progress over time.',
     'Quizzes', 7),

    ('How do I reset my password?',
     'Click "Forgot Password" on the Login page, enter your registered email address, and you will receive a reset link valid for 1 hour.',
     'Account', 8),

    ('What file types can an instructor upload as learning materials?',
     'Instructors can upload PDF documents, images (JPG, PNG), and video files (MP4, MOV) up to a maximum of 50 MB per file.',
     'Instructors', 9),

    ('Are the first aid guidelines on Aidify up to date?',
     'Module content is based on current guidelines from recognised bodies including the Resuscitation Council UK and the European Resuscitation Council. Instructors are responsible for keeping their module content current.',
     'Content', 10);

-- ─────────────────────────────────────────────────────────────────────────────
-- BADGES (extended)
-- ─────────────────────────────────────────────────────────────────────────────

DELETE FROM Badges;

INSERT INTO Badges (Name, IconPath, RuleType, RuleThreshold) VALUES
    ('First Responder',   '/Images/badges/first-responder.png', 'ModulesCompleted', 1),
    ('Double Trained',    '/Images/badges/double-trained.png',  'ModulesCompleted', 2),
    ('CPR Hero',          '/Images/badges/cpr-hero.png',        'ModulesCompleted', 3),
    ('Life Saver',        '/Images/badges/life-saver.png',      'ModulesCompleted', 5),
    ('Quiz Ace',          '/Images/badges/quiz-ace.png',        'QuizScore',        90),
    ('Perfect Score',     '/Images/badges/perfect-score.png',   'QuizScore',        100),
    ('Knowledge Seeker',  '/Images/badges/knowledge-seeker.png','ModulesCompleted', 2),
    ('Streak Starter',    '/Images/badges/streak.png',          'Streak',           3);

PRINT 'Seed 04 complete: 5 modules, 14 lessons, 4 quizzes, 19 questions, 76 options, 8 badges, 10 FAQs';
