<%@ Page Title="Performance" Language="C#" AutoEventWireup="true" CodeBehind="Performance.aspx.cs" Inherits="Aidify_assigment.Instructor.Performance" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Aidify - Instructor Performance</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            margin: 0;
            background-color: #fff8f7;
            color: #121c2c;
            font-family: Arial, sans-serif;
        }

        .topbar {
            height: 76px;
            background: #ffffff;
            border-bottom: 1px solid #e6bdb8;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 34px;
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 26px;
            font-weight: 800;
            color: #b70011;
        }

        .role-badge {
            background: #b70011;
            color: white;
            font-size: 11px;
            padding: 4px 10px;
            border-radius: 20px;
            text-transform: uppercase;
        }

        .top-links {
            display: flex;
            gap: 18px;
            align-items: center;
            flex-wrap: wrap;
        }

        .top-links a {
            color: #5c403c;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
        }

        .top-links a.active {
            color: #b70011;
            border-bottom: 2px solid #b70011;
            padding-bottom: 8px;
        }

        .layout {
            display: flex;
        }

        .sidebar {
            width: 260px;
            min-height: calc(100vh - 76px);
            background: #ffffff;
            border-right: 1px solid #e6bdb8;
            padding: 28px 18px;
            position: sticky;
            top: 76px;
        }

        .sidebar-heading {
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #916f6b;
            font-weight: 800;
            margin: 18px 12px 10px;
        }

        .side-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 13px 15px;
            border-radius: 10px;
            color: #5c403c;
            text-decoration: none;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .side-link:hover {
            background: #fff1ef;
            color: #b70011;
        }

        .side-link.active {
            background: #b70011;
            color: white;
        }

        .help-box {
            background: #b70011;
            color: white;
            border-radius: 18px;
            padding: 22px;
            margin-top: 35px;
        }

        .help-box button {
            width: 100%;
            border: none;
            background: white;
            color: #b70011;
            border-radius: 8px;
            padding: 8px 14px;
            font-weight: 800;
        }

        .main {
            flex: 1;
            padding: 42px 48px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: end;
            gap: 20px;
            margin-bottom: 28px;
        }

        .page-header h1 {
            font-size: 36px;
            font-weight: 800;
            margin-bottom: 6px;
        }

        .page-header p {
            color: #545f72;
            margin: 0;
        }

        .btn-aidify {
            background: #b70011;
            color: white;
            border: 1px solid #b70011;
            font-weight: 700;
            border-radius: 8px;
            padding: 10px 16px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-outline-aidify {
            background: white;
            color: #5c403c;
            border: 1px solid #e6bdb8;
            font-weight: 700;
            border-radius: 8px;
            padding: 10px 16px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .summary-card,
        .table-card,
        .filter-card,
        .side-card {
            background: white;
            border: 1px solid #e6bdb8;
            border-radius: 16px;
        }

        .summary-card {
            padding: 22px;
            height: 100%;
        }

        .summary-card span {
            color: #545f72;
            font-size: 13px;
            font-weight: 800;
        }

        .summary-card h3 {
            font-size: 31px;
            font-weight: 900;
            margin: 6px 0 0;
        }

        .summary-icon {
            width: 45px;
            height: 45px;
            border-radius: 13px;
            background: #ffdad6;
            color: #b70011;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }

        .filter-card,
        .side-card {
            padding: 24px;
        }

        .table-card {
            overflow: hidden;
            margin-bottom: 24px;
        }

        .table-card-header {
            padding: 22px 24px;
            border-bottom: 1px solid #e6bdb8;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-card-header h2 {
            font-size: 22px;
            font-weight: 800;
            margin: 0;
        }

        .data-table {
            margin-bottom: 0;
        }

        .data-table th {
            background: #fff8f7;
            color: #916f6b;
            font-size: 12px;
            text-transform: uppercase;
            padding: 15px;
            border-bottom: 1px solid #e6bdb8;
            white-space: nowrap;
        }

        .data-table td {
            padding: 16px;
            vertical-align: middle;
            border-bottom: 1px solid #f1d6d2;
        }

        .badge-soft {
            background: #ffdad6;
            color: #b70011;
            border-radius: 14px;
            padding: 5px 10px;
            font-weight: 800;
            font-size: 12px;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .badge-green {
            background: #d8f3e7;
            color: #198754;
            border: 1px solid #9bd9b8;
            border-radius: 14px;
            padding: 5px 10px;
            font-weight: 800;
            font-size: 12px;
        }

        .badge-red {
            background: #ffe1e4;
            color: #b70011;
            border: 1px solid #ffb4ab;
            border-radius: 14px;
            padding: 5px 10px;
            font-weight: 800;
            font-size: 12px;
        }

        .form-control,
        .form-select {
            border: 1px solid #e6bdb8;
            border-radius: 10px;
            padding: 11px 13px;
        }

        .message-box {
            border-radius: 10px;
            padding: 12px 14px;
            margin-bottom: 16px;
            font-weight: 700;
        }

        .message-success {
            background: #d8f3e7;
            color: #198754;
            border: 1px solid #9bd9b8;
        }

        .message-error {
            background: #ffe1e4;
            color: #b70011;
            border: 1px solid #ffb4ab;
        }

        .empty-state {
            text-align: center;
            padding: 35px 20px;
            color: #545f72;
        }

        @media (max-width: 992px) {
            .sidebar,
            .top-links {
                display: none;
            }

            .main {
                padding: 28px 20px;
            }

            .page-header {
                flex-direction: column;
                align-items: start;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="topbar">
            <div class="brand">
                Aidify
                <span class="role-badge">Instructor</span>
            </div>

            <div class="top-links">
                <a href="Dashboard.aspx">Dashboard</a>
                <a href="Modules/List.aspx">Modules</a>
                <a href="Lessons/List.aspx">Lessons</a>
                <a href="Materials/Upload.aspx">Materials</a>
                <a href="Quizzes/List.aspx">Quizzes</a>
                <a href="Performance.aspx" class="active">Performance</a>
                <a href="Discussions.aspx">Discussions</a>
                <a href="Challenges.aspx">Challenges</a>
                <a href="Events.aspx">Events</a>
            </div>

            <div class="fw-bold">Dr. Smith</div>
        </div>

        <div class="layout">
            <aside class="sidebar">
                <div class="sidebar-heading">Main Menu</div>

                <a href="Dashboard.aspx" class="side-link">
                    <i class="bi bi-grid"></i> Dashboard
                </a>

                <a href="Modules/List.aspx" class="side-link">
                    <i class="bi bi-journal-bookmark"></i> Modules
                </a>

                <a href="Lessons/List.aspx" class="side-link">
                    <i class="bi bi-book"></i> Lessons
                </a>

                <a href="Materials/Upload.aspx" class="side-link">
                    <i class="bi bi-folder2-open"></i> Materials
                </a>

                <a href="Quizzes/List.aspx" class="side-link">
                    <i class="bi bi-ui-checks"></i> Quizzes
                </a>

                <div class="sidebar-heading">Monitoring</div>

                <a href="Performance.aspx" class="side-link active">
                    <i class="bi bi-graph-up"></i> Performance
                </a>

                <a href="Discussions.aspx" class="side-link">
                    <i class="bi bi-chat-dots"></i> Discussions
                </a>

                <a href="Challenges.aspx" class="side-link">
                    <i class="bi bi-trophy"></i> Challenges
                </a>

                <a href="Events.aspx" class="side-link">
                    <i class="bi bi-calendar-event"></i> Events
                </a>

                <div class="help-box">
                    <h6><i class="bi bi-question-circle me-2"></i>Need Help?</h6>
                    <p>Monitor learner progress, quiz scores, and module performance.</p>
                    <button type="button">Read Guide</button>
                </div>
            </aside>

            <main class="main">
                <div class="page-header">
                    <div>
                        <h1>Performance</h1>
                        <p>Monitor learner activity, lesson completion, and quiz achievement.</p>
                    </div>

                    <asp:Button ID="btnRefresh" runat="server"
                        Text="Refresh"
                        CssClass="btn-outline-aidify"
                        CausesValidation="false"
                        OnClick="btnRefresh_Click" />
                </div>

                <asp:Label ID="lblPerformanceStatus" runat="server" Visible="false"></asp:Label>

                <div class="row g-4 mb-4">
                    <div class="col-md-6 col-xl-3">
                        <div class="summary-card">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span>Total Learners</span>
                                    <h3><asp:Label ID="lblTotalLearners" runat="server" Text="0"></asp:Label></h3>
                                </div>
                                <div class="summary-icon"><i class="bi bi-people"></i></div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-xl-3">
                        <div class="summary-card">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span>Enrollments</span>
                                    <h3><asp:Label ID="lblTotalEnrollments" runat="server" Text="0"></asp:Label></h3>
                                </div>
                                <div class="summary-icon"><i class="bi bi-person-check"></i></div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-xl-3">
                        <div class="summary-card">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span>Completed Lessons</span>
                                    <h3><asp:Label ID="lblCompletedLessons" runat="server" Text="0"></asp:Label></h3>
                                </div>
                                <div class="summary-icon"><i class="bi bi-check2-circle"></i></div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-xl-3">
                        <div class="summary-card">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span>Average Score</span>
                                    <h3><asp:Label ID="lblAverageScore" runat="server" Text="0%"></asp:Label></h3>
                                </div>
                                <div class="summary-icon"><i class="bi bi-bar-chart"></i></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="filter-card mb-4">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-8">
                            <label class="form-label fw-bold">Filter by Module</label>
                            <asp:DropDownList ID="ddlModuleFilter" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>

                        <div class="col-md-4">
                            <asp:Button ID="btnApplyFilter" runat="server"
                                Text="Apply Filter"
                                CssClass="btn-aidify w-100"
                                CausesValidation="false"
                                OnClick="btnApplyFilter_Click" />
                        </div>
                    </div>
                </div>

                <div class="table-card">
                    <div class="table-card-header">
                        <h2><i class="bi bi-journal-bookmark text-danger me-2"></i>Module Performance</h2>
                        <span class="badge-soft">Progress Summary</span>
                    </div>

                    <div class="table-responsive">
                        <table class="table data-table">
                            <thead>
                                <tr>
                                    <th>Module</th>
                                    <th>Enrollments</th>
                                    <th>Lessons</th>
                                    <th>Completed Progress</th>
                                    <th>Completion Rate</th>
                                    <th>Quiz Attempts</th>
                                    <th>Average Score</th>
                                </tr>
                            </thead>

                            <tbody>
                                <asp:Repeater ID="rptModulePerformance" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><strong><%# Eval("ModuleTitle") %></strong></td>
                                            <td><span class="badge-soft"><%# Eval("EnrollmentCount") %></span></td>
                                            <td><%# Eval("LessonCount") %></td>
                                            <td><%# Eval("CompletedLessons") %></td>
                                            <td><%# Eval("CompletionRate") %>%</td>
                                            <td><%# Eval("QuizAttemptCount") %></td>
                                            <td><%# Eval("AverageScore") %>%</td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>

                        <asp:Panel ID="pnlModuleEmpty" runat="server" CssClass="empty-state" Visible="false">
                            <i class="bi bi-graph-up fs-1 text-danger"></i>
                            <h4 class="mt-3">No module performance data found.</h4>
                        </asp:Panel>
                    </div>
                </div>

                <div class="table-card">
                    <div class="table-card-header">
                        <h2><i class="bi bi-ui-checks text-danger me-2"></i>Recent Quiz Attempts</h2>
                        <span class="badge-soft">Assessment Activity</span>
                    </div>

                    <div class="table-responsive">
                        <table class="table data-table">
                            <thead>
                                <tr>
                                    <th>Learner</th>
                                    <th>Quiz</th>
                                    <th>Module</th>
                                    <th>Score</th>
                                    <th>Result</th>
                                    <th>Submitted</th>
                                </tr>
                            </thead>

                            <tbody>
                                <asp:Repeater ID="rptQuizAttempts" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Eval("LearnerName") %></td>
                                            <td><strong><%# Eval("QuizTitle") %></strong></td>
                                            <td><%# Eval("ModuleTitle") %></td>
                                            <td><%# Eval("Score") %>%</td>
                                            <td>
                                                <span class="<%# Convert.ToBoolean(Eval("Passed")) ? "badge-green" : "badge-red" %>">
                                                    <%# Convert.ToBoolean(Eval("Passed")) ? "Passed" : "Failed" %>
                                                </span>
                                            </td>
                                            <td><%# FormatDate(Eval("SubmittedAt")) %></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>

                        <asp:Panel ID="pnlAttemptsEmpty" runat="server" CssClass="empty-state" Visible="false">
                            <i class="bi bi-ui-checks fs-1 text-danger"></i>
                            <h4 class="mt-3">No quiz attempts found.</h4>
                        </asp:Panel>
                    </div>
                </div>
            </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>