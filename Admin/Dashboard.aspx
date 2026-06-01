<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Aidify_assigment.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        /* Hide normal public navbar/footer only on this admin page */
        .aidify-navbar,
        .aidify-footer {
            display: none !important;
        }

        .admin-footer {
            background-color: #eeeeee;
            border-top: 1px solid #e2e2e2;
            padding: 40px 48px 20px;
            margin-left: 0;
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

        .admin-logo {
            width: 42px;
            height: 42px;
            object-fit: contain;
        }

        .admin-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 800;
            font-size: 30px;
            color: #E53935;
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
            transition: transform 0.15s ease, box-shadow 0.15s ease, border-color 0.15s ease;
        }

        .admin-stat-link {
            color: inherit;
            display: block;
            height: 100%;
            text-decoration: none;
        }

        .admin-stat-link:hover,
        .admin-stat-link:focus {
            color: inherit;
            text-decoration: none;
        }

        .admin-stat-link:hover .admin-stat-card,
        .admin-stat-link:focus .admin-stat-card {
            border-color: #db322f;
            box-shadow: 0 12px 28px rgba(31, 41, 51, 0.12);
            transform: translateY(-2px);
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

        .admin-footer h5 {
            color: #E53935;
            font-weight: 800;
        }

        .admin-card:last-child {
            margin-bottom: 0;
        }

        .admin-dropdown-toggle {
            text-decoration: none;
            color: #1f2937;
            font-weight: 700;
            font-size: 18px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .admin-dropdown-toggle:hover {
            color: #E53935;
        }

        .dropdown-menu {
            min-width: 180px;
            border-radius: 12px;
            border: 1px solid #eee;
        }

        .dropdown-item {
            padding: 10px 16px;
        }

        

        @media (max-width: 992px) {
            .admin-sidebar {
                display: none;
            }

            .admin-main {
                padding: 28px 20px;
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
                <img src="<%= ResolveUrl("~/Images/aidify-kit.png") %>"
                     alt="Aidify Logo"
                     class="admin-logo" />
                <span>Aidify</span>
            </div>

            <div class="admin-top-links">
                <a href="Dashboard.aspx" class="active">Dashboard</a>
                <a href="Users/List.aspx">Users</a>
             
             
                <a href="Content/ApprovalQueue.aspx">Approvals</a>
                <a href="Analytics.aspx">Analytics</a>
            </div>
           

            <div class="admin-profile dropdown">

                <a href="#"
                   class="admin-dropdown-toggle"
                   data-bs-toggle="dropdown"
                   aria-expanded="false">

                    Admin
                    <i class="bi bi-chevron-down"></i>
                </a>

                <ul class="dropdown-menu dropdown-menu-end">

                    <li>
                        <a class="dropdown-item"
                           href="../Account/Profile.aspx">
                            <i class="bi bi-person me-2"></i>
                            Profile
                        </a>
                    </li>

                    <li>
                        <a class="dropdown-item text-danger"
                           href="../Auth/Logout.aspx">
                            <i class="bi bi-box-arrow-right me-2"></i>
                            Logout
                        </a>
                    </li>

                </ul>

            </div>

        </div> <!-- admin-topbar -->

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

                

                <div class="admin-sidebar-heading">Content</div>

                    <a href="Content/ApprovalQueue.aspx" class="admin-side-link">
                        <i class="bi bi-book"></i> Approval Queue
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

            </aside>

            <!-- Main Dashboard Content -->
            <main class="admin-main">

                <div class="admin-page-header">
                    <div>
                        <h1>Admin Dashboard</h1>
                        <p>System status and user engagement metrics for today.</p>
                    </div>


                    <div class="d-flex gap-2">
                        <a href="Modules/Create.aspx" class="btn btn-aidify">
                            <i class="bi bi-plus-lg"></i> New Module
                        </a>

                        <a href="Events/Create.aspx" class="btn btn-aidify">
                            <i class="bi bi-plus-lg"></i> New Event
                        </a>

                    </div>
                </div>

                <!-- Stats Cards -->
                <div class="row g-4 mb-4">

                    <div class="col-md-6 col-lg-3">
                        <a href="Users/List.aspx" class="admin-stat-link" aria-label="Open user management">
                            <div class="admin-stat-card">
                                <div class="admin-stat-top">
                                    <div class="admin-stat-icon icon-blue">
                                        <i class="bi bi-people"></i>
                                    </div>
                                    <small id="statUserGrowthLabel" class="text-success fw-bold">—</small>
                                </div>
                                <span>Total active users</span>
                                <h2 id="statTotalUsers">—</h2>
                                <p>Registered learners and staff</p>
                            </div>
                        </a>
                    </div>

                    <div class="col-md-6 col-lg-3">
                        <a href="Analytics.aspx" class="admin-stat-link" aria-label="Open analytics completion report">
                            <div class="admin-stat-card">
                                <div class="admin-stat-top">
                                    <div class="admin-stat-icon icon-purple">
                                        <i class="bi bi-check-circle"></i>
                                    </div>
                                    <small id="statLearnerStatusLabel" class="text-success fw-bold">—</small>
                                </div>
                                <span>Module Completion Rate</span>

                                    <h2 id="statActiveLearners">—</h2>

                                    <div class="progress mt-2" style="height: 6px;">
                                        <div id="learnerProgressBar"
                                             class="progress-bar bg-danger"
                                             style="width: 0%;">
                                        </div>
                                    </div>

                                    <p id="completionLabel">Loading...</p>
                            </div>
                        </a>
                    </div>

                    <div class="col-md-6 col-lg-3">
                        <a href="Analytics.aspx" class="admin-stat-link" aria-label="Open analytics activity report">
                            <div class="admin-stat-card">
                                <div class="admin-stat-top">
                                    <div class="admin-stat-icon icon-green">
                                        <i class="bi bi-shield-plus"></i>
                                    </div>
                                    <small id="statAttemptsStatusLabel" class="text-muted fw-bold">—</small>
                                </div>
                                <span>Module Attempts</span>
                                <h2 id="statTotalAttempts">—</h2>
                                <p>Total learning activity recorded</p>
                            </div>
                        </a>
                    </div>

                    <div class="col-md-6 col-lg-3">
                        <a href="Content/ApprovalQueue.aspx" class="admin-stat-link" aria-label="Open approval queue">
                            <div class="admin-stat-card priority-card">
                                <div class="admin-stat-top">
                                    <div class="admin-stat-icon icon-red">
                                        <i class="bi bi-exclamation-triangle"></i>
                                    </div>
                                    <small id="statAlertStatusLabel" class="text-danger fw-bold">—</small>
                                </div>
                                <span>Critical Alerts</span>
                                <h2 id="statPendingModules">—</h2>
                                <p>Needs admin review</p>
                            </div>
                        </a>
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
                        type: 'POST',
                        url: 'Dashboard.aspx/GetDailySummary',
                        data: '{}',
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
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

                            document.getElementById('statTotalUsers').textContent =
                                d.totalUsers.toLocaleString();

                            document.getElementById('statActiveLearners').textContent =
                                d.completionRate + '%';

                            document.getElementById('statTotalAttempts').textContent =
                                d.totalAttempts.toLocaleString();

                            document.getElementById('statPendingModules').textContent =
                                d.pendingModules + ' Pending';

                            document.getElementById('statUserGrowthLabel').textContent =
                                d.userGrowthLabel;

                            document.getElementById('statLearnerStatusLabel').textContent =
                                d.learnerStatusLabel;

                            document.getElementById('completionLabel').textContent =
                                d.completionLabel;

                            document.getElementById('statAttemptsStatusLabel').textContent =
                                d.attemptsStatusLabel;

                            document.getElementById('statAlertStatusLabel').textContent =
                                d.alertStatusLabel;

                            document.getElementById('learnerProgressBar').style.width =
                                d.learnerProgressPercent + '%';
                        }
                    });
                </script>

                <script type="text/javascript">
                $.ajax({
                    type:'POST', url:'Dashboard.aspx/GetRecentActivity',
                    data:'{}', contentType:'application/json; charset=utf-8', dataType:'json',
                    success: function(r) {
                        var rows = r.d, body = document.getElementById('activityTableBody');
                        if (!rows || rows.length === 0) {
                            body.innerHTML = '<tr><td colspan="5" class="text-center text-muted py-3">No activity yet.</td></tr>';
                            return;
                        }
                        var chips = ['bg-primary-subtle text-primary','bg-danger-subtle text-danger',
                                     'bg-success-subtle text-success','bg-warning-subtle text-warning',
                                     'bg-info-subtle text-info'];
                        var html = '';
                        for (var i = 0; i < rows.length; i++) {
                            var l = rows[i];
                            var dt = new Date(parseInt(l.timestamp.replace('/Date(','').replace(')/',''))).toLocaleTimeString();
                            var chip = chips[i % chips.length];
                            html += '<tr>' +
                                '<td><span class="user-chip ' + chip + '">' + esc(l.actorInitials) + '</span>' +
                                '<strong>' + esc(l.actorName) + '</strong></td>' +
                                '<td>' + esc(l.action) + '</td>' +
                                '<td>' + esc(l.targetEntity || '—') + '</td>' +
                                '<td>' + dt + '</td>' +
                                '<td><span class="badge bg-success-subtle text-success">Done</span></td></tr>';
                        }
                        body.innerHTML = html;
                    }
                });
                function esc(s){return String(s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');}
                </script>

                <script type="text/javascript">
                    function loadEngagementTrend(days) {

                        $.ajax({
                            type: 'POST',
                            url: 'Dashboard.aspx/GetEngagementTrend',
                            data: JSON.stringify({ days: days }),
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',

                            success: function (r) {

                                var rows = r.d;
                                var chart = document.getElementById('engagementChartBox');
                                var daysBox = document.getElementById('engagementChartDays');

                                if (!rows || rows.length === 0) {
                                    chart.innerHTML = '<p class="text-muted">No engagement data yet.</p>';
                                    daysBox.innerHTML = '';
                                    return;
                                }

                                var chartHtml = '';
                                var daysHtml = '';

                                for (var i = 0; i < rows.length; i++) {
                                    chartHtml += '<div class="chart-bar" title="' +
                                        rows[i].Count +
                                        ' activity record(s)" style="height:' +
                                        rows[i].Percent +
                                        '%;"></div>';

                                    if (rows.length <= 7 || i % 5 === 0 || i === rows.length - 1) {
                                        daysHtml += '<span>' + esc(rows[i].DayLabel) + '</span>';
                                    }
                                    else {
                                        daysHtml += '<span></span>';
                                    }
                                }

                                chart.innerHTML = chartHtml;
                                daysBox.innerHTML = daysHtml;
                            },

                            error: function () {
                                document.getElementById('engagementChartBox').innerHTML =
                                    '<p class="text-muted">Unable to load engagement trend.</p>';
                            }
                        });
                    }

                    $(document).ready(function () {

                        loadEngagementTrend(7);

                        $('#trendRange').change(function () {
                            loadEngagementTrend(parseInt(this.value));
                        });

                    });

                    $.ajax({
                        type: 'POST',
                        url: 'Dashboard.aspx/GetSystemAlerts',
                        data: '{}',
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        success: function (r) {
                            var alerts = r.d;
                            var body = document.getElementById('systemAlertsBody');
                            var count = document.getElementById('alertCount');

                            if (!alerts || alerts.length === 0) {
                                count.textContent = '0 New';
                                body.innerHTML = '<p class="text-muted">No system alerts.</p>';
                                return;
                            }

                            count.textContent = alerts.length + ' New';

                            var html = '';

                            for (var i = 0; i < alerts.length; i++) {
                                var a = alerts[i];
                                var css = a.Severity === 'danger' ? 'admin-alert danger' : 'admin-alert';
                                var icon = a.Severity === 'danger'
                                    ? 'bi bi-exclamation-triangle text-danger fs-4'
                                    : 'bi bi-info-circle text-primary fs-4';

                                html += '<div class="' + css + '">' +
                                    '<i class="' + icon + '"></i>' +
                                    '<div>' +
                                    '<strong>' + esc(a.Title) + '</strong>' +
                                    '<p>' + esc(a.Message) + '</p>' +
                                    '<small class="text-muted">' + esc(a.TimeLabel) + '</small>' +
                                    '</div>' +
                                    '</div>';
                            }

                            body.innerHTML = html;
                        },
                        error: function () {
                            document.getElementById('systemAlertsBody').innerHTML =
                                '<p class="text-muted">Unable to load system alerts.</p>';
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
                                    <small class="text-muted">Login activity per day</small>
                                </div>

                                <select id="trendRange" class="form-select w-auto">
                                    <option value="7">Last 7 Days</option>
                                    <option value="30">Last 30 Days</option>
                                </select>
                            </div>

                            <div class="chart-box" id="engagementChartBox">
                                <p class="text-muted">Loading engagement trend...</p>
                            </div>

                            <div class="chart-days" id="engagementChartDays"></div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="admin-card">
                            <div class="admin-card-header">
                                <h4>System Alerts</h4>
                                <span class="badge bg-danger" id="alertCount">0 New</span>
                            </div>

                            <div id="systemAlertsBody">
                                <p class="text-muted">Loading alerts...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activity -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <div>
                            <h4>Recent Activity</h4>
                            <small class="text-muted">Latest logged admin and system actions</small>
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
                                  
                                </tr>
                            </thead>

                            <tbody id="activityTableBody">
                                <tr><td colspan="5" class="text-center text-muted py-3">Loading activity…</td></tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="text-center bg-light p-3 rounded-bottom">
                        <a href="AuditLogs.aspx"
                           class="btn btn-link text-muted text-decoration-none fw-bold">
                            View Full Audit Log <i class="bi bi-arrow-right"></i>
                        </a>
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
            </div>
            <hr class="mt-1 mb-2" />
            <p class="text-muted small mb-0 text-center">© 2026 Aidify Admin Panel. Educational use only.</p>
        </footer>

    </div>

</asp:Content>
