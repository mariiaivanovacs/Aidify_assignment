<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Aidify_assigment.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        /* Hide normal public navbar/footer only on this admin page */
        .aidify-navbar,
        .aidify-footer {
            display: none !important;
        }

        .admin-footer {
            margin-top: 0;
        }

        .admin-shell {
            overflow-x: hidden;
        }

        table.activity-table {
            margin-bottom: 0;
        }

        body {
            background-color: #f9f9f9;
        }

        .admin-shell {
            min-height: 100vh;
            background-color: #f9f9f9;
            color: #1f2933;
            display: flex;
            flex-direction: column;
        }

        .admin-topbar {
            height: 80px;
            background-color: #ffffff;
            border-bottom: 1px solid #e2e2e2;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 36px;
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .admin-brand {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 800;
            font-size: 26px;
            color: #E53935;
        }

        .admin-badge {
            background-color: #db322f;
            color: #ffffff;
            font-size: 11px;
            padding: 3px 9px;
            border-radius: 20px;
            font-weight: 700;
        }

        .admin-top-links {
            display: flex;
            gap: 28px;
            align-items: center;
        }

        .admin-top-links a {
            color: #3d2a28;
            text-decoration: none;
            font-weight: 600;
        }

        .admin-top-links a.active {
            color: #E53935;
            border-bottom: 2px solid #E53935;
            padding-bottom: 8px;
        }

        .admin-profile {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .admin-avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: #E53935;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
        }

        .admin-layout {
            display: flex;
            flex: 1;
            align-items: flex-start; 
        }

        .admin-sidebar {
            width: 260px;
            min-height: calc(100vh - 80px);
            background-color: #f3f3f3;
            border-right: 1px solid #e2e2e2;
            padding: 28px 18px;
            flex-shrink: 0;
        }

        .admin-sidebar-heading {
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #906f6c;
            font-weight: 800;
            margin: 18px 12px 10px;
        }

        .admin-side-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 13px 15px;
            border-radius: 10px;
            color: #5b403d;
            text-decoration: none;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .admin-side-link:hover {
            background-color: #eeeeee;
            color: #E53935;
        }

        .admin-side-link.active {
            background-color: #E53935;
            color: #ffffff;
        }

        .support-box {
            background-color: #db322f;
            color: white;
            border-radius: 18px;
            padding: 22px;
            margin-top: 35px;
        }

        .support-box h6 {
            font-weight: 800;
            margin-top: 8px;
        }

        .support-box p {
            margin: 0;
            opacity: 0.9;
            font-size: 14px;
        }


        .admin-main {
            flex: 1;
            padding: 42px 48px 42px;
        }

        .admin-page-header {
            display: flex;
            justify-content: space-between;
            align-items: end;
            margin-bottom: 28px;
        }

        .admin-page-header h1 {
            font-size: 36px;
            font-weight: 800;
            margin-bottom: 6px;
        }

        .admin-page-header p {
            color: #666;
            margin: 0;
        }

        .admin-stat-card {
            background: #ffffff;
            border: 1px solid #e2e2e2;
            border-radius: 16px;
            padding: 24px;
            height: 100%;
        }

        .admin-stat-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }

        .admin-stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }

        .icon-blue {
            background-color: #dff6ff;
            color: #0ea5e9;
        }

        .icon-green {
            background-color: #d8f3e7;
            color: #198754;
        }

        .icon-red {
            background-color: #ffe1e4;
            color: #dc3545;
        }

        .icon-purple {
            background-color: #e0e7ff;
            color: #4B50C7;
        }

        .admin-stat-card span {
            color: #666;
            font-size: 14px;
        }

        .admin-stat-card h2 {
            font-size: 32px;
            font-weight: 800;
            margin: 4px 0;
        }

        .admin-stat-card p {
            color: #666;
            margin: 0;
            font-size: 14px;
        }

        .priority-card {
            border: 3px solid #dc143c;
        }

        .admin-card {
            background: #ffffff;
            border: 1px solid #e2e2e2;
            border-radius: 16px;
            padding: 25px;
            height: 100%;
        }

        .admin-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 22px;
        }

        .admin-card-header h4 {
            font-weight: 800;
            margin: 0;
        }

        .chart-box {
            background-color: #f6f6f6;
            height: 300px;
            border-radius: 14px;
            padding: 35px 28px 20px;
            display: flex;
            align-items: end;
            gap: 22px;
        }

        .chart-bar {
            flex: 1;
            background-color: #db322f;
            border-radius: 6px 6px 0 0;
            opacity: 0.85;
        }

        .chart-days {
            display: flex;
            justify-content: space-between;
            padding: 12px 20px 0;
            color: #666;
            font-size: 14px;
        }

        .admin-alert {
            border: 1px solid #e2e2e2;
            background-color: #f8f8f8;
            border-radius: 12px;
            padding: 18px;
            margin-bottom: 14px;
            display: flex;
            gap: 14px;
        }

        .admin-alert.danger {
            background-color: #ffe1e4;
            border-color: #f3a6ad;
        }

        .admin-alert strong {
            display: block;
            font-size: 15px;
        }

        .admin-alert p {
            margin: 2px 0 0;
            color: #666;
            font-size: 14px;
        }

        .activity-table th {
            background-color: #f3f3f3;
            color: #906f6c;
            font-size: 12px;
            text-transform: uppercase;
            padding: 15px;
        }

        .activity-table td {
            padding: 16px;
            vertical-align: middle;
        }

        .user-chip {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 800;
            margin-right: 10px;
        }

        .admin-footer {
            background-color: #eeeeee;
            border-top: 1px solid #e2e2e2;
            padding: 40px 48px 20px;
            margin-left: 260px;
        }

        .admin-footer h5 {
            color: #E53935;
            font-weight: 800;
        }

        .admin-card:last-child {
            margin-bottom: 0;
        }

        

        @media (max-width: 992px) {
            .admin-sidebar {
                display: none;
            }

            .admin-main {
                padding: 28px 20px;
            }

            .admin-footer {
                margin-left: 0;
            }

            .admin-top-links {
                display: none;
            }

            .admin-page-header {
                flex-direction: column;
                align-items: start;
                gap: 16px;
            }
        }
    </style>

    <div class="admin-shell">

        <!-- Admin Topbar -->
        <div class="admin-topbar">
            <div class="admin-brand">
                Aidify
                <span class="admin-badge">ADMIN</span>
            </div>

            <div class="admin-top-links">
                <a href="Dashboard.aspx" class="active">Dashboard</a>
                <a href="Users/List.aspx">Users</a>
                <a href="Roles.aspx">Roles</a>
                <a href="Content/ManagePublicPages.aspx">Public Pages</a>
                <a href="Content/ApprovalQueue.aspx">Approvals</a>
                <a href="Analytics.aspx">Analytics</a>
            </div>
           

            <div class="dropdown">
                <a class="admin-profile text-decoration-none text-dark dropdown-toggle"
                   href="#"
                   role="button"
                   data-bs-toggle="dropdown"
                   aria-expanded="false">

                    <i class="bi bi-bell fs-5"></i>

                    <div class="text-end d-none d-md-block">
                        <div class="fw-bold">Dr. Sarah Chen</div>
                        <small class="text-muted">System Administrator</small>
                    </div>

                    <div class="admin-avatar">A</div>
                </a>

                <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                    <li>
                        <a class="dropdown-item" href="#">
                            <i class="bi bi-person me-2"></i> Profile
                        </a>
                    </li>

                    <li>
                        <a class="dropdown-item" href="#">
                            <i class="bi bi-gear me-2"></i> Settings
                        </a>
                    </li>

                    <li><hr class="dropdown-divider"></li>

                    <li>
                        <a class="dropdown-item text-danger" href="../Auth/Logout.aspx">
                            <i class="bi bi-box-arrow-right me-2"></i> Logout
                        </a>
                    </li>
                </ul>
            </div>

        </div>

        <div class="admin-layout">

            <!-- Sidebar -->
            <aside class="admin-sidebar">
                <div class="admin-sidebar-heading">Main Menu</div>

                <a href="Dashboard.aspx" class="admin-side-link active">
                    <i class="bi bi-grid"></i> Overview
                </a>

                <a href="Users/List.aspx" class="admin-side-link">
                    <i class="bi bi-people"></i> User Management
                </a>

                <a href="Roles.aspx" class="admin-side-link">
                    <i class="bi bi-shield-check"></i> Roles & Permissions
                </a>

                <div class="admin-sidebar-heading">Content</div>

                    <a href="Content/ApprovalQueue.aspx" class="admin-side-link">
                        <i class="bi bi-book"></i> Approval Queue
                    </a>

                    <a href="Content/ManagePublicPages.aspx" class="admin-side-link">
                        <i class="bi bi-layout-text-window-reverse"></i> Public Pages
                    </a>

                    <a href="AI_Insights.aspx" class="admin-side-link">
                        <i class="bi bi-stars"></i> AI Insights
                    </a>

                <div class="admin-sidebar-heading">System</div>

                <a href="Analytics.aspx" class="admin-side-link">
                    <i class="bi bi-graph-up"></i> Analytics
                </a>

                <a href="AuditLogs.aspx" class="admin-side-link">
                    <i class="bi bi-clock-history"></i> Audit Logs
                </a>

                <div class="support-box">
                    <div class="d-flex align-items-center mb-3">
                        <i class="bi bi-question-circle fs-4 me-2" style="line-height: 1;"></i>
                        <h6 class="mb-0 fw-bold" style="line-height: 1;">
                            Technical Support
                        </h6>
                    </div>

                    <p>Priority admin hotline available 24/7.</p>
                </div>
            </aside>

            <!-- Main Dashboard Content -->
            <main class="admin-main">

                <div class="admin-page-header">
                    <div>
                        <h1>Admin Dashboard</h1>
                        <p>System status and user engagement metrics for today.</p>
                    </div>

                    <div class="d-flex gap-2">
                        <a href="Analytics.aspx" class="btn btn-outline-secondary">
                            <i class="bi bi-download"></i> Export Data
                        </a>

                        <a href="Content/ApprovalQueue.aspx" class="btn btn-aidify">
                            <i class="bi bi-plus-lg"></i> New Module
                        </a>
                    </div>
                </div>

                <!-- Stats Cards -->
                <div class="row g-4 mb-4">

                    <div class="col-md-6 col-lg-3">
                        <div class="admin-stat-card">
                            <div class="admin-stat-top">
                                <div class="admin-stat-icon icon-blue">
                                    <i class="bi bi-people"></i>
                                </div>
                                <small class="text-success fw-bold">+12% ↑</small>
                            </div>
                            <span>Total active users</span>
                            <h2 id="statTotalUsers">—</h2>
                            <p>Registered learners and staff</p>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-3">
                        <div class="admin-stat-card">
                            <div class="admin-stat-top">
                                <div class="admin-stat-icon icon-purple">
                                    <i class="bi bi-check-circle"></i>
                                </div>
                                <small class="text-success fw-bold">+5% ↑</small>
                            </div>
                            <span>Module completion rate</span>
                            <h2 id="statActiveLearners">—</h2>
                            <div class="progress mt-2" style="height: 6px;">
                                <div class="progress-bar bg-danger" style="width: 68%;"></div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-3">
                        <div class="admin-stat-card">
                            <div class="admin-stat-top">
                                <div class="admin-stat-icon icon-green">
                                    <i class="bi bi-shield-plus"></i>
                                </div>
                                <small class="text-muted fw-bold">Stable</small>
                            </div>
                            <span>System Uptime</span>
                            <h2 id="statTotalAttempts">—</h2>
                            <p>All systems operational</p>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-3">
                        <div class="admin-stat-card priority-card">
                            <div class="admin-stat-top">
                                <div class="admin-stat-icon icon-red">
                                    <i class="bi bi-exclamation-triangle"></i>
                                </div>
                                <small class="text-danger fw-bold">Priority</small>
                            </div>
                            <span>Critical Alerts</span>
                            <h2 id="statPendingModules">—</h2>
                            <p>Needs admin review</p>
                        </div>
                    </div>

                </div>

                <!-- AI Daily Insight Card -->
                <div class="admin-card mb-4" id="aiInsightCard">
                    <div class="admin-card-header">
                        <div>
                            <h4><i class="bi bi-stars text-danger me-2"></i>AI Daily Insight</h4>
                            <small class="text-muted">Powered by Gemini · refreshes every 24 h</small>
                        </div>
                    </div>
                    <p id="aiInsightText" class="text-muted fst-italic mb-0">Loading insight…</p>
                </div>

                <script type="text/javascript">
                    $.ajax({
                        type:        'POST',
                        url:         'Dashboard.aspx/GetDailySummary',
                        data:        '{}',
                        contentType: 'application/json; charset=utf-8',
                        dataType:    'json',
                        success: function (data) {
                            document.getElementById('aiInsightText').textContent = data.d;
                        },
                        error: function () {
                            document.getElementById('aiInsightText').textContent =
                                'AI insight unavailable at the moment.';
                        }
                    });
                </script>

                <script type="text/javascript">
                    $.ajax({
                        type: 'POST', url: 'Dashboard.aspx/GetStats',
                        data: '{}', contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        success: function (r) {
                            var d = r.d;
                            document.getElementById('statTotalUsers').textContent     = d.totalUsers.toLocaleString();
                            document.getElementById('statActiveLearners').textContent = d.activeLearners.toLocaleString();
                            document.getElementById('statTotalAttempts').textContent  = d.totalAttempts.toLocaleString();
                            document.getElementById('statPendingModules').textContent = d.pendingModules + ' Pending';
                        }
                    });
                </script>

                <!-- Chart + Alerts -->
                <div class="row g-4 mb-4">
                    <div class="col-lg-8">
                        <div class="admin-card">
                            <div class="admin-card-header">
                                <div>
                                    <h4>User Engagement Trend</h4>
                                    <small class="text-muted">Sessions and module interactions per day</small>
                                </div>

                                <select class="form-select w-auto">
                                    <option>Last 7 Days</option>
                                    <option>Last 30 Days</option>
                                </select>
                            </div>

                            <div class="chart-box">
                                <div class="chart-bar" style="height: 40%;"></div>
                                <div class="chart-bar" style="height: 60%;"></div>
                                <div class="chart-bar" style="height: 55%;"></div>
                                <div class="chart-bar" style="height: 80%;"></div>
                                <div class="chart-bar" style="height: 70%;"></div>
                                <div class="chart-bar" style="height: 95%;"></div>
                                <div class="chart-bar" style="height: 85%;"></div>
                            </div>

                            <div class="chart-days">
                                <span>Mon</span>
                                <span>Tue</span>
                                <span>Wed</span>
                                <span>Thu</span>
                                <span>Fri</span>
                                <span>Sat</span>
                                <span>Sun</span>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="admin-card">
                            <div class="admin-card-header">
                                <h4>System Alerts</h4>
                                <span class="badge bg-danger">3 New</span>
                            </div>

                            <div class="admin-alert danger">
                                <i class="bi bi-x-circle text-danger fs-4"></i>
                                <div>
                                    <strong>API Response Latency</strong>
                                    <p>AI service response is slower than usual.</p>
                                    <small class="text-muted">2 mins ago</small>
                                </div>
                            </div>

                            <div class="admin-alert">
                                <i class="bi bi-info-circle text-primary fs-4"></i>
                                <div>
                                    <strong>Scheduled Backup</strong>
                                    <p>Database backup will start at 02:00 UTC.</p>
                                    <small class="text-muted">45 mins ago</small>
                                </div>
                            </div>

                            <div class="admin-alert">
                                <i class="bi bi-shield-check text-danger fs-4"></i>
                                <div>
                                    <strong>New Admin Role</strong>
                                    <p>Junior Editor role has been added.</p>
                                    <small class="text-muted">2 hours ago</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activity -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <h4>Recent Activity</h4>
                        <div class="d-flex gap-2">
                            <button type="button" class="btn btn-light rounded-circle">
                                <i class="bi bi-filter"></i>
                            </button>
                            <button type="button" class="btn btn-light rounded-circle">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table activity-table mb-0">
                            <thead>
                                <tr>
                                    <th>User / Action</th>
                                    <th>Activity Type</th>
                                    <th>Module</th>
                                    <th>Timestamp</th>
                                    <th>Status</th>
                                    <th></th>
                                </tr>
                            </thead>

                            <tbody>
                                <tr>
                                    <td>
                                        <span class="user-chip bg-primary-subtle text-primary">MK</span>
                                        <strong>Mark Kovacs</strong>
                                        <br />
                                        <small class="text-muted ms-5">m.kovacs@email.com</small>
                                    </td>
                                    <td>Module Completed</td>
                                    <td><span class="badge bg-light text-dark border">Basic CPR 101</span></td>
                                    <td>10:24 AM</td>
                                    <td><span class="badge bg-success-subtle text-success">Success</span></td>
                                    <td><i class="bi bi-three-dots-vertical"></i></td>
                                </tr>

                                <tr>
                                    <td>
                                        <span class="user-chip bg-danger-subtle text-danger">AS</span>
                                        <strong>Anita Singh</strong>
                                        <br />
                                        <small class="text-muted ms-5">anita.s@hospital.org</small>
                                    </td>
                                    <td>New User Registered</td>
                                    <td>—</td>
                                    <td>09:15 AM</td>
                                    <td><span class="badge bg-info-subtle text-info">Pending Ver.</span></td>
                                    <td><i class="bi bi-three-dots-vertical"></i></td>
                                </tr>

                                <tr>
                                    <td>
                                        <span class="user-chip bg-info-subtle text-info">JD</span>
                                        <strong>James Doe</strong>
                                        <br />
                                        <small class="text-muted ms-5">james@provider.net</small>
                                    </td>
                                    <td>Certification Failed</td>
                                    <td><span class="badge bg-light text-dark border">Advanced Trauma</span></td>
                                    <td>08:50 AM</td>
                                    <td><span class="badge bg-danger-subtle text-danger">Retry Available</span></td>
                                    <td><i class="bi bi-three-dots-vertical"></i></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="text-center bg-light p-3 rounded-bottom">
                        <button type="button" class="btn btn-link text-muted text-decoration-none fw-bold">
                            Load 50 More Activities <i class="bi bi-chevron-down"></i>
                        </button>
                    </div>
                </div>

            </main>

        </div>

        <!-- Admin Footer -->
        <footer class="admin-footer">
            <div class="d-flex justify-content-between align-items-start flex-wrap gap-3 mb-3">
                <div>
                    <h5>Aidify</h5>
                    <p class="text-muted small mb-0">Administrative control center for the Aidify learning platform.</p>
                </div>
                <div class="d-flex align-items-center gap-3">
                    <a href="Dashboard.aspx" class="text-muted text-decoration-none small">Dashboard</a>
                    <span class="text-muted">|</span>
                    <a href="#" class="text-muted text-decoration-none small">Privacy Policy</a>
                    <span class="text-muted">|</span>
                    <a href="#" class="text-muted text-decoration-none small">Terms of Service</a>
                </div>
            </div>
            <hr class="mt-1 mb-2" />
            <p class="text-muted small mb-0 text-center">© 2026 Aidify Admin Panel. Educational use only.</p>
        </footer>

    </div>

</asp:Content>