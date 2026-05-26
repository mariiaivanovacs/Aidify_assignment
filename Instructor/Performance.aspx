<%@ Page Title="Learner Performance" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Performance.aspx.cs" Inherits="Aidify_assigment.Instructor.Performance" %>

<asp:Content ID="PerformanceContent" ContentPlaceHolderID="MainContent" runat="server">

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
        transition: 0.2s ease;
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

    .header-actions {
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

    .summary-card {
        background: #fff;
        border: 1px solid #e6bdb8;
        border-radius: 10px;
        padding: 18px;
        box-shadow: 0 4px 14px rgba(40, 23, 21, .06);
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

    .performance-grid {
        display: grid;
        grid-template-columns: minmax(0, 1.45fr) minmax(360px, .8fr);
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
        margin-top: 22px;
    }

    .panel-header {
        padding: 18px 20px;
        border-bottom: 1px solid #e6bdb8;
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 14px;
        background: #fff8f7;
    }

    .panel-title {
        color: #281715;
        font-size: 20px;
        font-weight: 800;
        margin: 0;
    }

    .panel-subtitle {
        color: #5c403c;
        font-size: 12px;
        margin: 4px 0 0;
    }

    .panel-body {
        padding: 20px;
    }

    .performance-chart-wrap {
        background: #fff8f7;
        border: 1px solid #e6bdb8;
        border-radius: 12px;
        padding: 18px;
    }

    #performanceChart {
        width: 100% !important;
        max-width: 100%;
        height: 320px;
        display: block;
    }

    .chart-note {
        margin-top: 12px;
        color: #5c403c;
        font-size: 12px;
        font-weight: 700;
    }

    .chart-list {
        display: none;
    }

    .filter-row {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
        align-items: center;
        margin-bottom: 18px;
    }

    .filter-search {
        position: relative;
        flex: 1;
        min-width: 240px;
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
    .filter-row select {
        width: 100%;
        height: 38px;
        border: 1px solid #e6bdb8;
        background: #fff8f7;
        border-radius: 8px;
        padding: 0 12px;
        outline: none;
        color: #281715;
        font-size: 13px;
        box-sizing: border-box;
    }

    .filter-search input {
        padding-left: 38px;
    }

    .table-wrap {
        overflow-x: auto;
    }

    .data-table {
        width: 100%;
        border-collapse: collapse;
        min-width: 760px;
    }

    .data-table th {
        background: #fff0ee;
        color: #5c403c;
        text-align: left;
        font-size: 11px;
        font-weight: 800;
        text-transform: uppercase;
        padding: 12px;
        border-bottom: 1px solid #e6bdb8;
    }

    .data-table td {
        padding: 14px 12px;
        border-bottom: 1px solid #f0d2ce;
        color: #281715;
        font-size: 13px;
        vertical-align: middle;
    }

    .learner-name {
        font-weight: 800;
    }

    .learner-email {
        color: #5c403c;
        font-size: 12px;
        margin-top: 3px;
    }

    .badge {
        border-radius: 6px;
        padding: 5px 8px;
        font-size: 10px;
        font-weight: 800;
        text-transform: uppercase;
        display: inline-flex;
    }

    .badge-good {
        background: #dcfce7;
        color: #15803d;
    }

    .badge-warning {
        background: #fef3c7;
        color: #a16207;
    }

    .badge-risk {
        background: #ffdad6;
        color: #ba1a1a;
    }

    .mini-progress {
        width: 110px;
        height: 8px;
        border-radius: 999px;
        background: #ffe9e6;
        overflow: hidden;
    }

    .mini-progress-fill {
        height: 100%;
        background: #b70011;
        border-radius: 999px;
    }

    .row-actions {
        display: flex;
        gap: 7px;
    }

    .icon-btn {
        width: 34px;
        height: 34px;
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

    .insight-list {
        display: grid;
        gap: 12px;
    }

    .insight-item {
        display: flex;
        gap: 12px;
        padding: 12px;
        border: 1px solid #e6bdb8;
        background: #fff8f7;
        border-radius: 10px;
    }

    .insight-icon {
        width: 34px;
        height: 34px;
        border-radius: 8px;
        background: #ffe9e6;
        color: #b70011;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }

    .insight-title {
        color: #281715;
        font-size: 13px;
        font-weight: 800;
        margin-bottom: 4px;
    }

    .insight-text {
        color: #5c403c;
        font-size: 12px;
        line-height: 1.5;
    }

    .hidden-panel {
        display: none;
        margin-top: 22px;
    }

    .hidden-panel.visible {
        display: block;
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
        .performance-grid {
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

            <a href="/Instructor/Quizzes/List.aspx">
                <span class="material-symbols-outlined">quiz</span>
                Quizzes
            </a>

            <a class="active" href="/Instructor/Performance.aspx">
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
            <input id="globalSearch" type="text" placeholder="Search learners, modules, or progress..." />
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
                    <h2 class="page-title">Learner Performance</h2>
                    <p class="page-subtitle">Monitor quiz attempts, progress records, and module-level learning outcomes.</p>
                </div>

                <div class="header-actions">
                    <button type="button" class="btn-muted" onclick="refreshPerformance()">
                        <span class="material-symbols-outlined">refresh</span>
                        Refresh
                    </button>

                    <button type="button" class="btn-outline-red" onclick="toggleAttemptsPanel()">
                        <span class="material-symbols-outlined">quiz</span>
                        View Quiz Attempts
                    </button>

                    <button type="button" class="btn-primary-red" onclick="exportReport()">
                        <span class="material-symbols-outlined">ios_share</span>
                        Export Report
                    </button>
                </div>
            </section>

            <section class="summary-grid">
                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">groups</span></div>
                    <div class="summary-label">Tracked Learners</div>
                    <p class="summary-value" id="trackedLearners">6</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">check_circle</span></div>
                    <div class="summary-label">Average Quiz Score</div>
                    <p class="summary-value" id="avgScore">82%</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">pending_actions</span></div>
                    <div class="summary-label">Quiz Attempts</div>
                    <p class="summary-value" id="attemptCount">18</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">trending_up</span></div>
                    <div class="summary-label">Average Progress</div>
                    <p class="summary-value" id="avgProgress">74%</p>
                </div>
            </section>

            <section class="performance-grid">

                <div>
                    <div class="panel-card">
                        <div class="panel-header">
                            <div>
                                <h3 class="panel-title">Average Quiz Score by Module</h3>
                                <p class="panel-subtitle">Bar chart showing average quiz score per module.</p>
                            </div>

                            <button type="button" class="btn-muted" onclick="sortChart()">
                                <span class="material-symbols-outlined">sort</span>
                                Sort
                            </button>
                        </div>

                        <div class="panel-body">
                            <div class="performance-chart-wrap">
                                <canvas id="performanceChart" width="900" height="320"></canvas>
                                <p class="chart-note">
                                    Higher bars indicate stronger learner performance. Trauma Response currently needs review.
                                </p>
                            </div>

                            <div class="chart-list" id="chartList">
                                <div class="chart-row" data-score="88" data-module="CPR Fundamentals"></div>
                                <div class="chart-row" data-score="76" data-module="Airway Emergencies"></div>
                                <div class="chart-row" data-score="69" data-module="Trauma Response"></div>
                                <div class="chart-row" data-score="84" data-module="Burn Treatment Basics"></div>
                                <div class="chart-row" data-score="91" data-module="Emergency Wound Care"></div>
                            </div>
                        </div>
                    </div>

                    <div class="panel-card">
                        <div class="panel-header">
                            <div>
                                <h3 class="panel-title">Quiz Attempts & Progress Records</h3>
                                <p class="panel-subtitle">Learner-level performance records for instructor review.</p>
                            </div>

                            <button type="button" class="btn-muted" onclick="toggleRecordsPanel()">
                                <span class="material-symbols-outlined">fact_check</span>
                                View Progress Records
                            </button>
                        </div>

                        <div class="panel-body">
                            <div class="filter-row">
                                <div class="filter-search">
                                    <span class="material-symbols-outlined">search</span>
                                    <input id="learnerSearch" type="text" placeholder="Search learner..." />
                                </div>

                                <select id="moduleFilter" onchange="filterLearners()">
                                    <option value="all">All Modules</option>
                                    <option value="CPR Fundamentals">CPR Fundamentals</option>
                                    <option value="Airway Emergencies">Airway Emergencies</option>
                                    <option value="Trauma Response">Trauma Response</option>
                                    <option value="Burn Treatment Basics">Burn Treatment Basics</option>
                                </select>

                                <select id="statusFilter" onchange="filterLearners()">
                                    <option value="all">All Status</option>
                                    <option value="Good">Good</option>
                                    <option value="Needs Review">Needs Review</option>
                                    <option value="At Risk">At Risk</option>
                                </select>

                                <button type="button" class="btn-muted" onclick="clearFilters()">
                                    <span class="material-symbols-outlined">filter_alt_off</span>
                                    Clear
                                </button>
                            </div>

                            <div class="table-wrap">
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>Learner</th>
                                            <th>Module</th>
                                            <th>Quiz Score</th>
                                            <th>Attempts</th>
                                            <th>Progress</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>

                                    <tbody id="learnerTableBody">
                                        <tr class="learner-row" data-name="amira hassan" data-module="CPR Fundamentals" data-score="92" data-progress="96" data-status="Good" data-attempts="3">
                                            <td><div class="learner-name">Amira Hassan</div><div class="learner-email">amira.hassan@student.edu</div></td>
                                            <td>CPR Fundamentals</td>
                                            <td>92%</td>
                                            <td>3</td>
                                            <td><div class="mini-progress"><div class="mini-progress-fill" style="width:96%;"></div></div></td>
                                            <td><span class="badge badge-good">Good</span></td>
                                            <td class="row-actions">
                                                <button type="button" class="icon-btn" onclick="viewLearner(this)"><span class="material-symbols-outlined">visibility</span></button>
                                                <button type="button" class="icon-btn" onclick="messageLearner(this)"><span class="material-symbols-outlined">mail</span></button>
                                            </td>
                                        </tr>

                                        <tr class="learner-row" data-name="daniel lim" data-module="Airway Emergencies" data-score="75" data-progress="70" data-status="Needs Review" data-attempts="2">
                                            <td><div class="learner-name">Daniel Lim</div><div class="learner-email">daniel.lim@student.edu</div></td>
                                            <td>Airway Emergencies</td>
                                            <td>75%</td>
                                            <td>2</td>
                                            <td><div class="mini-progress"><div class="mini-progress-fill" style="width:70%;"></div></div></td>
                                            <td><span class="badge badge-warning">Needs Review</span></td>
                                            <td class="row-actions">
                                                <button type="button" class="icon-btn" onclick="viewLearner(this)"><span class="material-symbols-outlined">visibility</span></button>
                                                <button type="button" class="icon-btn" onclick="messageLearner(this)"><span class="material-symbols-outlined">mail</span></button>
                                            </td>
                                        </tr>

                                        <tr class="learner-row" data-name="sara wong" data-module="Trauma Response" data-score="58" data-progress="45" data-status="At Risk" data-attempts="4">
                                            <td><div class="learner-name">Sara Wong</div><div class="learner-email">sara.wong@student.edu</div></td>
                                            <td>Trauma Response</td>
                                            <td>58%</td>
                                            <td>4</td>
                                            <td><div class="mini-progress"><div class="mini-progress-fill" style="width:45%;"></div></div></td>
                                            <td><span class="badge badge-risk">At Risk</span></td>
                                            <td class="row-actions">
                                                <button type="button" class="icon-btn" onclick="viewLearner(this)"><span class="material-symbols-outlined">visibility</span></button>
                                                <button type="button" class="icon-btn" onclick="messageLearner(this)"><span class="material-symbols-outlined">mail</span></button>
                                            </td>
                                        </tr>

                                        <tr class="learner-row" data-name="omar khalid" data-module="Burn Treatment Basics" data-score="86" data-progress="82" data-status="Good" data-attempts="2">
                                            <td><div class="learner-name">Omar Khalid</div><div class="learner-email">omar.khalid@student.edu</div></td>
                                            <td>Burn Treatment Basics</td>
                                            <td>86%</td>
                                            <td>2</td>
                                            <td><div class="mini-progress"><div class="mini-progress-fill" style="width:82%;"></div></div></td>
                                            <td><span class="badge badge-good">Good</span></td>
                                            <td class="row-actions">
                                                <button type="button" class="icon-btn" onclick="viewLearner(this)"><span class="material-symbols-outlined">visibility</span></button>
                                                <button type="button" class="icon-btn" onclick="messageLearner(this)"><span class="material-symbols-outlined">mail</span></button>
                                            </td>
                                        </tr>

                                        <tr class="learner-row" data-name="lina tan" data-module="CPR Fundamentals" data-score="79" data-progress="74" data-status="Needs Review" data-attempts="3">
                                            <td><div class="learner-name">Lina Tan</div><div class="learner-email">lina.tan@student.edu</div></td>
                                            <td>CPR Fundamentals</td>
                                            <td>79%</td>
                                            <td>3</td>
                                            <td><div class="mini-progress"><div class="mini-progress-fill" style="width:74%;"></div></div></td>
                                            <td><span class="badge badge-warning">Needs Review</span></td>
                                            <td class="row-actions">
                                                <button type="button" class="icon-btn" onclick="viewLearner(this)"><span class="material-symbols-outlined">visibility</span></button>
                                                <button type="button" class="icon-btn" onclick="messageLearner(this)"><span class="material-symbols-outlined">mail</span></button>
                                            </td>
                                        </tr>

                                        <tr class="learner-row" data-name="jason lee" data-module="Airway Emergencies" data-score="89" data-progress="88" data-status="Good" data-attempts="4">
                                            <td><div class="learner-name">Jason Lee</div><div class="learner-email">jason.lee@student.edu</div></td>
                                            <td>Airway Emergencies</td>
                                            <td>89%</td>
                                            <td>4</td>
                                            <td><div class="mini-progress"><div class="mini-progress-fill" style="width:88%;"></div></div></td>
                                            <td><span class="badge badge-good">Good</span></td>
                                            <td class="row-actions">
                                                <button type="button" class="icon-btn" onclick="viewLearner(this)"><span class="material-symbols-outlined">visibility</span></button>
                                                <button type="button" class="icon-btn" onclick="messageLearner(this)"><span class="material-symbols-outlined">mail</span></button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div id="attemptsPanel" class="panel-card hidden-panel">
                        <div class="panel-header">
                            <div>
                                <h3 class="panel-title">Quiz Attempts Details</h3>
                                <p class="panel-subtitle">Latest attempt records from learner quiz activity.</p>
                            </div>

                            <button type="button" class="btn-muted" onclick="toggleAttemptsPanel()">
                                <span class="material-symbols-outlined">close</span>
                                Close
                            </button>
                        </div>

                        <div class="panel-body">
                            <div class="insight-list">
                                <div class="insight-item">
                                    <div class="insight-icon"><span class="material-symbols-outlined">quiz</span></div>
                                    <div>
                                        <div class="insight-title">Amira Hassan — CPR Fundamentals</div>
                                        <div class="insight-text">Attempt 3 scored 92%. Completed in 8 minutes.</div>
                                    </div>
                                </div>

                                <div class="insight-item">
                                    <div class="insight-icon"><span class="material-symbols-outlined">quiz</span></div>
                                    <div>
                                        <div class="insight-title">Sara Wong — Trauma Response</div>
                                        <div class="insight-text">Attempt 4 scored 58%. Recommended for revision support.</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="recordsPanel" class="panel-card hidden-panel">
                        <div class="panel-header">
                            <div>
                                <h3 class="panel-title">Progress Records</h3>
                                <p class="panel-subtitle">Structured view of completion and learning progress.</p>
                            </div>

                            <button type="button" class="btn-muted" onclick="toggleRecordsPanel()">
                                <span class="material-symbols-outlined">close</span>
                                Close
                            </button>
                        </div>

                        <div class="panel-body">
                            <div class="insight-list">
                                <div class="insight-item">
                                    <div class="insight-icon"><span class="material-symbols-outlined">trending_up</span></div>
                                    <div>
                                        <div class="insight-title">CPR Fundamentals completion is strong</div>
                                        <div class="insight-text">Average completion is above 85%, with most learners passing on first or second attempt.</div>
                                    </div>
                                </div>

                                <div class="insight-item">
                                    <div class="insight-icon"><span class="material-symbols-outlined">warning</span></div>
                                    <div>
                                        <div class="insight-title">Trauma Response needs review</div>
                                        <div class="insight-text">Lower quiz scores and progress indicate this module may need clearer case explanations.</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <aside>
                    <div class="panel-card">
                        <div class="panel-header">
                            <div>
                                <h3 class="panel-title">Instructor Insights</h3>
                                <p class="panel-subtitle">Automatic interpretation of learner performance.</p>
                            </div>
                        </div>

                        <div class="panel-body">
                            <div class="insight-list" id="insightsList">
                                <div class="insight-item">
                                    <div class="insight-icon"><span class="material-symbols-outlined">verified</span></div>
                                    <div>
                                        <div class="insight-title">Strong CPR understanding</div>
                                        <div class="insight-text">Most learners are above 85% in CPR Fundamentals.</div>
                                    </div>
                                </div>

                                <div class="insight-item">
                                    <div class="insight-icon"><span class="material-symbols-outlined">priority_high</span></div>
                                    <div>
                                        <div class="insight-title">Trauma module risk</div>
                                        <div class="insight-text">Scores below 70% suggest learners need clearer case-based practice.</div>
                                    </div>
                                </div>
                            </div>

                            <div style="display:grid; gap:10px; margin-top:16px;">
                                <button type="button" class="btn-primary-red" onclick="generateInsight()">
                                    <span class="material-symbols-outlined">auto_awesome</span>
                                    Generate AI Insight
                                </button>

                                <button type="button" class="btn-outline-red" onclick="flagAtRiskLearners()">
                                    <span class="material-symbols-outlined">flag</span>
                                    Flag At-Risk Learners
                                </button>

                                <button type="button" class="btn-muted" onclick="printPerformance()">
                                    <span class="material-symbols-outlined">print</span>
                                    Print View
                                </button>
                            </div>
                        </div>
                    </div>
                </aside>

            </section>

        </div>
    </main>

</div>

<div id="performanceToast" class="toast">Action completed.</div>

<script>
    var chartSorted = false;

    document.addEventListener("DOMContentLoaded", function () {
        setupSearch();
        drawPerformanceChart();
        updateSummary();
    });

    function setupSearch() {
        var learnerSearch = document.getElementById("learnerSearch");
        var globalSearch = document.getElementById("globalSearch");

        if (learnerSearch) {
            learnerSearch.addEventListener("input", filterLearners);
        }

        if (globalSearch && learnerSearch) {
            globalSearch.addEventListener("input", function () {
                learnerSearch.value = globalSearch.value;
                filterLearners();
            });
        }
    }

    function showToast(message) {
        var toast = document.getElementById("performanceToast");
        toast.textContent = message;
        toast.classList.add("show");

        window.clearTimeout(window.__performanceToastTimer);
        window.__performanceToastTimer = window.setTimeout(function () {
            toast.classList.remove("show");
        }, 2200);
    }

    function getChartData() {
        var rows = Array.prototype.slice.call(document.querySelectorAll("#chartList .chart-row"));

        return rows.map(function (row) {
            return {
                module: row.getAttribute("data-module"),
                score: parseInt(row.getAttribute("data-score"), 10) || 0
            };
        });
    }

    function drawPerformanceChart() {
        var canvas = document.getElementById("performanceChart");
        if (!canvas) return;

        var ctx = canvas.getContext("2d");
        var data = getChartData();

        var width = canvas.width;
        var height = canvas.height;

        ctx.clearRect(0, 0, width, height);

        var paddingLeft = 190;
        var paddingRight = 45;
        var paddingTop = 42;
        var rowHeight = 50;
        var barHeight = 22;
        var maxScore = 100;
        var chartWidth = width - paddingLeft - paddingRight;

        ctx.font = "800 17px Inter, Arial";
        ctx.fillStyle = "#281715";
        ctx.fillText("Module Quiz Performance", 20, 24);

        data.forEach(function (item, index) {
            var y = paddingTop + 25 + index * rowHeight;
            var barWidth = (item.score / maxScore) * chartWidth;

            ctx.font = "700 13px Inter, Arial";
            ctx.fillStyle = "#281715";
            ctx.fillText(item.module, 20, y + 16);

            ctx.fillStyle = "#ffe9e6";
            roundRect(ctx, paddingLeft, y, chartWidth, barHeight, 10, true);

            ctx.fillStyle = getScoreColor(item.score);
            roundRect(ctx, paddingLeft, y, barWidth, barHeight, 10, true);

            ctx.font = "800 13px Inter, Arial";
            ctx.fillStyle = "#b70011";
            ctx.fillText(item.score + "%", paddingLeft + chartWidth + 10, y + 16);
        });

        ctx.font = "700 11px Inter, Arial";
        ctx.fillStyle = "#5c403c";
        ctx.fillText("0%", paddingLeft, height - 14);
        ctx.fillText("50%", paddingLeft + chartWidth / 2 - 10, height - 14);
        ctx.fillText("100%", paddingLeft + chartWidth - 25, height - 14);
    }

    function getScoreColor(score) {
        if (score >= 85) return "#15803d";
        if (score >= 70) return "#b70011";
        return "#ba1a1a";
    }

    function roundRect(ctx, x, y, width, height, radius, fill) {
        if (width < radius * 2) radius = width / 2;

        ctx.beginPath();
        ctx.moveTo(x + radius, y);
        ctx.arcTo(x + width, y, x + width, y + height, radius);
        ctx.arcTo(x + width, y + height, x, y + height, radius);
        ctx.arcTo(x, y + height, x, y, radius);
        ctx.arcTo(x, y, x + width, y, radius);
        ctx.closePath();

        if (fill) ctx.fill();
    }

    function sortChart() {
        var chartList = document.getElementById("chartList");
        var rows = Array.prototype.slice.call(chartList.querySelectorAll(".chart-row"));

        rows.sort(function (a, b) {
            var scoreA = parseInt(a.getAttribute("data-score"), 10);
            var scoreB = parseInt(b.getAttribute("data-score"), 10);

            return chartSorted ? scoreA - scoreB : scoreB - scoreA;
        });

        rows.forEach(function (row) {
            chartList.appendChild(row);
        });

        chartSorted = !chartSorted;
        drawPerformanceChart();

        showToast(chartSorted ? "Chart sorted highest to lowest." : "Chart sorted lowest to highest.");
    }

    function filterLearners() {
        var search = (document.getElementById("learnerSearch").value || "").toLowerCase().trim();
        var moduleValue = document.getElementById("moduleFilter").value;
        var statusValue = document.getElementById("statusFilter").value;
        var rows = document.querySelectorAll(".learner-row");
        var visible = 0;

        rows.forEach(function (row) {
            var name = row.getAttribute("data-name") || "";
            var moduleName = row.getAttribute("data-module") || "";
            var status = row.getAttribute("data-status") || "";

            var matchName = !search || name.indexOf(search) !== -1;
            var matchModule = moduleValue === "all" || moduleName === moduleValue;
            var matchStatus = statusValue === "all" || status === statusValue;

            if (matchName && matchModule && matchStatus) {
                row.style.display = "";
                visible++;
            } else {
                row.style.display = "none";
            }
        });

        updateSummary();
        showToast("Showing " + visible + " learner record(s).");
    }

    function clearFilters() {
        document.getElementById("learnerSearch").value = "";
        document.getElementById("globalSearch").value = "";
        document.getElementById("moduleFilter").value = "all";
        document.getElementById("statusFilter").value = "all";

        document.querySelectorAll(".learner-row").forEach(function (row) {
            row.style.display = "";
        });

        updateSummary();
        showToast("Filters cleared.");
    }

    function updateSummary() {
        var rows = Array.prototype.slice.call(document.querySelectorAll(".learner-row")).filter(function (row) {
            return row.style.display !== "none";
        });

        var total = rows.length;
        var scoreSum = 0;
        var progressSum = 0;
        var attemptsSum = 0;

        rows.forEach(function (row) {
            scoreSum += parseInt(row.getAttribute("data-score"), 10) || 0;
            progressSum += parseInt(row.getAttribute("data-progress"), 10) || 0;
            attemptsSum += parseInt(row.getAttribute("data-attempts"), 10) || 0;
        });

        var avgScore = total ? Math.round(scoreSum / total) : 0;
        var avgProgress = total ? Math.round(progressSum / total) : 0;

        document.getElementById("trackedLearners").textContent = total;
        document.getElementById("avgScore").textContent = avgScore + "%";
        document.getElementById("avgProgress").textContent = avgProgress + "%";
        document.getElementById("attemptCount").textContent = attemptsSum;
    }

    function viewLearner(button) {
        var row = button.closest(".learner-row");
        var name = row.querySelector(".learner-name").textContent;
        var moduleName = row.getAttribute("data-module");
        var score = row.getAttribute("data-score");
        var progress = row.getAttribute("data-progress");
        var status = row.getAttribute("data-status");

        alert(
            "Learner Performance Details\n\n" +
            "Name: " + name + "\n" +
            "Module: " + moduleName + "\n" +
            "Quiz Score: " + score + "%\n" +
            "Progress: " + progress + "%\n" +
            "Status: " + status
        );
    }

    function messageLearner(button) {
        var row = button.closest(".learner-row");
        var name = row.querySelector(".learner-name").textContent;
        var email = row.querySelector(".learner-email").textContent;

        alert(
            "Message Learner\n\n" +
            "To: " + name + " <" + email + ">\n\n" +
            "Suggested message:\n" +
            "Please review your latest module feedback and complete the recommended practice activity."
        );
    }

    function toggleAttemptsPanel() {
        var panel = document.getElementById("attemptsPanel");
        panel.classList.toggle("visible");

        if (panel.classList.contains("visible")) {
            panel.scrollIntoView({ behavior: "smooth", block: "start" });
            showToast("Quiz attempts panel opened.");
        } else {
            showToast("Quiz attempts panel closed.");
        }
    }

    function toggleRecordsPanel() {
        var panel = document.getElementById("recordsPanel");
        panel.classList.toggle("visible");

        if (panel.classList.contains("visible")) {
            panel.scrollIntoView({ behavior: "smooth", block: "start" });
            showToast("Progress records panel opened.");
        } else {
            showToast("Progress records panel closed.");
        }
    }

    function refreshPerformance() {
        clearFilters();
        drawPerformanceChart();
        updateSummary();
        showToast("Performance data refreshed.");
    }

    function generateInsight() {
        var list = document.getElementById("insightsList");
        var item = document.createElement("div");

        item.className = "insight-item";
        item.innerHTML =
            '<div class="insight-icon"><span class="material-symbols-outlined">auto_awesome</span></div>' +
            '<div>' +
            '<div class="insight-title">AI Insight Generated</div>' +
            '<div class="insight-text">Learners with repeated attempts benefit from short scenario-based recap activities before retaking quizzes.</div>' +
            '</div>';

        list.prepend(item);
        showToast("AI insight generated.");
    }

    function flagAtRiskLearners() {
        document.getElementById("statusFilter").value = "At Risk";
        filterLearners();
        showToast("At-risk learners flagged.");
    }

    function buildReportHtml(title) {
        var chartData = getChartData();
        var rows = Array.prototype.slice.call(document.querySelectorAll(".learner-row")).filter(function (row) {
            return row.style.display !== "none";
        });

        var chartHtml = chartData.map(function (item) {
            return (
                '<div class="report-chart-row">' +
                '<div class="report-chart-label">' + item.module + '</div>' +
                '<div class="report-chart-track">' +
                '<div class="report-chart-fill" style="width:' + item.score + '%;"></div>' +
                '</div>' +
                '<div class="report-chart-value">' + item.score + '%</div>' +
                '</div>'
            );
        }).join("");

        var tableRows = rows.map(function (row) {
            var learner = row.querySelector(".learner-name").textContent;
            var moduleName = row.getAttribute("data-module");
            var score = row.getAttribute("data-score");
            var progress = row.getAttribute("data-progress");
            var attempts = row.getAttribute("data-attempts");
            var status = row.getAttribute("data-status");

            return (
                "<tr>" +
                "<td>" + learner + "</td>" +
                "<td>" + moduleName + "</td>" +
                "<td>" + score + "%</td>" +
                "<td>" + attempts + "</td>" +
                "<td>" + progress + "%</td>" +
                "<td>" + status + "</td>" +
                "</tr>"
            );
        }).join("");

        return (
            "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
            "<title>" + title + "</title>" +
            "<style>" +
            "body{font-family:Arial,sans-serif;margin:32px;color:#281715;background:#fff;}" +
            ".report-head{border-bottom:3px solid #b70011;padding-bottom:16px;margin-bottom:24px;}" +
            "h1{margin:0;color:#b70011;font-size:28px;}" +
            ".sub{color:#5c403c;margin-top:6px;}" +
            ".summary{display:grid;grid-template-columns:repeat(4,1fr);gap:12px;margin-bottom:24px;}" +
            ".box{border:1px solid #e6bdb8;border-radius:10px;padding:14px;background:#fff8f7;}" +
            ".label{font-size:11px;text-transform:uppercase;font-weight:800;color:#5c403c;}" +
            ".value{font-size:24px;font-weight:800;margin-top:6px;}" +
            ".section{margin-top:26px;}" +
            ".section h2{font-size:18px;color:#281715;border-bottom:1px solid #e6bdb8;padding-bottom:8px;}" +
            ".report-chart-row{display:grid;grid-template-columns:190px 1fr 50px;gap:12px;align-items:center;margin:12px 0;}" +
            ".report-chart-label{font-weight:700;font-size:13px;}" +
            ".report-chart-track{height:14px;background:#ffe9e6;border-radius:999px;overflow:hidden;}" +
            ".report-chart-fill{height:100%;background:#b70011;border-radius:999px;}" +
            ".report-chart-value{font-weight:800;color:#b70011;text-align:right;}" +
            "table{width:100%;border-collapse:collapse;margin-top:12px;}" +
            "th{background:#fff0ee;text-align:left;font-size:11px;text-transform:uppercase;color:#5c403c;padding:10px;border:1px solid #e6bdb8;}" +
            "td{padding:10px;border:1px solid #e6bdb8;font-size:13px;}" +
            ".footer{margin-top:28px;color:#5c403c;font-size:12px;}" +
            "@media print{body{margin:18px;}}" +
            "</style>" +
            "</head>" +
            "<body>" +
            "<div class='report-head'>" +
            "<h1>Aidify Learner Performance Report</h1>" +
            "<div class='sub'>Generated by Instructor Portal • Dr. Sarah Mitchell</div>" +
            "</div>" +

            "<div class='summary'>" +
            "<div class='box'><div class='label'>Tracked Learners</div><div class='value'>" + document.getElementById("trackedLearners").textContent + "</div></div>" +
            "<div class='box'><div class='label'>Average Quiz Score</div><div class='value'>" + document.getElementById("avgScore").textContent + "</div></div>" +
            "<div class='box'><div class='label'>Quiz Attempts</div><div class='value'>" + document.getElementById("attemptCount").textContent + "</div></div>" +
            "<div class='box'><div class='label'>Average Progress</div><div class='value'>" + document.getElementById("avgProgress").textContent + "</div></div>" +
            "</div>" +

            "<div class='section'>" +
            "<h2>Average Quiz Score by Module</h2>" +
            chartHtml +
            "</div>" +

            "<div class='section'>" +
            "<h2>Learner Performance Records</h2>" +
            "<table>" +
            "<thead><tr><th>Learner</th><th>Module</th><th>Quiz Score</th><th>Attempts</th><th>Progress</th><th>Status</th></tr></thead>" +
            "<tbody>" + tableRows + "</tbody>" +
            "</table>" +
            "</div>" +

            "<div class='footer'>This is a UI-generated report for prototype demonstration.</div>" +
            "</body>" +
            "</html>"
        );
    }

    function exportReport() {
        updateSummary();

        var reportWindow = window.open("", "_blank", "width=1100,height=800");

        if (!reportWindow) {
            alert("Popup blocked. Please allow popups for this site to export the report.");
            return;
        }

        reportWindow.document.open();
        reportWindow.document.write(buildReportHtml("Aidify Performance Export Report"));
        reportWindow.document.close();

        showToast("Clean export report opened.");
    }

    function printPerformance() {
        updateSummary();

        var reportWindow = window.open("", "_blank", "width=1100,height=800");

        if (!reportWindow) {
            alert("Popup blocked. Please allow popups for this site to print the report.");
            return;
        }

        reportWindow.document.open();
        reportWindow.document.write(buildReportHtml("Aidify Performance Print Report"));
        reportWindow.document.close();

        setTimeout(function () {
            reportWindow.focus();
            reportWindow.print();
        }, 600);

        showToast("Clean print report opened.");
    }

    function openNotifications() {
        alert(
            "Notifications\n\n" +
            "• 2 learners are currently at risk.\n" +
            "• Trauma Response average score dropped below 70%.\n" +
            "• CPR Fundamentals completion improved this week."
        );
    }

    function openHelp() {
        alert(
            "Performance Page Help\n\n" +
            "Refresh: resets filters and redraws the chart.\n" +
            "View Quiz Attempts: opens quiz attempt details.\n" +
            "View Progress Records: opens progress analysis.\n" +
            "Export Report: opens a clean report page.\n" +
            "Print View: opens a clean printable report.\n" +
            "Sort: sorts the chart bars.\n" +
            "AI Insight: adds an instructor recommendation.\n" +
            "Flag At-Risk Learners: filters learners who need support."
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
</script>

</asp:Content>