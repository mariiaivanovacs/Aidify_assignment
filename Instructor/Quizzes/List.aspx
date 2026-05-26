<%@ Page Title="My Quizzes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Aidify_assigment.Instructor.Quizzes.List" %>

<asp:Content ID="QuizzesListContent" ContentPlaceHolderID="MainContent" runat="server">

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

    .summary-grid {
        display: grid;
        grid-template-columns: repeat(4, minmax(0, 1fr));
        gap: 16px;
        margin-bottom: 24px;
    }

    .summary-card,
    .filters-card,
    .panel-card,
    .quiz-card {
        background: #fff;
        border: 1px solid #e6bdb8;
        border-radius: 12px;
        box-shadow: 0 4px 14px rgba(40, 23, 21, .06);
    }

    .summary-card {
        padding: 18px;
        min-height: 118px;
    }

    .summary-icon {
        width: 34px;
        height: 34px;
        border-radius: 8px;
        background: #ffe9e6;
        color: #b70011;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 14px;
    }

    .summary-label {
        color: #5c403c;
        font-size: 11px;
        font-weight: 800;
        text-transform: uppercase;
        letter-spacing: .04em;
        margin-bottom: 5px;
    }

    .summary-value {
        color: #281715;
        font-size: 28px;
        line-height: 1;
        font-weight: 800;
        margin: 0;
    }

    .filters-card {
        padding: 16px;
        margin-bottom: 22px;
    }

    .filter-row {
        display: grid;
        grid-template-columns: minmax(260px, 1fr) 180px 220px auto;
        gap: 10px;
        align-items: center;
    }

    .filter-search {
        position: relative;
    }

    .filter-search .material-symbols-outlined {
        position: absolute;
        left: 12px;
        top: 50%;
        transform: translateY(-50%);
        color: #5c403c;
        font-size: 18px;
    }

    .filter-search input,
    .filter-row select,
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

    .filter-search input {
        padding-left: 38px;
    }

    .form-textarea {
        min-height: 105px;
        resize: vertical;
        line-height: 1.5;
    }

    .quiz-grid {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 18px;
        margin-bottom: 30px;
    }

    .quiz-card {
        padding: 18px;
        transition: .2s ease;
    }

    .quiz-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 14px 28px rgba(40, 23, 21, .10);
    }

    .quiz-card.hidden {
        display: none;
    }

    .quiz-title {
        color: #281715;
        font-size: 17px;
        font-weight: 800;
        margin: 0 0 5px;
        line-height: 1.3;
    }

    .quiz-module {
        color: #5c403c;
        font-size: 12px;
        font-weight: 700;
        margin-bottom: 12px;
    }

    .badge-row {
        display: flex;
        gap: 7px;
        flex-wrap: wrap;
        margin-bottom: 14px;
    }

    .badge {
        border-radius: 6px;
        padding: 5px 8px;
        font-size: 10px;
        font-weight: 800;
        text-transform: uppercase;
        display: inline-flex;
        align-items: center;
        line-height: 1;
    }

    .badge-easy,
    .badge-published {
        background: #dcfce7;
        color: #15803d;
    }

    .badge-medium,
    .badge-pending {
        background: #fef3c7;
        color: #a16207;
    }

    .badge-hard {
        background: #ffdad6;
        color: #ba1a1a;
    }

    .badge-draft {
        background: #f3f4f6;
        color: #374151;
    }

    .badge-cert {
        background: #ffe9e6;
        color: #b70011;
        border: 1px solid #b70011;
    }

    .quiz-meta {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 9px;
        margin-bottom: 15px;
    }

    .meta-box {
        background: #fff8f7;
        border: 1px solid #e6bdb8;
        border-radius: 8px;
        padding: 10px;
    }

    .meta-label {
        color: #5c403c;
        font-size: 10px;
        font-weight: 800;
        text-transform: uppercase;
        margin-bottom: 4px;
    }

    .meta-value {
        color: #281715;
        font-size: 14px;
        font-weight: 800;
    }

    .quiz-actions {
        border-top: 1px solid #e6bdb8;
        padding-top: 12px;
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 8px;
    }

    .small-action {
        border: 1px solid #e6bdb8;
        background: #fff;
        color: #281715;
        border-radius: 8px;
        padding: 8px;
        font-size: 12px;
        font-weight: 800;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 5px;
    }

    .small-action:hover {
        background: #fff0ee;
        color: #b70011;
    }

    .quiz-editor {
        display: none;
        scroll-margin-top: 88px;
    }

    .quiz-editor.visible {
        display: block;
    }

    .editor-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        gap: 18px;
        margin-bottom: 16px;
    }

    .editor-title {
        font-size: 26px;
        font-weight: 800;
        margin: 0 0 4px;
        color: #281715;
    }

    .editor-subtitle {
        color: #5c403c;
        font-size: 13px;
        margin: 0;
    }

    .editor-layout {
        display: grid;
        grid-template-columns: minmax(0, 1.15fr) minmax(360px, .85fr);
        gap: 22px;
        align-items: start;
    }

    .panel-card {
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

    .question-list {
        display: grid;
        gap: 10px;
    }

    .question-item {
        border: 1px solid #e6bdb8;
        border-radius: 10px;
        padding: 12px;
        background: #fff8f7;
        display: grid;
        grid-template-columns: 1fr auto;
        gap: 10px;
        align-items: start;
    }

    .question-title {
        color: #281715;
        font-size: 13px;
        font-weight: 800;
        margin-bottom: 6px;
    }

    .question-meta {
        color: #5c403c;
        font-size: 12px;
        font-weight: 700;
    }

    .question-actions {
        display: flex;
        gap: 6px;
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

    .preview-box {
        background: #fff8f7;
        border: 1px solid #e6bdb8;
        border-radius: 10px;
        padding: 14px;
        display: grid;
        gap: 9px;
        color: #281715;
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
        .summary-grid,
        .quiz-grid,
        .editor-layout {
            grid-template-columns: 1fr;
        }

        .filter-row {
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
            <a href="/Instructor/Dashboard.aspx"><span class="material-symbols-outlined">dashboard</span>Dashboard</a>
            <a href="/Instructor/Modules/List.aspx"><span class="material-symbols-outlined">school</span>Modules</a>
            <a href="/Instructor/Materials/Upload.aspx"><span class="material-symbols-outlined">description</span>Materials</a>
            <a class="active" href="/Instructor/Quizzes/List.aspx"><span class="material-symbols-outlined">quiz</span>Quizzes</a>
            <a href="/Instructor/Performance.aspx"><span class="material-symbols-outlined">trending_up</span>Performance</a>
            <a href="/Instructor/Discussions/Discussions.aspx"><span class="material-symbols-outlined">forum</span>Discussions</a>
            <a href="/Instructor/Challenges.aspx"><span class="material-symbols-outlined">military_tech</span>Challenges</a>
            <a href="/Instructor/Events.aspx"><span class="material-symbols-outlined">calendar_today</span>Events</a>
        </nav>

        <div class="aidify-sidebar-bottom">
            <a href="#" onclick="showToast('Settings selected.'); return false;"><span class="material-symbols-outlined">settings</span>Settings</a>
            <a href="#" style="color:#ba1a1a;" onclick="showToast('Logout selected.'); return false;"><span class="material-symbols-outlined">logout</span>Logout</a>
        </div>
    </aside>

    <header class="aidify-topbar">
        <div class="topbar-search">
            <span class="material-symbols-outlined">search</span>
            <input id="globalSearch" type="text" placeholder="Search quizzes, modules, or questions..." />
        </div>

        <div class="topbar-actions">
            <button type="button" class="topbar-icon" onclick="openNotifications()"><span class="material-symbols-outlined">notifications</span></button>
            <button type="button" class="topbar-icon" onclick="openHelp()"><span class="material-symbols-outlined">help_outline</span></button>
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
                    <h2 class="page-title">My Quizzes</h2>
                    <p class="page-subtitle">Create, manage, preview, and generate assessment quizzes for your training modules.</p>
                </div>

                <div class="header-actions">
                    <button type="button" class="btn-primary-red" onclick="createQuiz()">
                        <span class="material-symbols-outlined">add</span>
                        Create Quiz
                    </button>

                    <button type="button" class="btn-outline-red" onclick="openAiGenerator()">
                        <span class="material-symbols-outlined">auto_awesome</span>
                        Generate With AI
                    </button>

                    <button type="button" class="btn-muted" onclick="exportQuizReport()">
                        <span class="material-symbols-outlined">ios_share</span>
                        Export Quiz Report
                    </button>
                </div>
            </section>

            <section class="summary-grid">
                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">quiz</span></div>
                    <div class="summary-label">Total Quizzes</div>
                    <p class="summary-value" id="totalQuizzesValue">6</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">check_circle</span></div>
                    <div class="summary-label">Published</div>
                    <p class="summary-value" id="publishedValue">3</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">draft</span></div>
                    <div class="summary-label">Draft</div>
                    <p class="summary-value" id="draftValue">2</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">percent</span></div>
                    <div class="summary-label">Average Passing Score</div>
                    <p class="summary-value" id="avgPassingValue">79%</p>
                </div>
            </section>

            <section class="filters-card">
                <div class="filter-row">
                    <div class="filter-search">
                        <span class="material-symbols-outlined">search</span>
                        <input id="quizSearch" type="text" placeholder="Search quiz by title or module..." />
                    </div>

                    <select id="statusFilter" onchange="filterQuizzes()">
                        <option value="all">All Status</option>
                        <option value="Published">Published</option>
                        <option value="Draft">Draft</option>
                        <option value="Pending Review">Pending Review</option>
                    </select>

                    <select id="moduleFilter" onchange="filterQuizzes()">
                        <option value="all">All Modules</option>
                        <option value="CPR Fundamentals">CPR Fundamentals</option>
                        <option value="Airway Emergencies">Airway Emergencies</option>
                        <option value="Trauma Response">Trauma Response</option>
                        <option value="Burn Treatment Basics">Burn Treatment Basics</option>
                        <option value="Emergency Wound Care">Emergency Wound Care</option>
                        <option value="Pediatric First Aid">Pediatric First Aid</option>
                    </select>

                    <button type="button" class="btn-muted" onclick="clearQuizFilters()">
                        <span class="material-symbols-outlined">filter_alt_off</span>
                        Clear
                    </button>
                </div>
            </section>

            <section id="quizGrid" class="quiz-grid">
                <article class="quiz-card" data-title="CPR Fundamentals Quiz" data-module="CPR Fundamentals" data-status="Published" data-difficulty="Easy" data-questions="12" data-passing="80" data-time="10" data-attempts="124" data-cert="false"></article>
                <article class="quiz-card" data-title="Choking Response Check" data-module="Airway Emergencies" data-status="Draft" data-difficulty="Medium" data-questions="10" data-passing="75" data-time="8" data-attempts="0" data-cert="false"></article>
                <article class="quiz-card" data-title="Trauma Response Assessment" data-module="Trauma Response" data-status="Pending Review" data-difficulty="Hard" data-questions="18" data-passing="85" data-time="20" data-attempts="52" data-cert="false"></article>
                <article class="quiz-card" data-title="Burn Classification Quiz" data-module="Burn Treatment Basics" data-status="Published" data-difficulty="Medium" data-questions="15" data-passing="80" data-time="15" data-attempts="91" data-cert="false"></article>
                <article class="quiz-card" data-title="Emergency Wound Care Check" data-module="Emergency Wound Care" data-status="Draft" data-difficulty="Easy" data-questions="8" data-passing="70" data-time="7" data-attempts="0" data-cert="false"></article>
                <article class="quiz-card" data-title="Pediatric First Aid Final Quiz" data-module="Pediatric First Aid" data-status="Published" data-difficulty="Hard" data-questions="30" data-passing="85" data-time="25" data-attempts="67" data-cert="true"></article>
            </section>

            <section id="quizEditor" class="quiz-editor">
                <div class="editor-header">
                    <div>
                        <h2 class="editor-title">Quiz Builder</h2>
                        <p class="editor-subtitle">
                            <span id="editorModeLabel">Create Quiz</span> — Create or edit quiz settings and questions in one place.
                        </p>
                    </div>

                    <div class="button-row">
                        <button type="button" class="btn-muted" onclick="cancelQuizEditor()">Cancel</button>
                        <button type="button" class="btn-outline-red" onclick="saveAndPreviewQuiz()">Save & Preview</button>
                        <button type="button" class="btn-primary-red" onclick="saveQuiz()">Save Quiz</button>
                    </div>
                </div>

                <div class="editor-layout">
                    <div>
                        <div class="panel-card">
                            <div class="panel-header">
                                <h3 class="panel-title">Quiz Details</h3>
                            </div>

                            <div class="panel-body">
                                <div class="form-grid">
                                    <div class="form-group">
                                        <label class="form-label">Quiz Title <span class="required">* REQUIRED</span></label>
                                        <input id="quizTitleInput" class="form-input" type="text" />
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Select Module <span class="required">* REQUIRED</span></label>
                                        <select id="quizModuleInput" class="form-select">
                                            <option value="">Select module</option>
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
                                        <select id="quizDifficultyInput" class="form-select">
                                            <option>Easy</option>
                                            <option>Medium</option>
                                            <option>Hard</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Status</label>
                                        <select id="quizStatusInput" class="form-select">
                                            <option>Draft</option>
                                            <option>Pending Review</option>
                                            <option>Published</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Passing Score</label>
                                        <input id="quizPassingInput" class="form-input" type="number" min="0" max="100" value="80" />
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Time Limit</label>
                                        <input id="quizTimeInput" class="form-input" type="number" min="1" value="10" />
                                    </div>

                                    <div class="form-group full">
                                        <label class="form-label">Certification Ready</label>
                                        <select id="quizCertInput" class="form-select">
                                            <option value="false">No</option>
                                            <option value="true">Yes</option>
                                        </select>
                                    </div>

                                    <div class="form-group full">
                                        <label class="form-label">Short Description</label>
                                        <textarea id="quizDescriptionInput" class="form-textarea"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="panel-card" style="margin-top:18px;">
                            <div class="panel-header">
                                <h3 class="panel-title">Question Builder</h3>
                            </div>

                            <div class="panel-body">
                                <div class="form-group">
                                    <label class="form-label">Question Text <span class="required">* REQUIRED</span></label>
                                    <textarea id="questionTextInput" class="form-textarea"></textarea>
                                </div>

                                <div class="form-grid">
                                    <div class="form-group">
                                        <label class="form-label">Question Type</label>
                                        <select id="questionTypeInput" class="form-select">
                                            <option>Multiple Choice</option>
                                            <option>True/False</option>
                                            <option>Short Answer</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Correct Answer</label>
                                        <select id="correctAnswerInput" class="form-select">
                                            <option>A</option>
                                            <option>B</option>
                                            <option>C</option>
                                            <option>D</option>
                                            <option>True</option>
                                            <option>False</option>
                                        </select>
                                    </div>

                                    <div class="form-group"><label class="form-label">Option A</label><input id="optionAInput" class="form-input" type="text" /></div>
                                    <div class="form-group"><label class="form-label">Option B</label><input id="optionBInput" class="form-input" type="text" /></div>
                                    <div class="form-group"><label class="form-label">Option C</label><input id="optionCInput" class="form-input" type="text" /></div>
                                    <div class="form-group"><label class="form-label">Option D</label><input id="optionDInput" class="form-input" type="text" /></div>

                                    <div class="form-group full">
                                        <label class="form-label">Explanation</label>
                                        <textarea id="explanationInput" class="form-textarea"></textarea>
                                    </div>
                                </div>

                                <div class="button-row">
                                    <button type="button" class="btn-primary-red" onclick="addQuestion()">Add Question</button>
                                    <button type="button" class="btn-outline-red" onclick="updateQuestion()">Update Question</button>
                                    <button type="button" class="btn-muted" onclick="clearQuestionForm()">Clear Question Form</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <aside>
                        <div class="panel-card">
                            <div class="panel-header">
                                <h3 class="panel-title">Question List</h3>
                            </div>

                            <div class="panel-body">
                                <div id="questionList" class="question-list">
                                    <div class="question-item">
                                        <div>
                                            <div class="question-title">No questions added yet.</div>
                                            <div class="question-meta">Use Add Question or Generate With AI.</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="panel-card" style="margin-top:18px;">
                            <div class="panel-header">
                                <h3 class="panel-title">Quiz Preview</h3>
                            </div>

                            <div class="panel-body">
                                <div class="preview-box">
                                    <div><strong>Title:</strong> <span id="previewTitle">No quiz selected</span></div>
                                    <div><strong>Module:</strong> <span id="previewModule">-</span></div>
                                    <div><strong>Passing Score:</strong> <span id="previewPassing">-</span></div>
                                    <div><strong>Time Limit:</strong> <span id="previewTime">-</span></div>
                                    <div><strong>Questions:</strong> <span id="previewQuestions">0</span></div>
                                </div>

                                <button type="button" class="btn-outline-red" style="margin-top:12px;" onclick="openFullPreview()">
                                    Open Full Preview
                                </button>
                            </div>
                        </div>
                    </aside>
                </div>
            </section>
        </div>
    </main>
</div>

<div id="quizToast" class="toast">Action completed.</div>

<script>
    var selectedQuizCard = null;
    var currentQuestions = [];
    var selectedQuestionIndex = -1;

    document.addEventListener("DOMContentLoaded", function () {
        setupSearch();
        renderInitialCards();
        updateSummary();
        loadGeneratedQuizFromAI();
    });

    function renderInitialCards() {
        document.querySelectorAll(".quiz-card").forEach(function (card) {
            refreshCard(card);
        });
    }

    function setupSearch() {
        var quizSearch = document.getElementById("quizSearch");
        var globalSearch = document.getElementById("globalSearch");

        if (quizSearch) {
            quizSearch.addEventListener("input", filterQuizzes);
        }

        if (globalSearch && quizSearch) {
            globalSearch.addEventListener("input", function () {
                quizSearch.value = globalSearch.value;
                filterQuizzes();
            });
        }
    }

    function showToast(message) {
        var toast = document.getElementById("quizToast");
        toast.textContent = message;
        toast.classList.add("show");

        clearTimeout(window.__quizToastTimer);
        window.__quizToastTimer = setTimeout(function () {
            toast.classList.remove("show");
        }, 2200);
    }

    function openEditor() {
        document.getElementById("quizEditor").classList.add("visible");
        setTimeout(function () {
            document.getElementById("quizEditor").scrollIntoView({ behavior: "smooth", block: "start" });
        }, 50);
    }

    function openAiGenerator() {
        showToast("Opening AI Quiz Generator...");

        setTimeout(function () {
            window.location.href = "/Instructor/Quizzes/GenerateWithAI.aspx";
        }, 400);
    }

    function loadGeneratedQuizFromAI() {
        var raw = localStorage.getItem("aidifyGeneratedQuiz");

        if (!raw) {
            return;
        }

        try {
            var quiz = JSON.parse(raw);

            selectedQuizCard = null;
            selectedQuestionIndex = -1;

            document.getElementById("editorModeLabel").textContent = "Create Quiz from AI";
            document.getElementById("quizTitleInput").value = quiz.title || "";
            document.getElementById("quizModuleInput").value = quiz.module || "";
            document.getElementById("quizDifficultyInput").value = quiz.difficulty || "Medium";
            document.getElementById("quizStatusInput").value = "Draft";
            document.getElementById("quizPassingInput").value = quiz.passingScore || "80";
            document.getElementById("quizTimeInput").value = quiz.timeLimit || "10";
            document.getElementById("quizCertInput").value = quiz.certificationReady ? "true" : "false";
            document.getElementById("quizDescriptionInput").value = quiz.description || "";

            currentQuestions = Array.isArray(quiz.questions) ? quiz.questions : [];

            renderQuestionList();
            updatePreview();
            openEditor();

            localStorage.removeItem("aidifyGeneratedQuiz");
            showToast("Generated quiz loaded into Quiz Builder.");
        } catch (error) {
            localStorage.removeItem("aidifyGeneratedQuiz");
            showToast("Could not load generated quiz.");
        }
    }

    function createQuiz() {
        selectedQuizCard = null;
        currentQuestions = [];
        selectedQuestionIndex = -1;

        document.getElementById("editorModeLabel").textContent = "Create Quiz";
        clearQuizFields();
        clearQuestionForm();
        renderQuestionList();
        updatePreview();
        openEditor();

        showToast("Create Quiz builder opened.");
    }

    function clearQuizFields() {
        document.getElementById("quizTitleInput").value = "";
        document.getElementById("quizModuleInput").value = "";
        document.getElementById("quizDifficultyInput").value = "Easy";
        document.getElementById("quizStatusInput").value = "Draft";
        document.getElementById("quizPassingInput").value = "80";
        document.getElementById("quizTimeInput").value = "10";
        document.getElementById("quizCertInput").value = "false";
        document.getElementById("quizDescriptionInput").value = "";
    }

    function editQuiz(button) {
        var card = button.closest(".quiz-card");
        selectedQuizCard = card;

        document.getElementById("editorModeLabel").textContent = "Edit Quiz";
        document.getElementById("quizTitleInput").value = card.getAttribute("data-title");
        document.getElementById("quizModuleInput").value = card.getAttribute("data-module");
        document.getElementById("quizDifficultyInput").value = card.getAttribute("data-difficulty");
        document.getElementById("quizStatusInput").value = card.getAttribute("data-status");
        document.getElementById("quizPassingInput").value = card.getAttribute("data-passing");
        document.getElementById("quizTimeInput").value = card.getAttribute("data-time");
        document.getElementById("quizCertInput").value = card.getAttribute("data-cert");
        document.getElementById("quizDescriptionInput").value = "Quiz assessment for " + card.getAttribute("data-module") + ".";

        currentQuestions = [
            {
                text: "What is the safest first step in this clinical situation?",
                type: "Multiple Choice",
                correct: "A",
                a: "Assess scene safety",
                b: "Start advanced treatment",
                c: "Ignore learner response",
                d: "Skip assessment",
                explanation: "Scene safety must be checked first."
            },
            {
                text: "The learner should follow the module protocol before escalating care.",
                type: "True/False",
                correct: "True",
                a: "True",
                b: "False",
                c: "",
                d: "",
                explanation: "Protocol-based action improves consistency."
            }
        ];

        selectedQuestionIndex = -1;
        renderQuestionList();
        updatePreview();
        openEditor();

        showToast("Quiz loaded for editing.");
    }

    function saveQuiz() {
        var title = document.getElementById("quizTitleInput").value.trim();
        var moduleName = document.getElementById("quizModuleInput").value;

        if (!title) {
            showToast("Quiz title is required.");
            document.getElementById("quizTitleInput").focus();
            return false;
        }

        if (!moduleName) {
            showToast("Module is required.");
            document.getElementById("quizModuleInput").focus();
            return false;
        }

        var difficulty = document.getElementById("quizDifficultyInput").value;
        var status = document.getElementById("quizStatusInput").value;
        var passing = document.getElementById("quizPassingInput").value || "80";
        var time = document.getElementById("quizTimeInput").value || "10";
        var cert = document.getElementById("quizCertInput").value;
        var questions = currentQuestions.length || 0;

        if (selectedQuizCard) {
            selectedQuizCard.setAttribute("data-title", title);
            selectedQuizCard.setAttribute("data-module", moduleName);
            selectedQuizCard.setAttribute("data-difficulty", difficulty);
            selectedQuizCard.setAttribute("data-status", status);
            selectedQuizCard.setAttribute("data-passing", passing);
            selectedQuizCard.setAttribute("data-time", time);
            selectedQuizCard.setAttribute("data-cert", cert);
            selectedQuizCard.setAttribute("data-questions", questions);

            refreshCard(selectedQuizCard);
            showToast("Quiz updated successfully.");
        } else {
            selectedQuizCard = createQuizCard(title, moduleName, status, difficulty, questions, passing, time, "0", cert);
            showToast("New quiz created successfully.");
        }

        updateSummary();
        filterQuizzes();
        updatePreview();
        return true;
    }

    function saveAndPreviewQuiz() {
        var saved = saveQuiz();

        if (saved) {
            openFullPreview();
        }
    }

    function cancelQuizEditor() {
        document.getElementById("quizEditor").classList.remove("visible");
        selectedQuizCard = null;
        selectedQuestionIndex = -1;
        showToast("Quiz builder closed.");
    }

    function previewCardQuiz(button) {
        var card = button.closest(".quiz-card");

        alert(
            "Quiz Preview\n\n" +
            "Title: " + card.getAttribute("data-title") + "\n" +
            "Module: " + card.getAttribute("data-module") + "\n" +
            "Status: " + card.getAttribute("data-status") + "\n" +
            "Difficulty: " + card.getAttribute("data-difficulty") + "\n" +
            "Questions: " + card.getAttribute("data-questions") + "\n" +
            "Passing Score: " + card.getAttribute("data-passing") + "%\n" +
            "Time Limit: " + card.getAttribute("data-time") + " min\n\n" +
            "Sample Question:\nWhat is the safest first action in this module?"
        );
    }

    function duplicateQuiz(button) {
        var card = button.closest(".quiz-card");

        createQuizCard(
            card.getAttribute("data-title") + " Copy",
            card.getAttribute("data-module"),
            "Draft",
            card.getAttribute("data-difficulty"),
            card.getAttribute("data-questions"),
            card.getAttribute("data-passing"),
            card.getAttribute("data-time"),
            "0",
            card.getAttribute("data-cert")
        );

        updateSummary();
        filterQuizzes();
        showToast("Quiz duplicated as Draft.");
    }

    function submitOrPublishQuiz(button) {
        var card = button.closest(".quiz-card");
        var status = card.getAttribute("data-status");

        if (status === "Draft") {
            card.setAttribute("data-status", "Pending Review");
            showToast("Quiz submitted for review.");
        } else if (status === "Pending Review") {
            card.setAttribute("data-status", "Published");
            showToast("Quiz published successfully.");
        } else {
            showToast("Quiz is already published.");
        }

        refreshCard(card);
        updateSummary();
        filterQuizzes();
    }

    function createQuizCard(title, moduleName, status, difficulty, questions, passing, time, attempts, cert) {
        var grid = document.getElementById("quizGrid");
        var card = document.createElement("article");

        card.className = "quiz-card";
        card.setAttribute("data-title", title);
        card.setAttribute("data-module", moduleName);
        card.setAttribute("data-status", status);
        card.setAttribute("data-difficulty", difficulty);
        card.setAttribute("data-questions", questions);
        card.setAttribute("data-passing", passing);
        card.setAttribute("data-time", time);
        card.setAttribute("data-attempts", attempts);
        card.setAttribute("data-cert", cert);

        grid.prepend(card);
        refreshCard(card);

        return card;
    }

    function refreshCard(card) {
        var title = card.getAttribute("data-title");
        var moduleName = card.getAttribute("data-module");
        var status = card.getAttribute("data-status");
        var difficulty = card.getAttribute("data-difficulty");
        var questions = card.getAttribute("data-questions");
        var passing = card.getAttribute("data-passing");
        var time = card.getAttribute("data-time");
        var attempts = card.getAttribute("data-attempts");
        var cert = card.getAttribute("data-cert") === "true";

        card.innerHTML =
            '<h3 class="quiz-title">' + escapeHtml(title) + '</h3>' +
            '<div class="quiz-module">' + escapeHtml(moduleName) + '</div>' +
            '<div class="badge-row">' +
            '<span class="badge ' + getStatusClass(status) + '">' + escapeHtml(status) + '</span>' +
            '<span class="badge ' + getDifficultyClass(difficulty) + '">' + escapeHtml(difficulty) + '</span>' +
            (cert ? '<span class="badge badge-cert">Certification Ready</span>' : '') +
            '</div>' +
            '<div class="quiz-meta">' +
            '<div class="meta-box"><div class="meta-label">Questions</div><div class="meta-value">' + questions + '</div></div>' +
            '<div class="meta-box"><div class="meta-label">Passing</div><div class="meta-value">' + passing + '%</div></div>' +
            '<div class="meta-box"><div class="meta-label">Time</div><div class="meta-value">' + time + ' min</div></div>' +
            '<div class="meta-box"><div class="meta-label">Attempts</div><div class="meta-value">' + attempts + '</div></div>' +
            '</div>' +
            '<div class="quiz-actions">' +
            '<button type="button" class="small-action" onclick="editQuiz(this)">Edit</button>' +
            '<button type="button" class="small-action" onclick="previewCardQuiz(this)">Preview</button>' +
            '<button type="button" class="small-action" onclick="duplicateQuiz(this)">Duplicate</button>' +
            '<button type="button" class="small-action" onclick="submitOrPublishQuiz(this)">' + (status === "Draft" ? "Submit" : "Publish") + '</button>' +
            '</div>';
    }

    function getStatusClass(status) {
        if (status === "Published") return "badge-published";
        if (status === "Pending Review") return "badge-pending";
        return "badge-draft";
    }

    function getDifficultyClass(difficulty) {
        if (difficulty === "Easy") return "badge-easy";
        if (difficulty === "Hard") return "badge-hard";
        return "badge-medium";
    }

    function addQuestion() {
        var text = document.getElementById("questionTextInput").value.trim();

        if (!text) {
            showToast("Question text is required.");
            document.getElementById("questionTextInput").focus();
            return;
        }

        currentQuestions.push(readQuestionForm());
        clearQuestionForm();
        renderQuestionList();
        updatePreview();
        showToast("Question added.");
    }

    function readQuestionForm() {
        return {
            text: document.getElementById("questionTextInput").value.trim(),
            type: document.getElementById("questionTypeInput").value,
            correct: document.getElementById("correctAnswerInput").value,
            a: document.getElementById("optionAInput").value,
            b: document.getElementById("optionBInput").value,
            c: document.getElementById("optionCInput").value,
            d: document.getElementById("optionDInput").value,
            explanation: document.getElementById("explanationInput").value
        };
    }

    function editQuestion(index) {
        var question = currentQuestions[index];
        selectedQuestionIndex = index;

        document.getElementById("questionTextInput").value = question.text || "";
        document.getElementById("questionTypeInput").value = question.type || "Multiple Choice";
        document.getElementById("correctAnswerInput").value = question.correct || "A";
        document.getElementById("optionAInput").value = question.a || "";
        document.getElementById("optionBInput").value = question.b || "";
        document.getElementById("optionCInput").value = question.c || "";
        document.getElementById("optionDInput").value = question.d || "";
        document.getElementById("explanationInput").value = question.explanation || "";

        showToast("Question loaded for editing.");
    }

    function updateQuestion() {
        if (selectedQuestionIndex < 0) {
            showToast("Select a question to update first.");
            return;
        }

        var text = document.getElementById("questionTextInput").value.trim();

        if (!text) {
            showToast("Question text is required.");
            return;
        }

        currentQuestions[selectedQuestionIndex] = readQuestionForm();
        selectedQuestionIndex = -1;
        clearQuestionForm();
        renderQuestionList();
        updatePreview();
        showToast("Question updated.");
    }

    function deleteQuestion(index) {
        var confirmed = confirm("Delete question " + (index + 1) + "?");

        if (!confirmed) {
            showToast("Delete cancelled.");
            return;
        }

        currentQuestions.splice(index, 1);
        selectedQuestionIndex = -1;
        renderQuestionList();
        updatePreview();
        showToast("Question deleted.");
    }

    function clearQuestionForm() {
        document.getElementById("questionTextInput").value = "";
        document.getElementById("questionTypeInput").value = "Multiple Choice";
        document.getElementById("correctAnswerInput").value = "A";
        document.getElementById("optionAInput").value = "";
        document.getElementById("optionBInput").value = "";
        document.getElementById("optionCInput").value = "";
        document.getElementById("optionDInput").value = "";
        document.getElementById("explanationInput").value = "";
        selectedQuestionIndex = -1;
    }

    function renderQuestionList() {
        var list = document.getElementById("questionList");
        list.innerHTML = "";

        if (currentQuestions.length === 0) {
            list.innerHTML =
                '<div class="question-item">' +
                '<div>' +
                '<div class="question-title">No questions added yet.</div>' +
                '<div class="question-meta">Use Add Question or Generate With AI.</div>' +
                '</div>' +
                '</div>';
            return;
        }

        currentQuestions.forEach(function (question, index) {
            var item = document.createElement("div");
            item.className = "question-item";
            item.innerHTML =
                '<div>' +
                '<div class="question-title">Q' + (index + 1) + '. ' + escapeHtml(question.text) + '</div>' +
                '<div class="question-meta">' + escapeHtml(question.type || "Multiple Choice") + ' • Correct: ' + escapeHtml(question.correct || "A") + '</div>' +
                '</div>' +
                '<div class="question-actions">' +
                '<button type="button" class="icon-btn" onclick="editQuestion(' + index + ')"><span class="material-symbols-outlined">edit</span></button>' +
                '<button type="button" class="icon-btn" onclick="deleteQuestion(' + index + ')"><span class="material-symbols-outlined">delete</span></button>' +
                '</div>';
            list.appendChild(item);
        });
    }

    function updatePreview() {
        document.getElementById("previewTitle").textContent = document.getElementById("quizTitleInput").value || "No quiz selected";
        document.getElementById("previewModule").textContent = document.getElementById("quizModuleInput").value || "-";
        document.getElementById("previewPassing").textContent = (document.getElementById("quizPassingInput").value || "-") + "%";
        document.getElementById("previewTime").textContent = (document.getElementById("quizTimeInput").value || "-") + " min";
        document.getElementById("previewQuestions").textContent = currentQuestions.length;
    }

    function openFullPreview() {
        updatePreview();

        var title = document.getElementById("quizTitleInput").value || "Untitled Quiz";
        var moduleName = document.getElementById("quizModuleInput").value || "No module selected";
        var passing = document.getElementById("quizPassingInput").value || "0";
        var time = document.getElementById("quizTimeInput").value || "0";

        var sampleQuestions = currentQuestions.map(function (question, index) {
            return (index + 1) + ". " + question.text + " | Correct: " + question.correct;
        }).join("\n");

        alert(
            "Full Quiz Preview\n\n" +
            "Title: " + title + "\n" +
            "Module: " + moduleName + "\n" +
            "Passing Score: " + passing + "%\n" +
            "Time Limit: " + time + " min\n" +
            "Questions: " + currentQuestions.length + "\n\n" +
            (sampleQuestions || "No questions added yet.")
        );
    }

    function filterQuizzes() {
        var query = (document.getElementById("quizSearch").value || "").toLowerCase().trim();
        var status = document.getElementById("statusFilter").value;
        var moduleName = document.getElementById("moduleFilter").value;
        var cards = document.querySelectorAll(".quiz-card");
        var visible = 0;

        cards.forEach(function (card) {
            var cardTitle = (card.getAttribute("data-title") || "").toLowerCase();
            var cardModule = card.getAttribute("data-module") || "";
            var cardStatus = card.getAttribute("data-status") || "";

            var matchSearch = !query || cardTitle.indexOf(query) !== -1 || cardModule.toLowerCase().indexOf(query) !== -1;
            var matchStatus = status === "all" || cardStatus === status;
            var matchModule = moduleName === "all" || cardModule === moduleName;

            if (matchSearch && matchStatus && matchModule) {
                card.classList.remove("hidden");
                visible++;
            } else {
                card.classList.add("hidden");
            }
        });

        showToast("Showing " + visible + " quiz card(s).");
    }

    function clearQuizFilters() {
        document.getElementById("quizSearch").value = "";
        document.getElementById("globalSearch").value = "";
        document.getElementById("statusFilter").value = "all";
        document.getElementById("moduleFilter").value = "all";

        document.querySelectorAll(".quiz-card").forEach(function (card) {
            card.classList.remove("hidden");
        });

        showToast("Filters cleared.");
    }

    function updateSummary() {
        var cards = document.querySelectorAll(".quiz-card");
        var total = cards.length;
        var published = 0;
        var draft = 0;
        var passingSum = 0;

        cards.forEach(function (card) {
            var status = card.getAttribute("data-status");
            var passing = parseInt(card.getAttribute("data-passing"), 10) || 0;

            if (status === "Published") published++;
            if (status === "Draft") draft++;
            passingSum += passing;
        });

        document.getElementById("totalQuizzesValue").textContent = total;
        document.getElementById("publishedValue").textContent = published;
        document.getElementById("draftValue").textContent = draft;
        document.getElementById("avgPassingValue").textContent = (total ? Math.round(passingSum / total) : 0) + "%";
    }

    function exportQuizReport() {
        updateSummary();

        var rows = Array.prototype.slice.call(document.querySelectorAll(".quiz-card")).map(function (card) {
            return "<tr>" +
                "<td>" + escapeHtml(card.getAttribute("data-title")) + "</td>" +
                "<td>" + escapeHtml(card.getAttribute("data-module")) + "</td>" +
                "<td>" + escapeHtml(card.getAttribute("data-status")) + "</td>" +
                "<td>" + escapeHtml(card.getAttribute("data-difficulty")) + "</td>" +
                "<td>" + escapeHtml(card.getAttribute("data-questions")) + "</td>" +
                "<td>" + escapeHtml(card.getAttribute("data-passing")) + "%</td>" +
                "</tr>";
        }).join("");

        var reportWindow = window.open("", "_blank", "width=1100,height=800");

        if (!reportWindow) {
            alert("Popup blocked. Please allow popups to export the report.");
            return;
        }

        reportWindow.document.open();
        reportWindow.document.write(
            "<!DOCTYPE html><html><head><title>Aidify Quiz Report</title>" +
            "<style>" +
            "body{font-family:Arial,sans-serif;margin:32px;color:#281715;}" +
            "h1{color:#b70011;margin-bottom:6px;}" +
            ".sub{color:#5c403c;margin-bottom:22px;}" +
            ".summary{display:grid;grid-template-columns:repeat(4,1fr);gap:12px;margin-bottom:24px;}" +
            ".box{border:1px solid #e6bdb8;border-radius:10px;background:#fff8f7;padding:14px;}" +
            ".label{font-size:11px;text-transform:uppercase;font-weight:800;color:#5c403c;}" +
            ".value{font-size:24px;font-weight:800;margin-top:6px;}" +
            "table{width:100%;border-collapse:collapse;}" +
            "th{background:#fff0ee;color:#5c403c;text-align:left;padding:10px;border:1px solid #e6bdb8;font-size:11px;text-transform:uppercase;}" +
            "td{padding:10px;border:1px solid #e6bdb8;font-size:13px;}" +
            "</style></head><body>" +
            "<h1>Aidify Quiz Report</h1>" +
            "<div class='sub'>Generated from Instructor Quiz Manager</div>" +
            "<div class='summary'>" +
            "<div class='box'><div class='label'>Total Quizzes</div><div class='value'>" + document.getElementById("totalQuizzesValue").textContent + "</div></div>" +
            "<div class='box'><div class='label'>Published</div><div class='value'>" + document.getElementById("publishedValue").textContent + "</div></div>" +
            "<div class='box'><div class='label'>Draft</div><div class='value'>" + document.getElementById("draftValue").textContent + "</div></div>" +
            "<div class='box'><div class='label'>Avg Passing</div><div class='value'>" + document.getElementById("avgPassingValue").textContent + "</div></div>" +
            "</div>" +
            "<table><thead><tr><th>Quiz</th><th>Module</th><th>Status</th><th>Difficulty</th><th>Questions</th><th>Passing</th></tr></thead><tbody>" +
            rows +
            "</tbody></table></body></html>"
        );
        reportWindow.document.close();

        showToast("Quiz report exported.");
    }

    function openNotifications() {
        alert(
            "Quiz Notifications\n\n" +
            "• 2 quiz drafts need completion.\n" +
            "• 1 quiz is pending review.\n" +
            "• CPR Fundamentals Quiz has new learner attempts."
        );
    }

    function openHelp() {
        alert(
            "Quiz Page Help\n\n" +
            "Create Quiz: opens a blank quiz builder.\n" +
            "Generate With AI: opens the AI Generator page.\n" +
            "Edit: fills builder fields from a quiz card.\n" +
            "Preview: shows quiz details.\n" +
            "Duplicate: creates a draft copy.\n" +
            "Submit/Publish: moves quiz through workflow.\n" +
            "Export: opens a clean quiz report."
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