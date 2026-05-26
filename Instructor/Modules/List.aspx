<%@ Page Title="My Modules" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Aidify_assigment.Instructor.Modules.List" %>

<asp:Content ID="ModulesListContent" ContentPlaceHolderID="MainContent" runat="server">

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
        padding: 24px 12px;
        display: flex;
        flex-direction: column;
        z-index: 20;
        box-sizing: border-box;
    }

    .aidify-brand {
        padding: 0 12px 34px;
    }

    .aidify-brand h1 {
        margin: 0;
        color: #b70011;
        font-size: 21px;
        font-weight: 800;
        line-height: 1.1;
    }

    .aidify-brand p {
        margin: 5px 0 0;
        color: #5c403c;
        font-size: 11px;
    }

    .aidify-nav {
        display: flex;
        flex-direction: column;
        gap: 8px;
        flex: 1;
    }

    .aidify-nav a,
    .aidify-sidebar-bottom a {
        min-height: 44px;
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 11px 14px;
        border-radius: 10px;
        color: #5c403c;
        text-decoration: none !important;
        font-size: 13px;
        font-weight: 700;
        transition: .2s ease;
        box-sizing: border-box;
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
        height: 60px;
        background: rgba(255, 248, 247, .95);
        border-bottom: 1px solid #e6bdb8;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 34px;
        z-index: 15;
        box-sizing: border-box;
    }

    .topbar-search {
        position: relative;
        width: 360px;
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
        height: 40px;
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
        margin-top: 60px;
        padding: 34px 42px;
        min-height: calc(100vh - 60px);
        background: #fff8f7;
        box-sizing: border-box;
    }

    .page-container {
        max-width: 1280px;
        margin: 0 auto;
    }

    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 24px;
        margin-bottom: 26px;
    }

    .page-title {
        font-size: 32px;
        line-height: 1.1;
        font-weight: 800;
        letter-spacing: -.035em;
        margin: 0 0 8px;
        color: #281715;
    }

    .page-subtitle {
        color: #5c403c;
        font-size: 14px;
        margin: 0;
        line-height: 1.5;
    }

    .header-actions,
    .button-row {
        display: flex;
        align-items: center;
        gap: 12px;
        flex-wrap: wrap;
    }

    .btn-primary-red,
    .btn-outline-red,
    .btn-muted,
    .btn-white {
        min-height: 46px;
        border-radius: 10px;
        padding: 0 18px;
        font-size: 13px;
        font-weight: 800;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        text-decoration: none !important;
        cursor: pointer;
        white-space: nowrap;
        box-sizing: border-box;
    }

    .btn-primary-red {
        background: #b70011;
        color: #fff !important;
        border: 1px solid #b70011;
        box-shadow: 0 10px 22px rgba(183, 0, 17, .18);
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

    .btn-white {
        background: #fff;
        color: #b70011 !important;
        border: 0;
    }

    .summary-grid {
        display: grid;
        grid-template-columns: repeat(4, minmax(0, 1fr));
        gap: 18px;
        margin-bottom: 28px;
    }

    .summary-card,
    .filters-card,
    .module-card,
    .editor-panel {
        background: #fff;
        border: 1px solid #e6bdb8;
        border-radius: 14px;
        box-shadow: 0 4px 14px rgba(40, 23, 21, .06);
    }

    .summary-card {
        min-height: 120px;
        padding: 20px;
        box-sizing: border-box;
    }

    .summary-icon {
        width: 38px;
        height: 38px;
        border-radius: 10px;
        background: #ffe9e6;
        color: #b70011;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 16px;
    }

    .summary-label {
        color: #5c403c;
        font-size: 11px;
        font-weight: 800;
        text-transform: uppercase;
        letter-spacing: .05em;
        margin-bottom: 5px;
    }

    .summary-value {
        color: #281715;
        font-size: 30px;
        line-height: 1;
        font-weight: 800;
        margin: 0;
    }

    .filters-card {
        padding: 18px;
        margin-bottom: 26px;
    }

    .filter-row {
        display: grid;
        grid-template-columns: auto minmax(280px, 1fr) auto;
        gap: 16px;
        align-items: center;
    }

    .filter-tabs {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
    }

    .filter-tabs button {
        height: 36px;
        padding: 0 14px;
        border: 1px solid #e6bdb8;
        background: #fff;
        color: #5c403c;
        border-radius: 999px;
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

    .filter-search input {
        width: 100%;
        height: 42px;
        border: 1px solid #e6bdb8;
        background: #fff8f7;
        border-radius: 10px;
        color: #281715;
        font-size: 13px;
        outline: none;
        padding: 0 12px 0 38px;
        box-sizing: border-box;
    }

    .module-grid {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 24px;
        align-items: stretch;
    }

    .module-card {
        overflow: hidden;
        min-height: 430px;
        display: flex;
        flex-direction: column;
        transition: .22s ease;
    }

    .module-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 14px 28px rgba(40, 23, 21, .10);
    }

    .module-cover {
        height: 165px;
        position: relative;
        overflow: hidden;
        background: #ffe9e6;
    }

    .module-cover img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        opacity: .92;
        transition: .45s ease;
    }

    .module-card:hover .module-cover img {
        transform: scale(1.05);
    }

    .badge-row {
        position: absolute;
        top: 12px;
        left: 12px;
        display: flex;
        gap: 7px;
        flex-wrap: wrap;
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

    .module-body {
        padding: 20px;
        display: flex;
        flex-direction: column;
        flex: 1;
    }

    .module-title {
        color: #281715;
        font-size: 18px;
        line-height: 1.3;
        font-weight: 800;
        margin: 0 0 10px;
    }

    .module-desc {
        color: #5c403c;
        font-size: 13px;
        line-height: 1.5;
        margin: 0 0 16px;
        min-height: 40px;
    }

    .module-meta {
        display: flex;
        align-items: center;
        gap: 14px;
        color: #5c403c;
        font-size: 12px;
        font-weight: 700;
        flex-wrap: wrap;
        margin-bottom: 16px;
    }

    .module-meta span {
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }

    .module-meta .material-symbols-outlined {
        color: #b70011;
        font-size: 17px;
    }

    .module-actions {
        margin-top: auto;
        border-top: 1px solid #e6bdb8;
        padding-top: 14px;
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 9px;
    }

    .module-action {
        min-height: 38px;
        border-radius: 9px;
        border: 1px solid #e6bdb8;
        background: #fff;
        color: #281715 !important;
        font-size: 12px;
        font-weight: 800;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 5px;
        cursor: pointer;
        text-decoration: none !important;
    }

    .module-action:hover {
        background: #fff0ee;
        color: #b70011 !important;
    }

    .module-action .material-symbols-outlined {
        font-size: 17px;
    }

    .module-editor {
        display: none;
        margin-top: 34px;
        scroll-margin-top: 90px;
    }

    .module-editor.visible {
        display: block;
    }

    .editor-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        gap: 18px;
        margin-bottom: 18px;
    }

    .editor-layout {
        display: grid;
        grid-template-columns: minmax(0, 2fr) minmax(330px, 1fr);
        gap: 22px;
        align-items: start;
    }

    .editor-panel {
        padding: 22px;
    }

    .editor-panel + .editor-panel {
        margin-top: 18px;
    }

    .section-kicker {
        color: #b70011;
        font-size: 11px;
        font-weight: 800;
        letter-spacing: .12em;
        text-transform: uppercase;
        margin-bottom: 16px;
    }

    .form-group {
        margin-bottom: 16px;
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
        letter-spacing: .08em;
    }

    .form-input,
    .form-select,
    .form-textarea {
        width: 100%;
        border: 1px solid #e6bdb8;
        background: #fff8f7;
        border-radius: 10px;
        color: #281715;
        font-size: 13px;
        outline: none;
        padding: 11px 12px;
        box-sizing: border-box;
    }

    .form-textarea {
        min-height: 150px;
        resize: vertical;
        line-height: 1.5;
    }

    .small-textarea {
        min-height: 115px;
    }

    .cover-preview {
        height: 145px;
        border-radius: 12px;
        overflow: hidden;
        border: 1px solid #e6bdb8;
        background: #fff0ee;
        margin-bottom: 14px;
    }

    .cover-preview img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .side-actions {
        display: grid;
        gap: 10px;
    }

    .side-actions button {
        width: 100%;
    }

    .lesson-panel {
        display: none;
    }

    .lesson-panel.visible {
        display: block;
    }

    .lesson-row {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 14px;
    }

    .ai-panel {
        background: #b70011;
        color: #fff;
        border-color: #b70011;
    }

    .ai-panel h3 {
        margin: 0 0 8px;
        font-size: 18px;
        font-weight: 800;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .ai-panel p {
        color: rgba(255,255,255,.88);
        font-size: 13px;
        line-height: 1.5;
        margin: 0 0 14px;
    }

    .ai-result {
        display: none;
        margin-top: 14px;
        background: rgba(255,255,255,.12);
        border: 1px solid rgba(255,255,255,.25);
        border-radius: 10px;
        padding: 12px;
        font-size: 13px;
        line-height: 1.5;
    }

    .ai-result.visible {
        display: block;
    }

    .pagination-row {
        margin-top: 36px;
        padding-top: 20px;
        border-top: 1px solid #e6bdb8;
        display: flex;
        justify-content: space-between;
        align-items: center;
        color: #5c403c;
        font-size: 13px;
        font-weight: 700;
    }

    .pagination {
        display: flex;
        gap: 8px;
        align-items: center;
    }

    .page-btn {
        width: 38px;
        height: 38px;
        border: 1px solid #e6bdb8;
        background: #fff;
        color: #281715;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 800;
        cursor: pointer;
    }

    .page-btn.active {
        background: #b70011;
        border-color: #b70011;
        color: #fff;
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

    @media (max-width: 1200px) {
        .summary-grid,
        .module-grid {
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }

        .filter-row,
        .editor-layout {
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

        .aidify-sidebar-bottom {
            display: none;
        }

        .aidify-topbar {
            position: relative;
            left: 0;
            height: auto;
            padding: 14px 16px;
            flex-direction: column;
            align-items: stretch;
            gap: 12px;
        }

        .topbar-search {
            width: 100%;
        }

        .aidify-main {
            margin-left: 0;
            margin-top: 0;
            padding: 22px 16px;
        }

        .page-header,
        .pagination-row,
        .editor-header {
            flex-direction: column;
            align-items: flex-start;
        }

        .summary-grid,
        .module-grid,
        .lesson-row {
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
            <a class="active" href="/Instructor/Modules/List.aspx"><span class="material-symbols-outlined">school</span>Modules</a>
            <a href="/Instructor/Materials/Upload.aspx"><span class="material-symbols-outlined">description</span>Materials</a>
            <a href="/Instructor/Quizzes/List.aspx"><span class="material-symbols-outlined">quiz</span>Quizzes</a>
            <a href="/Instructor/Performance.aspx"><span class="material-symbols-outlined">trending_up</span>Performance</a>
            <a href="/Instructor/Discussions.aspx"><span class="material-symbols-outlined">forum</span>Discussions</a>
            <a href="/Instructor/Challenges.aspx"><span class="material-symbols-outlined">military_tech</span>Challenges</a>
            <a href="/Instructor/Events.aspx"><span class="material-symbols-outlined">calendar_today</span>Events</a>
        </nav>

        <div class="aidify-sidebar-bottom">
            <a href="#" onclick="openSettings(); return false;"><span class="material-symbols-outlined">settings</span>Settings</a>
            <a href="#" style="color:#ba1a1a;" onclick="logoutPreview(); return false;"><span class="material-symbols-outlined">logout</span>Logout</a>
        </div>
    </aside>

    <header class="aidify-topbar">
        <div class="topbar-search">
            <span class="material-symbols-outlined">search</span>
            <input id="globalSearch" type="text" placeholder="Search modules, content, or learners..." />
        </div>

        <div class="topbar-actions">
            <button type="button" class="topbar-icon" onclick="openNotifications()">
                <span class="material-symbols-outlined">notifications</span>
            </button>

            <button type="button" class="topbar-icon" onclick="openHelp()">
                <span class="material-symbols-outlined">help_outline</span>
            </button>

            <a href="#" class="profile-chip" onclick="openProfile(); return false;">
                <img alt="Instructor" src="https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=200&q=80" />
                <span>Dr. Sarah Mitchell</span>
            </a>
        </div>
    </header>

    <main class="aidify-main">
        <div class="page-container">

            <section class="page-header">
                <div>
                    <h2 class="page-title">My Modules</h2>
                    <p class="page-subtitle">Manage clinical training modules, lessons, review status, and learner enrollment.</p>
                </div>

                <div class="header-actions">
                    <button type="button" class="btn-primary-red" onclick="openCreateModule(); return false;">
                        <span class="material-symbols-outlined">add</span>
                        Create Module
                    </button>

                    <button type="button" class="btn-outline-red" onclick="exportModuleReport(); return false;">
                        <span class="material-symbols-outlined">ios_share</span>
                        Export Report
                    </button>
                </div>
            </section>

            <section class="summary-grid">
                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">inventory_2</span></div>
                    <div class="summary-label">Total Modules</div>
                    <p class="summary-value" id="totalModulesValue">0</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">check_circle</span></div>
                    <div class="summary-label">Published</div>
                    <p class="summary-value" id="publishedValue">0</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">pending_actions</span></div>
                    <div class="summary-label">Pending Review</div>
                    <p class="summary-value" id="pendingValue">0</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">groups</span></div>
                    <div class="summary-label">Enrolled Learners</div>
                    <p class="summary-value" id="learnerValue">0</p>
                </div>
            </section>

            <section class="filters-card">
                <div class="filter-row">
                    <div class="filter-tabs">
                        <button type="button" class="active" data-filter="all" onclick="setFilter('all', this)">All</button>
                        <button type="button" data-filter="published" onclick="setFilter('published', this)">Published</button>
                        <button type="button" data-filter="pending" onclick="setFilter('pending', this)">Pending Review</button>
                        <button type="button" data-filter="draft" onclick="setFilter('draft', this)">Draft</button>
                    </div>

                    <div class="filter-search">
                        <span class="material-symbols-outlined">search</span>
                        <input id="moduleSearch" type="text" placeholder="Search modules..." />
                    </div>

                    <button type="button" class="btn-muted" onclick="clearFilters(); return false;">
                        <span class="material-symbols-outlined">filter_alt_off</span>
                        Clear
                    </button>
                </div>
            </section>

            <section id="moduleGrid" class="module-grid"></section>

            <section class="pagination-row">
                <p id="moduleCountText">Showing modules</p>

                <div class="pagination">
                    <button type="button" id="prevPageBtn" class="page-btn" onclick="setPage(currentPage - 1)">
                        <span class="material-symbols-outlined">chevron_left</span>
                    </button>

                    <button type="button" id="pageOneBtn" class="page-btn active" onclick="setPage(1)">1</button>
                    <button type="button" id="pageTwoBtn" class="page-btn" onclick="setPage(2)">2</button>

                    <button type="button" id="nextPageBtn" class="page-btn" onclick="setPage(currentPage + 1)">
                        <span class="material-symbols-outlined">chevron_right</span>
                    </button>
                </div>
            </section>

            <section id="moduleEditor" class="module-editor">
                <div class="editor-header">
                    <div>
                        <h2 class="page-title" id="editorMainTitle">Module Configuration</h2>
                        <p class="page-subtitle">Create or edit module content, status, lessons, and review settings.</p>
                    </div>

                    <button type="button" class="btn-muted" onclick="closeEditor()">
                        <span class="material-symbols-outlined">close</span>
                        Close Editor
                    </button>
                </div>

                <div class="editor-layout">
                    <div>
                        <div class="editor-panel">
                            <div class="section-kicker">Primary Content</div>

                            <div class="form-group">
                                <label class="form-label">Module Title <span class="required">* REQUIRED</span></label>
                                <input id="moduleTitleInput" class="form-input" type="text" />
                            </div>

                            <div class="form-group">
                                <label class="form-label">Description</label>
                                <textarea id="moduleDescriptionInput" class="form-textarea"></textarea>
                            </div>
                        </div>

                        <div class="editor-panel">
                            <div class="section-kicker">Instructor Internal Notes</div>
                            <textarea id="internalNotesInput" class="form-textarea small-textarea">Ensure the module materials are updated and aligned with clinical standards.</textarea>
                        </div>

                        <div id="lessonPanel" class="editor-panel lesson-panel">
                            <div class="section-kicker">Add Lesson</div>

                            <div class="lesson-row">
                                <div class="form-group">
                                    <label class="form-label">Lesson Title <span class="required">* REQUIRED</span></label>
                                    <input id="lessonTitleInput" class="form-input" type="text" />
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Estimated Duration</label>
                                    <input id="lessonDurationInput" class="form-input" type="number" min="1" value="15" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Lesson Summary</label>
                                <textarea id="lessonSummaryInput" class="form-textarea small-textarea"></textarea>
                            </div>

                            <button type="button" class="btn-primary-red" onclick="saveLesson()">
                                <span class="material-symbols-outlined">save</span>
                                Save Lesson
                            </button>
                        </div>
                    </div>

                    <aside>
                        <div class="editor-panel">
                            <div class="section-kicker">Module Settings</div>

                            <div class="form-group">
                                <label class="form-label">Difficulty Level <span class="required">* REQUIRED</span></label>
                                <select id="difficultySelect" class="form-select">
                                    <option>Easy</option>
                                    <option>Medium</option>
                                    <option>Hard</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Module Status <span class="required">* REQUIRED</span></label>
                                <select id="statusSelect" class="form-select">
                                    <option>Draft</option>
                                    <option>Pending Review</option>
                                    <option>Published</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Cover Image</label>
                                <div class="cover-preview">
                                    <img id="coverPreviewImage" alt="Module cover" src="https://images.unsplash.com/photo-1584515933487-779824d29309?auto=format&fit=crop&w=900&q=80" />
                                </div>
                            </div>

                            <div class="side-actions">
                                <button type="button" class="btn-primary-red" onclick="saveModule()">
                                    <span class="material-symbols-outlined">save</span>
                                    Save Changes
                                </button>

                                <button type="button" class="btn-outline-red" onclick="saveAndAddLesson()">
                                    <span class="material-symbols-outlined">add_circle</span>
                                    Save & Add Lesson
                                </button>

                                <button type="button" class="btn-muted" onclick="exportDraft()">
                                    <span class="material-symbols-outlined">picture_as_pdf</span>
                                    Export Draft
                                </button>
                            </div>
                        </div>

                        <div class="editor-panel ai-panel">
                            <h3><span class="material-symbols-outlined">auto_awesome</span>AI Audit Ready</h3>
                            <p>Generate a clinical review checklist or improve the module structure before submission.</p>

                            <button type="button" class="btn-white" onclick="runAiAudit()">
                                <span class="material-symbols-outlined">verified</span>
                                Run AI Audit
                            </button>

                            <div id="aiAuditResult" class="ai-result"></div>
                        </div>
                    </aside>
                </div>
            </section>

        </div>
    </main>
</div>

<div id="toast" class="toast">Action completed.</div>

<script>
    var modules = [
        {
            title: "CPR Fundamentals",
            status: "published",
            difficulty: "Easy",
            lessons: 6,
            learners: 124,
            description: "Core life-saving techniques for adult and pediatric CPR.",
            image: "https://images.unsplash.com/photo-1584515933487-779824d29309?auto=format&fit=crop&w=900&q=80"
        },
        {
            title: "Choking & Airway Emergencies",
            status: "pending",
            difficulty: "Medium",
            lessons: 4,
            learners: 76,
            description: "Assess and manage airway obstruction scenarios.",
            image: "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?auto=format&fit=crop&w=900&q=80"
        },
        {
            title: "Trauma Response",
            status: "draft",
            difficulty: "Hard",
            lessons: 8,
            learners: 52,
            description: "Immediate care protocols for bleeding, fractures, and shock.",
            image: "https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=900&q=80"
        },
        {
            title: "Burn Treatment Basics",
            status: "published",
            difficulty: "Medium",
            lessons: 5,
            learners: 91,
            description: "Classification, cooling, coverage, and first response for burn injuries.",
            image: "https://images.unsplash.com/photo-1579684385127-1ef15d508118?auto=format&fit=crop&w=900&q=80"
        },
        {
            title: "Emergency Wound Care",
            status: "draft",
            difficulty: "Easy",
            lessons: 3,
            learners: 38,
            description: "Wound cleaning, dressing, and infection prevention basics.",
            image: "https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&w=900&q=80"
        },
        {
            title: "Pediatric First Aid",
            status: "pending",
            difficulty: "Hard",
            lessons: 7,
            learners: 67,
            description: "Emergency response principles for children and infants.",
            image: "https://images.unsplash.com/photo-1559757175-0eb30cd8c063?auto=format&fit=crop&w=900&q=80"
        }
    ];

    var selectedIndex = null;
    var currentFilter = "all";
    var currentPage = 1;
    var pageSize = 3;

    document.addEventListener("DOMContentLoaded", function () {
        setupSearch();
        renderModules();
        updateSummary();
    });

    function setupSearch() {
        var moduleSearch = document.getElementById("moduleSearch");
        var globalSearch = document.getElementById("globalSearch");

        if (moduleSearch) {
            moduleSearch.addEventListener("input", function () {
                currentPage = 1;
                renderModules();
            });
        }

        if (globalSearch && moduleSearch) {
            globalSearch.addEventListener("input", function () {
                moduleSearch.value = globalSearch.value;
                currentPage = 1;
                renderModules();
            });
        }
    }

    function setFilter(filter, button) {
        currentFilter = filter;
        currentPage = 1;

        document.querySelectorAll(".filter-tabs button").forEach(function (btn) {
            btn.classList.remove("active");
        });

        if (button) {
            button.classList.add("active");
        }

        renderModules();
        toast(filter === "all" ? "Showing all modules." : "Filtered by " + filter + ".");
    }

    function filteredModules() {
        var searchInput = document.getElementById("moduleSearch");
        var query = searchInput ? searchInput.value.toLowerCase().trim() : "";

        return modules.filter(function (module) {
            var matchFilter = currentFilter === "all" || module.status === currentFilter;
            var searchable = (module.title + " " + module.description + " " + module.difficulty).toLowerCase();
            var matchSearch = !query || searchable.indexOf(query) !== -1;

            return matchFilter && matchSearch;
        });
    }

    function renderModules() {
        var grid = document.getElementById("moduleGrid");
        var list = filteredModules();
        var totalPages = Math.max(1, Math.ceil(list.length / pageSize));

        if (currentPage < 1) currentPage = 1;
        if (currentPage > totalPages) currentPage = totalPages;

        var start = (currentPage - 1) * pageSize;
        var pageItems = list.slice(start, start + pageSize);

        grid.innerHTML = "";

        pageItems.forEach(function (module) {
            var realIndex = modules.indexOf(module);
            var card = document.createElement("article");
            card.className = "module-card";

            card.innerHTML =
                '<div class="module-cover">' +
                '<img src="' + escapeHtml(module.image) + '" alt="' + escapeHtml(module.title) + '" />' +
                '<div class="badge-row">' +
                '<span class="badge ' + getStatusClass(module.status) + '">' + getStatusText(module.status) + '</span>' +
                '<span class="badge ' + getDifficultyClass(module.difficulty) + '">' + escapeHtml(module.difficulty) + '</span>' +
                '</div>' +
                '</div>' +
                '<div class="module-body">' +
                '<h3 class="module-title">' + escapeHtml(module.title) + '</h3>' +
                '<p class="module-desc">' + escapeHtml(module.description) + '</p>' +
                '<div class="module-meta">' +
                '<span><span class="material-symbols-outlined">groups</span>' + module.learners + ' Learners</span>' +
                '<span><span class="material-symbols-outlined">menu_book</span>' + module.lessons + ' Lessons</span>' +
                '</div>' +
                '<div class="module-actions">' +
                '<button type="button" class="module-action" onclick="editModule(' + realIndex + ')"><span class="material-symbols-outlined">edit</span>Edit</button>' +
                '<button type="button" class="module-action" onclick="openLessonForm(' + realIndex + ')"><span class="material-symbols-outlined">menu_book</span>Lesson</button>' +
                '<button type="button" class="module-action" onclick="submitModule(' + realIndex + ')"><span class="material-symbols-outlined">send</span>Submit</button>' +
                '</div>' +
                '</div>';

            grid.appendChild(card);
        });

        updatePagination(list.length, start, pageItems.length, totalPages);
        updateSummary();
    }

    function updatePagination(total, start, count, totalPages) {
        var from = total === 0 ? 0 : start + 1;
        var to = start + count;

        document.getElementById("moduleCountText").textContent =
            "Showing " + from + " - " + to + " of " + total + " modules";

        document.getElementById("prevPageBtn").disabled = currentPage <= 1;
        document.getElementById("nextPageBtn").disabled = currentPage >= totalPages;

        document.getElementById("pageOneBtn").classList.toggle("active", currentPage === 1);
        document.getElementById("pageTwoBtn").classList.toggle("active", currentPage === 2);
        document.getElementById("pageTwoBtn").style.display = totalPages >= 2 ? "flex" : "none";
    }

    function setPage(page) {
        var totalPages = Math.max(1, Math.ceil(filteredModules().length / pageSize));

        if (page < 1 || page > totalPages) {
            toast("No more modules on this page.");
            return;
        }

        currentPage = page;
        renderModules();
    }

    function openCreateModule() {
        selectedIndex = null;

        document.getElementById("editorMainTitle").textContent = "Create Module";
        document.getElementById("moduleTitleInput").value = "";
        document.getElementById("moduleDescriptionInput").value = "";
        document.getElementById("difficultySelect").value = "Easy";
        document.getElementById("statusSelect").value = "Draft";
        document.getElementById("internalNotesInput").value = "Prepare clinical objectives and learner safety notes.";
        document.getElementById("coverPreviewImage").src = "https://images.unsplash.com/photo-1584515933487-779824d29309?auto=format&fit=crop&w=900&q=80";

        document.getElementById("lessonPanel").classList.remove("visible");
        openEditor();

        toast("Create Module form opened.");
    }

    function editModule(index) {
        var module = modules[index];

        if (!module) {
            toast("Module not found.");
            return;
        }

        selectedIndex = index;

        document.getElementById("editorMainTitle").textContent = "Edit Module";
        document.getElementById("moduleTitleInput").value = module.title;
        document.getElementById("moduleDescriptionInput").value = module.description;
        document.getElementById("difficultySelect").value = module.difficulty;
        document.getElementById("statusSelect").value = getStatusText(module.status);
        document.getElementById("internalNotesInput").value = "Review this module before publishing. Confirm lesson accuracy and clinical references.";
        document.getElementById("coverPreviewImage").src = module.image;

        document.getElementById("lessonPanel").classList.remove("visible");
        openEditor();

        toast("Module loaded for editing.");
    }

    function openEditor() {
        var editor = document.getElementById("moduleEditor");
        editor.classList.add("visible");

        setTimeout(function () {
            editor.scrollIntoView({ behavior: "smooth", block: "start" });
        }, 60);
    }

    function closeEditor() {
        document.getElementById("moduleEditor").classList.remove("visible");
        document.getElementById("lessonPanel").classList.remove("visible");
        selectedIndex = null;
        toast("Editor closed.");
    }

    function saveModule() {
        var title = document.getElementById("moduleTitleInput").value.trim();
        var description = document.getElementById("moduleDescriptionInput").value.trim();
        var difficulty = document.getElementById("difficultySelect").value;
        var status = getStatusKey(document.getElementById("statusSelect").value);

        if (!title) {
            toast("Module title is required.");
            document.getElementById("moduleTitleInput").focus();
            return false;
        }

        if (!description) {
            description = "No description added yet.";
        }

        var moduleData = {
            title: title,
            status: status,
            difficulty: difficulty,
            lessons: selectedIndex !== null ? modules[selectedIndex].lessons : 0,
            learners: selectedIndex !== null ? modules[selectedIndex].learners : 0,
            description: description,
            image: selectedIndex !== null ? modules[selectedIndex].image : "https://images.unsplash.com/photo-1584515933487-779824d29309?auto=format&fit=crop&w=900&q=80"
        };

        if (selectedIndex !== null) {
            modules[selectedIndex] = moduleData;
            toast("Module updated successfully.");
        } else {
            modules.unshift(moduleData);
            selectedIndex = 0;
            currentPage = 1;
            toast("New module created successfully.");
        }

        renderModules();
        updateSummary();
        return true;
    }

    function saveAndAddLesson() {
        var saved = saveModule();

        if (!saved) {
            return;
        }

        document.getElementById("lessonPanel").classList.add("visible");
        document.getElementById("lessonTitleInput").value = "";
        document.getElementById("lessonDurationInput").value = "15";
        document.getElementById("lessonSummaryInput").value = "Add a short objective and key clinical steps for this lesson.";

        setTimeout(function () {
            document.getElementById("lessonPanel").scrollIntoView({ behavior: "smooth", block: "center" });
        }, 80);

        toast("Lesson form opened.");
    }

    function openLessonForm(index) {
        editModule(index);

        setTimeout(function () {
            document.getElementById("lessonPanel").classList.add("visible");
            document.getElementById("lessonTitleInput").value = "";
            document.getElementById("lessonDurationInput").value = "15";
            document.getElementById("lessonSummaryInput").value = "";
            document.getElementById("lessonPanel").scrollIntoView({ behavior: "smooth", block: "center" });
        }, 180);
    }

    function saveLesson() {
        var title = document.getElementById("lessonTitleInput").value.trim();

        if (!title) {
            toast("Lesson title is required.");
            document.getElementById("lessonTitleInput").focus();
            return;
        }

        if (selectedIndex === null) {
            toast("Save a module first.");
            return;
        }

        modules[selectedIndex].lessons += 1;

        document.getElementById("lessonPanel").classList.remove("visible");
        renderModules();
        updateSummary();

        toast("Lesson added successfully.");
    }

    function submitModule(index) {
        var module = modules[index];

        if (!module) {
            toast("Module not found.");
            return;
        }

        if (module.status === "published") {
            toast("This module is already published.");
            return;
        }

        if (module.status === "pending") {
            module.status = "published";
            toast("Module published successfully.");
        } else {
            module.status = "pending";
            toast("Module submitted for review.");
        }

        renderModules();
        updateSummary();
    }

    function exportDraft() {
        var title = document.getElementById("moduleTitleInput").value || "Untitled Module";
        var description = document.getElementById("moduleDescriptionInput").value || "No description.";
        var difficulty = document.getElementById("difficultySelect").value;
        var status = document.getElementById("statusSelect").value;

        var reportWindow = window.open("", "_blank", "width=900,height=700");

        if (!reportWindow) {
            alert("Popup blocked. Please allow popups to export.");
            return;
        }

        reportWindow.document.open();
        reportWindow.document.write(
            "<!DOCTYPE html><html><head><title>Module Draft</title>" +
            "<style>body{font-family:Arial,sans-serif;margin:32px;color:#281715;}h1{color:#b70011;}section{border:1px solid #e6bdb8;border-radius:10px;padding:18px;margin-bottom:16px;background:#fff8f7;}p{line-height:1.6;}</style>" +
            "</head><body>" +
            "<h1>Aidify Module Draft</h1>" +
            "<section><h2>" + escapeHtml(title) + "</h2><p>" + escapeHtml(description) + "</p></section>" +
            "<section><p><strong>Difficulty:</strong> " + escapeHtml(difficulty) + "</p><p><strong>Status:</strong> " + escapeHtml(status) + "</p></section>" +
            "</body></html>"
        );
        reportWindow.document.close();

        toast("Draft exported.");
    }

    function exportModuleReport() {
        updateSummary();

        var rows = modules.map(function (module) {
            return "<tr>" +
                "<td>" + escapeHtml(module.title) + "</td>" +
                "<td>" + escapeHtml(getStatusText(module.status)) + "</td>" +
                "<td>" + escapeHtml(module.difficulty) + "</td>" +
                "<td>" + module.lessons + "</td>" +
                "<td>" + module.learners + "</td>" +
                "</tr>";
        }).join("");

        var reportWindow = window.open("", "_blank", "width=1100,height=800");

        if (!reportWindow) {
            alert("Popup blocked. Please allow popups to export the report.");
            return;
        }

        reportWindow.document.open();
        reportWindow.document.write(
            "<!DOCTYPE html><html><head><title>Aidify Module Report</title>" +
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
            "<h1>Aidify Module Report</h1>" +
            "<div class='sub'>Generated from Instructor Module Manager</div>" +
            "<div class='summary'>" +
            "<div class='box'><div class='label'>Total</div><div class='value'>" + document.getElementById("totalModulesValue").textContent + "</div></div>" +
            "<div class='box'><div class='label'>Published</div><div class='value'>" + document.getElementById("publishedValue").textContent + "</div></div>" +
            "<div class='box'><div class='label'>Pending</div><div class='value'>" + document.getElementById("pendingValue").textContent + "</div></div>" +
            "<div class='box'><div class='label'>Learners</div><div class='value'>" + document.getElementById("learnerValue").textContent + "</div></div>" +
            "</div>" +
            "<table><thead><tr><th>Module</th><th>Status</th><th>Difficulty</th><th>Lessons</th><th>Learners</th></tr></thead><tbody>" +
            rows +
            "</tbody></table></body></html>"
        );
        reportWindow.document.close();

        toast("Module report exported.");
    }

    function runAiAudit() {
        var result = document.getElementById("aiAuditResult");

        result.innerHTML =
            "<strong>Audit Result:</strong><br/>" +
            "• Module structure is clear.<br/>" +
            "• Add measurable learning objectives.<br/>" +
            "• Verify clinical references before publishing.<br/>" +
            "• Add scenario-based checks for learner assessment.";

        result.classList.add("visible");
        toast("AI audit completed.");
    }

    function clearFilters() {
        document.getElementById("moduleSearch").value = "";
        document.getElementById("globalSearch").value = "";
        currentFilter = "all";
        currentPage = 1;

        document.querySelectorAll(".filter-tabs button").forEach(function (button) {
            button.classList.remove("active");

            if (button.getAttribute("data-filter") === "all") {
                button.classList.add("active");
            }
        });

        renderModules();
        toast("Filters cleared.");
    }

    function updateSummary() {
        var total = modules.length;
        var published = modules.filter(function (module) { return module.status === "published"; }).length;
        var pending = modules.filter(function (module) { return module.status === "pending"; }).length;
        var learners = modules.reduce(function (sum, module) {
            return sum + Number(module.learners || 0);
        }, 0);

        document.getElementById("totalModulesValue").textContent = total;
        document.getElementById("publishedValue").textContent = published;
        document.getElementById("pendingValue").textContent = pending;
        document.getElementById("learnerValue").textContent = learners;
    }

    function openNotifications() {
        alert(
            "Notifications\n\n" +
            "• 3 modules need review.\n" +
            "• 5 discussion replies are pending.\n" +
            "• 2 learners completed CPR Fundamentals today."
        );
    }

    function openHelp() {
        alert(
            "Aidify Help\n\n" +
            "Create Module: opens a blank module form.\n" +
            "Edit: loads module data into the editor.\n" +
            "Lesson: opens inline lesson form.\n" +
            "Submit: changes Draft to Pending Review, then Published.\n" +
            "Export: opens a clean printable report.\n" +
            "Filters and search update the module grid."
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

    function openSettings() {
        alert("Settings\n\nThis UI prototype can be connected later to instructor preferences.");
    }

    function logoutPreview() {
        alert("Logout\n\nThis is a UI-only prototype. Authentication is not connected.");
    }

    function toast(message) {
        var toastBox = document.getElementById("toast");

        toastBox.textContent = message;
        toastBox.classList.add("show");

        clearTimeout(window.__toastTimer);
        window.__toastTimer = setTimeout(function () {
            toastBox.classList.remove("show");
        }, 2200);
    }

    function getStatusKey(text) {
        if (text === "Published") return "published";
        if (text === "Pending Review") return "pending";
        return "draft";
    }

    function getStatusText(key) {
        if (key === "published") return "Published";
        if (key === "pending") return "Pending Review";
        return "Draft";
    }

    function getStatusClass(key) {
        if (key === "published") return "badge-published";
        if (key === "pending") return "badge-pending";
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