-- Aidify — Additional Modules Seed (brings total to 10)
-- Run AFTER 04_SeedRealisticContent.sql
-- Adds 5 new first-aid modules with lessons, quizzes, and questions.
-- Safe to re-run: uses IF NOT EXISTS guards on module titles.
USE AidifyDB;
GO

DECLARE @InstructorId INT = (SELECT UserId FROM Users WHERE Email = 'instructor@aidify.edu');

-- ─────────────────────────────────────────────────────────────────────────────
-- MODULE 6 — Anaphylaxis & Allergic Reactions
-- ─────────────────────────────────────────────────────────────────────────────

IF NOT EXISTS (SELECT 1 FROM Modules WHERE Title = 'Anaphylaxis & Allergic Reactions')
BEGIN
    INSERT INTO Modules (Title, Description, DifficultyLevel, Status, IsPreview, CreatedBy)
    VALUES (
        'Anaphylaxis & Allergic Reactions',
        'Recognising and responding to severe allergic reactions including anaphylaxis. '
        + 'Covers common triggers, symptoms, correct use of an adrenaline auto-injector (EpiPen), '
        + 'and post-injection care while waiting for emergency services.',
        'Intermediate', 'Published', 0, @InstructorId
    );
END
GO

DECLARE @Ana INT = (SELECT ModuleId FROM Modules WHERE Title = 'Anaphylaxis & Allergic Reactions');
DECLARE @InstructorId INT = (SELECT UserId FROM Users WHERE Email = 'instructor@aidify.edu');

IF NOT EXISTS (SELECT 1 FROM Lessons WHERE ModuleId = @Ana)
BEGIN
    INSERT INTO Lessons (ModuleId, Title, BodyHtml, SequenceOrder, EstimatedMinutes) VALUES
    (@Ana, 'Recognising Anaphylaxis',
     '<h3>What is Anaphylaxis?</h3>'
     + '<p>Anaphylaxis is a severe, life-threatening allergic reaction that requires immediate treatment. '
     + 'It typically develops within minutes of exposure to a trigger.</p>'
     + '<h4>Common Triggers</h4>'
     + '<ul><li>Foods: peanuts, tree nuts, shellfish, milk, eggs</li>'
     + '<li>Insect stings: bee, wasp</li>'
     + '<li>Medications: penicillin, aspirin, NSAIDs</li>'
     + '<li>Latex</li></ul>'
     + '<h4>Signs and Symptoms</h4>'
     + '<ul><li>Skin: flushing, hives (urticaria), swelling of lips or tongue</li>'
     + '<li>Respiratory: wheezing, difficulty breathing, stridor</li>'
     + '<li>Cardiovascular: rapid weak pulse, drop in blood pressure, loss of consciousness</li>'
     + '<li>Gastrointestinal: nausea, vomiting, abdominal cramps</li></ul>'
     + '<p><strong>Any combination of breathing difficulty AND skin/gut symptoms after exposure = treat as anaphylaxis.</strong></p>',
     1, 9),

    (@Ana, 'Using an Adrenaline Auto-Injector (EpiPen)',
     '<h3>How to Use an EpiPen</h3>'
     + '<p>Adrenaline (epinephrine) is the only effective treatment for anaphylaxis. '
     + 'Act immediately — do not wait for symptoms to worsen.</p>'
     + '<ol><li>Remove the EpiPen from its carrier and take off the blue safety cap.</li>'
     + '<li>Place the orange tip against the outer mid-thigh (can be used through clothing).</li>'
     + '<li>Press down firmly until you hear a click and hold for 3 seconds.</li>'
     + '<li>Remove and massage the area for 10 seconds.</li>'
     + '<li>Note the time of injection and call 999/112 immediately.</li></ol>'
     + '<h4>After Injecting</h4>'
     + '<p>Lay the casualty flat with legs raised (unless breathing is difficult — sit them up). '
     + 'A second EpiPen may be given after 5–15 minutes if symptoms return. '
     + 'All cases require hospital assessment even if symptoms improve.</p>',
     2, 8),

    (@Ana, 'Position & Post-Reaction Care',
     '<h3>Positioning During Anaphylaxis</h3>'
     + '<ul><li><strong>Breathing difficulty:</strong> Sit upright to ease breathing.</li>'
     + '<li><strong>Shock (faintness, pale):</strong> Lay flat with legs raised to improve circulation.</li>'
     + '<li><strong>Unconscious and breathing:</strong> Recovery position.</li>'
     + '<li><strong>Unconscious and not breathing:</strong> Begin CPR immediately.</li></ul>'
     + '<h4>What to Tell Emergency Services</h4>'
     + '<ul><li>Suspected trigger (if known)</li>'
     + '<li>Time EpiPen was given and which thigh</li>'
     + '<li>Current symptoms and casualty''s level of consciousness</li></ul>',
     3, 7);
END

IF NOT EXISTS (SELECT 1 FROM Quizzes WHERE ModuleId = @Ana)
BEGIN
    INSERT INTO Quizzes (ModuleId, Title, Description, TimeLimitSec, PassingPct, IsPreview)
    VALUES (@Ana, 'Anaphylaxis Response Quiz',
            'Test your knowledge of recognising and treating anaphylactic reactions.', 240, 70, 0);

    DECLARE @QAna INT = (SELECT QuizId FROM Quizzes WHERE ModuleId = @Ana);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QAna, 'Which medication is the first-line treatment for anaphylaxis?', 'MCQ', 1);
    DECLARE @A1 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@A1, 'Antihistamine',       0),
        (@A1, 'Adrenaline (EpiPen)', 1),
        (@A1, 'Steroid inhaler',     0),
        (@A1, 'Aspirin',             0);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QAna, 'Where on the body should an EpiPen be injected?', 'MCQ', 1);
    DECLARE @A2 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@A2, 'Upper arm',         0),
        (@A2, 'Outer mid-thigh',   1),
        (@A2, 'Abdomen',           0),
        (@A2, 'Inner forearm',     0);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QAna, 'After giving an EpiPen, the casualty''s symptoms improve. What do you do next?', 'MCQ', 1);
    DECLARE @A3 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@A3, 'Send them home to rest and monitor',                             0),
        (@A3, 'Still call 999 — all anaphylaxis requires hospital assessment',  1),
        (@A3, 'Give antihistamines and wait 30 minutes',                        0),
        (@A3, 'Repeat the EpiPen immediately regardless of improvement',        0);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QAna, 'A casualty in anaphylactic shock becomes faint and pale. How should they be positioned?', 'MCQ', 1);
    DECLARE @A4 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@A4, 'Sitting upright',          0),
        (@A4, 'Flat with legs raised',    1),
        (@A4, 'Standing to keep airways open', 0),
        (@A4, 'On their right side',      0);
END
GO

-- ─────────────────────────────────────────────────────────────────────────────
-- MODULE 7 — Stroke Recognition (FAST)
-- ─────────────────────────────────────────────────────────────────────────────

DECLARE @InstructorId INT = (SELECT UserId FROM Users WHERE Email = 'instructor@aidify.edu');

IF NOT EXISTS (SELECT 1 FROM Modules WHERE Title = 'Stroke Recognition (FAST Method)')
BEGIN
    INSERT INTO Modules (Title, Description, DifficultyLevel, Status, IsPreview, CreatedBy)
    VALUES (
        'Stroke Recognition (FAST Method)',
        'Learn to rapidly identify a stroke using the FAST assessment tool and understand '
        + 'why immediate emergency response is critical for reducing brain damage.',
        'Beginner', 'Published', 1, @InstructorId
    );
END
GO

DECLARE @Stroke INT = (SELECT ModuleId FROM Modules WHERE Title = 'Stroke Recognition (FAST Method)');
DECLARE @InstructorId INT = (SELECT UserId FROM Users WHERE Email = 'instructor@aidify.edu');

IF NOT EXISTS (SELECT 1 FROM Lessons WHERE ModuleId = @Stroke)
BEGIN
    INSERT INTO Lessons (ModuleId, Title, BodyHtml, SequenceOrder, EstimatedMinutes) VALUES
    (@Stroke, 'What is a Stroke?',
     '<h3>Understanding Stroke</h3>'
     + '<p>A stroke occurs when blood supply to part of the brain is cut off — either by a blood clot '
     + '(ischaemic stroke, ~85% of cases) or a burst blood vessel (haemorrhagic stroke).</p>'
     + '<p>Brain cells begin to die within minutes of losing blood supply. '
     + '<strong>Time is brain</strong> — every minute without treatment equals roughly 1.9 million neurons lost.</p>'
     + '<h4>Risk Factors</h4>'
     + '<ul><li>High blood pressure (the single biggest risk factor)</li>'
     + '<li>Atrial fibrillation (irregular heartbeat)</li>'
     + '<li>Smoking, diabetes, high cholesterol, obesity</li>'
     + '<li>Previous stroke or TIA (transient ischaemic attack)</li></ul>',
     1, 7),

    (@Stroke, 'The FAST Test',
     '<h3>FAST — A Memory Tool for Stroke Signs</h3>'
     + '<p>FAST stands for:</p>'
     + '<ul>'
     + '<li><strong>F — Face drooping:</strong> Ask the person to smile. Is one side drooping? Is the smile uneven?</li>'
     + '<li><strong>A — Arm weakness:</strong> Ask them to raise both arms. Does one drift downward?</li>'
     + '<li><strong>S — Speech difficulty:</strong> Ask them to repeat a simple sentence ("The sky is blue"). Is speech slurred or strange?</li>'
     + '<li><strong>T — Time to call 999/112:</strong> If you see ANY of the above, call immediately.</li>'
     + '</ul>'
     + '<p>Other symptoms include sudden severe headache, visual disturbance, loss of balance, or confusion — always take these seriously.</p>'
     + '<p><strong>Do not give the person food or water</strong> — stroke can impair the swallowing reflex.</p>',
     2, 8),

    (@Stroke, 'Stroke First Aid Response',
     '<h3>What to Do While Waiting for Help</h3>'
     + '<ol>'
     + '<li>Call 999 (or your local emergency number) immediately and say "I think this person is having a stroke."</li>'
     + '<li>Note the exact time symptoms started — this is critical for hospital treatment decisions.</li>'
     + '<li>Keep the person calm and still. Help them sit or lie down comfortably.</li>'
     + '<li>Do not give them anything to eat or drink.</li>'
     + '<li>If they become unconscious and are breathing, place in the recovery position.</li>'
     + '<li>If they stop breathing, begin CPR.</li>'
     + '<li>Stay with them until emergency services arrive.</li>'
     + '</ol>'
     + '<p>Even if symptoms resolve quickly (a TIA or "mini-stroke"), the person must go to hospital urgently — risk of full stroke is very high in the following 48 hours.</p>',
     3, 6);
END

IF NOT EXISTS (SELECT 1 FROM Quizzes WHERE ModuleId = @Stroke)
BEGIN
    INSERT INTO Quizzes (ModuleId, Title, Description, TimeLimitSec, PassingPct, IsPreview)
    VALUES (@Stroke, 'Stroke Recognition Quiz',
            'Check your understanding of stroke signs and the FAST test.', 180, 70, 0);

    DECLARE @QStroke INT = (SELECT QuizId FROM Quizzes WHERE ModuleId = @Stroke);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QStroke, 'What does the "A" in FAST stand for?', 'MCQ', 1);
    DECLARE @S1 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@S1, 'Ask for help',    0),
        (@S1, 'Arm weakness',    1),
        (@S1, 'Airway check',    0),
        (@S1, 'Alert services',  0);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QStroke, 'A stroke casualty''s symptoms resolve after 5 minutes. What should you do?', 'MCQ', 1);
    DECLARE @S2 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@S2, 'Monitor at home — the stroke has passed',               0),
        (@S2, 'Still take them to hospital urgently',                  1),
        (@S2, 'Give aspirin and wait another 30 minutes',              0),
        (@S2, 'Book a GP appointment for the following day',           0);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QStroke, 'Why is noting the time of stroke symptom onset important?', 'MCQ', 1);
    DECLARE @S3 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@S3, 'For the insurance report',                                                         0),
        (@S3, 'Hospital treatment with clot-busting drugs must be given within a specific time window', 1),
        (@S3, 'Ambulance response time targets depend on onset time',                              0),
        (@S3, 'It is required for legal documentation only',                                       0);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QStroke, 'You should give water to a suspected stroke casualty to keep them calm. True or False?', 'MCQ', 1);
    DECLARE @S4 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@S4, 'True — hydration is important',                                    0),
        (@S4, 'False — stroke can impair swallowing, risking choking',            1),
        (@S4, 'True — only for ischaemic strokes',                                0),
        (@S4, 'False — only if they are unconscious',                             0);
END
GO

-- ─────────────────────────────────────────────────────────────────────────────
-- MODULE 8 — Head Injuries & Concussion
-- ─────────────────────────────────────────────────────────────────────────────

DECLARE @InstructorId INT = (SELECT UserId FROM Users WHERE Email = 'instructor@aidify.edu');

IF NOT EXISTS (SELECT 1 FROM Modules WHERE Title = 'Head Injuries & Concussion')
BEGIN
    INSERT INTO Modules (Title, Description, DifficultyLevel, Status, IsPreview, CreatedBy)
    VALUES (
        'Head Injuries & Concussion',
        'Assessment and first aid management of head injuries from minor bumps to suspected '
        + 'skull fractures. Includes concussion recognition, red flag symptoms, and when to call for help.',
        'Intermediate', 'Published', 0, @InstructorId
    );
END
GO

DECLARE @Head INT = (SELECT ModuleId FROM Modules WHERE Title = 'Head Injuries & Concussion');
DECLARE @InstructorId INT = (SELECT UserId FROM Users WHERE Email = 'instructor@aidify.edu');

IF NOT EXISTS (SELECT 1 FROM Lessons WHERE ModuleId = @Head)
BEGIN
    INSERT INTO Lessons (ModuleId, Title, BodyHtml, SequenceOrder, EstimatedMinutes) VALUES
    (@Head, 'Assessing a Head Injury',
     '<h3>Initial Assessment</h3>'
     + '<p>Head injuries range from minor bumps to life-threatening bleeds. Always assess carefully.</p>'
     + '<h4>Ask About the Mechanism</h4>'
     + '<ul><li>Was there a significant impact (e.g. fall from height, road traffic collision)?</li>'
     + '<li>Did the person lose consciousness, even briefly?</li>'
     + '<li>Are they confused about what happened (amnesia)?</li></ul>'
     + '<h4>Red Flag Symptoms — Call 999 Immediately</h4>'
     + '<ul><li>Unconsciousness or difficulty waking</li>'
     + '<li>Repeated vomiting (more than once)</li>'
     + '<li>Seizure following the injury</li>'
     + '<li>Clear fluid from the nose or ears</li>'
     + '<li>Unequal pupils</li>'
     + '<li>Weakness or numbness in limbs</li>'
     + '<li>Worsening headache</li></ul>',
     1, 9),

    (@Head, 'Concussion Recognition & Management',
     '<h3>What is Concussion?</h3>'
     + '<p>Concussion is a temporary disturbance of brain function caused by a blow or jolt to the head. '
     + 'It does not always involve loss of consciousness.</p>'
     + '<h4>Common Symptoms</h4>'
     + '<ul><li>Headache or pressure in the head</li>'
     + '<li>Feeling slowed down, foggy, or dazed</li>'
     + '<li>Memory problems or confusion</li>'
     + '<li>Nausea or vomiting (once)</li>'
     + '<li>Balance problems, dizziness</li>'
     + '<li>Sensitivity to light or noise</li>'
     + '<li>Sleep disturbance</li></ul>'
     + '<h4>First Aid for Suspected Concussion</h4>'
     + '<ol><li>Remove from activity immediately — do not let them "play through" it.</li>'
     + '<li>Rest in a quiet, calm environment.</li>'
     + '<li>Apply a cold pack (wrapped in cloth) to reduce swelling.</li>'
     + '<li>Monitor closely for 24 hours. Wake every few hours overnight.</li>'
     + '<li>Seek medical attention — concussion always requires medical assessment.</li>'
     + '<li>No return to sport or strenuous activity until medically cleared.</li></ol>',
     2, 9),

    (@Head, 'Spinal Injury Precautions',
     '<h3>Suspected Spinal Injury</h3>'
     + '<p>Any significant head injury may also involve spinal injury, especially if the person fell from a height, '
     + 'was in a vehicle collision, or was diving.</p>'
     + '<h4>Symptoms of Spinal Injury</h4>'
     + '<ul><li>Pain or tenderness in the neck or back</li>'
     + '<li>Tingling, numbness, or weakness in the arms or legs</li>'
     + '<li>Loss of bladder or bowel control</li></ul>'
     + '<h4>What to Do</h4>'
     + '<ul><li>Do NOT move the person unless there is immediate danger to life.</li>'
     + '<li>Keep the head still — kneel behind and hold the head steady with both hands.</li>'
     + '<li>Call 999 and keep the person still until paramedics arrive.</li>'
     + '<li>If they must be moved (fire, water) and you have enough helpers, use a log-roll technique.</li></ul>',
     3, 8);
END

IF NOT EXISTS (SELECT 1 FROM Quizzes WHERE ModuleId = @Head)
BEGIN
    INSERT INTO Quizzes (ModuleId, Title, Description, TimeLimitSec, PassingPct, IsPreview)
    VALUES (@Head, 'Head Injury Assessment Quiz',
            'Test your knowledge of concussion and serious head injury management.', 240, 70, 0);

    DECLARE @QHead INT = (SELECT QuizId FROM Quizzes WHERE ModuleId = @Head);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QHead, 'A person who was hit on the head vomits twice and then seems alert. What should you do?', 'MCQ', 1);
    DECLARE @H1 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@H1, 'Give water and let them rest at home',               0),
        (@H1, 'Call 999 — repeated vomiting is a red flag',         1),
        (@H1, 'Observe for another hour before deciding',           0),
        (@H1, 'Only call for help if they vomit a third time',      0);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QHead, 'Clear fluid leaking from the ear after a head injury suggests:', 'MCQ', 1);
    DECLARE @H2 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@H2, 'Minor ear canal damage only',                          0),
        (@H2, 'Possible skull fracture — call 999 immediately',       1),
        (@H2, 'Normal post-impact drainage',                          0),
        (@H2, 'The person has a perforated eardrum',                  0);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QHead, 'An athlete with suspected concussion says they feel fine and wants to continue playing. What do you do?', 'MCQ', 1);
    DECLARE @H3 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@H3, 'Allow them to continue — they are the best judge of how they feel', 0),
        (@H3, 'Remove from play immediately — no return until medically cleared',  1),
        (@H3, 'Allow return after 15 minutes of rest',                             0),
        (@H3, 'Ask a team-mate to monitor them during play',                       0);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QHead, 'You suspect a casualty has both a head AND spinal injury. What is the priority?', 'MCQ', 1);
    DECLARE @H4 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@H4, 'Sit them up to check breathing',                                          0),
        (@H4, 'Keep the head still, call 999, and do not move them unless there is immediate danger', 1),
        (@H4, 'Roll them onto their side into the recovery position immediately',        0),
        (@H4, 'Help them stand up to assess balance',                                    0);
END
GO

-- ─────────────────────────────────────────────────────────────────────────────
-- MODULE 9 — Diabetic Emergencies
-- ─────────────────────────────────────────────────────────────────────────────

DECLARE @InstructorId INT = (SELECT UserId FROM Users WHERE Email = 'instructor@aidify.edu');

IF NOT EXISTS (SELECT 1 FROM Modules WHERE Title = 'Diabetic Emergencies')
BEGIN
    INSERT INTO Modules (Title, Description, DifficultyLevel, Status, IsPreview, CreatedBy)
    VALUES (
        'Diabetic Emergencies',
        'Recognising and responding to hypoglycaemia (low blood sugar) and hyperglycaemia '
        + '(high blood sugar) in people with diabetes. Covers symptoms, safe sugar treatment, '
        + 'and when to call for emergency help.',
        'Beginner', 'Published', 0, @InstructorId
    );
END
GO

DECLARE @Diab INT = (SELECT ModuleId FROM Modules WHERE Title = 'Diabetic Emergencies');
DECLARE @InstructorId INT = (SELECT UserId FROM Users WHERE Email = 'instructor@aidify.edu');

IF NOT EXISTS (SELECT 1 FROM Lessons WHERE ModuleId = @Diab)
BEGIN
    INSERT INTO Lessons (ModuleId, Title, BodyHtml, SequenceOrder, EstimatedMinutes) VALUES
    (@Diab, 'Hypoglycaemia — Low Blood Sugar',
     '<h3>What is Hypoglycaemia?</h3>'
     + '<p>Hypoglycaemia ("hypo") occurs when blood glucose falls too low, typically below 4 mmol/L. '
     + 'It can develop rapidly and become life-threatening if untreated.</p>'
     + '<h4>Causes</h4>'
     + '<ul><li>Too much insulin or oral diabetes medication</li>'
     + '<li>Skipping or delaying a meal</li>'
     + '<li>Unusual physical activity without extra carbohydrates</li><li>Alcohol consumption</li></ul>'
     + '<h4>Signs and Symptoms</h4>'
     + '<ul><li>Shaking, trembling</li><li>Sweating, pale skin</li>'
     + '<li>Hunger, dizziness, weakness</li>'
     + '<li>Confusion, aggression, or unusual behaviour</li>'
     + '<li>In severe cases: unconsciousness or seizure</li></ul>',
     1, 8),

    (@Diab, 'Treating a Hypoglycaemic Episode',
     '<h3>If the Person is Conscious and Can Swallow</h3>'
     + '<ol><li>Give 15–20 g of fast-acting carbohydrate immediately:<ul>'
     + '<li>5–6 glucose tablets</li>'
     + '<li>150–200 ml of fruit juice or regular (not diet) fizzy drink</li>'
     + '<li>3–4 teaspoons of sugar dissolved in water</li></ul></li>'
     + '<li>Wait 15 minutes and recheck — if still symptomatic, repeat the dose.</li>'
     + '<li>Once the person feels better, give a longer-acting snack (biscuit, sandwich) to prevent recurrence.</li>'
     + '<li>If they carry a glucose gel, help them apply it to the inside of their cheek.</li></ol>'
     + '<h3>If the Person is Unconscious</h3>'
     + '<p>Do NOT give anything by mouth — risk of choking.</p>'
     + '<ol><li>Call 999 immediately.</li>'
     + '<li>Place in the recovery position if breathing.</li>'
     + '<li>If trained: glucagon injection per prescription.</li><li>Stay until help arrives.</li></ol>',
     2, 8),

    (@Diab, 'Hyperglycaemia & Diabetic Ketoacidosis',
     '<h3>High Blood Sugar (Hyperglycaemia)</h3>'
     + '<p>Hyperglycaemia develops more slowly than hypoglycaemia — over hours or days.</p>'
     + '<h4>Symptoms</h4>'
     + '<ul><li>Excessive thirst and frequent urination</li>'
     + '<li>Tiredness and blurred vision</li>'
     + '<li>Headache, nausea</li>'
     + '<li>Sweet or fruity breath (in DKA)</li></ul>'
     + '<h4>Diabetic Ketoacidosis (DKA)</h4>'
     + '<p>DKA is a dangerous complication of severe hyperglycaemia, more common in Type 1 diabetes. '
     + 'Signs include deep rapid breathing, vomiting, and confusion.</p>'
     + '<p><strong>DKA is a medical emergency — call 999.</strong></p>'
     + '<h4>Distinguishing Hypo from Hyper (quick guide)</h4>'
     + '<table border="1" style="border-collapse:collapse; width:100%;"><tr>'
     + '<th>Hypoglycaemia</th><th>Hyperglycaemia</th></tr>'
     + '<tr><td>Rapid onset (minutes)</td><td>Slow onset (hours/days)</td></tr>'
     + '<tr><td>Pale, sweating</td><td>Flushed, dry skin</td></tr>'
     + '<tr><td>Hungry</td><td>Thirsty</td></tr>'
     + '<tr><td>Treat with sugar NOW</td><td>Needs medical attention</td></tr></table>',
     3, 9);
END

IF NOT EXISTS (SELECT 1 FROM Quizzes WHERE ModuleId = @Diab)
BEGIN
    INSERT INTO Quizzes (ModuleId, Title, Description, TimeLimitSec, PassingPct, IsPreview)
    VALUES (@Diab, 'Diabetic Emergencies Quiz',
            'Test your ability to recognise and respond to diabetic emergencies.', 240, 70, 0);

    DECLARE @QDiab INT = (SELECT QuizId FROM Quizzes WHERE ModuleId = @Diab);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QDiab, 'A diabetic person is shaking, sweating, and confused. What should you give them FIRST?', 'MCQ', 1);
    DECLARE @D1 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@D1, 'A large meal to raise blood sugar slowly',       0),
        (@D1, '15–20 g of fast-acting sugar (juice, glucose tablets)', 1),
        (@D1, 'Water to prevent dehydration',                   0),
        (@D1, 'Their insulin injection',                        0);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QDiab, 'A diabetic casualty is unconscious. What should you do?', 'MCQ', 1);
    DECLARE @D2 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@D2, 'Pour orange juice into their mouth',                            0),
        (@D2, 'Call 999 and place in the recovery position if breathing',      1),
        (@D2, 'Wait for them to regain consciousness before acting',           0),
        (@D2, 'Give their insulin pen injection immediately',                  0);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QDiab, 'Which feature most helps distinguish hypoglycaemia from hyperglycaemia?', 'MCQ', 1);
    DECLARE @D3 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@D3, 'The person''s age',                                       0),
        (@D3, 'Speed of onset — hypo is rapid, hyper is slow',           1),
        (@D3, 'Whether the person is Type 1 or Type 2 diabetic',         0),
        (@D3, 'Whether they have taken their medication today',           0);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QDiab, 'A diabetic person has deep rapid breathing, fruity breath, and is vomiting. This suggests:', 'MCQ', 1);
    DECLARE @D4 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@D4, 'Mild hypoglycaemia — give sugar',                         0),
        (@D4, 'Diabetic Ketoacidosis (DKA) — call 999 immediately',      1),
        (@D4, 'Food poisoning unrelated to diabetes',                    0),
        (@D4, 'Normal post-exercise breathing',                          0);
END
GO

-- ─────────────────────────────────────────────────────────────────────────────
-- MODULE 10 — Poisoning & Overdose Response
-- ─────────────────────────────────────────────────────────────────────────────

DECLARE @InstructorId INT = (SELECT UserId FROM Users WHERE Email = 'instructor@aidify.edu');

IF NOT EXISTS (SELECT 1 FROM Modules WHERE Title = 'Poisoning & Overdose Response')
BEGIN
    INSERT INTO Modules (Title, Description, DifficultyLevel, Status, IsPreview, CreatedBy)
    VALUES (
        'Poisoning & Overdose Response',
        'First aid response to swallowed poisons, household chemicals, alcohol intoxication, '
        + 'and medication overdose. Covers what information to gather, what NOT to do, '
        + 'and how to work with Poison Control and emergency services.',
        'Advanced', 'Published', 0, @InstructorId
    );
END
GO

DECLARE @Pois INT = (SELECT ModuleId FROM Modules WHERE Title = 'Poisoning & Overdose Response');
DECLARE @InstructorId INT = (SELECT UserId FROM Users WHERE Email = 'instructor@aidify.edu');

IF NOT EXISTS (SELECT 1 FROM Lessons WHERE ModuleId = @Pois)
BEGIN
    INSERT INTO Lessons (ModuleId, Title, BodyHtml, SequenceOrder, EstimatedMinutes) VALUES
    (@Pois, 'Recognising Poisoning',
     '<h3>Types of Poisoning</h3>'
     + '<ul><li><strong>Swallowed:</strong> household chemicals, medications, plants, alcohol</li>'
     + '<li><strong>Inhaled:</strong> carbon monoxide, gas leaks, fumes</li>'
     + '<li><strong>Absorbed through skin:</strong> pesticides, industrial chemicals</li>'
     + '<li><strong>Injected:</strong> drug overdose, snake/insect venom</li></ul>'
     + '<h4>General Signs of Poisoning</h4>'
     + '<ul><li>Sudden illness after contact with a substance</li>'
     + '<li>Nausea, vomiting, stomach pain</li>'
     + '<li>Seizures, confusion, or loss of consciousness</li>'
     + '<li>Burns or staining around the mouth</li>'
     + '<li>Unusual smell on the breath</li>'
     + '<li>Constricted or dilated pupils</li></ul>',
     1, 8),

    (@Pois, 'First Aid for Swallowed Poison',
     '<h3>What to Do</h3>'
     + '<ol><li>Call 999 or Poison Control immediately — do not wait for symptoms.</li>'
     + '<li>Stay calm and try to find out what was taken, how much, and when.</li>'
     + '<li>Keep the substance packaging to show to paramedics.</li>'
     + '<li>If the person is conscious, keep them calm and still.</li>'
     + '<li>If unconscious and breathing — recovery position and monitor.</li>'
     + '<li>If not breathing — begin CPR.</li></ol>'
     + '<h4>Critical DO NOTs</h4>'
     + '<ul><li><strong>Do NOT</strong> induce vomiting — it can cause additional damage with corrosive substances.</li>'
     + '<li><strong>Do NOT</strong> give food, drink, or milk unless told to by Poison Control.</li>'
     + '<li><strong>Do NOT</strong> leave the person alone.</li></ul>',
     2, 9),

    (@Pois, 'Alcohol & Drug Overdose',
     '<h3>Alcohol Intoxication vs Alcohol Poisoning</h3>'
     + '<p><strong>Intoxication</strong> is common and usually resolves with time. '
     + '<strong>Alcohol poisoning</strong> is life-threatening.</p>'
     + '<h4>Signs of Alcohol Poisoning</h4>'
     + '<ul><li>Unconscious and cannot be roused</li>'
     + '<li>Pale, blue-tinged skin (cyanosis)</li>'
     + '<li>Slow, shallow, or irregular breathing</li>'
     + '<li>Hypothermia (cold, clammy skin)</li>'
     + '<li>Seizures</li></ul>'
     + '<h4>Drug Overdose</h4>'
     + '<p>Signs vary by substance. Opioid overdose: pinpoint pupils, very slow breathing, unconsciousness. '
     + 'Stimulant overdose: rapid heart rate, agitation, chest pain, seizures.</p>'
     + '<h4>Response for Both</h4>'
     + '<ol><li>Call 999 immediately.</li>'
     + '<li>If breathing — recovery position on their side (vomiting is common).</li>'
     + '<li>Keep warm with a blanket.</li>'
     + '<li>Monitor breathing continuously until help arrives.</li>'
     + '<li>Never leave alone.</li></ol>',
     3, 9);
END

IF NOT EXISTS (SELECT 1 FROM Quizzes WHERE ModuleId = @Pois)
BEGIN
    INSERT INTO Quizzes (ModuleId, Title, Description, TimeLimitSec, PassingPct, IsPreview)
    VALUES (@Pois, 'Poisoning & Overdose Quiz',
            'Assess your knowledge of first aid for poisoning and overdose situations.', 240, 75, 0);

    DECLARE @QPois INT = (SELECT QuizId FROM Quizzes WHERE ModuleId = @Pois);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QPois, 'A child has swallowed a household cleaning product. What should you do first?', 'MCQ', 1);
    DECLARE @P1 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@P1, 'Make them vomit to remove the poison',                        0),
        (@P1, 'Call 999 or Poison Control immediately',                      1),
        (@P1, 'Give them milk to neutralise the chemical',                   0),
        (@P1, 'Wait to see if symptoms develop before calling for help',     0);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QPois, 'Why should you NEVER induce vomiting after a person swallows a corrosive substance?', 'MCQ', 1);
    DECLARE @P2 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@P2, 'It has no effect once the substance is swallowed',                                  0),
        (@P2, 'Vomiting brings the corrosive back up and causes additional damage to the throat',  1),
        (@P2, 'It will make the person more agitated',                                             0),
        (@P2, 'It is only contraindicated in children, not adults',                                0);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QPois, 'An unconscious person is suspected of opioid overdose. Their breathing is very slow. What do you do?', 'MCQ', 1);
    DECLARE @P3 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@P3, 'Leave them to sleep it off in a warm room',                  0),
        (@P3, 'Call 999 and place in the recovery position if breathing; begin CPR if not', 1),
        (@P3, 'Give them strong coffee to stimulate breathing',             0),
        (@P3, 'Sit them upright and wait for them to regain consciousness', 0);

    INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points) VALUES
        (@QPois, 'Which of these is a sign of alcohol poisoning (not just intoxication)?', 'MCQ', 1);
    DECLARE @P4 INT = SCOPE_IDENTITY();
    INSERT INTO Options (QuestionId, OptionText, IsCorrect) VALUES
        (@P4, 'Slurred speech and loss of coordination',                           0),
        (@P4, 'Unconscious, cannot be roused, with slow irregular breathing',      1),
        (@P4, 'Flushed face and overconfidence',                                   0),
        (@P4, 'Nausea without vomiting',                                           0);
END
GO

PRINT '05_SeedAdditionalModules complete:';
PRINT '  Added modules 6-10: Anaphylaxis, Stroke, Head Injuries, Diabetic Emergencies, Poisoning';
PRINT '  10 total modules now in the database.';
PRINT '  5 new quizzes, 20 new questions, 80 new answer options.';
GO
