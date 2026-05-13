<%@ Page Title="Instructor Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Aidify_assigment.Instructor.Dashboard" %>

<asp:Content ID="DashboardContent" ContentPlaceHolderID="MainContent" runat="server">

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

        .aidify-dashboard {
            min-height: 100vh;
            display: flex;
            background: #fff8f7;
            color: #281715;
        }

        .aidify-sidebar {
            width: 260px;
            min-height: 100vh;
            background: #fff0ee;
            border-right: 1px solid #e6bdb8;
            display: flex;
            flex-direction: column;
            padding: 18px 14px;
            flex-shrink: 0;
        }

        .aidify-logo {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 0 8px 24px;
        }

        .aidify-logo-mark {
            width: 30px;
            height: 30px;
            border-radius: 7px;
            background: #dc2626;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .aidify-logo-text {
            font-size: 15px;
            font-weight: 800;
            color: #b70011;
        }

        .aidify-nav {
            display: flex;
            flex-direction: column;
            gap: 6px;
            flex: 1;
        }

        .aidify-nav a {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 11px 12px;
            border-radius: 8px;
            color: #281715;
            text-decoration: none;
            font-size: 13px;
            font-weight: 700;
            transition: 0.2s ease;
        }

        .aidify-nav a:hover {
            background: #fbdbd7;
            color: #b70011;
        }

        .aidify-nav a.active {
            background: #b70011;
            color: white;
        }

        .aidify-nav .material-symbols-outlined {
            font-size: 18px;
        }

        .aidify-plan {
            margin-top: auto;
            background: #fff8f7;
            border-top: 1px solid #e6bdb8;
            padding: 16px 10px 4px;
        }

        .aidify-plan-label {
            color: #b70011;
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: .08em;
            margin-bottom: 6px;
        }

        .aidify-plan small {
            color: #916f6b;
            font-size: 11px;
        }

        .aidify-main {
            flex: 1;
            min-width: 0;
            background: #fff8f7;
        }

        .aidify-topbar {
            height: 58px;
            background: #fff8f7;
            border-bottom: 1px solid #e6bdb8;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 26px;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .aidify-topbar-title {
            font-size: 15px;
            font-weight: 800;
            color: #281715;
        }

        .aidify-topbar-right {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .verified-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            border-radius: 999px;
            background: #ffe9e6;
            border: 1px solid #e6bdb8;
            color: #916f6b;
            padding: 6px 10px;
            font-size: 11px;
            font-weight: 700;
        }

        .profile-name {
            font-size: 12px;
            font-weight: 800;
            line-height: 1;
            text-align: right;
        }

        .profile-role {
            font-size: 10px;
            color: #916f6b;
            text-align: right;
        }

        .avatar {
            width: 28px;
            height: 28px;
            border-radius: 50%;
            background: #ffdad6;
            border: 2px solid #b70011;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #b70011;
            font-weight: 800;
            font-size: 12px;
        }

        .aidify-content {
            max-width: 1180px;
            margin: 0 auto;
            padding: 24px 28px 34px;
        }

        .welcome-row {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            gap: 18px;
            margin-bottom: 20px;
        }

        .welcome-title {
            font-size: 32px;
            line-height: 1.15;
            font-weight: 800;
            letter-spacing: -0.04em;
            margin: 0 0 5px;
            color: #281715;
        }

        .welcome-subtitle {
            color: #596373;
            font-size: 13px;
            margin: 0;
        }

        .welcome-actions {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .btn-aidify-primary,
        .btn-aidify-secondary {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            text-decoration: none;
            border-radius: 7px;
            padding: 9px 13px;
            font-size: 12px;
            font-weight: 800;
            transition: 0.2s ease;
            border: 1px solid transparent;
            white-space: nowrap;
        }

        .btn-aidify-primary {
            background: #dc2626;
            color: white !important;
            border-color: #dc2626;
        }

        .btn-aidify-primary:hover {
            filter: brightness(1.06);
            transform: translateY(-1px);
        }

        .btn-aidify-secondary {
            background: white;
            color: #b70011 !important;
            border-color: #e6bdb8;
        }

        .btn-aidify-secondary:hover {
            background: #fff0ee;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 12px;
            margin-bottom: 24px;
        }

        .stat-card {
            background: white;
            border: 1px solid #e6bdb8;
            border-radius: 9px;
            padding: 15px;
            min-height: 112px;
            box-shadow: 0 8px 20px rgba(40, 23, 21, .04);
        }

        .stat-card.featured {
            background: #dc2626;
            border-color: #dc2626;
            color: white;
        }

        .stat-icon {
            width: 26px;
            height: 26px;
            border-radius: 7px;
            background: #ffe9e6;
            color: #b70011;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 12px;
        }

        .featured .stat-icon {
            background: rgba(255,255,255,.16);
            color: white;
        }

        .stat-icon .material-symbols-outlined {
            font-size: 17px;
        }

        .stat-label {
            color: #916f6b;
            font-size: 10px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: .06em;
            margin-bottom: 4px;
        }

        .featured .stat-label {
            color: #fff0ee;
        }

        .stat-number {
            display: block;
            font-size: 28px;
            line-height: 1;
            font-weight: 800;
            color: #281715;
            margin-bottom: 5px;
        }

        .featured .stat-number {
            color: white;
        }

        .stat-note {
            font-size: 10px;
            color: #916f6b;
            font-weight: 600;
        }

        .featured .stat-note {
            color: #fff0ee;
        }

        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 14px;
            margin-bottom: 14px;
        }

        .section-left {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title {
            font-size: 19px;
            font-weight: 800;
            margin: 0;
            color: #281715;
        }

        .filters {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .filter-pill {
            border: 0;
            background: transparent;
            color: #916f6b;
            font-size: 10px;
            font-weight: 800;
            border-radius: 999px;
            padding: 4px 8px;
        }

        .filter-pill.active {
            background: #ffe9e6;
            color: #b70011;
        }

        .view-all {
            color: #b70011;
            font-size: 12px;
            font-weight: 800;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 2px;
        }

        .modules-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 16px;
            align-items: stretch;
        }

        .module-card {
            background: white;
            border: 1px solid #e6bdb8;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 10px 22px rgba(40, 23, 21, .06);
            display: flex;
            flex-direction: column;
            min-height: 330px;
            transition: 0.22s ease;
        }

        .module-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 18px 36px rgba(40, 23, 21, .11);
        }

        .module-cover {
            height: 130px;
            position: relative;
            background:
                linear-gradient(to top, rgba(0,0,0,.58), rgba(0,0,0,.04)),
                linear-gradient(135deg, #1f2937, #b70011);
            overflow: hidden;
        }

        .module-cover.cpr {
            background:
                linear-gradient(to top, rgba(0,0,0,.62), rgba(0,0,0,.08)),
                radial-gradient(circle at 25% 35%, #ffdad6 0 8%, transparent 9%),
                linear-gradient(135deg, #0f172a, #0f766e);
        }

        .module-cover.burn {
            background:
                linear-gradient(to top, rgba(0,0,0,.62), rgba(0,0,0,.08)),
                radial-gradient(circle at 55% 45%, #f8fafc 0 12%, transparent 13%),
                linear-gradient(135deg, #111827, #6b7280);
        }

        .module-cover.trauma {
            background:
                linear-gradient(to top, rgba(0,0,0,.62), rgba(0,0,0,.08)),
                radial-gradient(circle at 35% 35%, #fecaca 0 11%, transparent 12%),
                linear-gradient(135deg, #3f1d1d, #b70011);
        }

        .status-badge {
            position: absolute;
            left: 12px;
            bottom: 10px;
            background: #dc2626;
            color: white;
            border-radius: 999px;
            padding: 4px 9px;
            font-size: 10px;
            font-weight: 800;
        }

        .rating-badge {
            position: absolute;
            right: 12px;
            bottom: 10px;
            background: rgba(0,0,0,.38);
            color: white;
            border-radius: 999px;
            padding: 4px 8px;
            font-size: 10px;
            font-weight: 700;
        }

        .module-body {
            padding: 14px 14px 12px;
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .module-title {
            font-size: 17px;
            font-weight: 800;
            line-height: 1.25;
            margin: 0 0 6px;
            color: #281715;
        }

        .module-desc {
            font-size: 12px;
            line-height: 1.45;
            color: #596373;
            margin: 0 0 12px;
            min-height: 35px;
        }

        .module-meta {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
            color: #555f6f;
            font-size: 10px;
            font-weight: 800;
            margin-bottom: 12px;
        }

        .module-meta span {
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .module-meta .material-symbols-outlined {
            font-size: 14px;
            color: #b70011;
        }

        .module-footer {
            border-top: 1px solid #e6bdb8;
            padding-top: 10px;
            margin-top: auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 8px;
        }

        .action-icons {
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .action-icon {
            width: 28px;
            height: 28px;
            border-radius: 7px;
            color: #555f6f;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: 0.2s ease;
        }

        .action-icon:hover {
            background: #ffe9e6;
            color: #b70011;
        }

        .action-icon .material-symbols-outlined {
            font-size: 17px;
        }

        .level-pill {
            border-radius: 999px;
            background: #dce2f3;
            color: #404754;
            padding: 4px 8px;
            font-size: 9px;
            font-weight: 800;
        }

        .ai-card {
            background: #dc2626;
            color: white;
            border-radius: 10px;
            min-height: 330px;
            padding: 22px;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            box-shadow: 0 14px 28px rgba(220, 38, 38, .24);
        }

        .ai-card::after {
            content: "auto_awesome";
            font-family: 'Material Symbols Outlined';
            position: absolute;
            right: -22px;
            bottom: -35px;
            font-size: 130px;
            opacity: .12;
        }

        .ai-inner {
            position: relative;
            z-index: 1;
            width: 100%;
        }

        .ai-icon {
            width: 38px;
            height: 38px;
            border-radius: 10px;
            background: rgba(255,255,255,.16);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 18px;
        }

        .ai-title {
            font-size: 25px;
            line-height: 1.1;
            font-weight: 800;
            margin: 0 0 12px;
        }

        .ai-desc {
            font-size: 12px;
            line-height: 1.55;
            opacity: .92;
            margin: 0 0 20px;
        }

        .ai-button {
            width: 100%;
            background: white;
            color: #dc2626 !important;
            border-radius: 8px;
            padding: 10px 12px;
            font-size: 12px;
            font-weight: 800;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 500, 'GRAD' 0, 'opsz' 24;
        }

        @media (max-width: 1100px) {
            .stats-grid,
            .modules-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 800px) {
            .aidify-dashboard {
                display: block;
            }

            .aidify-sidebar {
                width: 100%;
                min-height: auto;
                position: relative;
            }

            .aidify-nav {
                flex-direction: row;
                overflow-x: auto;
            }

            .aidify-nav a {
                white-space: nowrap;
            }

            .aidify-plan {
                display: none;
            }

            .welcome-row {
                align-items: flex-start;
                flex-direction: column;
            }

            .stats-grid,
            .modules-grid {
                grid-template-columns: 1fr;
            }

            .aidify-topbar {
                padding: 0 16px;
            }

            .verified-pill,
            .profile-name,
            .profile-role {
                display: none;
            }

            .aidify-content {
                padding: 20px 16px;
            }
        }
    </style>

    <div class="aidify-dashboard">

        <!-- Sidebar -->
        <aside class="aidify-sidebar">
            <div class="aidify-logo">
                <div class="aidify-logo-mark">
                    <span class="material-symbols-outlined" style="font-size:19px;">medical_services</span>
                </div>
                <div>
                    <div class="aidify-logo-text">Aidify</div>
                </div>
            </div>

            <nav class="aidify-nav">
                <a class="active" href="/Instructor/Dashboard.aspx">
                    <span class="material-symbols-outlined">dashboard</span>
                    Dashboard
                </a>
                <a href="/Instructor/Modules/Edit.aspx">
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
            </nav>

            <div class="aidify-plan">
                <div class="aidify-plan-label">Plan: Pro Instructor</div>
                <div style="height:6px;background:#e6bdb8;border-radius:999px;overflow:hidden;">
                    <div style="height:100%;width:75%;background:#dc2626;border-radius:999px;"></div>
                </div>
                <small>7.5GB of 10GB used</small>
            </div>
        </aside>

        <!-- Main -->
        <main class="aidify-main">

            <!-- Top Bar -->
            <header class="aidify-topbar">
                <div class="aidify-topbar-title">Instructor Portal</div>

                <div class="aidify-topbar-right">
                    <div class="verified-pill">
                        <span class="material-symbols-outlined" style="font-size:14px;color:#b70011;">verified_user</span>
                        Verified Educator
                    </div>

                    <span class="material-symbols-outlined" style="font-size:18px;color:#916f6b;">notifications</span>

                    <div>
                        <div class="profile-name">Dr. Sarah Mitchell</div>
                        <div class="profile-role">Lead Medical Instructor</div>
                    </div>

                    <div class="avatar">M</div>
                </div>
            </header>

            <div class="aidify-content">

                <!-- Welcome -->
                <section class="welcome-row">
                    <div>
                        <h1 class="welcome-title">Welcome back, Dr. Mitchell</h1>
                        <asp:Label ID="lblWelcomeInstructor" runat="server" CssClass="welcome-subtitle d-block"></asp:Label>
                    </div>

                    <div class="welcome-actions">
                        <asp:HyperLink ID="lnkCreateModule" runat="server"
                            CssClass="btn-aidify-primary"
                            NavigateUrl="~/Instructor/Modules/Edit.aspx">
                            <span class="material-symbols-outlined" style="font-size:15px;">add</span>
                            Create New Module
                        </asp:HyperLink>

                        <asp:HyperLink ID="lnkGenerateWithAI" runat="server"
                            CssClass="btn-aidify-secondary"
                            NavigateUrl="~/Instructor/Quizzes/GenerateWithAI.aspx">
                            <span class="material-symbols-outlined" style="font-size:15px;">auto_awesome</span>
                            AI Generator
                        </asp:HyperLink>
                    </div>
                </section>

                <!-- Stats -->
                <section class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <span class="material-symbols-outlined">school</span>
                        </div>
                        <div class="stat-label">Total Modules</div>
                        <div class="stat-number">12</div>
                        <div class="stat-note" style="color:#dc2626;">+2 this month</div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon">
                            <span class="material-symbols-outlined">play_circle</span>
                        </div>
                        <div class="stat-label">Active Lessons</div>
                        <div class="stat-number">45</div>
                        <div class="stat-note">Across 8 categories</div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon">
                            <span class="material-symbols-outlined">quiz</span>
                        </div>
                        <div class="stat-label">Quizzes Created</div>
                        <div class="stat-number">28</div>
                        <div class="stat-note">85% avg score</div>
                    </div>

                    <div class="stat-card featured">
                        <div class="stat-icon">
                            <span class="material-symbols-outlined">trending_up</span>
                        </div>
                        <div class="stat-label">Global Impact</div>
                        <div class="stat-number">4.8k</div>
                        <div class="stat-note">Total active learners</div>
                    </div>
                </section>

                <!-- Modules Header -->
                <section>
                    <div class="section-header">
                        <div class="section-left">
                            <h2 class="section-title">My Modules</h2>
                            <div class="filters">
                                <span class="filter-pill active">All</span>
                                <span class="filter-pill">Published</span>
                                <span class="filter-pill">Drafts</span>
                            </div>
                        </div>

                        <a class="view-all" href="/Instructor/Modules/Edit.aspx">
                            View All
                            <span class="material-symbols-outlined" style="font-size:14px;">chevron_right</span>
                        </a>
                    </div>

                    <div class="modules-grid">

                        <asp:Repeater ID="rptMyModules" runat="server">
                            <ItemTemplate>
                                <article class="module-card">
                                    <div class='module-cover <%# Container.ItemIndex == 0 ? "cpr" : Container.ItemIndex == 1 ? "burn" : "trauma" %>'>
                                        <span class="status-badge"><%# Eval("Status") %></span>
                                        <span class="rating-badge">★ 4.9</span>
                                    </div>

                                    <div class="module-body">
                                        <h3 class="module-title"><%# Eval("Title") %></h3>
                                        <p class="module-desc"><%# Eval("Description") %></p>

                                        <div class="module-meta">
                                            <span>
                                                <span class="material-symbols-outlined">group</span>
                                                <%# Eval("LearnerCount") %> Learners
                                            </span>
                                            <span>
                                                <span class="material-symbols-outlined">menu_book</span>
                                                <%# Eval("LessonCount") %> Lessons
                                            </span>
                                        </div>

                                        <div class="module-footer">
                                            <div class="action-icons">
                                                <a class="action-icon" href="/Instructor/Modules/Edit.aspx" title="Edit Module">
                                                    <span class="material-symbols-outlined">edit</span>
                                                </a>
                                                <a class="action-icon" href="/Instructor/Lessons/Edit.aspx" title="Lessons">
                                                    <span class="material-symbols-outlined">menu_book</span>
                                                </a>
                                                <a class="action-icon" href="/Instructor/Materials/Upload.aspx" title="Materials">
                                                    <span class="material-symbols-outlined">description</span>
                                                </a>
                                            </div>

                                            <span class="level-pill"><%# Eval("Level") %></span>
                                        </div>
                                    </div>
                                </article>
                            </ItemTemplate>
                        </asp:Repeater>

                        <!-- AI Card -->
                        <article class="ai-card">
                            <div class="ai-inner">
                                <div class="ai-icon">
                                    <span class="material-symbols-outlined">bolt</span>
                                </div>

                                <h3 class="ai-title">Accelerate with AI Assistant</h3>

                                <p class="ai-desc">
                                    Generate compliant medical quiz questions, module outlines, and interactive scenarios in seconds using our Clinical AI model.
                                </p>

                                <a class="ai-button" href="/Instructor/Quizzes/GenerateWithAI.aspx">
                                    Launch AI Assistant
                                    <span class="material-symbols-outlined" style="font-size:16px;">arrow_forward</span>
                                </a>
                            </div>
                        </article>

                    </div>
                </section>

            </div>
        </main>
    </div>

</asp:Content>