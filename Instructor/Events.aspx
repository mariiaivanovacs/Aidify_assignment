<%@ Page Title="Events" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Events.aspx.cs" Inherits="Aidify_assigment.Instructor.Events" %>

<asp:Content ID="EventsContent" ContentPlaceHolderID="MainContent" runat="server">

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
        letter-spacing: -.035em;
        margin: 0 0 4px;
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
    .event-card,
    .event-editor {
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

    .event-editor {
        display: none;
        margin-bottom: 24px;
        overflow: hidden;
        scroll-margin-top: 88px;
    }

    .event-editor.visible {
        display: block !important;
    }

    .editor-header {
        padding: 16px 18px;
        border-bottom: 1px solid #e6bdb8;
        background: #fff8f7;
        display: flex;
        justify-content: space-between;
        gap: 16px;
        align-items: flex-end;
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

    .form-textarea {
        min-height: 100px;
        resize: vertical;
        line-height: 1.5;
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

    .filter-search input {
        width: 100%;
        border: 1px solid #e6bdb8;
        background: #fff8f7;
        border-radius: 8px;
        color: #281715;
        font-size: 13px;
        outline: none;
        padding: 10px 12px 10px 38px;
        box-sizing: border-box;
    }

    .event-grid {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 22px;
    }

    .event-card {
        overflow: hidden;
        transition: .22s ease;
    }

    .event-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 14px 28px rgba(40, 23, 21, .10);
    }

    .event-cover {
        height: 145px;
        position: relative;
        overflow: hidden;
        background: #ffe9e6;
    }

    .event-cover img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        opacity: .92;
    }

    .event-date {
        position: absolute;
        top: 12px;
        left: 12px;
        width: 58px;
        border-radius: 10px;
        overflow: hidden;
        background: #fff;
        border: 1px solid #e6bdb8;
        box-shadow: 0 8px 18px rgba(40, 23, 21, .12);
        text-align: center;
    }

    .event-month {
        background: #b70011;
        color: #fff;
        font-size: 10px;
        font-weight: 800;
        padding: 4px 0;
        text-transform: uppercase;
    }

    .event-day {
        color: #281715;
        font-size: 20px;
        line-height: 1;
        font-weight: 800;
        padding: 8px 0;
    }

    .badge-row {
        position: absolute;
        top: 12px;
        right: 12px;
        display: flex;
        gap: 7px;
        flex-wrap: wrap;
        justify-content: flex-end;
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

    .badge-upcoming {
        background: #dcfce7;
        color: #15803d;
    }

    .badge-online {
        background: #ffdad6;
        color: #b70011;
    }

    .badge-person {
        background: #fef3c7;
        color: #a16207;
    }

    .badge-cancelled {
        background: #f3f4f6;
        color: #374151;
    }

    .event-body {
        padding: 18px;
    }

    .event-title {
        color: #281715;
        font-size: 18px;
        line-height: 1.25;
        font-weight: 800;
        margin: 0 0 12px;
    }

    .event-info {
        display: grid;
        gap: 8px;
        margin-bottom: 14px;
    }

    .event-info-row {
        display: flex;
        align-items: center;
        gap: 7px;
        color: #5c403c;
        font-size: 12px;
        font-weight: 700;
    }

    .event-info-row .material-symbols-outlined {
        font-size: 17px;
        color: #b70011;
    }

    .event-stats {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 8px;
        margin-bottom: 14px;
    }

    .stat-box {
        background: #fff8f7;
        border: 1px solid #e6bdb8;
        border-radius: 8px;
        padding: 10px 8px;
    }

    .stat-label {
        color: #5c403c;
        font-size: 10px;
        font-weight: 800;
        text-transform: uppercase;
        margin-bottom: 4px;
    }

    .stat-value {
        color: #281715;
        font-size: 15px;
        font-weight: 800;
    }

    .event-actions {
        border-top: 1px solid #e6bdb8;
        padding-top: 14px;
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 8px;
    }

    .event-action {
        color: #281715 !important;
        text-decoration: none !important;
        border-radius: 8px;
        padding: 9px 8px;
        font-size: 12px;
        font-weight: 800;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 5px;
        background: #fff;
        border: 1px solid #e6bdb8;
        cursor: pointer;
    }

    .event-action:hover {
        background: #fff0ee;
        color: #b70011 !important;
    }

    .event-action.cancel {
        color: #ba1a1a !important;
    }

    .event-action.cancelled {
        background: #f3f4f6;
        color: #374151 !important;
        border-color: #d1d5db;
    }

    .pagination-row {
        margin-top: 34px;
        border-top: 1px solid #e6bdb8;
        padding-top: 18px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        color: #5c403c;
        font-size: 13px;
        font-weight: 700;
    }

    .pagination {
        display: flex;
        gap: 7px;
        align-items: center;
    }

    .page-btn {
        width: 36px;
        height: 36px;
        border: 1px solid #e6bdb8;
        background: #fff;
        color: #281715;
        border-radius: 8px;
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

    @media (max-width: 1150px) {
        .summary-grid,
        .event-grid,
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
            <a href="/Instructor/Discussions.aspx"><span class="material-symbols-outlined">forum</span>Discussions</a>
            <a href="/Instructor/Challenges.aspx"><span class="material-symbols-outlined">military_tech</span>Challenges</a>
            <a class="active" href="/Instructor/Events.aspx"><span class="material-symbols-outlined">calendar_today</span>Events</a>
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
            <input id="globalSearch" type="text" placeholder="Search events, modules, or learners..." />
        </div>

        <div class="topbar-actions">
            <button type="button" class="topbar-icon" onclick="openNotifications(); return false;">
                <span class="material-symbols-outlined">notifications</span>
            </button>

            <button type="button" class="topbar-icon" onclick="openHelp(); return false;">
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
                    <h2 class="page-title">Events</h2>
                    <p class="page-subtitle">Schedule instructor-led sessions, workshops, and learner training activities.</p>
                </div>

                <div class="header-actions">
                    <button type="button" class="btn-primary-red" onclick="openCreateEventForm(); return false;">
                        <span class="material-symbols-outlined">add</span>
                        Create Event
                    </button>

                    <button type="button" class="btn-outline-red" onclick="exportEventReport(); return false;">
                        <span class="material-symbols-outlined">ios_share</span>
                        Export Report
                    </button>
                </div>
            </section>

            <section class="summary-grid">
                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">event</span></div>
                    <div class="summary-label">Upcoming Events</div>
                    <p class="summary-value" id="upcomingValue">0</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">groups</span></div>
                    <div class="summary-label">Registered Learners</div>
                    <p class="summary-value" id="registeredValue">0</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">videocam</span></div>
                    <div class="summary-label">Online Sessions</div>
                    <p class="summary-value" id="onlineValue">0</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">cancel</span></div>
                    <div class="summary-label">Cancelled</div>
                    <p class="summary-value" id="cancelledValue">0</p>
                </div>
            </section>

            <section id="eventEditor" class="event-editor">
                <div class="editor-header">
                    <div>
                        <h3 class="editor-title" id="editorModeLabel">Create Event</h3>
                        <p class="editor-subtitle">Create or update an instructor-led session.</p>
                    </div>

                    <div class="button-row">
                        <button type="button" class="btn-muted" onclick="cancelEditor(); return false;">Cancel</button>
                        <button type="button" class="btn-outline-red" onclick="previewEditorEvent(); return false;">Preview</button>
                        <button type="button" class="btn-primary-red" onclick="saveEvent(); return false;">Save Event</button>
                    </div>
                </div>

                <div class="editor-body">
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">Event Title <span class="required">* REQUIRED</span></label>
                            <input id="eventTitleInput" class="form-input" type="text" />
                        </div>

                        <div class="form-group">
                            <label class="form-label">Module <span class="required">* REQUIRED</span></label>
                            <select id="eventModuleInput" class="form-select">
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
                            <label class="form-label">Date</label>
                            <input id="eventDateInput" class="form-input" type="date" />
                        </div>

                        <div class="form-group">
                            <label class="form-label">Time</label>
                            <input id="eventTimeInput" class="form-input" type="time" />
                        </div>

                        <div class="form-group">
                            <label class="form-label">Format</label>
                            <select id="eventFormatInput" class="form-select">
                                <option>Online</option>
                                <option>In-Person</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Status</label>
                            <select id="eventStatusInput" class="form-select">
                                <option>Upcoming</option>
                                <option>Cancelled</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Location / Link</label>
                            <input id="eventLocationInput" class="form-input" type="text" />
                        </div>

                        <div class="form-group">
                            <label class="form-label">Registered Learners</label>
                            <input id="eventRegisteredInput" class="form-input" type="number" min="0" value="0" />
                        </div>

                        <div class="form-group full">
                            <label class="form-label">Description</label>
                            <textarea id="eventDescriptionInput" class="form-textarea"></textarea>
                        </div>
                    </div>
                </div>
            </section>

            <section class="filters-card">
                <div class="filter-row">
                    <div class="filter-tabs">
                        <button type="button" class="active" onclick="setEventFilter('all', this); return false;">All</button>
                        <button type="button" onclick="setEventFilter('Upcoming', this); return false;">Upcoming</button>
                        <button type="button" onclick="setEventFilter('Online', this); return false;">Online</button>
                        <button type="button" onclick="setEventFilter('In-Person', this); return false;">In-Person</button>
                        <button type="button" onclick="setEventFilter('Cancelled', this); return false;">Cancelled</button>
                    </div>

                    <div class="filter-search">
                        <span class="material-symbols-outlined">search</span>
                        <input id="eventSearch" type="text" placeholder="Search events..." />
                    </div>

                    <button type="button" class="btn-muted" onclick="showFilterSummary(); return false;">
                        <span class="material-symbols-outlined">filter_list</span>
                        Filter
                    </button>
                </div>
            </section>

            <section id="eventGrid" class="event-grid"></section>

            <section class="pagination-row">
                <p id="paginationLabel">Showing 0 of 0 events</p>

                <div class="pagination">
                    <button type="button" id="prevPageBtn" class="page-btn" onclick="previousPage(); return false;">
                        <span class="material-symbols-outlined">chevron_left</span>
                    </button>

                    <button type="button" class="page-btn active" onclick="goToPage(1); return false;">1</button>
                    <button type="button" class="page-btn" onclick="goToPage(2); return false;">2</button>
                    <button type="button" class="page-btn" onclick="goToPage(3); return false;">3</button>

                    <button type="button" id="nextPageBtn" class="page-btn" onclick="nextPage(); return false;">
                        <span class="material-symbols-outlined">chevron_right</span>
                    </button>
                </div>
            </section>

        </div>
    </main>
</div>

<div id="eventToast" class="toast">Action completed.</div>

<script>
    var events = [
        {
            title: "CPR Live Workshop",
            module: "CPR Fundamentals",
            status: "Upcoming",
            format: "In-Person",
            date: "2026-06-18",
            time: "10:00",
            location: "Simulation Lab A",
            registered: 42,
            type: "Lab",
            description: "Hands-on CPR workshop with instructor demonstration.",
            image: "https://images.unsplash.com/photo-1584515933487-779824d29309?auto=format&fit=crop&w=900&q=80"
        },
        {
            title: "Airway Emergency Webinar",
            module: "Airway Emergencies",
            status: "Upcoming",
            format: "Online",
            date: "2026-06-20",
            time: "14:00",
            location: "Online",
            registered: 68,
            type: "Webinar",
            description: "Online airway emergency session for choking response.",
            image: "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?auto=format&fit=crop&w=900&q=80"
        },
        {
            title: "Trauma Response Drill",
            module: "Trauma Response",
            status: "Upcoming",
            format: "In-Person",
            date: "2026-06-22",
            time: "09:00",
            location: "Clinical Skills Center",
            registered: 36,
            type: "Drill",
            description: "Scenario-based trauma drill for emergency decision making.",
            image: "https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=900&q=80"
        },
        {
            title: "Burn Treatment Case Review",
            module: "Burn Treatment Basics",
            status: "Upcoming",
            format: "Online",
            date: "2026-06-25",
            time: "13:30",
            location: "Online",
            registered: 54,
            type: "Review",
            description: "Case-based review for burn classification and treatment.",
            image: "https://images.unsplash.com/photo-1579684385127-1ef15d508118?auto=format&fit=crop&w=900&q=80"
        },
        {
            title: "Pediatric First Aid Practice",
            module: "Pediatric First Aid",
            status: "Upcoming",
            format: "In-Person",
            date: "2026-06-28",
            time: "11:00",
            location: "Simulation Lab B",
            registered: 38,
            type: "Practice",
            description: "Pediatric first aid practice with guided instructor feedback.",
            image: "https://images.unsplash.com/photo-1559757175-0eb30cd8c063?auto=format&fit=crop&w=900&q=80"
        },
        {
            title: "Emergency Wound Care Briefing",
            module: "Emergency Wound Care",
            status: "Cancelled",
            format: "Online",
            date: "2026-06-30",
            time: "15:00",
            location: "Online",
            registered: 48,
            type: "Briefing",
            description: "Briefing on emergency wound cleaning and escalation steps.",
            image: "https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&w=900&q=80"
        }
    ];

    var selectedEventIndex = -1;
    var activeEventFilter = "all";
    var currentPage = 1;
    var pageSize = 3;

    document.addEventListener("DOMContentLoaded", function () {
        var eventSearch = document.getElementById("eventSearch");
        var globalSearch = document.getElementById("globalSearch");

        if (eventSearch) {
            eventSearch.addEventListener("input", function () {
                currentPage = 1;
                renderEvents();
            });
        }

        if (globalSearch && eventSearch) {
            globalSearch.addEventListener("input", function () {
                eventSearch.value = globalSearch.value;
                currentPage = 1;
                renderEvents();
            });
        }

        renderEvents();
        updateSummary();
    });

    function openCreateEventForm() {
        selectedEventIndex = -1;

        var editor = document.getElementById("eventEditor");

        if (!editor) {
            alert("ERROR: eventEditor section not found.");
            return false;
        }

        setText("editorModeLabel", "Create Event");

        setValue("eventTitleInput", "");
        setValue("eventModuleInput", "");
        setValue("eventDateInput", "");
        setValue("eventTimeInput", "");
        setValue("eventFormatInput", "Online");
        setValue("eventStatusInput", "Upcoming");
        setValue("eventLocationInput", "");
        setValue("eventRegisteredInput", "0");
        setValue("eventDescriptionInput", "");

        editor.style.display = "block";
        editor.classList.add("visible");

        setTimeout(function () {
            editor.scrollIntoView({ behavior: "smooth", block: "start" });
        }, 80);

        showToast("Create Event form opened.");
        return false;
    }

    function setValue(id, value) {
        var el = document.getElementById(id);
        if (el) {
            el.value = value;
        }
    }

    function getValue(id) {
        var el = document.getElementById(id);
        return el ? el.value : "";
    }

    function setText(id, value) {
        var el = document.getElementById(id);
        if (el) {
            el.textContent = value;
        }
    }

    function getText(id) {
        var el = document.getElementById(id);
        return el ? el.textContent : "";
    }

    function focusElement(id) {
        var el = document.getElementById(id);
        if (el) {
            el.focus();
        }
    }

    function showToast(message) {
        var toast = document.getElementById("eventToast");

        if (!toast) {
            alert(message);
            return;
        }

        toast.textContent = message;
        toast.classList.add("show");

        clearTimeout(window.__eventToastTimer);
        window.__eventToastTimer = setTimeout(function () {
            toast.classList.remove("show");
        }, 2200);
    }

    function getFilteredEvents() {
        var searchInput = document.getElementById("eventSearch");
        var query = searchInput ? searchInput.value.toLowerCase().trim() : "";

        return events.filter(function (item) {
            var matchesFilter =
                activeEventFilter === "all" ||
                item.status === activeEventFilter ||
                item.format === activeEventFilter;

            var searchable = (item.title + " " + item.module + " " + item.location + " " + item.description).toLowerCase();
            var matchesSearch = !query || searchable.indexOf(query) !== -1;

            return matchesFilter && matchesSearch;
        });
    }

    function renderEvents() {
        var grid = document.getElementById("eventGrid");

        if (!grid) {
            return;
        }

        var filtered = getFilteredEvents();
        var totalPages = Math.max(1, Math.ceil(filtered.length / pageSize));

        if (currentPage > totalPages) {
            currentPage = totalPages;
        }

        var start = (currentPage - 1) * pageSize;
        var pageItems = filtered.slice(start, start + pageSize);

        grid.innerHTML = "";

        pageItems.forEach(function (item) {
            var realIndex = events.indexOf(item);
            var dateParts = parseDateParts(item.date);
            var locationIcon = item.format === "Online" ? "videocam" : "location_on";

            var card = document.createElement("article");
            card.className = "event-card";

            card.innerHTML =
                '<div class="event-cover">' +
                '<img alt="' + escapeHtml(item.title) + '" src="' + escapeHtml(item.image) + '" />' +
                '<div class="event-date">' +
                '<div class="event-month">' + dateParts.month + '</div>' +
                '<div class="event-day">' + dateParts.day + '</div>' +
                '</div>' +
                '<div class="badge-row">' +
                '<span class="badge ' + getStatusClass(item.status) + '">' + escapeHtml(item.status) + '</span>' +
                '<span class="badge ' + getFormatClass(item.format) + '">' + escapeHtml(item.format) + '</span>' +
                '</div>' +
                '</div>' +
                '<div class="event-body">' +
                '<h3 class="event-title">' + escapeHtml(item.title) + '</h3>' +
                '<div class="event-info">' +
                '<div class="event-info-row"><span class="material-symbols-outlined">schedule</span>' + formatDateTime(item.date, item.time) + '</div>' +
                '<div class="event-info-row"><span class="material-symbols-outlined">' + locationIcon + '</span>' + escapeHtml(item.location) + '</div>' +
                '<div class="event-info-row"><span class="material-symbols-outlined">school</span>' + escapeHtml(item.module) + '</div>' +
                '</div>' +
                '<div class="event-stats">' +
                '<div class="stat-box"><div class="stat-label">Registered</div><div class="stat-value">' + item.registered + '</div></div>' +
                '<div class="stat-box"><div class="stat-label">Type</div><div class="stat-value">' + escapeHtml(item.type) + '</div></div>' +
                '</div>' +
                '<div class="event-actions">' +
                '<button type="button" class="event-action" onclick="editEvent(' + realIndex + '); return false;"><span class="material-symbols-outlined">edit</span>Edit</button>' +
                '<button type="button" class="event-action" onclick="viewRegistrations(' + realIndex + '); return false;"><span class="material-symbols-outlined">list_alt</span>Registrations</button>' +
                '<button type="button" class="event-action ' + (item.status === "Cancelled" ? "cancelled" : "cancel") + '" onclick="cancelEvent(' + realIndex + '); return false;"><span class="material-symbols-outlined">cancel</span>' + (item.status === "Cancelled" ? "Cancelled" : "Cancel") + '</button>' +
                '</div>' +
                '</div>';

            grid.appendChild(card);
        });

        updatePagination(filtered.length, start, pageItems.length, totalPages);
    }

    function updatePagination(total, start, count, totalPages) {
        var from = total === 0 ? 0 : start + 1;
        var to = start + count;

        setText("paginationLabel", "Showing " + from + " - " + to + " of " + total + " events");

        var prev = document.getElementById("prevPageBtn");
        var next = document.getElementById("nextPageBtn");

        if (prev) {
            prev.disabled = currentPage <= 1;
        }

        if (next) {
            next.disabled = currentPage >= totalPages;
        }

        var numericButtons = Array.prototype.slice.call(document.querySelectorAll(".pagination .page-btn")).filter(function (button) {
            return /^\d+$/.test(button.textContent.trim());
        });

        numericButtons.forEach(function (button) {
            var page = parseInt(button.textContent.trim(), 10);
            button.classList.remove("active");
            button.style.display = page <= totalPages ? "flex" : "none";

            if (page === currentPage) {
                button.classList.add("active");
            }
        });
    }

    function setEventFilter(filter, button) {
        activeEventFilter = filter;
        currentPage = 1;

        document.querySelectorAll(".filter-tabs button").forEach(function (btn) {
            btn.classList.remove("active");
        });

        if (button) {
            button.classList.add("active");
        }

        renderEvents();
        showToast(filter === "all" ? "Showing all events." : "Filtered by " + filter + ".");
    }

    function showFilterSummary() {
        showToast("Current filter shows " + getFilteredEvents().length + " event(s).");
    }

    function editEvent(index) {
        var item = events[index];

        if (!item) {
            showToast("Event not found.");
            return;
        }

        selectedEventIndex = index;

        setText("editorModeLabel", "Edit Event");
        setValue("eventTitleInput", item.title);
        setValue("eventModuleInput", item.module);
        setValue("eventDateInput", item.date);
        setValue("eventTimeInput", item.time);
        setValue("eventFormatInput", item.format);
        setValue("eventStatusInput", item.status);
        setValue("eventLocationInput", item.location);
        setValue("eventRegisteredInput", item.registered);
        setValue("eventDescriptionInput", item.description);

        openEditor();
        showToast("Event loaded for editing.");
    }

    function openEditor() {
        var editor = document.getElementById("eventEditor");

        if (!editor) {
            showToast("Event editor not found.");
            return;
        }

        editor.style.display = "block";
        editor.classList.add("visible");

        setTimeout(function () {
            editor.scrollIntoView({ behavior: "smooth", block: "start" });
        }, 50);
    }

    function cancelEditor() {
        var editor = document.getElementById("eventEditor");

        if (editor) {
            editor.classList.remove("visible");
            editor.style.display = "none";
        }

        selectedEventIndex = -1;
        showToast("Event editor closed.");
    }

    function saveEvent() {
        var title = getValue("eventTitleInput").trim();
        var moduleName = getValue("eventModuleInput");

        if (!title) {
            showToast("Event title is required.");
            focusElement("eventTitleInput");
            return;
        }

        if (!moduleName) {
            showToast("Module is required.");
            focusElement("eventModuleInput");
            return;
        }

        var format = getValue("eventFormatInput") || "Online";

        var item = {
            title: title,
            module: moduleName,
            status: getValue("eventStatusInput") || "Upcoming",
            format: format,
            date: getValue("eventDateInput") || "2026-06-18",
            time: getValue("eventTimeInput") || "10:00",
            location: getValue("eventLocationInput").trim() || (format === "Online" ? "Online" : "Training Room"),
            registered: parseInt(getValue("eventRegisteredInput"), 10) || 0,
            type: format === "Online" ? "Webinar" : "Workshop",
            description: getValue("eventDescriptionInput").trim() || "No description provided.",
            image: "https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&w=900&q=80"
        };

        if (selectedEventIndex >= 0) {
            events[selectedEventIndex] = item;
            showToast("Event updated successfully.");
        } else {
            events.unshift(item);
            currentPage = 1;
            showToast("Event created successfully.");
        }

        var editor = document.getElementById("eventEditor");
        if (editor) {
            editor.classList.remove("visible");
            editor.style.display = "none";
        }

        selectedEventIndex = -1;
        renderEvents();
        updateSummary();
    }

    function previewEditorEvent() {
        var title = getValue("eventTitleInput") || "Untitled Event";
        var moduleName = getValue("eventModuleInput") || "No module selected";
        var date = getValue("eventDateInput") || "No date";
        var time = getValue("eventTimeInput") || "No time";
        var format = getValue("eventFormatInput") || "Online";
        var location = getValue("eventLocationInput") || "No location/link";
        var description = getValue("eventDescriptionInput") || "No description provided.";

        alert(
            "Event Preview\n\n" +
            "Title: " + title + "\n" +
            "Module: " + moduleName + "\n" +
            "Date: " + date + "\n" +
            "Time: " + time + "\n" +
            "Format: " + format + "\n" +
            "Location/Link: " + location + "\n\n" +
            "Description:\n" + description
        );
    }

    function viewRegistrations(index) {
        var item = events[index];

        if (!item) {
            showToast("Event not found.");
            return;
        }

        alert(
            "Event Registrations\n\n" +
            "Event: " + item.title + "\n" +
            "Module: " + item.module + "\n" +
            "Registered Learners: " + item.registered + "\n\n" +
            "Sample registration summary:\n" +
            "• 12 confirmed attendance\n" +
            "• 8 waiting for confirmation\n" +
            "• 3 requested reminders"
        );
    }

    function cancelEvent(index) {
        var item = events[index];

        if (!item) {
            showToast("Event not found.");
            return;
        }

        if (item.status === "Cancelled") {
            showToast("Event is already cancelled.");
            return;
        }

        var confirmed = confirm("Cancel event: " + item.title + "?");

        if (!confirmed) {
            showToast("Cancellation stopped.");
            return;
        }

        item.status = "Cancelled";
        renderEvents();
        updateSummary();
        showToast("Event cancelled.");
    }

    function previousPage() {
        if (currentPage > 1) {
            currentPage--;
            renderEvents();
            showToast("Previous page.");
        }
    }

    function nextPage() {
        var totalPages = Math.max(1, Math.ceil(getFilteredEvents().length / pageSize));

        if (currentPage < totalPages) {
            currentPage++;
            renderEvents();
            showToast("Next page.");
        }
    }

    function goToPage(page) {
        var totalPages = Math.max(1, Math.ceil(getFilteredEvents().length / pageSize));

        if (page <= totalPages) {
            currentPage = page;
            renderEvents();
            showToast("Page " + page + " selected.");
        }
    }

    function updateSummary() {
        var upcoming = 0;
        var registered = 0;
        var online = 0;
        var cancelled = 0;

        events.forEach(function (item) {
            if (item.status === "Upcoming") {
                upcoming++;
            }

            if (item.status === "Cancelled") {
                cancelled++;
            }

            if (item.format === "Online") {
                online++;
            }

            registered += parseInt(item.registered, 10) || 0;
        });

        setText("upcomingValue", upcoming);
        setText("registeredValue", registered);
        setText("onlineValue", online);
        setText("cancelledValue", cancelled);
    }

    function exportEventReport() {
        updateSummary();

        var rows = events.map(function (item) {
            return "<tr>" +
                "<td>" + escapeHtml(item.title) + "</td>" +
                "<td>" + escapeHtml(item.module) + "</td>" +
                "<td>" + escapeHtml(item.status) + "</td>" +
                "<td>" + escapeHtml(item.format) + "</td>" +
                "<td>" + escapeHtml(item.date) + "</td>" +
                "<td>" + escapeHtml(item.time) + "</td>" +
                "<td>" + item.registered + "</td>" +
                "</tr>";
        }).join("");

        var reportWindow = window.open("", "_blank", "width=1100,height=800");

        if (!reportWindow) {
            alert("Popup blocked. Please allow popups to export the report.");
            return;
        }

        reportWindow.document.open();
        reportWindow.document.write(
            "<!DOCTYPE html><html><head><title>Aidify Event Report</title>" +
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
            "<h1>Aidify Event Report</h1>" +
            "<div class='sub'>Generated from Instructor Event Manager</div>" +
            "<div class='summary'>" +
            "<div class='box'><div class='label'>Upcoming</div><div class='value'>" + getText("upcomingValue") + "</div></div>" +
            "<div class='box'><div class='label'>Registered</div><div class='value'>" + getText("registeredValue") + "</div></div>" +
            "<div class='box'><div class='label'>Online</div><div class='value'>" + getText("onlineValue") + "</div></div>" +
            "<div class='box'><div class='label'>Cancelled</div><div class='value'>" + getText("cancelledValue") + "</div></div>" +
            "</div>" +
            "<table><thead><tr><th>Event</th><th>Module</th><th>Status</th><th>Format</th><th>Date</th><th>Time</th><th>Registered</th></tr></thead><tbody>" +
            rows +
            "</tbody></table></body></html>"
        );
        reportWindow.document.close();

        showToast("Event report exported.");
    }

    function openNotifications() {
        alert(
            "Event Notifications\n\n" +
            "• 3 events are scheduled this week.\n" +
            "• Airway Emergency Webinar has 68 registrations.\n" +
            "• One cancelled event needs learner notification."
        );
    }

    function openHelp() {
        alert(
            "Events Help\n\n" +
            "Create Event: opens a blank event form.\n" +
            "Edit: loads event details into the editor.\n" +
            "Registrations: shows learner registration summary.\n" +
            "Cancel: marks an event as cancelled.\n" +
            "Filters: show events by status or format.\n" +
            "Search: searches event title, module, location, and description.\n" +
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

    function parseDateParts(dateValue) {
        var date = new Date(dateValue + "T00:00:00");

        if (isNaN(date.getTime())) {
            return { month: "TBD", day: "--" };
        }

        return {
            month: date.toLocaleString("en-US", { month: "short" }),
            day: String(date.getDate()).padStart(2, "0")
        };
    }

    function formatDateTime(dateValue, timeValue) {
        var date = new Date(dateValue + "T" + timeValue);

        if (isNaN(date.getTime())) {
            return "Date not set";
        }

        var dateText = date.toLocaleDateString("en-GB", {
            day: "2-digit",
            month: "long",
            year: "numeric"
        });

        var timeText = date.toLocaleTimeString("en-US", {
            hour: "numeric",
            minute: "2-digit"
        });

        return dateText + ", " + timeText;
    }

    function getStatusClass(status) {
        return status === "Cancelled" ? "badge-cancelled" : "badge-upcoming";
    }

    function getFormatClass(format) {
        return format === "Online" ? "badge-online" : "badge-person";
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