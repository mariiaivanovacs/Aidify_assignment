<%@ Page Title="Edit Lesson" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="Aidify_assigment.Instructor.Lessons.Edit" %>

<asp:Content ID="LessonEditContent" ContentPlaceHolderID="MainContent" runat="server">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

    <style>
        body {
            font-family: 'Inter', sans-serif !important;
            background-color: #fff8f7 !important;
            color: #281715 !important;
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 500, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }

        .aidify-page {
            min-height: 100vh;
            background: #fff8f7;
            color: #281715;
        }

        .aidify-sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 220px;
            height: 100vh;
            background: #fff0ee;
            border-right: 1px solid #e6bdb8;
            display: flex;
            flex-direction: column;
            padding: 20px 12px;
            z-index: 20;
        }

        .aidify-brand {
            padding: 0 12px 30px;
        }

        .aidify-brand h1 {
            color: #b70011;
            font-size: 18px;
            font-weight: 800;
            margin: 0;
            line-height: 1.1;
        }

        .aidify-brand p {
            color: #5c403c;
            font-size: 11px;
            margin: 3px 0 0;
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
            transition: 0.2s ease;
        }

        .aidify-nav a:hover,
        .aidify-sidebar-bottom a:hover {
            background: #fbdbd7;
            color: #281715;
        }

        .aidify-nav a.active {
            background: #b70011;
            color: #ffffff;
            box-shadow: 0 8px 18px rgba(183, 0, 17, 0.16);
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
            background: rgba(255, 248, 247, 0.94);
            backdrop-filter: blur(10px);
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
            padding: 3px 8px 3px 3px;
            border-radius: 999px;
            text-decoration: none;
            color: #281715;
        }

        .profile-chip img {
            width: 30px;
            height: 30px;
            border-radius: 999px;
            object-fit: cover;
            border: 1px solid #e6bdb8;
        }

        .profile-chip span {
            font-size: 12px;
            font-weight: 800;
        }

        .aidify-main {
            margin-left: 220px;
            margin-top: 56px;
            min-height: calc(100vh - 56px);
            padding: 28px;
            background: #fff8f7;
        }

        .page-container {
            max-width: 1220px;
            margin: 0 auto;
        }

        .breadcrumb {
            color: #5c403c;
            font-size: 12px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .breadcrumb span {
            color: #b70011;
            font-weight: 800;
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
            line-height: 1.15;
            font-weight: 800;
            letter-spacing: -0.035em;
            color: #281715;
            margin: 0 0 4px;
        }

        .page-subtitle {
            color: #5c403c;
            font-size: 14px;
            margin: 0;
        }

        .header-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn-primary-red {
            background: #b70011;
            color: #ffffff !important;
            border-radius: 8px;
            padding: 11px 18px;
            font-size: 13px;
            font-weight: 800;
            text-decoration: none !important;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            box-shadow: 0 10px 22px rgba(183, 0, 17, 0.16);
            white-space: nowrap;
            border: 1px solid #b70011;
            cursor: pointer;
        }

        .btn-outline-red,
        .btn-muted {
            background: #ffffff;
            color: #b70011 !important;
            border: 1px solid #e6bdb8;
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

        .btn-muted {
            color: #281715 !important;
        }

        .lesson-layout {
            display: grid;
            grid-template-columns: minmax(0, 2fr) minmax(320px, 1fr);
            gap: 22px;
            align-items: start;
        }

        .panel-card {
            background: #ffffff;
            border: 1px solid #e6bdb8;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(40, 23, 21, 0.06);
            padding: 20px;
            width: 100%;
            max-width: none;
        }

        .panel-card + .panel-card {
            margin-top: 18px;
        }

        .card-kicker {
            color: #b70011;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            margin-bottom: 16px;
        }

        .form-group {
            margin-bottom: 16px;
            width: 100%;
        }

        .form-label {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            color: #5c403c;
            font-size: 12px;
            font-weight: 800;
            margin-bottom: 7px;
            width: 100%;
        }

        .required {
            color: #b70011;
            font-size: 10px;
            letter-spacing: 0.08em;
        }

        .form-input,
        .form-select,
        .form-textarea {
            width: 100% !important;
            max-width: none !important;
            min-width: 100% !important;
            border: 1px solid #e6bdb8;
            background: #fff8f7;
            border-radius: 8px;
            color: #281715;
            font-size: 13px;
            outline: none;
            padding: 11px 12px;
            box-sizing: border-box !important;
            display: block;
        }

        .form-input:focus,
        .form-select:focus,
        .form-textarea:focus {
            border-color: #b70011;
            box-shadow: 0 0 0 4px rgba(183, 0, 17, 0.08);
        }

        .form-textarea {
            min-height: 170px;
            resize: vertical;
            line-height: 1.5;
        }

        #lessonBody {
            min-height: 260px !important;
        }

        #keySteps,
        #clinicalTip {
            min-height: 140px !important;
        }

        .small-textarea {
            min-height: 140px !important;
        }

        .toolbar {
            display: flex;
            gap: 6px;
            flex-wrap: wrap;
            border: 1px solid #e6bdb8;
            background: #fff0ee;
            border-radius: 10px;
            padding: 8px;
            margin-bottom: 10px;
            width: 100% !important;
            max-width: none !important;
            box-sizing: border-box !important;
        }

        .tool-btn {
            border: 0;
            background: #ffffff;
            color: #281715;
            border-radius: 7px;
            min-width: 36px;
            height: 34px;
            padding: 0 10px;
            font-size: 12px;
            font-weight: 800;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }

        .tool-btn:hover {
            background: #b70011;
            color: #ffffff;
        }

        .side-stack {
            display: grid;
            gap: 18px;
        }

        .info-card-title {
            color: #281715;
            font-size: 17px;
            font-weight: 800;
            margin: 0 0 12px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .param-grid {
            display: grid;
            gap: 14px;
        }

        .module-context {
            display: flex;
            gap: 12px;
            align-items: flex-start;
            margin-bottom: 14px;
        }

        .context-icon {
            width: 42px;
            height: 42px;
            border-radius: 10px;
            background: #ffe9e6;
            color: #b70011;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .context-title {
            color: #281715;
            font-size: 14px;
            font-weight: 800;
            margin-bottom: 3px;
        }

        .context-text {
            color: #5c403c;
            font-size: 12px;
            line-height: 1.5;
        }

        .progress-head {
            display: flex;
            justify-content: space-between;
            font-size: 12px;
            font-weight: 800;
            color: #5c403c;
            margin-bottom: 7px;
        }

        .progress-head span:last-child {
            color: #b70011;
        }

        .progress-track {
            height: 8px;
            background: #ffe9e6;
            border-radius: 999px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            width: 45%;
            background: #b70011;
            border-radius: 999px;
        }

        .insight-card {
            background: #fff0ee;
        }

        .insight-card p {
            color: #5c403c;
            font-size: 13px;
            line-height: 1.6;
            margin: 0;
        }

        .preview-panel {
            display: none;
            margin-top: 18px;
            background: #ffffff;
            border: 1px solid #e6bdb8;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 14px rgba(40, 23, 21, 0.06);
        }

        .preview-panel.visible {
            display: block;
        }

        .preview-title {
            color: #281715;
            font-size: 20px;
            font-weight: 800;
            margin: 0 0 8px;
        }

        .preview-meta {
            color: #5c403c;
            font-size: 13px;
            margin-bottom: 14px;
            font-weight: 700;
        }

        .preview-content {
            color: #281715;
            font-size: 14px;
            line-height: 1.7;
            white-space: pre-wrap;
            background: #fff8f7;
            border: 1px solid #e6bdb8;
            border-radius: 10px;
            padding: 14px;
        }

        .toast {
            position: fixed;
            right: 24px;
            bottom: 24px;
            background: #281715;
            color: #ffffff;
            border-radius: 12px;
            padding: 14px 16px;
            font-size: 13px;
            font-weight: 800;
            box-shadow: 0 12px 30px rgba(40, 23, 21, 0.25);
            opacity: 0;
            pointer-events: none;
            transform: translateY(10px);
            transition: 0.25s ease;
            z-index: 100;
        }

        .toast.show {
            opacity: 1;
            transform: translateY(0);
        }

        @media (max-width: 1150px) {
            .lesson-layout {
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

            .aidify-nav a {
                white-space: nowrap;
            }

            .aidify-sidebar-bottom {
                display: none;
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

                <a class="active" href="/Instructor/Modules/List.aspx">
                    <span class="material-symbols-outlined">school</span>
                    Modules
                </a>

                <a href="/Instructor/Materials/Upload.aspx">
                    <span class="material-symbols-outlined">description</span>
                    Materials
                </a>

                <a href="/Instructor/Quizzes/List.aspx">
                    <span class="material-symbols-outlined">quiz</span>
                    Quizzes
                </a>

                <a href="/Instructor/Performance/Performance.aspx">
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

            <div class="aidify-sidebar-bottom">
                <a href="#" onclick="showToast('Settings selected.'); return false;">
                    <span class="material-symbols-outlined">settings</span>
                    Settings
                </a>

                <a href="#" style="color:#ba1a1a;" onclick="showToast('Logout selected.'); return false;">
                    <span class="material-symbols-outlined">logout</span>
                    Logout
                </a>
            </div>
        </aside>

        <header class="aidify-topbar">
            <div class="topbar-search">
                <span class="material-symbols-outlined">search</span>
                <input id="globalSearch" type="text" placeholder="Search lessons, modules, or content..." />
            </div>

            <div class="topbar-actions">
                <button type="button" class="topbar-icon" onclick="openNotifications()">
                    <span class="material-symbols-outlined">notifications</span>
                </button>

                <button type="button" class="topbar-icon" onclick="openHelp()">
                    <span class="material-symbols-outlined">help_outline</span>
                </button>

                <a href="#" class="profile-chip" onclick="openProfile(); return false;">
                    <img alt="Instructor"
                         src="https://lh3.googleusercontent.com/aida-public/AB6AXuBTgTMp5iW7KpgwUSWn4fAuyefPR2SBfnO8bdfPX0kbX_N9naIVTbimChz6P6d-FPnlbUYB_y1tOjHq_Rye4b4y13fEnuo2LLcxWyFZ_KbEA7Sc1FYwD01OUtZ3kgcBRQGnRyD7_GdB2CV5ZTAMfIsGaz3BjYHlmxSNsHmK_q-oNfgqRh1LLDL33IPm4v78RmJ1UWsdUWCxExhnOuwVdQzB3QjAWwemoUo7i2_9YIta-46d5zHsC6ko63pD_0thGj29USMlLX8RSbI" />
                    <span>Dr. Sarah Mitchell</span>
                </a>
            </div>
        </header>

        <main class="aidify-main">
            <div class="page-container">

                <div class="breadcrumb">
                    Modules &gt; CPR Fundamentals &gt; <span>Lesson Editor</span>
                </div>

                <section class="page-header">
                    <div>
                        <h2 class="page-title">Edit Lesson</h2>
                        <p class="page-subtitle">Create and refine lesson content for your clinical training module.</p>
                    </div>

                    <div class="header-actions">
                        <button type="button" class="btn-muted" onclick="cancelLessonEdit()">
                            <span class="material-symbols-outlined">close</span>
                            Cancel
                        </button>

                        <button type="button" class="btn-outline-red" onclick="previewLesson()">
                            <span class="material-symbols-outlined">visibility</span>
                            Preview Lesson
                        </button>

                        <button type="button" class="btn-primary-red" onclick="saveChanges()">
                            <span class="material-symbols-outlined">save</span>
                            Save Changes
                        </button>
                    </div>
                </section>

                <section class="lesson-layout">

                    <div>
                        <div class="panel-card">
                            <div class="card-kicker">Lesson Content</div>

                            <div class="form-group">
                                <label class="form-label">
                                    Lesson Title
                                    <span class="required">* REQUIRED</span>
                                </label>
                                <input id="lessonTitle" class="form-input" type="text" value="Technique for Effective Chest Compressions" />
                            </div>

                            <div class="form-group">
                                <label class="form-label">
                                    Lesson Objective
                                    <span class="required">* REQUIRED</span>
                                </label>
                                <input id="lessonObjective" class="form-input" type="text" value="Teach learners to perform high-quality chest compressions with correct depth, rate, and recoil." />
                            </div>

                            <div class="form-group">
                                <label class="form-label">Formatting Toolbar</label>
                                <div class="toolbar">
                                    <button type="button" class="tool-btn" onclick="formatText('**', '**')">B</button>
                                    <button type="button" class="tool-btn" onclick="formatText('_', '_')">I</button>
                                    <button type="button" class="tool-btn" onclick="formatText('__', '__')">U</button>
                                    <button type="button" class="tool-btn" onclick="insertAtCursor('# ')">H1</button>
                                    <button type="button" class="tool-btn" onclick="insertAtCursor('## ')">H2</button>
                                    <button type="button" class="tool-btn" onclick="insertAtCursor('- ')">
                                        <span class="material-symbols-outlined" style="font-size:16px;">format_list_bulleted</span>
                                        Bullet
                                    </button>
                                    <button type="button" class="tool-btn" onclick="insertAtCursor('1. ')">
                                        <span class="material-symbols-outlined" style="font-size:16px;">format_list_numbered</span>
                                        Number
                                    </button>
                                    <button type="button" class="tool-btn" onclick="aiEdit()">
                                        <span class="material-symbols-outlined" style="font-size:16px;">auto_awesome</span>
                                        AI Edit
                                    </button>
                                </div>

                                <label class="form-label">
                                    Lesson Body
                                    <span class="required">Plain text only</span>
                                </label>
                                <textarea id="lessonBody" class="form-textarea">High-quality chest compressions are essential for maintaining blood flow to vital organs during cardiac arrest.

Key steps:
- Position the heel of one hand in the center of the chest.
- Compress the chest to the correct depth.
- Maintain a steady compression rate.
- Allow full chest recoil after each compression.
- Minimize interruptions.</textarea>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Key Steps</label>
                                <textarea id="keySteps" class="form-textarea small-textarea">Position correctly, compress deeply, maintain rate, allow recoil, and reduce interruptions.</textarea>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Clinical Tip</label>
                                <textarea id="clinicalTip" class="form-textarea small-textarea">Ensure complete chest recoil after each compression to allow the heart to refill with blood before the next stroke.</textarea>
                            </div>
                        </div>

                        <div id="previewPanel" class="preview-panel">
                            <h3 class="preview-title" id="previewTitle">Lesson Preview</h3>
                            <div class="preview-meta" id="previewMeta">Preview details</div>
                            <div class="preview-content" id="previewContent"></div>
                        </div>
                    </div>

                    <aside class="side-stack">

                        <div class="panel-card">
                            <h3 class="info-card-title">
                                <span class="material-symbols-outlined">tune</span>
                                Lesson Parameters
                            </h3>

                            <div class="param-grid">
                                <div class="form-group">
                                    <label class="form-label">Sequence Order</label>
                                    <input id="sequenceOrder" class="form-input" type="number" min="1" value="3" />
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Estimated Duration</label>
                                    <input id="estimatedDuration" class="form-input" type="number" min="1" value="15" />
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Difficulty</label>
                                    <select id="lessonDifficulty" class="form-select">
                                        <option>Beginner</option>
                                        <option selected="selected">Intermediate</option>
                                        <option>Advanced</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Visibility</label>
                                    <select id="lessonVisibility" class="form-select">
                                        <option selected="selected">Published</option>
                                        <option>Draft</option>
                                        <option>Instructor Only</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="panel-card">
                            <h3 class="info-card-title">
                                <span class="material-symbols-outlined">school</span>
                                Module Context
                            </h3>

                            <div class="module-context">
                                <div class="context-icon">
                                    <span class="material-symbols-outlined">emergency</span>
                                </div>

                                <div>
                                    <div class="context-title">CPR Fundamentals</div>
                                    <div class="context-text">
                                        Foundational course for emergency medical responders and clinical staff.
                                    </div>
                                </div>
                            </div>

                            <div class="progress-head">
                                <span>Module Progress</span>
                                <span id="progressValue">45%</span>
                            </div>

                            <div class="progress-track">
                                <div id="progressFill" class="progress-fill"></div>
                            </div>
                        </div>

                        <div class="panel-card insight-card">
                            <h3 class="info-card-title">
                                <span class="material-symbols-outlined">lightbulb</span>
                                Academic Insight
                            </h3>

                            <p id="academicInsight">
                                Break down complex techniques into bullet points. Medical learners retain more information when presented in structured lists and scenario-based steps.
                            </p>
                        </div>

                        <div class="panel-card">
                            <h3 class="info-card-title">
                                <span class="material-symbols-outlined">checklist</span>
                                Quick Actions
                            </h3>

                            <div style="display:grid; gap:10px;">
                                <button type="button" class="btn-outline-red" onclick="markReadyForReview()">
                                    <span class="material-symbols-outlined">send</span>
                                    Mark Ready for Review
                                </button>

                                <button type="button" class="btn-muted" onclick="duplicateLesson()">
                                    <span class="material-symbols-outlined">content_copy</span>
                                    Duplicate Lesson
                                </button>

                                <button type="button" class="btn-muted" onclick="resetLesson()">
                                    <span class="material-symbols-outlined">restart_alt</span>
                                    Reset Sample Content
                                </button>
                            </div>
                        </div>

                    </aside>

                </section>

            </div>
        </main>

    </div>

    <div id="lessonToast" class="toast">Action completed.</div>

    <script>
        function showToast(message) {
            var toast = document.getElementById("lessonToast");
            toast.textContent = message;
            toast.classList.add("show");

            window.clearTimeout(window.__lessonToastTimer);
            window.__lessonToastTimer = window.setTimeout(function () {
                toast.classList.remove("show");
            }, 2200);
        }

        function getLessonBody() {
            return document.getElementById("lessonBody");
        }

        function formatText(prefix, suffix) {
            var textarea = getLessonBody();
            var start = textarea.selectionStart || 0;
            var end = textarea.selectionEnd || 0;
            var selected = textarea.value.substring(start, end);
            var inserted = prefix + selected + suffix;

            textarea.value = textarea.value.substring(0, start) + inserted + textarea.value.substring(end);
            textarea.focus();
            textarea.selectionStart = start + prefix.length;
            textarea.selectionEnd = start + prefix.length + selected.length;

            showToast("Formatting added.");
        }

        function insertAtCursor(text) {
            var textarea = getLessonBody();
            var start = textarea.selectionStart || 0;
            var currentValue = textarea.value;
            var before = currentValue.substring(0, start);
            var after = currentValue.substring(start);
            var needsNewLine = before.length > 0 && !before.endsWith("\n");
            var inserted = (needsNewLine ? "\n" : "") + text;

            textarea.value = before + inserted + after;
            textarea.focus();
            textarea.selectionStart = before.length + inserted.length;
            textarea.selectionEnd = textarea.selectionStart;

            showToast("Text marker inserted.");
        }

        function aiEdit() {
            var textarea = getLessonBody();
            var clinicalTip = document.getElementById("clinicalTip");

            textarea.value +=
                "\n\nAI Improvement Suggestion:\n" +
                "- Begin with a measurable learning outcome.\n" +
                "- Use short action-based steps.\n" +
                "- Add one clinical safety reminder.\n" +
                "- Include one scenario-based question for learner reflection.";

            clinicalTip.value =
                "AI Tip: Ask learners to practice compressions with real-time feedback so they can correct depth, rhythm, and recoil during the activity.";

            showToast("AI improvement added.");
        }

        function saveChanges() {
            var title = document.getElementById("lessonTitle").value.trim();
            var objective = document.getElementById("lessonObjective").value.trim();
            var body = document.getElementById("lessonBody").value.trim();

            if (!title) {
                showToast("Lesson title is required.");
                document.getElementById("lessonTitle").focus();
                return;
            }

            if (!objective) {
                showToast("Lesson objective is required.");
                document.getElementById("lessonObjective").focus();
                return;
            }

            if (!body) {
                showToast("Lesson body is required.");
                document.getElementById("lessonBody").focus();
                return;
            }

            document.getElementById("progressFill").style.width = "60%";
            document.getElementById("progressValue").textContent = "60%";

            showToast("Lesson changes saved successfully.");
        }

        function previewLesson() {
            var title = document.getElementById("lessonTitle").value.trim() || "Untitled Lesson";
            var objective = document.getElementById("lessonObjective").value.trim() || "No objective added.";
            var body = document.getElementById("lessonBody").value.trim() || "No lesson body added.";
            var duration = document.getElementById("estimatedDuration").value || "0";
            var difficulty = document.getElementById("lessonDifficulty").value;
            var visibility = document.getElementById("lessonVisibility").value;

            document.getElementById("previewTitle").textContent = title;
            document.getElementById("previewMeta").textContent =
                difficulty + " • " + duration + " min • " + visibility + " • Objective: " + objective;

            document.getElementById("previewContent").textContent = body;
            document.getElementById("previewPanel").classList.add("visible");

            document.getElementById("previewPanel").scrollIntoView({
                behavior: "smooth",
                block: "start"
            });

            showToast("Lesson preview generated.");
        }

        function cancelLessonEdit() {
            window.location.href = "/Instructor/Modules/List.aspx";
        }

        function markReadyForReview() {
            document.getElementById("lessonVisibility").value = "Draft";
            showToast("Lesson marked ready for review.");
        }

        function duplicateLesson() {
            var titleInput = document.getElementById("lessonTitle");
            titleInput.value = titleInput.value + " - Copy";
            showToast("Lesson duplicated as a copy.");
        }

        function resetLesson() {
            document.getElementById("lessonTitle").value = "Technique for Effective Chest Compressions";
            document.getElementById("lessonObjective").value = "Teach learners to perform high-quality chest compressions with correct depth, rate, and recoil.";
            document.getElementById("lessonBody").value =
                "High-quality chest compressions are essential for maintaining blood flow to vital organs during cardiac arrest.\n\n" +
                "Key steps:\n" +
                "- Position the heel of one hand in the center of the chest.\n" +
                "- Compress the chest to the correct depth.\n" +
                "- Maintain a steady compression rate.\n" +
                "- Allow full chest recoil after each compression.\n" +
                "- Minimize interruptions.";
            document.getElementById("keySteps").value = "Position correctly, compress deeply, maintain rate, allow recoil, and reduce interruptions.";
            document.getElementById("clinicalTip").value = "Ensure complete chest recoil after each compression to allow the heart to refill with blood before the next stroke.";
            document.getElementById("previewPanel").classList.remove("visible");

            showToast("Sample lesson content reset.");
        }

        function openNotifications() {
            alert("Notifications\n\n• 2 lesson drafts need review.\n• CPR Fundamentals was updated today.\n• One learner discussion mentions this lesson.");
        }

        function openHelp() {
            alert(
                "Lesson Editor Help\n\n" +
                "Save Changes validates and saves the lesson UI state.\n" +
                "Preview Lesson shows a live preview panel.\n" +
                "AI Edit adds plain-text improvement suggestions.\n" +
                "Cancel returns to Modules.\n\n" +
                "Formatting buttons use plain-text markers only, not HTML tags."
            );
        }

        function openProfile() {
            alert("Instructor Profile\n\nDr. Sarah Mitchell\nLead Medical Instructor\nVerified Educator");
        }
    </script>

</asp:Content>