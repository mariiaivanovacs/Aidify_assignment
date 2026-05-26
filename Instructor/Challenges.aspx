<%@ Page Title="Clinical Challenges" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Challenges.aspx.cs" Inherits="Aidify_assigment.Instructor.Challenges" %>

<asp:Content ID="ChallengesContent" ContentPlaceHolderID="MainContent" runat="server">

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
    .challenge-card,
    .editor-card {
        background: #fff;
        border: 1px solid #e6bdb8;
        border-radius: 12px;
        box-shadow: 0 4px 14px rgba(40, 23, 21, .06);
    }

    .summary-card {
        padding: 18px;
        min-height: 112px;
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
        grid-template-columns: auto minmax(260px, 1fr) auto;
        gap: 14px;
        align-items: center;
    }

    .filter-tabs {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
    }

    .filter-tabs button {
        border: 1px solid #e6bdb8;
        background: #fff;
        color: #5c403c;
        border-radius: 999px;
        padding: 8px 13px;
        font-size: 12px;
        font-weight: 800;
        cursor: pointer;
    }

    .filter-tabs button.active {
        background: #b70011;
        color: #fff;
        border-color: #b70011;
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
        min-height: 110px;
        resize: vertical;
        line-height: 1.5;
    }

    .challenge-grid {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 18px;
        margin-bottom: 22px;
    }

    .challenge-card {
        padding: 18px;
        transition: .2s ease;
    }

    .challenge-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 14px 28px rgba(40, 23, 21, .10);
    }

    .challenge-card.hidden {
        display: none;
    }

    .challenge-top {
        display: flex;
        justify-content: space-between;
        gap: 12px;
        align-items: flex-start;
        margin-bottom: 12px;
    }

    .challenge-title {
        margin: 0;
        color: #281715;
        font-size: 17px;
        line-height: 1.35;
        font-weight: 800;
    }

    .challenge-module {
        color: #5c403c;
        font-size: 12px;
        font-weight: 700;
        margin-top: 5px;
    }

    .badge-row {
        display: flex;
        gap: 7px;
        flex-wrap: wrap;
        margin: 12px 0;
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

    .badge-published {
        background: #dcfce7;
        color: #15803d;
    }

    .badge-draft {
        background: #f3f4f6;
        color: #374151;
    }

    .badge-review {
        background: #fef3c7;
        color: #a16207;
    }

    .badge-easy {
        background: #dcfce7;
        color: #15803d;
    }

    .badge-medium {
        background: #fef3c7;
        color: #a16207;
    }

    .badge-hard {
        background: #ffdad6;
        color: #ba1a1a;
    }

    .challenge-desc {
        color: #5c403c;
        font-size: 13px;
        line-height: 1.5;
        min-height: 58px;
        margin-bottom: 14px;
    }

    .challenge-meta {
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

    .challenge-actions {
        border-top: 1px solid #e6bdb8;
        padding-top: 12px;
        display: grid;
        grid-template-columns: repeat(3, 1fr);
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

    .small-action.publish {
        color: #b70011;
    }

    .challenge-editor {
        display: none;
        margin-bottom: 24px;
        scroll-margin-top: 88px;
    }

    .challenge-editor.visible {
        display: block;
    }

    .editor-card {
        overflow: hidden;
    }

    .editor-header {
        padding: 16px 18px;
        border-bottom: 1px solid #e6bdb8;
        background: #fff8f7;
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        gap: 18px;
    }

    .editor-title {
        margin: 0;
        color: #281715;
        font-size: 20px;
        font-weight: 800;
    }

    .editor-subtitle {
        color: #5c403c;
        font-size: 12px;
        margin: 4px 0 0;
    }

    .editor-body {
        padding: 18px;
    }

    .form-grid {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 14px;
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

    .pagination-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 14px;
        border-top: 1px solid #e6bdb8;
        padding-top: 16px;
        color: #5c403c;
        font-size: 13px;
        font-weight: 700;
    }

    .pagination {
        display: flex;
        gap: 8px;
    }

    .page-btn {
        width: 36px;
        height: 36px;
        border-radius: 8px;
        border: 1px solid #e6bdb8;
        background: #fff;
        color: #281715;
        cursor: pointer;
        font-weight: 800;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .page-btn.active {
        background: #b70011;
        color: #fff;
        border-color: #b70011;
    }

    .page-btn:disabled {
        opacity: .45;
        cursor: not-allowed;
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
        .challenge-grid,
        .form-grid {
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
            <a href="/Instructor/Quizzes/List.aspx"><span class="material-symbols-outlined">quiz</span>Quizzes</a>
            <a href="/Instructor/Performance.aspx"><span class="material-symbols-outlined">trending_up</span>Performance</a>
            <a href="/Instructor/Discussions/Discussions.aspx"><span class="material-symbols-outlined">forum</span>Discussions</a>
            <a class="active" href="/Instructor/Challenges.aspx"><span class="material-symbols-outlined">military_tech</span>Challenges</a>
            <a href="/Instructor/Events.aspx"><span class="material-symbols-outlined">calendar_today</span>Events</a>
        </nav>

        <div class="aidify-sidebar-bottom">
            <a href="#" onclick="showToast('Settings selected.'); return false;">
                <span class="material-symbols-outlined">settings</span>Settings
            </a>
            <a href="#" style="color:#ba1a1a;" onclick="showToast('Logout selected.'); return false;">
                <span class="material-symbols-outlined">logout</span>Logout
            </a>
        </div>
    </aside>

    <header class="aidify-topbar">
        <div class="topbar-search">
            <span class="material-symbols-outlined">search</span>
            <input id="globalSearch" type="text" placeholder="Search challenges, modules, or learners..." />
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
                    <h2 class="page-title">Clinical Challenges</h2>
                    <p class="page-subtitle">Create scenario-based challenges, monitor submissions, and publish learner practice tasks.</p>
                </div>

                <div class="header-actions">
                    <button type="button" class="btn-primary-red" onclick="createChallenge()">
                        <span class="material-symbols-outlined">add</span>
                        Create Challenge
                    </button>

                    <button type="button" class="btn-outline-red" onclick="exportChallengeReport()">
                        <span class="material-symbols-outlined">ios_share</span>
                        Export Report
                    </button>
                </div>
            </section>

            <section class="summary-grid">
                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">military_tech</span></div>
                    <div class="summary-label">Total Challenges</div>
                    <p class="summary-value" id="totalChallengesValue">0</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">check_circle</span></div>
                    <div class="summary-label">Published</div>
                    <p class="summary-value" id="publishedValue">0</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">draft</span></div>
                    <div class="summary-label">Draft</div>
                    <p class="summary-value" id="draftValue">0</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">assignment</span></div>
                    <div class="summary-label">Submissions</div>
                    <p class="summary-value" id="submissionsValue">0</p>
                </div>
            </section>

            <section id="challengeEditor" class="challenge-editor">
                <div class="editor-card">
                    <div class="editor-header">
                        <div>
                            <h3 class="editor-title" id="editorModeLabel">Create Challenge</h3>
                            <p class="editor-subtitle">Build or update a clinical challenge for learners.</p>
                        </div>

                        <div class="button-row">
                            <button type="button" class="btn-muted" onclick="cancelEditor()">Cancel</button>
                            <button type="button" class="btn-outline-red" onclick="previewEditorChallenge()">Preview</button>
                            <button type="button" class="btn-primary-red" onclick="saveChallenge()">Save Challenge</button>
                        </div>
                    </div>

                    <div class="editor-body">
                        <div class="form-grid">
                            <div class="form-group">
                                <label class="form-label">Challenge Title <span class="required">* REQUIRED</span></label>
                                <input id="challengeTitleInput" class="form-input" type="text" />
                            </div>

                            <div class="form-group">
                                <label class="form-label">Module <span class="required">* REQUIRED</span></label>
                                <select id="challengeModuleInput" class="form-select">
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
                                <label class="form-label">Status</label>
                                <select id="challengeStatusInput" class="form-select">
                                    <option>Draft</option>
                                    <option>Review Needed</option>
                                    <option>Published</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Difficulty</label>
                                <select id="challengeDifficultyInput" class="form-select">
                                    <option>Easy</option>
                                    <option>Medium</option>
                                    <option>Hard</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Due Date</label>
                                <input id="challengeDueInput" class="form-input" type="date" />
                            </div>

                            <div class="form-group">
                                <label class="form-label">Points</label>
                                <input id="challengePointsInput" class="form-input" type="number" min="0" value="100" />
                            </div>

                            <div class="form-group full">
                                <label class="form-label">Scenario Description</label>
                                <textarea id="challengeDescriptionInput" class="form-textarea"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="filters-card">
                <div class="filter-row">
                    <div class="filter-tabs">
                        <button type="button" class="active" onclick="setStatusFilter('all', this)">All</button>
                        <button type="button" onclick="setStatusFilter('Published', this)">Published</button>
                        <button type="button" onclick="setStatusFilter('Draft', this)">Draft</button>
                        <button type="button" onclick="setStatusFilter('Review Needed', this)">Review Needed</button>
                    </div>

                    <div class="filter-search">
                        <span class="material-symbols-outlined">search</span>
                        <input id="challengeSearch" type="text" placeholder="Search challenges..." />
                    </div>

                    <button type="button" class="btn-muted" onclick="showFilterSummary()">
                        <span class="material-symbols-outlined">filter_list</span>
                        Filter
                    </button>
                </div>
            </section>

            <section id="challengeGrid" class="challenge-grid"></section>

            <section class="pagination-row">
                <p id="paginationLabel">Showing 0 of 0 challenges</p>

                <div class="pagination">
                    <button type="button" id="prevPageBtn" class="page-btn" onclick="previousPage()">
                        <span class="material-symbols-outlined">chevron_left</span>
                    </button>

                    <button type="button" class="page-btn active" onclick="goToPage(1)">1</button>
                    <button type="button" class="page-btn" onclick="goToPage(2)">2</button>
                    <button type="button" class="page-btn" onclick="goToPage(3)">3</button>

                    <button type="button" id="nextPageBtn" class="page-btn" onclick="nextPage()">
                        <span class="material-symbols-outlined">chevron_right</span>
                    </button>
                </div>
            </section>

        </div>
    </main>
</div>

<div id="challengeToast" class="toast">Action completed.</div>

<script>
    var challenges = [
        {
            title: "CPR Response Scenario",
            module: "CPR Fundamentals",
            status: "Published",
            difficulty: "Easy",
            due: "2026-06-02",
            points: 100,
            submissions: 42,
            description: "Learners respond to a sudden cardiac arrest case and explain the correct CPR sequence."
        },
        {
            title: "Choking Emergency Decision Task",
            module: "Airway Emergencies",
            status: "Draft",
            difficulty: "Medium",
            due: "2026-06-05",
            points: 80,
            submissions: 0,
            description: "Learners identify the safest intervention for an adult choking scenario."
        },
        {
            title: "Trauma Triage Challenge",
            module: "Trauma Response",
            status: "Review Needed",
            difficulty: "Hard",
            due: "2026-06-10",
            points: 120,
            submissions: 18,
            description: "Learners prioritize care for a multi-injury trauma case with limited information."
        },
        {
            title: "Burn Severity Classification",
            module: "Burn Treatment Basics",
            status: "Published",
            difficulty: "Medium",
            due: "2026-06-14",
            points: 90,
            submissions: 31,
            description: "Learners classify burn depth and recommend the first appropriate response."
        },
        {
            title: "Emergency Wound Care Case",
            module: "Emergency Wound Care",
            status: "Draft",
            difficulty: "Easy",
            due: "2026-06-18",
            points: 75,
            submissions: 0,
            description: "Learners select correct wound cleaning, dressing, and escalation decisions."
        },
        {
            title: "Pediatric First Aid Simulation",
            module: "Pediatric First Aid",
            status: "Published",
            difficulty: "Hard",
            due: "2026-06-22",
            points: 130,
            submissions: 27,
            description: "Learners handle a pediatric emergency scenario using age-appropriate first aid steps."
        }
    ];

    var selectedChallengeIndex = -1;
    var activeStatusFilter = "all";
    var currentPage = 1;
    var pageSize = 3;

    document.addEventListener("DOMContentLoaded", function () {
        var searchInput = document.getElementById("challengeSearch");
        var globalSearch = document.getElementById("globalSearch");

        searchInput.addEventListener("input", function () {
            currentPage = 1;
            renderChallenges();
        });

        globalSearch.addEventListener("input", function () {
            searchInput.value = globalSearch.value;
            currentPage = 1;
            renderChallenges();
        });

        renderChallenges();
        updateSummary();
    });

    function showToast(message) {
        var toast = document.getElementById("challengeToast");
        toast.textContent = message;
        toast.classList.add("show");

        clearTimeout(window.__challengeToastTimer);
        window.__challengeToastTimer = setTimeout(function () {
            toast.classList.remove("show");
        }, 2200);
    }

    function getFilteredChallenges() {
        var query = (document.getElementById("challengeSearch").value || "").toLowerCase().trim();

        return challenges.filter(function (item) {
            var matchesStatus = activeStatusFilter === "all" || item.status === activeStatusFilter;
            var searchable = (item.title + " " + item.module + " " + item.description).toLowerCase();
            var matchesSearch = !query || searchable.indexOf(query) !== -1;

            return matchesStatus && matchesSearch;
        });
    }

    function renderChallenges() {
        var grid = document.getElementById("challengeGrid");
        var filtered = getFilteredChallenges();
        var totalPages = Math.max(1, Math.ceil(filtered.length / pageSize));

        if (currentPage > totalPages) {
            currentPage = totalPages;
        }

        var start = (currentPage - 1) * pageSize;
        var pageItems = filtered.slice(start, start + pageSize);

        grid.innerHTML = "";

        pageItems.forEach(function (item) {
            var realIndex = challenges.indexOf(item);
            var card = document.createElement("article");
            card.className = "challenge-card";

            card.innerHTML =
                '<div class="challenge-top">' +
                    '<div>' +
                        '<h3 class="challenge-title">' + escapeHtml(item.title) + '</h3>' +
                        '<div class="challenge-module">' + escapeHtml(item.module) + '</div>' +
                    '</div>' +
                '</div>' +
                '<div class="badge-row">' +
                    '<span class="badge ' + getStatusClass(item.status) + '">' + escapeHtml(item.status) + '</span>' +
                    '<span class="badge ' + getDifficultyClass(item.difficulty) + '">' + escapeHtml(item.difficulty) + '</span>' +
                '</div>' +
                '<div class="challenge-desc">' + escapeHtml(item.description) + '</div>' +
                '<div class="challenge-meta">' +
                    '<div class="meta-box"><div class="meta-label">Due Date</div><div class="meta-value">' + escapeHtml(item.due) + '</div></div>' +
                    '<div class="meta-box"><div class="meta-label">Points</div><div class="meta-value">' + escapeHtml(item.points) + '</div></div>' +
                    '<div class="meta-box"><div class="meta-label">Submissions</div><div class="meta-value">' + escapeHtml(item.submissions) + '</div></div>' +
                    '<div class="meta-box"><div class="meta-label">Status</div><div class="meta-value">' + escapeHtml(item.status) + '</div></div>' +
                '</div>' +
                '<div class="challenge-actions">' +
                    '<button type="button" class="small-action" onclick="editChallenge(' + realIndex + ')"><span class="material-symbols-outlined">edit</span>Edit</button>' +
                    '<button type="button" class="small-action" onclick="viewSubmissions(' + realIndex + ')"><span class="material-symbols-outlined">assignment</span>Submissions</button>' +
                    '<button type="button" class="small-action publish" onclick="publishChallenge(' + realIndex + ')"><span class="material-symbols-outlined">publish</span>Publish</button>' +
                '</div>';

            grid.appendChild(card);
        });

        updatePagination(filtered.length, start, pageItems.length, totalPages);
    }

    function updatePagination(total, start, count, totalPages) {
        var label = document.getElementById("paginationLabel");
        var from = total === 0 ? 0 : start + 1;
        var to = start + count;

        label.textContent = "Showing " + from + " - " + to + " of " + total + " challenges";

        document.getElementById("prevPageBtn").disabled = currentPage <= 1;
        document.getElementById("nextPageBtn").disabled = currentPage >= totalPages;

        var buttons = document.querySelectorAll(".pagination .page-btn");
        buttons.forEach(function (button) {
            button.classList.remove("active");
        });

        var numericButtons = Array.prototype.slice.call(document.querySelectorAll(".pagination .page-btn")).filter(function (button) {
            return /^\d+$/.test(button.textContent.trim());
        });

        numericButtons.forEach(function (button) {
            var page = parseInt(button.textContent.trim(), 10);
            button.style.display = page <= totalPages ? "flex" : "none";
            if (page === currentPage) {
                button.classList.add("active");
            }
        });
    }

    function setStatusFilter(status, button) {
        activeStatusFilter = status;
        currentPage = 1;

        document.querySelectorAll(".filter-tabs button").forEach(function (btn) {
            btn.classList.remove("active");
        });

        button.classList.add("active");
        renderChallenges();
        showToast(status === "all" ? "Showing all challenges." : "Filtered by " + status + ".");
    }

    function showFilterSummary() {
        var filtered = getFilteredChallenges();
        showToast("Current filter shows " + filtered.length + " challenge(s).");
    }

    function createChallenge() {
        selectedChallengeIndex = -1;
        document.getElementById("editorModeLabel").textContent = "Create Challenge";

        document.getElementById("challengeTitleInput").value = "";
        document.getElementById("challengeModuleInput").value = "";
        document.getElementById("challengeStatusInput").value = "Draft";
        document.getElementById("challengeDifficultyInput").value = "Easy";
        document.getElementById("challengeDueInput").value = "";
        document.getElementById("challengePointsInput").value = "100";
        document.getElementById("challengeDescriptionInput").value = "";

        openEditor();
        showToast("Create Challenge form opened.");
    }

    function editChallenge(index) {
        var item = challenges[index];
        selectedChallengeIndex = index;

        document.getElementById("editorModeLabel").textContent = "Edit Challenge";
        document.getElementById("challengeTitleInput").value = item.title;
        document.getElementById("challengeModuleInput").value = item.module;
        document.getElementById("challengeStatusInput").value = item.status;
        document.getElementById("challengeDifficultyInput").value = item.difficulty;
        document.getElementById("challengeDueInput").value = item.due;
        document.getElementById("challengePointsInput").value = item.points;
        document.getElementById("challengeDescriptionInput").value = item.description;

        openEditor();
        showToast("Challenge loaded for editing.");
    }

    function openEditor() {
        document.getElementById("challengeEditor").classList.add("visible");
        setTimeout(function () {
            document.getElementById("challengeEditor").scrollIntoView({ behavior: "smooth", block: "start" });
        }, 50);
    }

    function cancelEditor() {
        document.getElementById("challengeEditor").classList.remove("visible");
        selectedChallengeIndex = -1;
        showToast("Challenge editor closed.");
    }

    function saveChallenge() {
        var title = document.getElementById("challengeTitleInput").value.trim();
        var moduleName = document.getElementById("challengeModuleInput").value;

        if (!title) {
            showToast("Challenge title is required.");
            document.getElementById("challengeTitleInput").focus();
            return;
        }

        if (!moduleName) {
            showToast("Module is required.");
            document.getElementById("challengeModuleInput").focus();
            return;
        }

        var item = {
            title: title,
            module: moduleName,
            status: document.getElementById("challengeStatusInput").value,
            difficulty: document.getElementById("challengeDifficultyInput").value,
            due: document.getElementById("challengeDueInput").value || "Not set",
            points: document.getElementById("challengePointsInput").value || "0",
            submissions: selectedChallengeIndex >= 0 ? challenges[selectedChallengeIndex].submissions : 0,
            description: document.getElementById("challengeDescriptionInput").value.trim() || "No scenario description provided."
        };

        if (selectedChallengeIndex >= 0) {
            challenges[selectedChallengeIndex] = item;
            showToast("Challenge updated successfully.");
        } else {
            challenges.unshift(item);
            currentPage = 1;
            showToast("Challenge created successfully.");
        }

        document.getElementById("challengeEditor").classList.remove("visible");
        selectedChallengeIndex = -1;
        renderChallenges();
        updateSummary();
    }

    function previewEditorChallenge() {
        var title = document.getElementById("challengeTitleInput").value || "Untitled Challenge";
        var moduleName = document.getElementById("challengeModuleInput").value || "No module selected";
        var status = document.getElementById("challengeStatusInput").value;
        var difficulty = document.getElementById("challengeDifficultyInput").value;
        var points = document.getElementById("challengePointsInput").value || "0";
        var description = document.getElementById("challengeDescriptionInput").value || "No description provided.";

        alert(
            "Challenge Preview\n\n" +
            "Title: " + title + "\n" +
            "Module: " + moduleName + "\n" +
            "Status: " + status + "\n" +
            "Difficulty: " + difficulty + "\n" +
            "Points: " + points + "\n\n" +
            "Scenario:\n" + description
        );
    }

    function viewSubmissions(index) {
        var item = challenges[index];

        alert(
            "Challenge Submissions\n\n" +
            "Challenge: " + item.title + "\n" +
            "Module: " + item.module + "\n" +
            "Submissions: " + item.submissions + "\n\n" +
            "Sample learner activity:\n" +
            "• 12 completed\n" +
            "• 5 pending review\n" +
            "• 3 need feedback"
        );
    }

    function publishChallenge(index) {
        var item = challenges[index];

        if (item.status === "Published") {
            showToast("Challenge is already published.");
            return;
        }

        if (item.status === "Draft") {
            item.status = "Review Needed";
            showToast("Challenge submitted for review.");
        } else if (item.status === "Review Needed") {
            item.status = "Published";
            showToast("Challenge published successfully.");
        }

        renderChallenges();
        updateSummary();
    }

    function previousPage() {
        if (currentPage > 1) {
            currentPage--;
            renderChallenges();
            showToast("Previous page.");
        }
    }

    function nextPage() {
        var totalPages = Math.max(1, Math.ceil(getFilteredChallenges().length / pageSize));

        if (currentPage < totalPages) {
            currentPage++;
            renderChallenges();
            showToast("Next page.");
        }
    }

    function goToPage(page) {
        var totalPages = Math.max(1, Math.ceil(getFilteredChallenges().length / pageSize));

        if (page <= totalPages) {
            currentPage = page;
            renderChallenges();
            showToast("Page " + page + " selected.");
        }
    }

    function updateSummary() {
        var total = challenges.length;
        var published = 0;
        var draft = 0;
        var submissions = 0;

        challenges.forEach(function (item) {
            if (item.status === "Published") published++;
            if (item.status === "Draft") draft++;
            submissions += parseInt(item.submissions, 10) || 0;
        });

        document.getElementById("totalChallengesValue").textContent = total;
        document.getElementById("publishedValue").textContent = published;
        document.getElementById("draftValue").textContent = draft;
        document.getElementById("submissionsValue").textContent = submissions;
    }

    function exportChallengeReport() {
        updateSummary();

        var rows = challenges.map(function (item) {
            return "<tr>" +
                "<td>" + escapeHtml(item.title) + "</td>" +
                "<td>" + escapeHtml(item.module) + "</td>" +
                "<td>" + escapeHtml(item.status) + "</td>" +
                "<td>" + escapeHtml(item.difficulty) + "</td>" +
                "<td>" + escapeHtml(item.points) + "</td>" +
                "<td>" + escapeHtml(item.submissions) + "</td>" +
                "</tr>";
        }).join("");

        var reportWindow = window.open("", "_blank", "width=1100,height=800");

        if (!reportWindow) {
            alert("Popup blocked. Please allow popups to export the report.");
            return;
        }

        reportWindow.document.open();
        reportWindow.document.write(
            "<!DOCTYPE html><html><head><title>Aidify Challenge Report</title>" +
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
            "<h1>Aidify Clinical Challenge Report</h1>" +
            "<div class='sub'>Generated from Instructor Challenge Manager</div>" +
            "<div class='summary'>" +
            "<div class='box'><div class='label'>Total</div><div class='value'>" + document.getElementById("totalChallengesValue").textContent + "</div></div>" +
            "<div class='box'><div class='label'>Published</div><div class='value'>" + document.getElementById("publishedValue").textContent + "</div></div>" +
            "<div class='box'><div class='label'>Draft</div><div class='value'>" + document.getElementById("draftValue").textContent + "</div></div>" +
            "<div class='box'><div class='label'>Submissions</div><div class='value'>" + document.getElementById("submissionsValue").textContent + "</div></div>" +
            "</div>" +
            "<table><thead><tr><th>Challenge</th><th>Module</th><th>Status</th><th>Difficulty</th><th>Points</th><th>Submissions</th></tr></thead><tbody>" +
            rows +
            "</tbody></table></body></html>"
        );
        reportWindow.document.close();

        showToast("Challenge report exported.");
    }

    function openNotifications() {
        alert(
            "Challenge Notifications\n\n" +
            "• 2 draft challenges need completion.\n" +
            "• 1 challenge is waiting for review.\n" +
            "• Trauma Triage Challenge has recent submissions."
        );
    }

    function openHelp() {
        alert(
            "Clinical Challenges Help\n\n" +
            "Create Challenge: opens a blank challenge form.\n" +
            "Edit: loads the challenge into the editor.\n" +
            "Submissions: shows learner submission details.\n" +
            "Publish: moves Draft → Review Needed → Published.\n" +
            "Filters: filter by status or search text.\n" +
            "Pagination: moves between challenge pages.\n" +
            "Export Report: opens a clean printable report."
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

    function getStatusClass(status) {
        if (status === "Published") return "badge-published";
        if (status === "Review Needed") return "badge-review";
        return "badge-draft";
    }

    function getDifficultyClass(difficulty) {
        if (difficulty === "Easy") return "badge-easy";
        if (difficulty === "Hard") return "badge-hard";
        return "badge-medium";
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