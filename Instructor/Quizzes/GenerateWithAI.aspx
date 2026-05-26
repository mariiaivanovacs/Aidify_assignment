<%@ Page Title="Generate Quiz With AI" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GenerateWithAI.aspx.cs" Inherits="Aidify_assigment.Instructor.Quizzes.GenerateWithAI" %>

<asp:Content ID="GenerateQuizAIContent" ContentPlaceHolderID="MainContent" runat="server">

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

<style>
    body {
        font-family: 'Inter', sans-serif !important;
        background: #fff8f7 !important;
        color: #281715 !important;
    }

    .material-symbols-outlined {
        font-variation-settings: 'FILL' 0, 'wght' 500, 'GRAD' 0, 'opsz' 24;
        vertical-align: middle;
    }

    .aidify-page {
        min-height: 100vh;
        background: #fff8f7;
    }

    .aidify-sidebar {
        position: fixed;
        left: 0;
        top: 0;
        width: 220px;
        height: 100vh;
        background: #fff0ee;
        border-right: 1px solid #e6bdb8;
        padding: 20px 12px;
        display: flex;
        flex-direction: column;
        z-index: 20;
    }

    .aidify-brand {
        padding: 0 12px 30px;
    }

    .aidify-brand h1 {
        margin: 0;
        color: #b70011;
        font-size: 18px;
        font-weight: 800;
    }

    .aidify-brand p {
        margin: 3px 0 0;
        color: #5c403c;
        font-size: 11px;
    }

    .aidify-nav {
        display: flex;
        flex-direction: column;
        gap: 6px;
        flex: 1;
    }

    .aidify-nav a,
    .aidify-sidebar-bottom a {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 10px 12px;
        border-radius: 8px;
        color: #5c403c;
        text-decoration: none !important;
        font-size: 13px;
        font-weight: 700;
        transition: .2s ease;
    }

    .aidify-nav a:hover,
    .aidify-sidebar-bottom a:hover {
        background: #fbdbd7;
        color: #281715;
    }

    .aidify-nav a.active {
        background: #b70011;
        color: #fff;
        box-shadow: 0 8px 18px rgba(183, 0, 17, .16);
    }

    .aidify-nav .material-symbols-outlined,
    .aidify-sidebar-bottom .material-symbols-outlined {
        font-size: 18px;
    }

    .aidify-sidebar-bottom {
        border-top: 1px solid #e6bdb8;
        padding-top: 14px;
        display: flex;
        flex-direction: column;
        gap: 6px;
    }

    .aidify-topbar {
        position: fixed;
        top: 0;
        left: 220px;
        right: 0;
        height: 56px;
        background: rgba(255, 248, 247, .94);
        border-bottom: 1px solid #e6bdb8;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 24px;
        z-index: 15;
    }

    .topbar-search {
        position: relative;
        width: min(460px, 100%);
    }

    .topbar-search .material-symbols-outlined {
        position: absolute;
        left: 13px;
        top: 50%;
        transform: translateY(-50%);
        color: #5c403c;
        font-size: 20px;
    }

    .topbar-search input {
        width: 100%;
        height: 38px;
        border-radius: 999px;
        border: 1px solid #e6bdb8;
        background: #fff0ee;
        padding: 0 16px 0 42px;
        color: #281715;
        font-size: 13px;
        outline: none;
        box-sizing: border-box;
    }

    .topbar-actions {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .topbar-icon {
        width: 34px;
        height: 34px;
        border: 0;
        background: transparent;
        color: #281715;
        border-radius: 999px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
    }

    .topbar-icon:hover {
        background: #fbdbd7;
        color: #b70011;
    }

    .profile-chip {
        display: flex;
        align-items: center;
        gap: 8px;
        color: #281715;
        text-decoration: none !important;
        font-size: 12px;
        font-weight: 800;
    }

    .profile-chip img {
        width: 30px;
        height: 30px;
        border-radius: 999px;
        object-fit: cover;
        border: 1px solid #e6bdb8;
    }

    .aidify-main {
        margin-left: 220px;
        margin-top: 56px;
        padding: 28px;
        min-height: calc(100vh - 56px);
    }

    .page-container {
        max-width: 1220px;
        margin: 0 auto;
    }

    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        gap: 18px;
        margin-bottom: 22px;
    }

    .page-title {
        font-size: 30px;
        font-weight: 800;
        letter-spacing: -0.035em;
        margin: 0 0 4px;
        color: #281715;
    }

    .page-subtitle {
        color: #5c403c;
        font-size: 14px;
        margin: 0;
    }

    .header-actions,
    .button-row {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
    }

    .btn-primary-red,
    .btn-outline-red,
    .btn-muted {
        border-radius: 8px;
        padding: 10px 16px;
        font-size: 13px;
        font-weight: 800;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 7px;
        text-decoration: none !important;
        cursor: pointer;
    }

    .btn-primary-red {
        background: #b70011;
        color: #fff !important;
        border: 1px solid #b70011;
        box-shadow: 0 10px 22px rgba(183, 0, 17, .16);
    }

    .btn-outline-red {
        background: #fff;
        color: #b70011 !important;
        border: 1px solid #e6bdb8;
    }

    .btn-muted {
        background: #fff;
        color: #281715 !important;
        border: 1px solid #e6bdb8;
    }

    .generator-grid {
        display: grid;
        grid-template-columns: minmax(0, 1fr) minmax(380px, .9fr);
        gap: 22px;
        align-items: start;
    }

    .panel-card {
        background: #fff;
        border: 1px solid #e6bdb8;
        border-radius: 12px;
        box-shadow: 0 4px 14px rgba(40, 23, 21, .06);
        overflow: hidden;
    }

    .panel-card + .panel-card {
        margin-top: 18px;
    }

    .panel-header {
        padding: 16px 18px;
        border-bottom: 1px solid #e6bdb8;
        background: #fff8f7;
    }

    .panel-title {
        margin: 0;
        color: #281715;
        font-size: 18px;
        font-weight: 800;
    }

    .panel-subtitle {
        margin: 4px 0 0;
        color: #5c403c;
        font-size: 12px;
        line-height: 1.5;
    }

    .panel-body {
        padding: 18px;
    }

    .form-grid {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 14px;
    }

    .form-group {
        margin-bottom: 14px;
    }

    .form-group.full {
        grid-column: 1 / -1;
    }

    .form-label {
        display: flex;
        justify-content: space-between;
        color: #5c403c;
        font-size: 12px;
        font-weight: 800;
        margin-bottom: 7px;
    }

    .required {
        color: #b70011;
        font-size: 10px;
        letter-spacing: .06em;
    }

    .form-input,
    .form-select,
    .form-textarea {
        width: 100% !important;
        max-width: none !important;
        border: 1px solid #e6bdb8;
        background: #fff8f7;
        border-radius: 8px;
        color: #281715;
        font-size: 13px;
        outline: none;
        padding: 10px 12px;
        box-sizing: border-box;
    }

    .form-input:focus,
    .form-select:focus,
    .form-textarea:focus {
        border-color: #b70011;
        box-shadow: 0 0 0 4px rgba(183, 0, 17, .08);
    }

    .form-textarea {
        min-height: 120px;
        resize: vertical;
        line-height: 1.5;
    }

    .preview-box {
        background: #fff8f7;
        border: 1px solid #e6bdb8;
        border-radius: 10px;
        padding: 14px;
        display: grid;
        gap: 10px;
        color: #281715;
        font-size: 13px;
        font-weight: 700;
    }

    .preview-row {
        display: flex;
        justify-content: space-between;
        gap: 10px;
        border-bottom: 1px solid #f0d2ce;
        padding-bottom: 8px;
    }

    .preview-row:last-child {
        border-bottom: 0;
        padding-bottom: 0;
    }

    .preview-label {
        color: #5c403c;
        font-weight: 800;
    }

    .preview-value {
        color: #281715;
        font-weight: 800;
        text-align: right;
    }

    .question-list {
        display: grid;
        gap: 12px;
    }

    .question-card {
        border: 1px solid #e6bdb8;
        border-radius: 10px;
        background: #fff8f7;
        padding: 14px;
    }

    .question-head {
        display: flex;
        justify-content: space-between;
        gap: 12px;
        align-items: flex-start;
        margin-bottom: 10px;
    }

    .question-title {
        color: #281715;
        font-size: 13px;
        font-weight: 800;
        line-height: 1.5;
    }

    .question-actions {
        display: flex;
        gap: 6px;
        flex-shrink: 0;
    }

    .icon-btn {
        width: 32px;
        height: 32px;
        border: 1px solid #e6bdb8;
        background: #fff;
        color: #281715;
        border-radius: 8px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
    }

    .icon-btn:hover {
        background: #fff0ee;
        color: #b70011;
    }

    .option-list {
        display: grid;
        gap: 6px;
        margin-top: 8px;
    }

    .option-item {
        background: #fff;
        border: 1px solid #f0d2ce;
        border-radius: 8px;
        padding: 8px 10px;
        color: #5c403c;
        font-size: 12px;
        font-weight: 700;
    }

    .answer-box {
        margin-top: 10px;
        background: #fff0ee;
        border: 1px solid #e6bdb8;
        border-radius: 8px;
        padding: 10px;
        color: #281715;
        font-size: 12px;
        line-height: 1.5;
    }

    .checklist {
        display: grid;
        gap: 10px;
    }

    .check-item {
        display: flex;
        gap: 10px;
        align-items: center;
        color: #281715;
        font-size: 13px;
        font-weight: 700;
    }

    .check-icon {
        width: 28px;
        height: 28px;
        border-radius: 999px;
        background: #dcfce7;
        color: #15803d;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }

    .empty-state {
        border: 1px dashed #e6bdb8;
        border-radius: 12px;
        padding: 22px;
        text-align: center;
        color: #5c403c;
        background: #fff8f7;
        font-size: 13px;
        font-weight: 700;
    }

    .toast {
        position: fixed;
        right: 24px;
        bottom: 24px;
        background: #281715;
        color: #fff;
        border-radius: 12px;
        padding: 14px 16px;
        font-size: 13px;
        font-weight: 800;
        box-shadow: 0 12px 30px rgba(40, 23, 21, .25);
        opacity: 0;
        pointer-events: none;
        transform: translateY(10px);
        transition: .25s ease;
        z-index: 100;
    }

    .toast.show {
        opacity: 1;
        transform: translateY(0);
    }

    @media (max-width: 1150px) {
        .generator-grid {
            grid-template-columns: 1fr;
        }
    }

    @media (max-width: 850px) {
        .aidify-sidebar {
            position: relative;
            width: 100%;
            height: auto;
        }

        .aidify-nav {
            flex-direction: row;
            overflow-x: auto;
        }

        .aidify-topbar {
            left: 0;
            position: relative;
        }

        .aidify-main {
            margin-left: 0;
            margin-top: 0;
            padding: 20px 16px;
        }

        .page-header {
            flex-direction: column;
            align-items: flex-start;
        }

        .form-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<div class="aidify-page">

    <aside class="aidify-sidebar">
        <div class="aidify-brand">
            <h1>Aidify</h1>
            <p>Instructor Portal</p>
        </div>

        <nav class="aidify-nav">
            <a href="/Instructor/Dashboard.aspx">
                <span class="material-symbols-outlined">dashboard</span>
                Dashboard
            </a>

            <a href="/Instructor/Modules/List.aspx">
                <span class="material-symbols-outlined">school</span>
                Modules
            </a>

            <a href="/Instructor/Materials/Upload.aspx">
                <span class="material-symbols-outlined">description</span>
                Materials
            </a>

            <a class="active" href="/Instructor/Quizzes/List.aspx">
                <span class="material-symbols-outlined">quiz</span>
                Quizzes
            </a>

            <a href="/Instructor/Performance.aspx">
                <span class="material-symbols-outlined">trending_up</span>
                Performance
            </a>

            <a href="/Instructor/Discussions/Discussions.aspx">
                <span class="material-symbols-outlined">forum</span>
                Discussions
            </a>

            <a href="/Instructor/Challenges.aspx">
                <span class="material-symbols-outlined">military_tech</span>
                Challenges
            </a>

            <a href="/Instructor/Events.aspx">
                <span class="material-symbols-outlined">calendar_today</span>
                Events
            </a>
        </nav>

            <div class="instructor-mini">
                <div class="avatar">M</div>
                <div>
                    <div class="mini-name">Dr. Sarah Mitchell</div>
                    <div class="mini-role">Lead Medical Instructor</div>
                </div>
            </div>
        </aside>

    <header class="aidify-topbar">
        <div class="topbar-search">
            <span class="material-symbols-outlined">search</span>
            <input id="globalSearch" type="text" placeholder="Search AI quiz topics or modules..." />
        </div>

        <div class="topbar-actions">
            <button type="button" class="topbar-icon" onclick="openNotifications()">
                <span class="material-symbols-outlined">notifications</span>
            </button>

            <button type="button" class="topbar-icon" onclick="openHelp()">
                <span class="material-symbols-outlined">help_outline</span>
            </button>

            <a href="#" class="profile-chip" onclick="openProfile(); return false;">
                <img alt="Instructor" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBTgTMp5iW7KpgwUSWn4fAuyefPR2SBfnO8bdfPX0kbX_N9naIVTbimChz6P6d-FPnlbUYB_y1tOjHq_Rye4b4y13fEnuo2LLcxWyFZ_KbEA7Sc1FYwD01OUtZ3kgcBRQGnRyD7_GdB2CV5ZTAMfIsGaz3BjYHlmxSNsHmK_q-oNfgqRh1LLDL33IPm4v78RmJ1UWsdUWCxExhnOuwVdQzB3QjAWwemoUo7i2_9YIta-46d5zHsC6ko63pD_0thGj29USMlLX8RSbI" />
                <span>Dr. Sarah Mitchell</span>
            </a>
        </div>
    </header>

    <main class="aidify-main">
        <div class="page-container">

            <section class="page-header">
                <div>
                    <h2 class="page-title">Generate Quiz With AI</h2>
                    <p class="page-subtitle">Generate structured quiz questions for clinical training modules, then send them back to the Quiz Builder.</p>
                </div>

                <div class="header-actions">
                    <button type="button" class="btn-muted" onclick="backToQuizzes()">
                        <span class="material-symbols-outlined">arrow_back</span>
                        Back to Quizzes
                    </button>

                    <button type="button" class="btn-outline-red" onclick="generateQuestions()">
                        <span class="material-symbols-outlined">auto_awesome</span>
                        Generate Questions
                    </button>

                    <button type="button" class="btn-primary-red" onclick="useInQuizBuilder()">
                        <span class="material-symbols-outlined">send</span>
                        Use in Quiz Builder
                    </button>
                </div>
            </section>

            <section class="generator-grid">

                <div>
                    <div class="panel-card">
                        <div class="panel-header">
                            <h3 class="panel-title">AI Generator Form</h3>
                            <p class="panel-subtitle">Set the quiz topic, module, difficulty, and assessment rules.</p>
                        </div>

                        <div class="panel-body">
                            <div class="form-grid">

                                <div class="form-group full">
                                    <label class="form-label">
                                        Quiz Topic
                                        <span class="required">* REQUIRED</span>
                                    </label>
                                    <input id="quizTopic" class="form-input" type="text" placeholder="e.g., CPR chest compressions, choking response, wound care" />
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Select Module</label>
                                    <select id="selectModule" class="form-select" onchange="updatePreview()">
                                        <option>CPR Fundamentals</option>
                                        <option>Airway Emergencies</option>
                                        <option>Trauma Response</option>
                                        <option>Burn Treatment Basics</option>
                                        <option>Emergency Wound Care</option>
                                        <option>Pediatric First Aid</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Difficulty</label>
                                    <select id="difficulty" class="form-select" onchange="updatePreview()">
                                        <option>Easy</option>
                                        <option selected="selected">Medium</option>
                                        <option>Hard</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Generate Style</label>
                                    <select id="generateStyle" class="form-select" onchange="updatePreview()">
                                        <option>Knowledge Check</option>
                                        <option>Scenario-Based</option>
                                        <option>Certification Practice</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Number of Questions</label>
                                    <input id="questionCount" class="form-input" type="number" min="1" max="20" value="5" onchange="updatePreview()" />
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Passing Score</label>
                                    <input id="passingScore" class="form-input" type="number" min="0" max="100" value="80" onchange="updatePreview()" />
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Time Limit</label>
                                    <input id="timeLimit" class="form-input" type="number" min="1" value="10" onchange="updatePreview()" />
                                </div>

                                <div class="form-group full">
                                    <label class="form-label">Certification Ready</label>
                                    <select id="certificationReady" class="form-select" onchange="updatePreview()">
                                        <option value="false">No</option>
                                        <option value="true">Yes</option>
                                    </select>
                                </div>

                                <div class="form-group full">
                                    <label class="form-label">Learning Objective</label>
                                    <textarea id="learningObjective" class="form-textarea" placeholder="Describe what learners should be able to do after completing this quiz."></textarea>
                                </div>
                            </div>

                            <div class="button-row">
                                <button type="button" class="btn-primary-red" onclick="generateQuestions()">
                                    <span class="material-symbols-outlined">auto_awesome</span>
                                    Generate Questions
                                </button>

                                <button type="button" class="btn-muted" onclick="clearGeneratorForm()">
                                    <span class="material-symbols-outlined">restart_alt</span>
                                    Clear Form
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <aside>
                    <div class="panel-card">
                        <div class="panel-header">
                            <h3 class="panel-title">Generation Preview</h3>
                            <p class="panel-subtitle">Live summary of the generated quiz draft.</p>
                        </div>

                        <div class="panel-body">
                            <div class="preview-box">
                                <div class="preview-row">
                                    <span class="preview-label">Quiz Title</span>
                                    <span class="preview-value" id="previewTitle">Generated Clinical Quiz</span>
                                </div>

                                <div class="preview-row">
                                    <span class="preview-label">Module</span>
                                    <span class="preview-value" id="previewModule">CPR Fundamentals</span>
                                </div>

                                <div class="preview-row">
                                    <span class="preview-label">Difficulty</span>
                                    <span class="preview-value" id="previewDifficulty">Medium</span>
                                </div>

                                <div class="preview-row">
                                    <span class="preview-label">Passing Score</span>
                                    <span class="preview-value" id="previewPassing">80%</span>
                                </div>

                                <div class="preview-row">
                                    <span class="preview-label">Time Limit</span>
                                    <span class="preview-value" id="previewTime">10 min</span>
                                </div>

                                <div class="preview-row">
                                    <span class="preview-label">Questions</span>
                                    <span class="preview-value" id="previewQuestions">0</span>
                                </div>

                                <div class="preview-row">
                                    <span class="preview-label">Certification Ready</span>
                                    <span class="preview-value" id="previewCertification">No</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel-card">
                        <div class="panel-header">
                            <h3 class="panel-title">Generated Questions</h3>
                            <p class="panel-subtitle">Review, edit, or delete generated questions before sending them to Quiz Builder.</p>
                        </div>

                        <div class="panel-body">
                            <div id="generatedQuestions" class="question-list">
                                <div class="empty-state">
                                    No questions generated yet. Fill the form and click Generate Questions.
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel-card">
                        <div class="panel-header">
                            <h3 class="panel-title">AI Quality Checklist</h3>
                            <p class="panel-subtitle">Prototype checklist for generated assessment quality.</p>
                        </div>

                        <div class="panel-body">
                            <div class="checklist">
                                <div class="check-item">
                                    <span class="check-icon material-symbols-outlined">check</span>
                                    Uses clinical training context
                                </div>

                                <div class="check-item">
                                    <span class="check-icon material-symbols-outlined">check</span>
                                    Includes correct answer
                                </div>

                                <div class="check-item">
                                    <span class="check-icon material-symbols-outlined">check</span>
                                    Includes explanation
                                </div>

                                <div class="check-item">
                                    <span class="check-icon material-symbols-outlined">check</span>
                                    Matches selected difficulty
                                </div>

                                <div class="check-item">
                                    <span class="check-icon material-symbols-outlined">check</span>
                                    Ready to move into Quiz Builder
                                </div>
                            </div>

                            <div class="button-row" style="margin-top:16px;">
                                <button type="button" class="btn-primary-red" onclick="useInQuizBuilder()">
                                    <span class="material-symbols-outlined">send</span>
                                    Use in Quiz Builder
                                </button>

                                <button type="button" class="btn-outline-red" onclick="exportGeneratedDraft()">
                                    <span class="material-symbols-outlined">ios_share</span>
                                    Export Generated Draft
                                </button>
                            </div>
                        </div>
                    </div>
                </aside>

            </section>

        </div>
    </main>

</div>

<div id="generatorToast" class="toast">Action completed.</div>

<script>
    var generatedQuestionsList = [];

    document.addEventListener("DOMContentLoaded", function () {
        attachPreviewEvents();
        updatePreview();
    });

    function attachPreviewEvents() {
        var ids = [
            "quizTopic",
            "selectModule",
            "difficulty",
            "generateStyle",
            "questionCount",
            "passingScore",
            "timeLimit",
            "certificationReady",
            "learningObjective"
        ];

        ids.forEach(function (id) {
            var element = document.getElementById(id);

            if (element) {
                element.addEventListener("input", updatePreview);
                element.addEventListener("change", updatePreview);
            }
        });

        var globalSearch = document.getElementById("globalSearch");

        if (globalSearch) {
            globalSearch.addEventListener("input", function () {
                var query = globalSearch.value.toLowerCase().trim();
                var topic = document.getElementById("quizTopic");
                if (!topic.value && query.length > 2) {
                    topic.value = globalSearch.value;
                    updatePreview();
                }
            });
        }
    }

    function showToast(message) {
        var toast = document.getElementById("generatorToast");
        toast.textContent = message;
        toast.classList.add("show");

        clearTimeout(window.__generatorToastTimer);
        window.__generatorToastTimer = setTimeout(function () {
            toast.classList.remove("show");
        }, 2200);
    }

    function backToQuizzes() {
        window.location.href = "/Instructor/Quizzes/List.aspx";
    }

    function getCleanTopic() {
        var topic = document.getElementById("quizTopic").value.trim();
        return topic || "Clinical Emergency Response";
    }

    function updatePreview() {
        var topic = getCleanTopic();
        var moduleName = document.getElementById("selectModule").value;
        var difficulty = document.getElementById("difficulty").value;
        var passing = document.getElementById("passingScore").value || "80";
        var time = document.getElementById("timeLimit").value || "10";
        var cert = document.getElementById("certificationReady").value === "true" ? "Yes" : "No";

        document.getElementById("previewTitle").textContent = topic + " Quiz";
        document.getElementById("previewModule").textContent = moduleName;
        document.getElementById("previewDifficulty").textContent = difficulty;
        document.getElementById("previewPassing").textContent = passing + "%";
        document.getElementById("previewTime").textContent = time + " min";
        document.getElementById("previewQuestions").textContent = generatedQuestionsList.length;
        document.getElementById("previewCertification").textContent = cert;
    }

    function generateQuestions() {
        var topic = document.getElementById("quizTopic").value.trim();
        var moduleName = document.getElementById("selectModule").value;
        var difficulty = document.getElementById("difficulty").value;
        var style = document.getElementById("generateStyle").value;
        var count = parseInt(document.getElementById("questionCount").value, 10) || 5;

        if (!topic) {
            showToast("Quiz topic is required.");
            document.getElementById("quizTopic").focus();
            return;
        }

        count = Math.max(1, Math.min(count, 20));
        generatedQuestionsList = [];

        for (var i = 1; i <= count; i++) {
            generatedQuestionsList.push({
                text: buildQuestionText(topic, moduleName, difficulty, style, i),
                type: "Multiple Choice",
                correct: "A",
                a: "Follow the recommended clinical sequence",
                b: "Skip assessment and continue immediately",
                c: "Delay action without monitoring the learner or patient",
                d: "Ignore learner safety checks",
                explanation: "The recommended clinical sequence improves safety, consistency, and decision-making during emergency response training."
            });
        }

        renderGeneratedQuestions();
        updatePreview();
        showToast(count + " questions generated.");
    }

    function buildQuestionText(topic, moduleName, difficulty, style, index) {
        if (style === "Scenario-Based") {
            return "Scenario " + index + ": A learner is managing " + topic + " during " + moduleName + ". Which action is most appropriate?";
        }

        if (style === "Certification Practice") {
            return "Certification practice " + index + ": What is the safest evidence-based action for " + topic + " in " + moduleName + "?";
        }

        return "Knowledge check " + index + ": Which action is most appropriate when managing " + topic + " in " + moduleName + "?";
    }

    function renderGeneratedQuestions() {
        var container = document.getElementById("generatedQuestions");
        container.innerHTML = "";

        if (generatedQuestionsList.length === 0) {
            container.innerHTML =
                '<div class="empty-state">No questions generated yet. Fill the form and click Generate Questions.</div>';
            updatePreview();
            return;
        }

        generatedQuestionsList.forEach(function (question, index) {
            var card = document.createElement("div");
            card.className = "question-card";

            card.innerHTML =
                '<div class="question-head">' +
                '<div class="question-title">Q' + (index + 1) + '. ' + escapeHtml(question.text) + '</div>' +
                '<div class="question-actions">' +
                '<button type="button" class="icon-btn" onclick="editGeneratedQuestion(' + index + ')">' +
                '<span class="material-symbols-outlined">edit</span>' +
                '</button>' +
                '<button type="button" class="icon-btn" onclick="deleteGeneratedQuestion(' + index + ')">' +
                '<span class="material-symbols-outlined">delete</span>' +
                '</button>' +
                '</div>' +
                '</div>' +
                '<div class="option-list">' +
                '<div class="option-item">A. ' + escapeHtml(question.a) + '</div>' +
                '<div class="option-item">B. ' + escapeHtml(question.b) + '</div>' +
                '<div class="option-item">C. ' + escapeHtml(question.c) + '</div>' +
                '<div class="option-item">D. ' + escapeHtml(question.d) + '</div>' +
                '</div>' +
                '<div class="answer-box">' +
                '<strong>Correct Answer:</strong> ' + escapeHtml(question.correct) + '<br />' +
                '<strong>Explanation:</strong> ' + escapeHtml(question.explanation) +
                '</div>';

            container.appendChild(card);
        });

        updatePreview();
    }

    function editGeneratedQuestion(index) {
        var question = generatedQuestionsList[index];

        if (!question) {
            showToast("Question not found.");
            return;
        }

        var updatedText = prompt("Edit question text:", question.text);

        if (updatedText === null) {
            showToast("Edit cancelled.");
            return;
        }

        updatedText = updatedText.trim();

        if (!updatedText) {
            showToast("Question text cannot be empty.");
            return;
        }

        generatedQuestionsList[index].text = updatedText;
        renderGeneratedQuestions();
        showToast("Question updated.");
    }

    function deleteGeneratedQuestion(index) {
        var questionNumber = index + 1;
        var confirmed = confirm("Delete generated question " + questionNumber + "?");

        if (!confirmed) {
            showToast("Delete cancelled.");
            return;
        }

        generatedQuestionsList.splice(index, 1);
        renderGeneratedQuestions();
        showToast("Question deleted.");
    }

    function clearGeneratorForm() {
        document.getElementById("quizTopic").value = "";
        document.getElementById("selectModule").value = "CPR Fundamentals";
        document.getElementById("difficulty").value = "Medium";
        document.getElementById("generateStyle").value = "Knowledge Check";
        document.getElementById("questionCount").value = "5";
        document.getElementById("passingScore").value = "80";
        document.getElementById("timeLimit").value = "10";
        document.getElementById("certificationReady").value = "false";
        document.getElementById("learningObjective").value = "";

        generatedQuestionsList = [];
        renderGeneratedQuestions();
        updatePreview();
        showToast("Form cleared.");
    }

    function buildGeneratedQuizObject() {
        var topic = getCleanTopic();
        var moduleName = document.getElementById("selectModule").value;
        var difficulty = document.getElementById("difficulty").value;
        var passingScore = document.getElementById("passingScore").value || "80";
        var timeLimit = document.getElementById("timeLimit").value || "10";
        var certificationReady = document.getElementById("certificationReady").value === "true";
        var objective = document.getElementById("learningObjective").value.trim();

        return {
            title: topic + " Quiz",
            module: moduleName,
            difficulty: difficulty,
            passingScore: passingScore,
            timeLimit: timeLimit,
            certificationReady: certificationReady,
            description: objective || "Generated quiz for " + moduleName + " covering " + topic + ".",
            questions: generatedQuestionsList
        };
    }

    function useInQuizBuilder() {
        if (generatedQuestionsList.length === 0) {
            showToast("Generate questions first.");
            return;
        }

        var generatedQuiz = buildGeneratedQuizObject();

        localStorage.setItem("aidifyGeneratedQuiz", JSON.stringify(generatedQuiz));
        showToast("Generated quiz sent to Quiz Builder.");

        setTimeout(function () {
            window.location.href = "/Instructor/Quizzes/List.aspx#quizEditor";
        }, 900);
    }

    function exportGeneratedDraft() {
        if (generatedQuestionsList.length === 0) {
            showToast("Generate questions first.");
            return;
        }

        var quiz = buildGeneratedQuizObject();

        var questionRows = quiz.questions.map(function (question, index) {
            return (
                "<tr>" +
                "<td>" + (index + 1) + "</td>" +
                "<td>" + escapeHtml(question.text) + "</td>" +
                "<td>" + escapeHtml(question.correct) + "</td>" +
                "<td>" + escapeHtml(question.explanation) + "</td>" +
                "</tr>"
            );
        }).join("");

        var reportWindow = window.open("", "_blank", "width=1100,height=800");

        if (!reportWindow) {
            alert("Popup blocked. Please allow popups to export the draft.");
            return;
        }

        reportWindow.document.open();
        reportWindow.document.write(
            "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
            "<title>Aidify Generated Quiz Draft</title>" +
            "<style>" +
            "body{font-family:Arial,sans-serif;margin:32px;color:#281715;background:#fff;}" +
            "h1{color:#b70011;margin:0 0 6px;}" +
            ".sub{color:#5c403c;margin-bottom:22px;}" +
            ".summary{display:grid;grid-template-columns:repeat(4,1fr);gap:12px;margin-bottom:24px;}" +
            ".box{border:1px solid #e6bdb8;border-radius:10px;background:#fff8f7;padding:14px;}" +
            ".label{font-size:11px;text-transform:uppercase;font-weight:800;color:#5c403c;}" +
            ".value{font-size:20px;font-weight:800;margin-top:6px;}" +
            "table{width:100%;border-collapse:collapse;margin-top:14px;}" +
            "th{background:#fff0ee;color:#5c403c;text-align:left;padding:10px;border:1px solid #e6bdb8;font-size:11px;text-transform:uppercase;}" +
            "td{padding:10px;border:1px solid #e6bdb8;font-size:13px;vertical-align:top;}" +
            "</style>" +
            "</head>" +
            "<body>" +
            "<h1>Aidify Generated Quiz Draft</h1>" +
            "<div class='sub'>Generated AI quiz draft for instructor review.</div>" +

            "<div class='summary'>" +
            "<div class='box'><div class='label'>Title</div><div class='value'>" + escapeHtml(quiz.title) + "</div></div>" +
            "<div class='box'><div class='label'>Module</div><div class='value'>" + escapeHtml(quiz.module) + "</div></div>" +
            "<div class='box'><div class='label'>Difficulty</div><div class='value'>" + escapeHtml(quiz.difficulty) + "</div></div>" +
            "<div class='box'><div class='label'>Questions</div><div class='value'>" + quiz.questions.length + "</div></div>" +
            "</div>" +

            "<h2>Generated Questions</h2>" +
            "<table>" +
            "<thead><tr><th>No.</th><th>Question</th><th>Correct</th><th>Explanation</th></tr></thead>" +
            "<tbody>" + questionRows + "</tbody>" +
            "</table>" +
            "</body>" +
            "</html>"
        );

        reportWindow.document.close();
        showToast("Generated draft exported.");
    }

    function openNotifications() {
        alert(
            "AI Quiz Generator Notifications\n\n" +
            "• Generated drafts can be sent to Quiz Builder.\n" +
            "• Certification-style quizzes should be reviewed before publishing.\n" +
            "• Always verify clinical accuracy before release."
        );
    }

    function openHelp() {
        alert(
            "AI Quiz Generator Help\n\n" +
            "Generate Questions: creates sample quiz questions from your topic.\n" +
            "Edit: updates generated question text.\n" +
            "Delete: removes a generated question.\n" +
            "Use in Quiz Builder: saves the quiz draft and redirects to the main Quiz Builder.\n" +
            "Export Generated Draft: opens a clean printable draft report."
        );
    }

    function openProfile() {
        alert(
            "Instructor Profile\n\n" +
            "Dr. Sarah Mitchell\n" +
            "Lead Medical Instructor\n" +
            "Verified Educator"
        );
    }

    function escapeHtml(value) {
        return String(value || "")
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }
</script>

</asp:Content>