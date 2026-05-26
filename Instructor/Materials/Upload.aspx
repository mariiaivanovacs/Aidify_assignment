<%@ Page Title="Upload Learning Material" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="Aidify_assigment.Instructor.Materials.Upload" %>

<asp:Content ID="MaterialsUploadContent" ContentPlaceHolderID="MainContent" runat="server">

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

        .topbar-search input:focus {
            border-color: #b70011;
            box-shadow: 0 0 0 4px rgba(183, 0, 17, 0.09);
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

        .profile-chip:hover {
            background: #fff0ee;
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

        .btn-primary-red:hover {
            filter: brightness(1.06);
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

        .summary-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }

        .summary-card {
            background: #ffffff;
            border: 1px solid #e6bdb8;
            border-radius: 10px;
            padding: 18px;
            box-shadow: 0 4px 14px rgba(40, 23, 21, 0.06);
            min-height: 118px;
        }

        .summary-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 14px;
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
        }

        .summary-icon.green {
            background: #dcfce7;
            color: #15803d;
        }

        .summary-icon.yellow {
            background: #fef3c7;
            color: #a16207;
        }

        .summary-icon.teal {
            background: #ccfbf1;
            color: #0f766e;
        }

        .summary-label {
            color: #5c403c;
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            margin-bottom: 5px;
        }

        .summary-value {
            color: #281715;
            font-size: 28px;
            line-height: 1;
            font-weight: 800;
            margin: 0;
        }

        .summary-tag {
            color: #b70011;
            background: rgba(183, 0, 17, 0.06);
            font-size: 11px;
            font-weight: 800;
            padding: 4px 8px;
            border-radius: 6px;
        }

        .materials-layout {
            display: grid;
            grid-template-columns: minmax(360px, 0.8fr) minmax(520px, 1.2fr);
            gap: 22px;
            align-items: start;
        }

        .panel-card {
            background: #ffffff;
            border: 1px solid #e6bdb8;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(40, 23, 21, 0.06);
            overflow: hidden;
        }

        .panel-body {
            padding: 20px;
        }

        .panel-title {
            color: #281715;
            font-size: 20px;
            font-weight: 800;
            margin: 0 0 16px;
        }

        .panel-header {
            padding: 18px 20px;
            border-bottom: 1px solid #e6bdb8;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            background: #fff8f7;
        }

        .panel-header h3 {
            color: #281715;
            font-size: 20px;
            font-weight: 800;
            margin: 0;
        }

        .items-count-badge {
            background: #ffe9e6;
            color: #b70011;
            border-radius: 999px;
            padding: 6px 10px;
            font-size: 11px;
            font-weight: 800;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-label {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            color: #5c403c;
            font-size: 12px;
            font-weight: 800;
            margin-bottom: 7px;
        }

        .required {
            color: #b70011;
            font-size: 10px;
            letter-spacing: 0.08em;
        }

        .form-input,
        .form-select {
            width: 100%;
            border: 1px solid #e6bdb8;
            background: #fff8f7;
            border-radius: 8px;
            color: #281715;
            font-size: 13px;
            outline: none;
            padding: 11px 12px;
            box-sizing: border-box;
        }

        .form-input:focus,
        .form-select:focus {
            border-color: #b70011;
            box-shadow: 0 0 0 4px rgba(183, 0, 17, 0.08);
        }

        .upload-box {
            border: 1.5px dashed #e6bdb8;
            background: #fff8f7;
            border-radius: 12px;
            padding: 32px 20px;
            text-align: center;
            transition: 0.2s ease;
        }

        .upload-box.dragging {
            border-color: #b70011;
            background: #fff0ee;
        }

        .upload-icon {
            width: 56px;
            height: 56px;
            margin: 0 auto 14px;
            border-radius: 999px;
            background: #ffe9e6;
            color: #b70011;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .upload-icon .material-symbols-outlined {
            font-size: 30px;
        }

        .upload-title {
            color: #281715;
            font-size: 20px;
            font-weight: 800;
            margin: 0 0 6px;
        }

        .upload-subtitle {
            color: #5c403c;
            font-size: 13px;
            margin: 0 0 14px;
        }

        .selected-file {
            min-height: 24px;
            color: #b70011;
            font-size: 12px;
            font-weight: 800;
            margin-bottom: 14px;
        }

        .upload-actions {
            display: flex;
            justify-content: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .materials-toolbar {
            padding: 14px 20px;
            border-bottom: 1px solid #e6bdb8;
            display: flex;
            justify-content: space-between;
            gap: 12px;
            align-items: center;
        }

        .materials-search {
            position: relative;
            width: min(320px, 100%);
        }

        .materials-search .material-symbols-outlined {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
            color: #5c403c;
        }

        .materials-search input {
            width: 100%;
            height: 38px;
            border: 1px solid #e6bdb8;
            background: #ffffff;
            border-radius: 8px;
            padding: 0 12px 0 38px;
            outline: none;
            font-size: 13px;
            color: #281715;
        }

        .materials-list {
            display: grid;
            gap: 0;
        }

        .material-item {
            display: grid;
            grid-template-columns: 44px minmax(0, 1fr) auto;
            gap: 12px;
            align-items: center;
            padding: 16px 20px;
            border-bottom: 1px solid #e6bdb8;
            background: #ffffff;
        }

        .material-item.hidden {
            display: none;
        }

        .file-icon {
            width: 40px;
            height: 40px;
            border-radius: 9px;
            background: #ffe9e6;
            color: #b70011;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .file-icon.teal {
            background: #ccfbf1;
            color: #0f766e;
        }

        .file-icon.yellow {
            background: #fef3c7;
            color: #a16207;
        }

        .file-icon.gray {
            background: #f3f4f6;
            color: #374151;
        }

        .file-name {
            color: #281715;
            font-size: 14px;
            font-weight: 800;
            margin-bottom: 5px;
            word-break: break-word;
        }

        .file-meta {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            align-items: center;
            color: #5c403c;
            font-size: 12px;
            font-weight: 700;
        }

        .badge {
            border-radius: 6px;
            padding: 4px 7px;
            font-size: 10px;
            font-weight: 800;
            text-transform: uppercase;
            line-height: 1;
            display: inline-flex;
            align-items: center;
        }

        .badge-pdf {
            background: #ffdad6;
            color: #b70011;
        }

        .badge-video {
            background: #ccfbf1;
            color: #0f766e;
        }

        .badge-image {
            background: #fef3c7;
            color: #a16207;
        }

        .badge-docx {
            background: #f3f4f6;
            color: #374151;
        }

        .badge-published {
            background: #dcfce7;
            color: #15803d;
        }

        .badge-draft {
            background: #f3f4f6;
            color: #374151;
        }

        .badge-private {
            background: #fef3c7;
            color: #a16207;
        }

        .material-actions {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .icon-btn {
            width: 34px;
            height: 34px;
            border: 1px solid #e6bdb8;
            background: #ffffff;
            color: #281715;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }

        .icon-btn:hover {
            background: #fff0ee;
            color: #b70011;
        }

        .icon-btn.delete:hover {
            background: #ffdad6;
            color: #ba1a1a;
        }

        .load-more-wrap {
            padding: 16px 20px;
            background: #fff8f7;
            display: flex;
            justify-content: center;
        }

        .guidelines-card {
            margin-top: 18px;
            background: #ffffff;
            border: 1px solid #e6bdb8;
            border-radius: 12px;
            padding: 18px;
            box-shadow: 0 4px 14px rgba(40, 23, 21, 0.06);
        }

        .guidelines-card h3 {
            color: #281715;
            font-size: 17px;
            font-weight: 800;
            margin: 0 0 10px;
        }

        .guidelines-card p {
            color: #5c403c;
            font-size: 13px;
            margin: 5px 0;
            line-height: 1.5;
        }

        .empty-state {
            display: none;
            padding: 28px 20px;
            text-align: center;
            color: #5c403c;
            font-size: 13px;
            font-weight: 700;
        }

        .empty-state.visible {
            display: block;
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
            .summary-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .materials-layout {
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

            .summary-grid {
                grid-template-columns: 1fr;
            }

            .material-item {
                grid-template-columns: 40px minmax(0, 1fr);
            }

            .material-actions {
                grid-column: 1 / -1;
                justify-content: flex-end;
            }
        }
    </style>

    <div class="aidify-page">

            <!-- Sidebar -->
            <aside class="materials-sidebar">
                <div class="instructor-block">
                    <div class="instructor-name">Dr. Sarah Mitchell</div>
                    <div class="instructor-role">Lead Medical Instructor</div>
                    <div class="verified-text">Verified Educator</div>
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

                <a class="active" href="/Instructor/Materials/Upload.aspx">
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
                <input id="globalSearch" type="text" placeholder="Search materials, modules, or lessons..." />
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

                <section class="page-header">
                    <div>
                        <h2 class="page-title">Upload Learning Material</h2>
                        <p class="page-subtitle">Add educational resources to your active curriculum modules.</p>
                    </div>

                    <button type="button" class="btn-primary-red" onclick="scrollToUpload()">
                        <span class="material-symbols-outlined">cloud_upload</span>
                        New Upload
                    </button>
                </section>

                <section class="summary-grid">
                    <div class="summary-card">
                        <div class="summary-top">
                            <div class="summary-icon">
                                <span class="material-symbols-outlined">folder</span>
                            </div>
                            <span class="summary-tag">Live</span>
                        </div>
                        <div class="summary-label">Total Materials</div>
                        <p class="summary-value" id="totalMaterialsValue">5</p>
                    </div>

                    <div class="summary-card">
                        <div class="summary-top">
                            <div class="summary-icon">
                                <span class="material-symbols-outlined">picture_as_pdf</span>
                            </div>
                        </div>
                        <div class="summary-label">PDF Resources</div>
                        <p class="summary-value" id="pdfValue">2</p>
                    </div>

                    <div class="summary-card">
                        <div class="summary-top">
                            <div class="summary-icon teal">
                                <span class="material-symbols-outlined">play_circle</span>
                            </div>
                        </div>
                        <div class="summary-label">Video Lessons</div>
                        <p class="summary-value" id="videoValue">1</p>
                    </div>

                    <div class="summary-card">
                        <div class="summary-top">
                            <div class="summary-icon yellow">
                                <span class="material-symbols-outlined">image</span>
                            </div>
                        </div>
                        <div class="summary-label">Image Charts</div>
                        <p class="summary-value" id="imageValue">1</p>
                    </div>
                </section>

                <section class="materials-layout">

                    <div>
                        <div class="panel-card">
                            <div class="panel-body">
                                <h3 class="panel-title">Material Details</h3>

                                <div class="form-group">
                                    <label class="form-label">
                                        Select Module
                                        <span class="required">* REQUIRED</span>
                                    </label>
                                    <select id="moduleSelect" class="form-select">
                                        <option value="">Select a module</option>
                                        <option>CPR Fundamentals</option>
                                        <option>Choking & Airway Emergencies</option>
                                        <option>Trauma Response</option>
                                        <option>Burn Treatment Basics</option>
                                        <option>Emergency Wound Care</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Select Lesson</label>
                                    <select id="lessonSelect" class="form-select">
                                        <option>Module-level</option>
                                        <option>Lesson 1: Intro</option>
                                        <option>Lesson 2: Practice Steps</option>
                                        <option>Lesson 3: Assessment</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">
                                        Resource Title
                                        <span class="required">* REQUIRED</span>
                                    </label>
                                    <input id="resourceTitleInput" class="form-input" type="text" placeholder="e.g., Quick Reference Guide - CPR" />
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Material Type</label>
                                    <select id="materialTypeSelect" class="form-select">
                                        <option>PDF</option>
                                        <option>Video</option>
                                        <option>Image</option>
                                        <option>DOCX</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Visibility</label>
                                    <select id="visibilitySelect" class="form-select">
                                        <option>Published</option>
                                        <option>Draft</option>
                                        <option>Instructor Only</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="panel-card" id="uploadPanel" style="margin-top:18px;">
                            <div class="panel-body">
                                <h3 class="panel-title">Upload File</h3>

                                <div id="uploadBox" class="upload-box">
                                    <div class="upload-icon">
                                        <span class="material-symbols-outlined">cloud_upload</span>
                                    </div>

                                    <h3 class="upload-title">Drag and drop file here</h3>
                                    <p class="upload-subtitle">Support for PDF, MP4, JPG, PNG, or DOCX files up to 50MB</p>

                                    <div id="selectedFileText" class="selected-file">No file selected</div>

                                    <input id="fakeFileInput" type="file" style="display:none;" accept=".pdf,.mp4,.jpg,.jpeg,.png,.docx" />

                                    <div class="upload-actions">
                                        <button type="button" class="btn-outline-red" onclick="chooseFile()">
                                            <span class="material-symbols-outlined">attach_file</span>
                                            Choose File
                                        </button>

                                        <button type="button" class="btn-primary-red" onclick="uploadMaterial()">
                                            <span class="material-symbols-outlined">upload</span>
                                            Upload Material
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="panel-card">
                            <div class="panel-header">
                                <h3>Recently Uploaded</h3>
                                <span class="items-count-badge" id="itemsCountBadge">5 Items Total</span>
                            </div>

                            <div class="materials-toolbar">
                                <div class="materials-search">
                                    <span class="material-symbols-outlined">search</span>
                                    <input id="materialsSearchInput" type="text" placeholder="Search uploaded files..." />
                                </div>

                                <button type="button" class="btn-muted" onclick="clearMaterialSearch()">
                                    <span class="material-symbols-outlined">filter_alt_off</span>
                                    Clear
                                </button>
                            </div>

                            <div class="materials-list" id="materialsList">

                                <article class="material-item" data-name="starter_guide.pdf" data-type="PDF" data-status="Published">
                                    <div class="file-icon">
                                        <span class="material-symbols-outlined">picture_as_pdf</span>
                                    </div>
                                    <div>
                                        <div class="file-name">Starter_Guide.pdf</div>
                                        <div class="file-meta">
                                            <span class="badge badge-pdf">PDF</span>
                                            <span>Foundations of Health</span>
                                            <span class="badge badge-published">Published</span>
                                        </div>
                                    </div>
                                    <div class="material-actions">
                                        <button type="button" class="icon-btn" onclick="previewMaterial(this)">
                                            <span class="material-symbols-outlined">visibility</span>
                                        </button>
                                        <button type="button" class="icon-btn delete" onclick="deleteMaterial(this)">
                                            <span class="material-symbols-outlined">delete</span>
                                        </button>
                                    </div>
                                </article>

                                <article class="material-item" data-name="lesson_worksheet.docx" data-type="DOCX" data-status="Draft">
                                    <div class="file-icon gray">
                                        <span class="material-symbols-outlined">description</span>
                                    </div>
                                    <div>
                                        <div class="file-name">Lesson_Worksheet.docx</div>
                                        <div class="file-meta">
                                            <span class="badge badge-docx">DOCX</span>
                                            <span>CPR Fundamentals</span>
                                            <span class="badge badge-draft">Draft</span>
                                        </div>
                                    </div>
                                    <div class="material-actions">
                                        <button type="button" class="icon-btn" onclick="previewMaterial(this)">
                                            <span class="material-symbols-outlined">visibility</span>
                                        </button>
                                        <button type="button" class="icon-btn delete" onclick="deleteMaterial(this)">
                                            <span class="material-symbols-outlined">delete</span>
                                        </button>
                                    </div>
                                </article>

                                <article class="material-item" data-name="chest_compression_demo.mp4" data-type="Video" data-status="Published">
                                    <div class="file-icon teal">
                                        <span class="material-symbols-outlined">play_circle</span>
                                    </div>
                                    <div>
                                        <div class="file-name">Chest_Compression_Demo.mp4</div>
                                        <div class="file-meta">
                                            <span class="badge badge-video">Video</span>
                                            <span>CPR Fundamentals</span>
                                            <span class="badge badge-published">Published</span>
                                        </div>
                                    </div>
                                    <div class="material-actions">
                                        <button type="button" class="icon-btn" onclick="previewMaterial(this)">
                                            <span class="material-symbols-outlined">visibility</span>
                                        </button>
                                        <button type="button" class="icon-btn delete" onclick="deleteMaterial(this)">
                                            <span class="material-symbols-outlined">delete</span>
                                        </button>
                                    </div>
                                </article>

                                <article class="material-item" data-name="burns_classification_chart.jpg" data-type="Image" data-status="Published">
                                    <div class="file-icon yellow">
                                        <span class="material-symbols-outlined">image</span>
                                    </div>
                                    <div>
                                        <div class="file-name">Burns_Classification_Chart.jpg</div>
                                        <div class="file-meta">
                                            <span class="badge badge-image">Image</span>
                                            <span>Burn Treatment Basics</span>
                                            <span class="badge badge-published">Published</span>
                                        </div>
                                    </div>
                                    <div class="material-actions">
                                        <button type="button" class="icon-btn" onclick="previewMaterial(this)">
                                            <span class="material-symbols-outlined">visibility</span>
                                        </button>
                                        <button type="button" class="icon-btn delete" onclick="deleteMaterial(this)">
                                            <span class="material-symbols-outlined">delete</span>
                                        </button>
                                    </div>
                                </article>

                                <article class="material-item" data-name="emergency_protocols_2026.pdf" data-type="PDF" data-status="Draft">
                                    <div class="file-icon">
                                        <span class="material-symbols-outlined">picture_as_pdf</span>
                                    </div>
                                    <div>
                                        <div class="file-name">Emergency_Protocols_2026.pdf</div>
                                        <div class="file-meta">
                                            <span class="badge badge-pdf">PDF</span>
                                            <span>Trauma Response</span>
                                            <span class="badge badge-draft">Draft</span>
                                        </div>
                                    </div>
                                    <div class="material-actions">
                                        <button type="button" class="icon-btn" onclick="previewMaterial(this)">
                                            <span class="material-symbols-outlined">visibility</span>
                                        </button>
                                        <button type="button" class="icon-btn delete" onclick="deleteMaterial(this)">
                                            <span class="material-symbols-outlined">delete</span>
                                        </button>
                                    </div>
                                </article>

                            </div>

                            <div id="emptyState" class="empty-state">
                                No materials match your search.
                            </div>

                            <div class="load-more-wrap">
                                <button type="button" class="btn-outline-red" onclick="loadMoreMaterials()">
                                    <span class="material-symbols-outlined">expand_more</span>
                                    Load More Materials
                                </button>
                            </div>
                        </div>

                        <div class="guidelines-card">
                            <h3>Upload Guidelines</h3>
                            <p><strong>Accepted formats:</strong> PDF, MP4, JPG, PNG, DOCX</p>
                            <p><strong>Max file size:</strong> 50MB</p>
                            <p><strong>Recommended naming:</strong> ModuleName_LessonName_Type</p>
                        </div>
                    </div>

                </section>

            </div>
        </main>

    </div>

    <div id="toast" class="toast">Action completed.</div>

    <script>
        var selectedFileName = "";
        var extraLoaded = false;

        document.addEventListener("DOMContentLoaded", function () {
            setupMaterialSearch();
            setupUploadBox();
            updateCounts();
        });

        function setupMaterialSearch() {
            var searchInput = document.getElementById("materialsSearchInput");
            var globalSearch = document.getElementById("globalSearch");

            if (searchInput) {
                searchInput.addEventListener("input", filterMaterials);
            }

            if (globalSearch && searchInput) {
                globalSearch.addEventListener("input", function () {
                    searchInput.value = globalSearch.value;
                    filterMaterials();
                });
            }
        }

        function setupUploadBox() {
            var uploadBox = document.getElementById("uploadBox");
            var fileInput = document.getElementById("fakeFileInput");

            if (fileInput) {
                fileInput.addEventListener("change", function () {
                    if (fileInput.files && fileInput.files.length > 0) {
                        selectedFileName = fileInput.files[0].name;
                        document.getElementById("selectedFileText").textContent = selectedFileName;
                        showToast("File selected: " + selectedFileName);
                    }
                });
            }

            if (uploadBox) {
                uploadBox.addEventListener("dragover", function (event) {
                    event.preventDefault();
                    uploadBox.classList.add("dragging");
                });

                uploadBox.addEventListener("dragleave", function () {
                    uploadBox.classList.remove("dragging");
                });

                uploadBox.addEventListener("drop", function (event) {
                    event.preventDefault();
                    uploadBox.classList.remove("dragging");

                    if (event.dataTransfer.files && event.dataTransfer.files.length > 0) {
                        selectedFileName = event.dataTransfer.files[0].name;
                        document.getElementById("selectedFileText").textContent = selectedFileName;
                        showToast("File dropped: " + selectedFileName);
                    }
                });
            }
        }

        function showToast(message) {
            var toast = document.getElementById("toast");
            toast.textContent = message;
            toast.classList.add("show");

            window.clearTimeout(window.__aidifyToastTimer);
            window.__aidifyToastTimer = window.setTimeout(function () {
                toast.classList.remove("show");
            }, 2200);
        }

        function scrollToUpload() {
            document.getElementById("uploadPanel").scrollIntoView({
                behavior: "smooth",
                block: "start"
            });

            showToast("Upload panel opened.");
        }

        function chooseFile() {
            document.getElementById("fakeFileInput").click();
        }

        function uploadMaterial() {
            var moduleSelect = document.getElementById("moduleSelect");
            var titleInput = document.getElementById("resourceTitleInput");
            var typeSelect = document.getElementById("materialTypeSelect");
            var visibilitySelect = document.getElementById("visibilitySelect");

            var moduleName = moduleSelect.value;
            var title = titleInput.value.trim();
            var materialType = typeSelect.value;
            var visibility = visibilitySelect.value;

            if (!moduleName) {
                showToast("Please select a module first.");
                moduleSelect.focus();
                return;
            }

            if (!title) {
                showToast("Resource title is required.");
                titleInput.focus();
                return;
            }

            var fileName = selectedFileName || buildFileName(title, materialType);
            addMaterialItem(fileName, materialType, moduleName, visibility);

            titleInput.value = "";
            selectedFileName = "";
            document.getElementById("selectedFileText").textContent = "No file selected";

            updateCounts();
            filterMaterials();
            showToast("Material uploaded successfully.");
        }

        function buildFileName(title, type) {
            var cleanTitle = title.replace(/[^a-z0-9]+/gi, "_").replace(/^_+|_+$/g, "");
            var extension = ".pdf";

            if (type === "Video") extension = ".mp4";
            if (type === "Image") extension = ".jpg";
            if (type === "DOCX") extension = ".docx";

            return cleanTitle + extension;
        }

        function addMaterialItem(fileName, type, moduleName, status) {
            var list = document.getElementById("materialsList");
            var article = document.createElement("article");

            article.className = "material-item";
            article.setAttribute("data-name", fileName.toLowerCase());
            article.setAttribute("data-type", type);
            article.setAttribute("data-status", status);

            var iconClass = getIconClass(type);
            var iconName = getIconName(type);
            var typeBadge = getTypeBadgeClass(type);
            var statusBadge = getStatusBadgeClass(status);

            article.innerHTML =
                '<div class="file-icon ' + iconClass + '">' +
                    '<span class="material-symbols-outlined">' + iconName + '</span>' +
                '</div>' +
                '<div>' +
                    '<div class="file-name">' + escapeHtml(fileName) + '</div>' +
                    '<div class="file-meta">' +
                        '<span class="badge ' + typeBadge + '">' + escapeHtml(type) + '</span>' +
                        '<span>' + escapeHtml(moduleName) + '</span>' +
                        '<span class="badge ' + statusBadge + '">' + escapeHtml(status) + '</span>' +
                    '</div>' +
                '</div>' +
                '<div class="material-actions">' +
                    '<button type="button" class="icon-btn" onclick="previewMaterial(this)">' +
                        '<span class="material-symbols-outlined">visibility</span>' +
                    '</button>' +
                    '<button type="button" class="icon-btn delete" onclick="deleteMaterial(this)">' +
                        '<span class="material-symbols-outlined">delete</span>' +
                    '</button>' +
                '</div>';

            list.prepend(article);
        }

        function previewMaterial(button) {
            var item = button.closest(".material-item");
            var fileName = item.querySelector(".file-name").textContent;
            var type = item.getAttribute("data-type");
            var status = item.getAttribute("data-status");

            alert(
                "Material Preview\n\n" +
                "File: " + fileName + "\n" +
                "Type: " + type + "\n" +
                "Status: " + status + "\n\n" +
                "This is a UI-only preview."
            );
        }

        function deleteMaterial(button) {
            var item = button.closest(".material-item");
            var fileName = item.querySelector(".file-name").textContent;

            var confirmed = confirm("Delete this material?\n\n" + fileName);

            if (!confirmed) {
                return;
            }

            item.remove();
            updateCounts();
            filterMaterials();
            showToast("Material deleted.");
        }

        function loadMoreMaterials() {
            if (extraLoaded) {
                showToast("All sample materials are already loaded.");
                return;
            }

            addMaterialItem("Pediatric_First_Aid_Checklist.pdf", "PDF", "Emergency Wound Care", "Published");
            addMaterialItem("Trauma_Response_Scenario.mp4", "Video", "Trauma Response", "Draft");

            extraLoaded = true;
            updateCounts();
            filterMaterials();
            showToast("2 more materials loaded.");
        }

        function filterMaterials() {
            var query = document.getElementById("materialsSearchInput").value.toLowerCase().trim();
            var items = document.querySelectorAll(".material-item");
            var visibleCount = 0;

            items.forEach(function (item) {
                var name = item.getAttribute("data-name") || "";

                if (!query || name.indexOf(query) !== -1) {
                    item.classList.remove("hidden");
                    visibleCount++;
                } else {
                    item.classList.add("hidden");
                }
            });

            var emptyState = document.getElementById("emptyState");

            if (visibleCount === 0) {
                emptyState.classList.add("visible");
            } else {
                emptyState.classList.remove("visible");
            }
        }

        function clearMaterialSearch() {
            document.getElementById("materialsSearchInput").value = "";
            document.getElementById("globalSearch").value = "";
            filterMaterials();
            showToast("Search cleared.");
        }

        function updateCounts() {
            var items = document.querySelectorAll(".material-item");
            var total = items.length;
            var pdf = 0;
            var video = 0;
            var image = 0;

            items.forEach(function (item) {
                var type = item.getAttribute("data-type");

                if (type === "PDF") pdf++;
                if (type === "Video") video++;
                if (type === "Image") image++;
            });

            document.getElementById("totalMaterialsValue").textContent = total;
            document.getElementById("pdfValue").textContent = pdf;
            document.getElementById("videoValue").textContent = video;
            document.getElementById("imageValue").textContent = image;
            document.getElementById("itemsCountBadge").textContent = total + " Items Total";
        }

        function getIconClass(type) {
            if (type === "Video") return "teal";
            if (type === "Image") return "yellow";
            if (type === "DOCX") return "gray";
            return "";
        }

        function getIconName(type) {
            if (type === "Video") return "play_circle";
            if (type === "Image") return "image";
            if (type === "DOCX") return "description";
            return "picture_as_pdf";
        }

        function getTypeBadgeClass(type) {
            if (type === "Video") return "badge-video";
            if (type === "Image") return "badge-image";
            if (type === "DOCX") return "badge-docx";
            return "badge-pdf";
        }

        function getStatusBadgeClass(status) {
            if (status === "Published") return "badge-published";
            if (status === "Instructor Only") return "badge-private";
            return "badge-draft";
        }

        function openNotifications() {
            alert(
                "Notifications\n\n" +
                "• 2 new materials uploaded this week.\n" +
                "• 1 draft material still needs review.\n" +
                "• CPR module resources were recently updated."
            );
        }

        function openHelp() {
            alert(
                "Aidify Materials Help\n\n" +
                "Choose File: selects a local file.\n" +
                "Upload Material: adds it to the uploaded list.\n" +
                "Preview: shows material information.\n" +
                "Delete: removes material from the list.\n" +
                "Load More: adds more sample resources."
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
            return String(value)
                .replace(/&/g, "&amp;")
                .replace(/</g, "&lt;")
                .replace(/>/g, "&gt;")
                .replace(/"/g, "&quot;")
                .replace(/'/g, "&#039;");
        }
    </script>

</asp:Content>