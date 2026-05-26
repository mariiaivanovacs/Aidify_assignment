<%@ Page Title="Instructor Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Aidify_assigment.Instructor.Dashboard" %>

<asp:Content ID="DashboardContent" ContentPlaceHolderID="MainContent" runat="server">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

    <div style="display:none;">
        <asp:Label ID="lblWelcomeInstructor" runat="server"></asp:Label>
        <asp:Label ID="lblPendingDiscussions" runat="server"></asp:Label>
        <asp:Repeater ID="rptMyModules" runat="server">
            <ItemTemplate></ItemTemplate>
        </asp:Repeater>
    </div>

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

        .header-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn-primary-red,
        .btn-outline-red {
            border-radius: 8px;
            padding: 11px 18px;
            font-size: 13px;
            font-weight: 800;
            text-decoration: none !important;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            white-space: nowrap;
        }

        .btn-primary-red {
            background: #b70011;
            color: #ffffff !important;
            border: 1px solid #b70011;
            box-shadow: 0 10px 22px rgba(183, 0, 17, 0.16);
        }

        .btn-outline-red {
            background: #ffffff;
            color: #b70011 !important;
            border: 1px solid #e6bdb8;
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

        .summary-card.impact {
            background: #b70011;
            color: #ffffff;
            border-color: #b70011;
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

        .summary-card.impact .summary-icon {
            background: rgba(255,255,255,0.16);
            color: #ffffff;
        }

        .summary-label {
            color: #5c403c;
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            margin-bottom: 5px;
        }

        .summary-card.impact .summary-label,
        .summary-card.impact .summary-note {
            color: rgba(255,255,255,0.86);
        }

        .summary-value {
            color: #281715;
            font-size: 28px;
            line-height: 1;
            font-weight: 800;
            margin: 0;
        }

        .summary-card.impact .summary-value {
            color: #ffffff;
        }

        .summary-note {
            color: #5c403c;
            font-size: 11px;
            font-weight: 700;
            margin: 7px 0 0;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: minmax(0, 2fr) minmax(320px, 1fr);
            gap: 22px;
            align-items: start;
        }

        .section-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 14px;
        }

        .section-title {
            color: #281715;
            font-size: 20px;
            font-weight: 800;
            margin: 0;
        }

        .section-link {
            color: #b70011 !important;
            text-decoration: none !important;
            font-size: 12px;
            font-weight: 800;
        }

        .module-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 18px;
        }

        .module-card,
        .widget-card,
        .progress-card {
            background: #ffffff;
            border: 1px solid #e6bdb8;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(40, 23, 21, 0.06);
            overflow: hidden;
        }

        .module-card:hover,
        .widget-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 26px rgba(40, 23, 21, 0.10);
            transition: 0.22s ease;
        }

        .module-cover {
            height: 130px;
            position: relative;
            overflow: hidden;
            background: #ffe9e6;
        }

        .module-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.92;
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

        .badge-published,
        .badge-easy {
            background: #dcfce7;
            color: #15803d;
        }

        .badge-pending,
        .badge-medium {
            background: #fef3c7;
            color: #a16207;
        }

        .badge-draft {
            background: #f3f4f6;
            color: #374151;
        }

        .badge-hard {
            background: #ffdad6;
            color: #ba1a1a;
        }

        .module-body {
            padding: 16px;
        }

        .module-title {
            color: #281715;
            font-size: 17px;
            line-height: 1.25;
            font-weight: 800;
            margin: 0 0 7px;
        }

        .module-desc {
            color: #5c403c;
            font-size: 12px;
            line-height: 1.5;
            margin: 0 0 14px;
        }

        .module-meta {
            display: flex;
            gap: 14px;
            color: #5c403c;
            font-size: 12px;
            font-weight: 700;
            margin-bottom: 14px;
            flex-wrap: wrap;
        }

        .module-meta span {
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .module-meta .material-symbols-outlined {
            font-size: 16px;
            color: #b70011;
        }

        .module-actions {
            border-top: 1px solid #e6bdb8;
            padding-top: 12px;
            display: flex;
            gap: 8px;
        }

        .module-action {
            color: #281715 !important;
            text-decoration: none !important;
            border-radius: 8px;
            padding: 8px 9px;
            font-size: 12px;
            font-weight: 800;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .module-action:hover {
            background: #fff0ee;
            color: #b70011 !important;
        }

        .right-column {
            display: grid;
            gap: 18px;
        }

        .widget-card {
            padding: 18px;
        }

        .ai-widget {
            background: #b70011;
            color: #ffffff;
            border-color: #b70011;
        }

        .widget-title {
            color: #281715;
            font-size: 17px;
            font-weight: 800;
            margin: 0 0 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .ai-widget .widget-title {
            color: #ffffff;
        }

        .widget-text {
            color: #5c403c;
            font-size: 12px;
            line-height: 1.5;
            margin: 0 0 14px;
        }

        .ai-widget .widget-text {
            color: rgba(255,255,255,0.86);
        }

        .btn-white {
            background: #ffffff;
            color: #b70011 !important;
            border-radius: 8px;
            padding: 9px 12px;
            font-size: 12px;
            font-weight: 800;
            text-decoration: none !important;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .mini-list {
            display: grid;
            gap: 10px;
        }

        .mini-item {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            padding: 10px;
            border: 1px solid #e6bdb8;
            border-radius: 9px;
            background: #fff8f7;
        }

        .mini-icon {
            width: 30px;
            height: 30px;
            border-radius: 8px;
            background: #ffe9e6;
            color: #b70011;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .mini-title {
            color: #281715;
            font-size: 12px;
            font-weight: 800;
            margin-bottom: 2px;
        }

        .mini-subtitle {
            color: #5c403c;
            font-size: 11px;
            font-weight: 700;
        }

        .progress-card {
            padding: 18px;
            margin-top: 22px;
        }

        .progress-list {
            display: grid;
            gap: 14px;
            margin-top: 16px;
        }

        .progress-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #281715;
            font-size: 12px;
            font-weight: 800;
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
            background: #b70011;
            border-radius: 999px;
        }

        @media (max-width: 1150px) {
            .summary-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .dashboard-grid {
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

            .summary-grid,
            .module-grid {
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
                <a class="active" href="/Instructor/Dashboard.aspx">
                    <span class="material-symbols-outlined">dashboard</span>
                    Dashboard
                </a>

                <a href="/Instructor/Modules/List.aspx">
                    <span class="material-symbols-outlined">school</span>
                    Modules
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
                <a href="#">
                    <span class="material-symbols-outlined">settings</span>
                    Settings
                </a>

                <a href="#" style="color:#ba1a1a;">
                    <span class="material-symbols-outlined">logout</span>
                    Logout
                </a>
            </div>
        </aside>

        <header class="aidify-topbar">
            <div class="topbar-search">
                <span class="material-symbols-outlined">search</span>
                <input type="text" placeholder="Search modules, quizzes, learners..." />
            </div>

            <div class="topbar-actions">
                <button type="button" class="topbar-icon">
                    <span class="material-symbols-outlined">notifications</span>
                </button>

                    <div>
                        <div class="profile-name">Dr. Sarah Mitchell</div>
                        <div class="profile-role">Lead Medical Instructor</div>
                    </div>

                <a href="#" class="profile-chip">
                    <img alt="Instructor"
                         src="https://lh3.googleusercontent.com/aida-public/AB6AXuBXsMkMFUJTraaiiBiKzgKj7zUOathxYepxlzKePooHo_1QLZSJZRV7fx_lpr7bF1c6pk1zJFoxlpIt8-qOoxggRqjwSnxvCfkqYeVxvcHDqaSoVAeiX4FaTBC3K1rscvbSFbJwapxCffY01KxBilHs4_-aoB20kHd3jvfZLt9MDdIbRAde7T-REZPaGEdBF7IHm9XA-CpgnCAhrpra-VGpluI4Kr_-7ZekahbaHI2Y4EgIgjzIMAb8PqQHUDfcvtsC55t6sq9pHdY" />
                    <span>Dr. Sarah Mitchell</span>
                </a>
            </div>
        </header>

        <main class="aidify-main">
            <div class="page-container">

                <section class="page-header">
                    <div>
                        <h2 class="page-title">Welcome back, Dr. Sarah Mitchell</h2>
                        <p class="page-subtitle">Here is a quick overview of your instructor activity and learner progress.</p>
                    </div>

                    <div class="header-actions">
                        <a href="/Instructor/Modules/Edit.aspx" class="btn-primary-red">
                            <span class="material-symbols-outlined">add</span>
                            Create Module
                        </a>

                        <a href="/Instructor/Quizzes/GenerateWithAI.aspx" class="btn-outline-red">
                            <span class="material-symbols-outlined">auto_awesome</span>
                            Generate Quiz with AI
                        </a>
                    </div>
                </section>

                <section class="summary-grid">
                    <div class="summary-card">
                        <div class="summary-top">
                            <div class="summary-icon">
                                <span class="material-symbols-outlined">inventory_2</span>
                            </div>
                        </div>
                        <div class="summary-label">Total Modules</div>
                        <p class="summary-value">12</p>
                        <p class="summary-note">+2 this month</p>
                    </div>

                    <div class="summary-card">
                        <div class="summary-top">
                            <div class="summary-icon">
                                <span class="material-symbols-outlined">menu_book</span>
                            </div>
                        </div>
                        <div class="summary-label">Active Lessons</div>
                        <p class="summary-value">45</p>
                        <p class="summary-note">Across 8 categories</p>
                    </div>

                    <div class="summary-card">
                        <div class="summary-top">
                            <div class="summary-icon">
                                <span class="material-symbols-outlined">quiz</span>
                            </div>
                        </div>
                        <div class="summary-label">Quizzes Created</div>
                        <p class="summary-value">28</p>
                        <p class="summary-note">84% average score</p>
                    </div>

                    <div class="summary-card impact">
                        <div class="summary-top">
                            <div class="summary-icon">
                                <span class="material-symbols-outlined">forum</span>
                            </div>
                        </div>
                        <div class="summary-label">Pending Discussions</div>
                        <p class="summary-value">5</p>
                        <p class="summary-note">Awaiting instructor reply</p>
                    </div>
                </section>

                <section class="dashboard-grid">

                    <div>
                        <div class="section-head">
                            <h3 class="section-title">Recent Modules</h3>
                            <a href="/Instructor/Modules/List.aspx" class="section-link">View All</a>
                        </div>

                        <div class="module-grid">

                            <article class="module-card">
                                <div class="module-cover">
                                    <img alt="CPR Fundamentals"
                                         src="https://lh3.googleusercontent.com/aida-public/AB6AXuD_1boaB2rq7_7HwVpN3dP78w_xiv4q2QHR5bO5sqcoY1BameMvfQq6QPsPIkP_Jtu08unqYUgHJHtohLHKv50VZzCdEPaUv-kkkdRuQ6bV-xlso7n4YvdIM5NcCrW3Gl4shRZXWEiA4h7D1yqpPm4hAlPvj3zXsa5w3a3znI7qIHblqScRwwqpx8ojD7gH-4QPJtj0a1j17CLm7GyQr1mOWFppl5XhGjocKvNSPVij2LarITVeixWEv7H32NqJvwNvmsZJGvXnF90" />

                                    <div class="badge-row">
                                        <span class="badge badge-published">Published</span>
                                        <span class="badge badge-easy">Easy</span>
                                    </div>
                                </div>

                                <div class="module-body">
                                    <h4 class="module-title">CPR Fundamentals</h4>
                                    <p class="module-desc">Core life-saving techniques for adult and pediatric CPR.</p>

                                    <div class="module-meta">
                                        <span><span class="material-symbols-outlined">groups</span>124 Learners</span>
                                        <span><span class="material-symbols-outlined">menu_book</span>6 Lessons</span>
                                    </div>

                                    <div class="module-actions">
                                        <a href="/Instructor/Modules/Edit.aspx" class="module-action">
                                            <span class="material-symbols-outlined">edit</span>
                                            Edit
                                        </a>
                                        <a href="/Instructor/Lessons/Edit.aspx" class="module-action">
                                            <span class="material-symbols-outlined">menu_book</span>
                                            View Lessons
                                        </a>
                                    </div>
                                </div>
                            </article>

                            <article class="module-card">
                                <div class="module-cover">
                                    <img alt="Choking and Airway Emergencies"
                                         src="https://lh3.googleusercontent.com/aida-public/AB6AXuAfV9uSpkYjAr19dXYdN29XTHSqNZiN-o_QZbEBnt-ispLzPL3uMAEBkM4GG9CDelnvyPCk_C4kc2Ist_2HRKV1Y8DAvpSxqIl2AlSaXITayMpKtIMf6E1RiBdWPOYMWWmWBxi5kuFPN4z_-Sq3shK1I_k24KEfh5FzFXzzoRXqZsu3igG7YUIUzKpWZPzigvofVm4z14bOkydw7Y7y3DfAk3yibp_WDP36nSGdFfIHT68HR_JsDmDT4H8DFQz02Y9MPMMQC_UpdrI" />

                                    <div class="badge-row">
                                        <span class="badge badge-pending">Pending Review</span>
                                        <span class="badge badge-medium">Medium</span>
                                    </div>
                                </div>

                                <div class="module-body">
                                    <h4 class="module-title">Choking &amp; Airway Emergencies</h4>
                                    <p class="module-desc">Assess and manage airway obstruction scenarios.</p>

                                    <div class="module-meta">
                                        <span><span class="material-symbols-outlined">groups</span>76 Learners</span>
                                        <span><span class="material-symbols-outlined">menu_book</span>4 Lessons</span>
                                    </div>

                                    <div class="module-actions">
                                        <a href="/Instructor/Modules/Edit.aspx" class="module-action">
                                            <span class="material-symbols-outlined">edit</span>
                                            Edit
                                        </a>
                                        <a href="#" class="module-action">
                                            <span class="material-symbols-outlined">send</span>
                                            Submit Review
                                        </a>
                                    </div>
                                </div>
                            </article>

                            <article class="module-card">
                                <div class="module-cover">
                                    <img alt="Trauma Response"
                                         src="https://lh3.googleusercontent.com/aida-public/AB6AXuCKXxjqJt_aZjrDdvr4ZGiOcPBBPax-CNplF4PKimeXW3H7OmemYcanAizIirJI4ViOLzj_ipfh_dMrRdH31ZJX2z8xVNZ53GzLHPSgeMupl5mj-PuvreiBLGLMyfi_e0q_8282Ru4oPf0h6_5pqAp__zWpPAmOZY0aVkFUcAHZDroX6Z32DEmE95LyBrYaGGLutPboR8PziRU6v3XE3l6_jCyyFoMihhlun92XRK3TF3Jc0rNUSbQozzNrHcM5zlgzkVrfjdavxTk" />

                                    <div class="badge-row">
                                        <span class="badge badge-draft">Draft</span>
                                        <span class="badge badge-hard">Hard</span>
                                    </div>
                                </div>

                                <div class="module-body">
                                    <h4 class="module-title">Trauma Response</h4>
                                    <p class="module-desc">Immediate care protocols for bleeding, fractures, and shock.</p>

                                    <div class="module-meta">
                                        <span><span class="material-symbols-outlined">groups</span>52 Learners</span>
                                        <span><span class="material-symbols-outlined">menu_book</span>8 Lessons</span>
                                    </div>

                                    <div class="module-actions">
                                        <a href="/Instructor/Modules/Edit.aspx" class="module-action">
                                            <span class="material-symbols-outlined">edit</span>
                                            Edit
                                        </a>
                                        <a href="/Instructor/Modules/Edit.aspx" class="module-action">
                                            <span class="material-symbols-outlined">arrow_forward</span>
                                            Continue
                                        </a>
                                    </div>
                                </div>
                            </article>

                        </div>
                    </div>

                    <aside class="right-column">

                        <div class="widget-card ai-widget">
                            <h3 class="widget-title">
                                <span class="material-symbols-outlined">auto_awesome</span>
                                AI Assistant Ready
                            </h3>
                            <p class="widget-text">
                                Generate clinical quizzes, case scenarios, and learner support content using AI.
                            </p>
                            <a href="/Instructor/Quizzes/GenerateWithAI.aspx" class="btn-white">
                                Launch AI Generator
                                <span class="material-symbols-outlined" style="font-size:16px;">arrow_forward</span>
                            </a>
                        </div>

                        <div class="widget-card">
                            <h3 class="widget-title">
                                <span class="material-symbols-outlined">forum</span>
                                Pending Discussion Replies
                            </h3>

                            <div class="mini-list">
                                <div class="mini-item">
                                    <div class="mini-icon"><span class="material-symbols-outlined">chat</span></div>
                                    <div>
                                        <div class="mini-title">CPR compression depth question</div>
                                        <div class="mini-subtitle">12 minutes ago</div>
                                    </div>
                                </div>

                                <div class="mini-item">
                                    <div class="mini-icon"><span class="material-symbols-outlined">chat</span></div>
                                    <div>
                                        <div class="mini-title">Trauma tourniquet scenario</div>
                                        <div class="mini-subtitle">30 minutes ago</div>
                                    </div>
                                </div>

                                <div class="mini-item">
                                    <div class="mini-icon"><span class="material-symbols-outlined">chat</span></div>
                                    <div>
                                        <div class="mini-title">Pediatric CPR ratio</div>
                                        <div class="mini-subtitle">3 hours ago</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="widget-card">
                            <h3 class="widget-title">
                                <span class="material-symbols-outlined">calendar_today</span>
                                Upcoming Events
                            </h3>

                            <div class="mini-list">
                                <div class="mini-item">
                                    <div class="mini-icon"><span class="material-symbols-outlined">event</span></div>
                                    <div>
                                        <div class="mini-title">CPR Live Workshop</div>
                                        <div class="mini-subtitle">18 Jun · Simulation Lab A</div>
                                    </div>
                                </div>

                                <div class="mini-item">
                                    <div class="mini-icon"><span class="material-symbols-outlined">videocam</span></div>
                                    <div>
                                        <div class="mini-title">Airway Emergency Webinar</div>
                                        <div class="mini-subtitle">20 Jun · Online</div>
                                    </div>
                                </div>

                                <div class="mini-item">
                                    <div class="mini-icon"><span class="material-symbols-outlined">health_and_safety</span></div>
                                    <div>
                                        <div class="mini-title">Trauma Response Drill</div>
                                        <div class="mini-subtitle">22 Jun · Clinical Skills Center</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </aside>

                </section>

                <section class="progress-card">
                    <div class="section-head">
                        <div>
                            <h3 class="section-title">Learner Progress Snapshot</h3>
                            <p class="page-subtitle">Average learner completion across active clinical modules.</p>
                        </div>
                        <a href="/Instructor/Performance/Performance.aspx" class="section-link">View Performance</a>
                    </div>

                    <div class="progress-list">
                        <div>
                            <div class="progress-head">
                                <span>CPR Fundamentals</span>
                                <span>92%</span>
                            </div>
                            <div class="progress-track">
                                <div class="progress-fill" style="width:92%;"></div>
                            </div>
                        </div>

                        <div>
                            <div class="progress-head">
                                <span>Airway Emergencies</span>
                                <span>74%</span>
                            </div>
                            <div class="progress-track">
                                <div class="progress-fill" style="width:74%;"></div>
                            </div>
                        </div>

                        <div>
                            <div class="progress-head">
                                <span>Trauma Response</span>
                                <span>61%</span>
                            </div>
                            <div class="progress-track">
                                <div class="progress-fill" style="width:61%;"></div>
                            </div>
                        </div>

                        <div>
                            <div class="progress-head">
                                <span>Burn Treatment Basics</span>
                                <span>83%</span>
                            </div>
                            <div class="progress-track">
                                <div class="progress-fill" style="width:83%;"></div>
                            </div>
                        </div>
                    </div>
                </section>

            </div>
        </main>

    </div>

</asp:Content>