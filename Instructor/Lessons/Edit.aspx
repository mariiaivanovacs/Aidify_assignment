<%@ Page Title="Create / Edit Lesson" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="Aidify_assigment.Instructor.Lessons.Edit" %>

<asp:Content ID="LessonEditContent" ContentPlaceHolderID="MainContent" runat="server">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: #fff8f7;
        }

        .lesson-page {
            min-height: 100vh;
            background: #fff8f7;
            color: #281715;
        }

        .lesson-topbar {
            height: 64px;
            background: #fff8f7;
            border-bottom: 1px solid #e6bdb8;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 28px;
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .topbar-left {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .menu-btn {
            border: 0;
            background: transparent;
            color: #b70011;
            width: 34px;
            height: 34px;
            border-radius: 999px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .menu-btn:hover {
            background: #fbdbd7;
        }

        .portal-title {
            font-size: 18px;
            font-weight: 800;
            color: #b70011;
            margin: 0;
        }

        .topbar-links {
            display: flex;
            align-items: center;
            gap: 28px;
            margin-right: 22px;
        }

        .topbar-links a {
            color: #5c403c;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
        }

        .topbar-links a.active {
            color: #b70011;
            border-bottom: 2px solid #b70011;
            padding-bottom: 4px;
        }

        .topbar-right {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .topbar-icon {
            color: #5c403c;
            width: 32px;
            height: 32px;
            border-radius: 999px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .topbar-icon:hover {
            background: #fbdbd7;
            color: #b70011;
        }

        .avatar {
            width: 32px;
            height: 32px;
            border-radius: 999px;
            background: #ffdad6;
            border: 2px solid #e6bdb8;
            color: #b70011;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 12px;
        }

        .lesson-layout {
            display: flex;
            min-height: calc(100vh - 64px);
        }

        .lesson-sidebar {
            width: 260px;
            background: #fff0ee;
            border-right: 1px solid #e6bdb8;
            padding: 24px 12px;
            flex-shrink: 0;
            position: sticky;
            top: 64px;
            height: calc(100vh - 64px);
            overflow-y: auto;
        }

        .instructor-card {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 0 14px 26px;
        }

        .instructor-avatar {
            width: 42px;
            height: 42px;
            border-radius: 999px;
            background: #ffdad6;
            color: #b70011;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            border: 1px solid #e6bdb8;
        }

        .instructor-name {
            color: #b70011;
            font-size: 13px;
            font-weight: 800;
            line-height: 1.2;
        }

        .instructor-role {
            color: #5c403c;
            font-size: 11px;
            margin-top: 2px;
        }

        .lesson-nav {
            display: flex;
            flex-direction: column;
            gap: 7px;
        }

        .lesson-nav a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 14px;
            border-radius: 10px;
            color: #5c403c;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: 0.2s ease;
        }

        .lesson-nav a:hover {
            background: #fbdbd7;
            color: #281715;
        }

        .lesson-nav a.active {
            background: #b70011;
            color: white;
            box-shadow: 0 8px 18px rgba(183, 0, 17, 0.14);
        }

        .lesson-nav .material-symbols-outlined {
            font-size: 19px;
        }

        .lesson-main {
            flex: 1;
            min-width: 0;
            background: #fff8f7;
            padding: 26px 32px 36px;
        }

        .lesson-container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .breadcrumb-line {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #596373;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 18px;
        }

        .breadcrumb-line a {
            color: #596373;
            text-decoration: none;
        }

        .breadcrumb-line a:hover {
            color: #b70011;
        }

        .editor-grid {
            display: grid;
            grid-template-columns: minmax(0, 8fr) minmax(310px, 4fr);
            gap: 28px;
            align-items: start;
        }

        .editor-card {
            background: white;
            border: 1px solid #e6bdb8;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 8px 22px rgba(40, 23, 21, 0.05);
        }

        .title-area {
            background: #fff0ee;
            border-bottom: 1px solid #e6bdb8;
            padding: 28px 32px;
        }

        .field-kicker {
            color: #5c403c;
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.13em;
            margin-bottom: 10px;
            display: block;
        }

        .lesson-title-input {
            width: 100%;
            border: 0 !important;
            background: transparent !important;
            color: #281715 !important;
            font-size: 42px !important;
            line-height: 1.12 !important;
            font-weight: 800 !important;
            letter-spacing: -0.04em;
            padding: 0 !important;
            box-shadow: none !important;
            outline: none !important;
        }

        .lesson-title-input:focus {
            box-shadow: none !important;
            outline: none !important;
        }

        .lesson-title-input::placeholder {
            color: #916f6b;
        }

        .validator-custom {
            color: #ba1a1a;
            font-size: 12px;
            font-weight: 700;
            display: block;
            margin-top: 8px;
        }

        .editor-toolbar {
            min-height: 54px;
            background: #ffe9e6;
            border-bottom: 1px solid #e6bdb8;
            padding: 10px 14px;
            display: flex;
            align-items: center;
            gap: 4px;
            position: sticky;
            top: 64px;
            z-index: 20;
            overflow-x: auto;
        }

        .toolbar-btn {
            border: 0;
            background: transparent;
            color: #5c403c;
            width: 34px;
            height: 34px;
            border-radius: 7px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: 0.2s ease;
            flex-shrink: 0;
        }

        .toolbar-btn:hover {
            background: #fbdbd7;
            color: #b70011;
        }

        .toolbar-separator {
            width: 1px;
            height: 24px;
            background: #e6bdb8;
            margin: 0 8px;
            flex-shrink: 0;
        }

        .ai-edit-btn {
            margin-left: auto;
            border: 0;
            background: #ffdad6;
            color: #410002;
            border-radius: 9px;
            padding: 8px 14px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 12px;
            font-weight: 800;
            white-space: nowrap;
        }

        .ai-edit-btn:hover {
            background: #ffb4ab;
        }

        .hidden-lesson-body {
            position: absolute;
            left: -9999px;
            width: 1px;
            height: 1px;
            opacity: 0;
        }

        .rich-editor {
            min-height: 540px;
            padding: 38px 42px;
            font-size: 18px;
            line-height: 1.75;
            color: #281715;
            outline: none;
        }

        .rich-editor p {
            margin-bottom: 18px;
        }

        .rich-editor h3 {
            font-size: 25px;
            line-height: 1.25;
            font-weight: 800;
            margin: 28px 0 14px;
            color: #281715;
        }

        .rich-editor ul {
            padding-left: 24px;
            margin-bottom: 22px;
        }

        .rich-editor li {
            margin-bottom: 8px;
        }

        .clinical-tip {
            background: #ffe9e6;
            border-left: 5px solid #dc2626;
            border-radius: 12px;
            padding: 22px 24px;
            margin: 32px 0;
        }

        .clinical-tip-title {
            color: #b70011;
            display: flex;
            align-items: center;
            gap: 9px;
            font-size: 13px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            margin-bottom: 8px;
        }

        .clinical-tip p {
            margin: 0;
            color: #281715;
            font-size: 16px;
            line-height: 1.6;
            font-style: italic;
        }

        .side-stack {
            display: flex;
            flex-direction: column;
            gap: 18px;
            position: sticky;
            top: 92px;
        }

        .side-actions {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .btn-save-lesson,
        .btn-cancel-lesson {
            width: 100%;
            border-radius: 12px !important;
            padding: 14px 18px !important;
            font-weight: 800 !important;
            font-size: 14px !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            gap: 8px !important;
        }

        .btn-save-lesson {
            background: #b70011 !important;
            border-color: #b70011 !important;
            color: #ffffff !important;
            box-shadow: 0 12px 24px rgba(183, 0, 17, 0.18);
        }

        .btn-save-lesson:hover {
            filter: brightness(1.06);
        }

        .btn-cancel-lesson {
            background: #ffe9e6 !important;
            border: 1px solid #e6bdb8 !important;
            color: #281715 !important;
        }

        .btn-cancel-lesson:hover {
            background: #fbdbd7 !important;
        }

        .side-panel {
            background: white;
            border: 1px solid #e6bdb8;
            border-radius: 14px;
            padding: 22px;
            box-shadow: 0 8px 22px rgba(40, 23, 21, 0.04);
        }

        .side-title {
            color: #5c403c;
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.14em;
            padding-bottom: 12px;
            margin-bottom: 18px;
            border-bottom: 1px solid #e6bdb8;
        }

        .mini-field {
            margin-bottom: 18px;
        }

        .mini-field:last-child {
            margin-bottom: 0;
        }

        .mini-label {
            color: #5c403c;
            font-size: 12px;
            font-weight: 800;
            margin-bottom: 8px;
            display: block;
        }

        .input-wrap {
            position: relative;
        }

        .side-input {
            width: 100%;
            background: #fff8f7 !important;
            border: 1px solid #e6bdb8 !important;
            border-radius: 9px !important;
            padding: 12px 40px !important;
            color: #281715 !important;
            box-shadow: none !important;
            outline: none !important;
        }

        .side-input:focus {
            border-color: #b70011 !important;
            box-shadow: 0 0 0 4px rgba(183, 0, 17, 0.10) !important;
        }

        .input-icon-left {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #555f6f;
            font-size: 20px;
        }

        .input-suffix {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #916f6b;
            font-size: 11px;
            font-weight: 700;
        }

        .field-help {
            color: #596373;
            font-size: 11px;
            line-height: 1.4;
            margin-top: 8px;
        }

        .module-context {
            display: flex;
            align-items: flex-start;
            gap: 14px;
        }

        .module-icon {
            width: 52px;
            height: 52px;
            border-radius: 13px;
            background: #ffe9e6;
            color: #b70011;
            border: 1px solid #e6bdb8;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .module-name {
            font-size: 15px;
            font-weight: 800;
            color: #281715;
            margin-bottom: 4px;
        }

        .module-desc {
            color: #596373;
            font-size: 12px;
            line-height: 1.45;
            margin: 0;
        }

        .progress-row {
            margin-top: 20px;
            padding-top: 18px;
            border-top: 1px solid #e6bdb8;
        }

        .progress-label {
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #5c403c;
            font-size: 12px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .progress-label strong {
            color: #b70011;
        }

        .progress-track {
            height: 7px;
            background: #fbdbd7;
            border-radius: 999px;
            overflow: hidden;
        }

        .progress-fill {
            width: 45%;
            height: 100%;
            background: #dc2626;
            border-radius: 999px;
        }

        .insight-card {
            background: #f0f2f8;
            border: 1px solid #d6e0f3;
            color: #151c27;
            border-radius: 14px;
            padding: 20px;
        }

        .insight-title {
            color: #535a67;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            font-weight: 800;
            margin-bottom: 10px;
        }

        .insight-text {
            color: #404754;
            font-size: 12px;
            line-height: 1.6;
            margin: 0;
        }

        .status-line {
            color: #596373;
            font-size: 12px;
            margin-bottom: 18px;
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 500, 'GRAD' 0, 'opsz' 24;
        }

        @media (max-width: 1100px) {
            .editor-grid {
                grid-template-columns: 1fr;
            }

            .side-stack {
                position: static;
            }
        }

        @media (max-width: 850px) {
            .lesson-layout {
                display: block;
            }

            .lesson-sidebar {
                width: 100%;
                height: auto;
                position: relative;
                top: 0;
            }

            .lesson-nav {
                flex-direction: row;
                overflow-x: auto;
            }

            .lesson-nav a {
                white-space: nowrap;
            }

            .lesson-main {
                padding: 20px 16px;
            }

            .topbar-links {
                display: none;
            }

            .lesson-title-input {
                font-size: 30px !important;
            }

            .rich-editor {
                padding: 26px 22px;
                font-size: 16px;
                min-height: 420px;
            }
        }
    </style>

    <asp:HiddenField ID="hfLessonId" runat="server" />
    <asp:HiddenField ID="hfModuleId" runat="server" />

    <div class="lesson-page">

        <!-- Top Bar -->
        <header class="lesson-topbar">
            <div class="topbar-left">
                <button type="button" class="menu-btn">
                    <span class="material-symbols-outlined">menu</span>
                </button>
                <h1 class="portal-title">Instructor Portal</h1>
            </div>

            <div class="topbar-right">
                <nav class="topbar-links">
                    <a href="/Instructor/Dashboard.aspx">Dashboard</a>
                    <a class="active" href="/Instructor/Modules/Edit.aspx">My Modules</a>
                    <a href="/Instructor/Quizzes/GenerateWithAI.aspx">AI Generator</a>
                </nav>

                <span class="topbar-icon">
                    <span class="material-symbols-outlined" style="font-size:18px;">search</span>
                </span>

                <span class="topbar-icon">
                    <span class="material-symbols-outlined" style="font-size:18px;color:#b70011;">notifications</span>
                </span>

                <div class="avatar">M</div>
            </div>
        </header>

        <div class="lesson-layout">

            <!-- Sidebar -->
            <aside class="lesson-sidebar">
                <div class="instructor-card">
                    <div class="instructor-avatar">M</div>
                    <div>
                        <div class="instructor-name"><%: Aidify_assigment.AuthHelper.GetName() %></div>
                        <div class="instructor-role"><%: Aidify_assigment.AuthHelper.GetRole() %></div>
                    </div>
                </div>

                <nav class="lesson-nav">
                    <a href="/Instructor/Dashboard.aspx">
                        <span class="material-symbols-outlined">dashboard</span>
                        Dashboard
                    </a>

                    <a class="active" href="/Instructor/Modules/Edit.aspx">
                        <span class="material-symbols-outlined">school</span>
                        My Modules
                    </a>

                    <a href="/Instructor/Materials/Upload.aspx">
                        <span class="material-symbols-outlined">description</span>
                        Materials
                    </a>

                    <a href="/Instructor/Quizzes/Edit.aspx">
                        <span class="material-symbols-outlined">quiz</span>
                        Quizzes
                    </a>

                    <a href="/Instructor/Quizzes/GenerateWithAI.aspx">
                        <span class="material-symbols-outlined">auto_awesome</span>
                        AI Generator
                    </a>

                    <a href="#">
                        <span class="material-symbols-outlined">settings</span>
                        Settings
                    </a>
                </nav>
            </aside>

            <!-- Main -->
            <main class="lesson-main">
                <div class="lesson-container">

                    <div class="breadcrumb-line">
                        <a href="/Instructor/Modules/Edit.aspx">Modules</a>
                        <span class="material-symbols-outlined" style="font-size:16px;">chevron_right</span>
                        <a href="/Instructor/Modules/Edit.aspx">CPR Fundamentals</a>
                        <span class="material-symbols-outlined" style="font-size:16px;">chevron_right</span>
                        <span style="color:#b70011;font-weight:800;">Lesson Editor</span>
                    </div>

                    <asp:Label ID="lblLessonStatus" runat="server" CssClass="status-line d-block"></asp:Label>

                    <div class="editor-grid">

                        <!-- Main Editor -->
                        <section class="editor-card">
                            <div class="title-area">
                                <asp:Label ID="lblLessonTitle" runat="server"
                                    AssociatedControlID="txtLessonTitle"
                                    CssClass="field-kicker">
                                    Lesson Title
                                </asp:Label>

                                <asp:TextBox ID="txtLessonTitle" runat="server"
                                    CssClass="lesson-title-input"
                                    MaxLength="200"
                                    placeholder="Untitled Lesson"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="rfvLessonTitle" runat="server"
                                    ControlToValidate="txtLessonTitle"
                                    CssClass="validator-custom"
                                    Display="Dynamic"
                                    ErrorMessage="Lesson title is required."></asp:RequiredFieldValidator>
                            </div>

                            <div class="editor-toolbar">
                                <button type="button" class="toolbar-btn" title="Bold" onclick="formatEditor('bold')">
                                    <span class="material-symbols-outlined">format_bold</span>
                                </button>

                                <button type="button" class="toolbar-btn" title="Italic" onclick="formatEditor('italic')">
                                    <span class="material-symbols-outlined">format_italic</span>
                                </button>

                                <button type="button" class="toolbar-btn" title="Underline" onclick="formatEditor('underline')">
                                    <span class="material-symbols-outlined">format_underlined</span>
                                </button>

                                <div class="toolbar-separator"></div>

                                <button type="button" class="toolbar-btn" title="Heading" onclick="formatEditor('formatBlock', 'h3')">
                                    <span class="material-symbols-outlined">format_h1</span>
                                </button>

                                <button type="button" class="toolbar-btn" title="Subheading" onclick="formatEditor('formatBlock', 'h4')">
                                    <span class="material-symbols-outlined">format_h2</span>
                                </button>

                                <div class="toolbar-separator"></div>

                                <button type="button" class="toolbar-btn" title="Bullet List" onclick="formatEditor('insertUnorderedList')">
                                    <span class="material-symbols-outlined">format_list_bulleted</span>
                                </button>

                                <button type="button" class="toolbar-btn" title="Numbered List" onclick="formatEditor('insertOrderedList')">
                                    <span class="material-symbols-outlined">format_list_numbered</span>
                                </button>

                                <button type="button" class="toolbar-btn" title="Link" onclick="formatEditor('createLink', prompt('Enter URL:'))">
                                    <span class="material-symbols-outlined">link</span>
                                </button>

                                <button type="button" class="toolbar-btn" title="Image">
                                    <span class="material-symbols-outlined">image</span>
                                </button>

                                <button type="button" class="ai-edit-btn">
                                    <span class="material-symbols-outlined" style="font-size:17px;">auto_awesome</span>
                                    AI Edit
                                </button>
                            </div>

                            <div style="position:relative;">
                                <asp:Label ID="lblLessonBody" runat="server"
                                    AssociatedControlID="txtLessonBody"
                                    CssClass="d-none">
                                    Lesson Body
                                </asp:Label>

                                <asp:TextBox ID="txtLessonBody" runat="server"
                                    CssClass="hidden-lesson-body"
                                    TextMode="MultiLine"
                                    Rows="10"></asp:TextBox>

                                <div id="visualLessonEditor" class="rich-editor" contenteditable="true">
                                    <p>
                                        High-quality chest compressions are essential for maintaining blood flow to vital organs during cardiac arrest.
                                        Effective compressions must meet specific criteria regarding depth, rate, and chest recoil.
                                    </p>

                                    <h3>Key Steps for Performance:</h3>

                                    <ul>
                                        <li><strong>Positioning:</strong> Place the heel of one hand in the center of the chest, on the lower half of the sternum.</li>
                                        <li><strong>Depth:</strong> Compress the chest to at least 2 inches (5 cm) but no more than 2.4 inches (6 cm).</li>
                                        <li><strong>Rate:</strong> Maintain a compression rate of 100 to 120 compressions per minute.</li>
                                    </ul>

                                    <div class="clinical-tip">
                                        <div class="clinical-tip-title">
                                            <span class="material-symbols-outlined" style="font-size:21px;">medical_information</span>
                                            Clinical Tip
                                        </div>
                                        <p>
                                            Ensure complete chest recoil after each compression to allow the heart to refill with blood before the next stroke.
                                        </p>
                                    </div>

                                    <p>
                                        Continue compressions with minimal interruptions. Rescuers should rotate every 2 minutes or sooner if fatigued to maintain high quality.
                                    </p>
                                </div>

                                <asp:RequiredFieldValidator ID="rfvLessonBody" runat="server"
                                    ControlToValidate="txtLessonBody"
                                    CssClass="validator-custom"
                                    Display="Dynamic"
                                    ErrorMessage="Lesson body is required."></asp:RequiredFieldValidator>
                            </div>
                        </section>

                        <!-- Right Sidebar -->
                        <aside class="side-stack">

                            <div class="side-actions">
                                <asp:Button ID="btnSaveLesson" runat="server"
                                    Text="Save Changes"
                                    CssClass="btn btn-save-lesson"
                                    OnClientClick="syncLessonEditor();"
                                    OnClick="btnSaveLesson_Click" />

                                <asp:Button ID="btnCancel" runat="server"
                                    Text="Cancel"
                                    CssClass="btn btn-cancel-lesson"
                                    CausesValidation="false"
                                    OnClick="btnCancel_Click" />
                            </div>

                            <section class="side-panel">
                                <div class="side-title">Lesson Parameters</div>

                                <div class="mini-field">
                                    <asp:Label ID="lblSequenceOrder" runat="server"
                                        AssociatedControlID="txtSequenceOrder"
                                        CssClass="mini-label">
                                        Sequence Order
                                    </asp:Label>

                                    <div class="input-wrap">
                                        <span class="material-symbols-outlined input-icon-left">format_list_numbered</span>
                                        <asp:TextBox ID="txtSequenceOrder" runat="server"
                                            CssClass="side-input"
                                            TextMode="Number"></asp:TextBox>
                                    </div>

                                    <div class="field-help">Determines position in the module timeline.</div>
                                </div>

                                <div class="mini-field">
                                    <asp:Label ID="lblEstimatedMinutes" runat="server"
                                        AssociatedControlID="txtEstimatedMinutes"
                                        CssClass="mini-label">
                                        Estimated Duration
                                    </asp:Label>

                                    <div class="input-wrap">
                                        <span class="material-symbols-outlined input-icon-left">schedule</span>
                                        <asp:TextBox ID="txtEstimatedMinutes" runat="server"
                                            CssClass="side-input"
                                            TextMode="Number"></asp:TextBox>
                                        <span class="input-suffix">min</span>
                                    </div>
                                </div>
                            </section>

                            <section class="side-panel">
                                <div class="side-title">Module Context</div>

                                <div class="module-context">
                                    <div class="module-icon">
                                        <span class="material-symbols-outlined" style="font-size:27px;">emergency</span>
                                    </div>

                                    <div>
                                        <div class="module-name">CPR Fundamentals</div>
                                        <p class="module-desc">
                                            Foundational course for emergency medical responders and clinical staff.
                                        </p>
                                    </div>
                                </div>

                                <div class="progress-row">
                                    <div class="progress-label">
                                        <span>Module Progress</span>
                                        <strong>45%</strong>
                                    </div>
                                    <div class="progress-track">
                                        <div class="progress-fill"></div>
                                    </div>
                                </div>
                            </section>

                            <div class="insight-card">
                                <div class="insight-title">
                                    <span class="material-symbols-outlined" style="font-size:21px;">lightbulb</span>
                                    Academic Insight
                                </div>
                                <p class="insight-text">
                                    Break down complex techniques into bullet points. Studies show medical students retain more information when presented in structured lists.
                                </p>
                            </div>

                        </aside>

                    </div>
                </div>
            </main>
        </div>
    </div>

    <script type="text/javascript">
        function getBodyTextBox() {
            return document.getElementById('<%= txtLessonBody.ClientID %>');
        }

        function syncLessonEditor() {
            var editor = document.getElementById('visualLessonEditor');
            var bodyTextBox = getBodyTextBox();

            if (editor && bodyTextBox) {
                bodyTextBox.value = editor.innerHTML.trim();
            }

            return true;
        }

        function loadLessonEditorContent() {
            var editor = document.getElementById('visualLessonEditor');
            var bodyTextBox = getBodyTextBox();

            if (!editor || !bodyTextBox) {
                return;
            }

            if (bodyTextBox.value && bodyTextBox.value.trim().length > 0) {
                editor.innerHTML = bodyTextBox.value;
            } else {
                bodyTextBox.value = editor.innerHTML.trim();
            }

            editor.addEventListener('input', syncLessonEditor);
        }

        function formatEditor(command, value) {
            var editor = document.getElementById('visualLessonEditor');

            if (editor) {
                editor.focus();
            }

            document.execCommand(command, false, value || null);
            syncLessonEditor();
        }

        document.addEventListener('DOMContentLoaded', loadLessonEditorContent);
        if (typeof Sys !== 'undefined' && Sys.Application) {
            Sys.Application.add_load(loadLessonEditorContent);
        }
    </script>

</asp:Content>