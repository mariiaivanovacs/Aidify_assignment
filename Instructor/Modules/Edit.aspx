<%@ Page Title="Create / Edit Module" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="Aidify_assigment.Instructor.Modules.Edit" %>

<asp:Content ID="ModuleEditContent" ContentPlaceHolderID="MainContent" runat="server">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: #f9fafb;
        }

        .module-page {
            min-height: 100vh;
            background: #f9fafb;
            color: #281715;
        }

        .module-topbar {
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
            width: 34px;
            height: 34px;
            border-radius: 999px;
            border: 0;
            background: transparent;
            color: #b70011;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: 0.2s ease;
        }

        .menu-btn:hover {
            background: #fbdbd7;
        }

        .portal-title {
            color: #b70011;
            font-size: 18px;
            font-weight: 800;
            margin: 0;
        }

        .topbar-right {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .topbar-icon {
            color: #b70011;
            width: 34px;
            height: 34px;
            border-radius: 999px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .topbar-icon:hover {
            background: #fbdbd7;
        }

        .topbar-avatar {
            width: 34px;
            height: 34px;
            border-radius: 999px;
            background: #ffdad6;
            border: 2px solid #e6bdb8;
            color: #b70011;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 13px;
        }

        .module-layout {
            display: flex;
            min-height: calc(100vh - 64px);
        }

        .module-sidebar {
            width: 280px;
            background: #fff0ee;
            border-right: 1px solid #e6bdb8;
            padding: 24px 12px;
            flex-shrink: 0;
            position: sticky;
            top: 64px;
            height: calc(100vh - 64px);
            overflow-y: auto;
        }

        .instructor-block {
            padding: 0 18px 30px;
        }

        .instructor-name {
            font-size: 21px;
            font-weight: 800;
            color: #b70011;
            margin-bottom: 3px;
        }

        .instructor-role {
            color: #5c403c;
            font-size: 12px;
            margin-bottom: 7px;
        }

        .verified-line {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            color: #b70011;
            font-size: 10px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.08em;
        }

        .module-nav {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .module-nav a {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 13px 16px;
            border-radius: 12px;
            color: #5c403c;
            text-decoration: none;
            font-size: 15px;
            font-weight: 600;
            transition: 0.2s ease;
        }

        .module-nav a:hover {
            background: #fbdbd7;
            color: #281715;
        }

        .module-nav a.active {
            background: #b70011;
            color: #ffffff;
            box-shadow: 0 8px 18px rgba(183, 0, 17, 0.14);
        }

        .module-main {
            flex: 1;
            min-width: 0;
            padding: 32px;
        }

        .module-container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #596373;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .breadcrumb a {
            color: #596373;
            text-decoration: none;
        }

        .breadcrumb a:hover {
            color: #b70011;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            gap: 24px;
            margin-bottom: 24px;
        }

        .page-title {
            font-size: 32px;
            line-height: 1.15;
            font-weight: 800;
            color: #281715;
            margin: 0 0 6px;
            letter-spacing: -0.03em;
        }

        .page-subtitle {
            color: #5c403c;
            font-size: 14px;
            margin: 0;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .btn-cancel-custom,
        .btn-save-custom {
            border-radius: 10px !important;
            padding: 12px 28px !important;
            font-weight: 800 !important;
            font-size: 13px !important;
            border: 1px solid transparent !important;
        }

        .btn-cancel-custom {
            background: transparent !important;
            color: #555f6f !important;
        }

        .btn-cancel-custom:hover {
            background: #ffe9e6 !important;
        }

        .btn-save-custom {
            background: #b70011 !important;
            color: #ffffff !important;
            border-color: #b70011 !important;
            box-shadow: 0 10px 22px rgba(183, 0, 17, 0.14);
        }

        .btn-save-custom:hover {
            filter: brightness(1.06);
        }

        .form-grid {
            display: grid;
            grid-template-columns: minmax(0, 8fr) minmax(320px, 4fr);
            gap: 32px;
            align-items: start;
        }

        .left-column,
        .right-column {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        .panel {
            background: #ffffff;
            border: 1px solid #e6bdb8;
            border-radius: 16px;
            box-shadow: 0 8px 22px rgba(40, 23, 21, 0.04);
            padding: 28px;
        }

        .panel-title {
            color: #b70011;
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.16em;
            padding-bottom: 14px;
            margin-bottom: 22px;
            border-bottom: 1px solid #e6bdb8;
        }

        .field-group {
            margin-bottom: 24px;
        }

        .field-group:last-child {
            margin-bottom: 0;
        }

        .field-label {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            color: #5c403c;
            font-size: 13px;
            font-weight: 800;
            margin-bottom: 10px;
        }

        .required-text,
        .validator-custom {
            color: #ba1a1a;
            font-size: 10px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.08em;
        }

        .module-input,
        .module-select,
        .module-textarea {
            width: 100%;
            border: 1px solid #916f6b !important;
            background: #fff8f7 !important;
            color: #281715 !important;
            border-radius: 10px !important;
            padding: 14px 16px !important;
            font-size: 15px !important;
            outline: none !important;
            box-shadow: none !important;
            transition: 0.2s ease;
        }

        .module-input:focus,
        .module-select:focus,
        .module-textarea:focus {
            border-color: #b70011 !important;
            box-shadow: 0 0 0 4px rgba(183, 0, 17, 0.10) !important;
        }

        .module-textarea {
            min-height: 320px;
            resize: vertical;
            line-height: 1.55;
        }

        .notes-panel {
            background: #fff8f7;
            border: 1px solid #e6bdb8;
            border-radius: 16px;
            padding: 26px;
            box-shadow: 0 8px 22px rgba(40, 23, 21, 0.04);
        }

        .notes-title {
            color: #b70011;
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.16em;
            margin-bottom: 12px;
        }

        .notes-text {
            color: #5c403c;
            line-height: 1.65;
            font-size: 14px;
            margin: 0;
        }

        .cover-upload {
            position: relative;
            cursor: pointer;
        }

        .cover-file {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            z-index: 5;
            cursor: pointer;
        }

        .cover-box {
            aspect-ratio: 16 / 9;
            width: 100%;
            border-radius: 14px;
            overflow: hidden;
            border: 2px dashed #e6bdb8;
            background: #fff0ee;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: 0.2s ease;
        }

        .cover-upload:hover .cover-box {
            border-color: #b70011;
        }

        .cover-preview-img {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: none;
        }

        .cover-placeholder-bg {
            position: absolute;
            inset: 0;
            background:
                linear-gradient(to top, rgba(0,0,0,0.50), rgba(0,0,0,0.12)),
                radial-gradient(circle at 45% 45%, #f8fafc 0 13%, transparent 14%),
                linear-gradient(135deg, #111827, #6b7280);
            opacity: 0.82;
        }

        .cover-content {
            position: relative;
            z-index: 2;
            text-align: center;
            color: #ffffff;
            pointer-events: none;
        }

        .cover-content .material-symbols-outlined {
            color: #ffdad6;
            font-size: 44px;
            display: block;
            margin-bottom: 6px;
        }

        .cover-content strong {
            display: block;
            font-size: 13px;
            margin-bottom: 3px;
        }

        .cover-content small {
            color: #ffedea;
            font-size: 11px;
        }

        .quick-actions {
            display: flex;
            flex-direction: column;
            gap: 12px;
            padding-top: 6px;
        }

        .btn-add-lesson-custom,
        .btn-export-custom {
            width: 100%;
            border-radius: 10px !important;
            padding: 14px 18px !important;
            font-weight: 800 !important;
            font-size: 13px !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            gap: 8px !important;
        }

        .btn-add-lesson-custom {
            background: #dc2626 !important;
            border-color: #dc2626 !important;
            color: #fff6f5 !important;
        }

        .btn-export-custom {
            background: #ffffff !important;
            border: 1px solid #916f6b !important;
            color: #281715 !important;
        }

        .btn-export-custom:hover {
            background: #fff0ee !important;
        }

        .ai-card {
            background: #dc2626;
            color: #fff6f5;
            border-radius: 16px;
            padding: 26px;
            box-shadow: 0 12px 26px rgba(220, 38, 38, 0.22);
            position: relative;
            overflow: hidden;
        }

        .ai-card::after {
            content: "auto_awesome";
            font-family: 'Material Symbols Outlined';
            position: absolute;
            right: -18px;
            bottom: -36px;
            font-size: 120px;
            opacity: 0.12;
        }

        .ai-head {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 14px;
            position: relative;
            z-index: 1;
        }

        .ai-head .material-symbols-outlined {
            font-size: 34px;
        }

        .ai-title {
            font-size: 22px;
            line-height: 1.1;
            font-weight: 800;
            margin: 0;
        }

        .ai-text {
            font-size: 13px;
            line-height: 1.55;
            margin: 0 0 16px;
            opacity: 0.92;
            position: relative;
            z-index: 1;
        }

        .ai-progress {
            height: 4px;
            background: rgba(255,255,255,0.22);
            border-radius: 999px;
            overflow: hidden;
            position: relative;
            z-index: 1;
        }

        .ai-progress-bar {
            height: 100%;
            width: 98%;
            background: #ffffff;
            border-radius: 999px;
        }

        .validation-box {
            border-radius: 14px !important;
            border: 1px solid #ba1a1a !important;
            background: #ffdad6 !important;
            color: #93000a !important;
            font-weight: 700;
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 500, 'GRAD' 0, 'opsz' 24;
        }

        @media (max-width: 1100px) {
            .form-grid {
                grid-template-columns: 1fr;
            }

            .module-sidebar {
                width: 240px;
            }
        }

        @media (max-width: 850px) {
            .module-layout {
                display: block;
            }

            .module-sidebar {
                width: 100%;
                height: auto;
                position: relative;
                top: 0;
            }

            .module-nav {
                flex-direction: row;
                overflow-x: auto;
            }

            .module-nav a {
                white-space: nowrap;
            }

            .module-main {
                padding: 22px 16px;
            }

            .page-header {
                align-items: flex-start;
                flex-direction: column;
            }

            .module-topbar {
                padding: 0 16px;
            }

            .portal-title {
                font-size: 16px;
            }

            .instructor-block {
                padding-bottom: 18px;
            }
        }
    </style>

    <div class="module-page">

        <!-- Top App Bar -->
        <header class="module-topbar">
            <div class="topbar-left">
                <button type="button" class="menu-btn">
                    <span class="material-symbols-outlined">menu</span>
                </button>
                <h1 class="portal-title">Instructor Portal</h1>
            </div>

            <div class="topbar-right">
                <span class="topbar-icon">
                    <span class="material-symbols-outlined" style="font-size:19px;">notifications</span>
                </span>
                <div class="topbar-avatar">M</div>
            </div>
        </header>

        <div class="module-layout">

            <!-- Sidebar -->
            <aside class="module-sidebar">
                <div class="instructor-block">
                    <div class="instructor-name">Dr. Sarah Mitchell</div>
                    <div class="instructor-role">Lead Medical Instructor</div>
                    <div class="verified-line">
                        <span class="material-symbols-outlined" style="font-size:13px;font-variation-settings:'FILL' 1;">verified</span>
                        Verified Educator
                    </div>
                </div>

                <nav class="module-nav">
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
                </nav>
            </aside>

            <!-- Main Content -->
            <main class="module-main">
                <div class="module-container">

                    <!-- Breadcrumb + Header -->
                    <div class="breadcrumb">
                        <a href="/Instructor/Modules/Edit.aspx">Modules</a>
                        <span class="material-symbols-outlined" style="font-size:16px;">chevron_right</span>
                        <span style="color:#281715;">Edit Module</span>
                    </div>

                    <div class="page-header">
                        <div>
                            <h2 class="page-title">Module Configuration</h2>
                            <p class="page-subtitle">Refine the curriculum and metadata for your clinical training program.</p>
                            <asp:Label ID="lblModuleStatus" runat="server" CssClass="page-subtitle d-block mt-1"></asp:Label>
                        </div>

                        <div class="header-actions">
                            <asp:Button ID="btnCancel" runat="server"
                                Text="Cancel"
                                CssClass="btn btn-cancel-custom"
                                CausesValidation="false"
                                OnClick="btnCancel_Click" />

                            <asp:Button ID="btnSaveModule" runat="server"
                                Text="Save Changes"
                                CssClass="btn btn-save-custom"
                                OnClick="btnSaveModule_Click" />
                        </div>
                    </div>

                    <asp:HiddenField ID="hfModuleId" runat="server" />
                    <asp:ValidationSummary ID="vsModule" runat="server" CssClass="alert validation-box mb-4" DisplayMode="BulletList" />

                    <div class="form-grid">

                        <!-- Left Column -->
                        <section class="left-column">

                            <div class="panel">
                                <div class="panel-title">Primary Content</div>

                                <div class="field-group">
                                    <asp:Label ID="lblModuleTitle" runat="server"
                                        AssociatedControlID="txtModuleTitle"
                                        CssClass="field-label">
                                        <span>Module Title</span>
                                        <span class="required-text">* Required</span>
                                    </asp:Label>

                                    <asp:TextBox ID="txtModuleTitle" runat="server"
                                        CssClass="module-input"
                                        MaxLength="200"
                                        placeholder="e.g., Trauma Management"></asp:TextBox>

                                    <asp:RequiredFieldValidator ID="rfvModuleTitle" runat="server"
                                        ControlToValidate="txtModuleTitle"
                                        CssClass="validator-custom"
                                        Display="Dynamic"
                                        ErrorMessage="Module title is required."></asp:RequiredFieldValidator>
                                </div>

                                <div class="field-group">
                                    <asp:Label ID="lblModuleDescription" runat="server"
                                        AssociatedControlID="txtModuleDescription"
                                        CssClass="field-label">
                                        <span>Description (Multiline)</span>
                                    </asp:Label>

                                    <asp:TextBox ID="txtModuleDescription" runat="server"
                                        CssClass="module-textarea"
                                        TextMode="MultiLine"
                                        Rows="12"
                                        placeholder="Write the module description here..."></asp:TextBox>
                                </div>
                            </div>

                            <div class="notes-panel">
                                <div class="notes-title">Instructor Internal Notes</div>
                                <p class="notes-text">
                                    Ensure that all video materials are updated to reflect the 2024 International Trauma Life Support (ITLS) guidelines.
                                    The final quiz must include at least 15 case-study questions based on recent clinical trials.
                                </p>
                            </div>

                        </section>

                        <!-- Right Column -->
                        <aside class="right-column">

                            <div class="panel">
                                <div class="panel-title">Module Settings</div>

                                <div class="field-group">
                                    <asp:Label ID="lblDifficulty" runat="server"
                                        AssociatedControlID="ddlDifficulty"
                                        CssClass="field-label">
                                        <span>Difficulty Level</span>
                                        <span class="required-text">* Required</span>
                                    </asp:Label>

                                    <asp:DropDownList ID="ddlDifficulty" runat="server" CssClass="module-select">
                                        <asp:ListItem Value="">Select Difficulty</asp:ListItem>
                                        <asp:ListItem Value="Beginner">Beginner</asp:ListItem>
                                        <asp:ListItem Value="Intermediate">Intermediate</asp:ListItem>
                                        <asp:ListItem Value="Advanced">Advanced</asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="rfvDifficulty" runat="server"
                                        ControlToValidate="ddlDifficulty"
                                        InitialValue=""
                                        CssClass="validator-custom"
                                        Display="Dynamic"
                                        ErrorMessage="Difficulty is required."></asp:RequiredFieldValidator>
                                </div>

                                <div class="field-group">
                                    <asp:Label ID="lblModuleStatusLabel" runat="server"
                                        AssociatedControlID="ddlModuleStatus"
                                        CssClass="field-label">
                                        <span>Module Status</span>
                                    </asp:Label>

                                    <asp:DropDownList ID="ddlModuleStatus" runat="server" CssClass="module-select">
                                        <asp:ListItem Value="Draft">Draft</asp:ListItem>
                                        <asp:ListItem Value="Submit for Review">Submit for Review</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <div class="field-group">
                                    <asp:Label ID="lblCoverImage" runat="server"
                                        AssociatedControlID="fuCoverImage"
                                        CssClass="field-label">
                                        <span>Cover Image</span>
                                    </asp:Label>

                                    <div class="cover-upload">
                                        <asp:FileUpload ID="fuCoverImage" runat="server"
                                            CssClass="cover-file"
                                            onchange="previewCoverImage(this)" />

                                        <div class="cover-box">
                                            <div id="coverPreviewPlaceholderBg" class="cover-placeholder-bg"></div>

                                            <asp:Image ID="imgCoverPreview" runat="server"
                                                CssClass="cover-preview-img"
                                                AlternateText="Module Preview" />

                                            <div id="coverPreviewOverlay" class="cover-placeholder-bg" style="display:none;"></div>

                                            <div id="coverPreviewPlaceholder" class="cover-content">
                                                <span class="material-symbols-outlined">cloud_upload</span>
                                                <strong>Change Cover Image</strong>
                                                <small>16:9 aspect ratio recommended</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="quick-actions">
                                    <asp:Button ID="btnSaveAndAddLesson" runat="server"
                                        Text="Save & Add Lesson"
                                        CssClass="btn btn-add-lesson-custom"
                                        OnClick="btnSaveAndAddLesson_Click" />

                                    <button type="button" class="btn btn-export-custom">
                                        Export Draft (PDF)
                                    </button>
                                </div>
                            </div>

                            <div class="ai-card">
                                <div class="ai-head">
                                    <span class="material-symbols-outlined" style="font-variation-settings:'FILL' 1;">auto_awesome</span>
                                    <h3 class="ai-title">AI Audit Ready</h3>
                                </div>

                                <p class="ai-text">
                                    Module content matches current medical standards. 98% compliance score against the latest clinical protocols.
                                </p>

                                <div class="ai-progress">
                                    <div class="ai-progress-bar"></div>
                                </div>
                            </div>

                        </aside>

                    </div>
                </div>
            </main>
        </div>
    </div>

    <script type="text/javascript">
        function previewCoverImage(input) {
            var file = input.files && input.files[0];
            var preview = document.getElementById('<%= imgCoverPreview.ClientID %>');
            var placeholder = document.getElementById('coverPreviewPlaceholder');
            var placeholderBg = document.getElementById('coverPreviewPlaceholderBg');
            var overlay = document.getElementById('coverPreviewOverlay');

            if (!file || !file.type || file.type.indexOf('image/') !== 0) {
                if (preview) {
                    preview.src = '';
                    preview.style.display = 'none';
                }

                if (placeholder) {
                    placeholder.style.display = '';
                }

                if (placeholderBg) {
                    placeholderBg.style.display = '';
                }

                if (overlay) {
                    overlay.style.display = 'none';
                }

                return;
            }

            var url = URL.createObjectURL(file);

            if (preview) {
                preview.src = url;
                preview.style.display = 'block';
                preview.onload = function () {
                    URL.revokeObjectURL(url);
                };
            }

            if (placeholder) {
                placeholder.style.display = 'none';
            }

            if (placeholderBg) {
                placeholderBg.style.display = 'none';
            }

            if (overlay) {
                overlay.style.display = 'none';
            }
        }
    </script>

</asp:Content>