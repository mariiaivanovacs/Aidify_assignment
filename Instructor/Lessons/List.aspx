<%@ Page Title="Lessons" Language="C#" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Aidify_assigment.Instructor.Lessons.List" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Aidify - Instructor Lessons</title>
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

        .instructor-shell {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background-color: #fff8f7;
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
            letter-spacing: .5px;
        }

        .top-links {
            display: flex;
            gap: 18px;
            align-items: center;
            flex-wrap: wrap;
            justify-content: center;
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

        .profile {
            display: flex;
            align-items: center;
            gap: 12px;
            white-space: nowrap;
        }

        .avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: #b70011;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border: 1px solid #e6bdb8;
        }

        .profile-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .layout {
            display: flex;
            flex: 1;
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

        .help-box h6 {
            font-weight: 800;
            margin-bottom: 8px;
        }

        .help-box p {
            font-size: 14px;
            opacity: .9;
            margin-bottom: 14px;
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

        .btn-aidify:hover {
            background: #8b000a;
            color: white;
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

        .filter-card,
        .table-card,
        .summary-card {
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

        .filter-card {
            padding: 22px;
            margin-bottom: 24px;
        }

        .form-control,
        .form-select {
            border: 1px solid #e6bdb8;
            border-radius: 10px;
            padding: 11px 13px;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: #b70011;
            box-shadow: 0 0 0 0.18rem rgba(183, 0, 17, 0.12);
        }

        .table-card {
            overflow: hidden;
        }

        .table-card-header {
            padding: 22px 24px;
            border-bottom: 1px solid #e6bdb8;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .lessons-table {
            margin-bottom: 0;
        }

        .lessons-table th {
            background: #fff8f7;
            color: #916f6b;
            font-size: 12px;
            text-transform: uppercase;
            padding: 15px;
            border-bottom: 1px solid #e6bdb8;
            white-space: nowrap;
        }

        .lessons-table td {
            padding: 16px;
            vertical-align: middle;
            border-bottom: 1px solid #f1d6d2;
        }

        .badge-order {
            background: #ffdad6;
            color: #b70011;
            border-radius: 14px;
            padding: 5px 10px;
            font-weight: 800;
            font-size: 12px;
        }

        .action-btn {
            border: 1px solid #e6bdb8;
            background: #ffffff;
            color: #5c403c;
            border-radius: 8px;
            padding: 7px 10px;
            font-size: 13px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            margin: 2px;
            font-weight: 700;
        }

        .action-btn:hover {
            background: #fff1ef;
            color: #b70011;
            border-color: #b70011;
        }

        .action-btn.danger {
            color: #b70011;
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
            padding: 45px 20px;
            color: #545f72;
        }

        @media (max-width: 992px) {
            .sidebar {
                display: none;
            }

            .main {
                padding: 28px 20px;
            }

            .top-links {
                display: none;
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
        <div class="instructor-shell">

            <div class="topbar">
                <div class="brand">
                    Aidify
                    <span class="role-badge">Instructor</span>
                </div>

                <div class="top-links">
                    <a href="../Dashboard.aspx">Dashboard</a>
                    <a href="../Modules/List.aspx">Modules</a>
                    <a href="List.aspx" class="active">Lessons</a>
                    <a href="../Materials/Upload.aspx">Materials</a>
                    <a href="../Quizzes/List.aspx">Quizzes</a>
                    <a href="../Performance.aspx">Performance</a>
                    <a href="../Challenges.aspx">Challenges</a>
                    <a href="../Events.aspx">Events</a>
                </div>

                <div class="profile">
                    <div class="text-end d-none d-md-block">
                        <div class="fw-bold">Dr. Smith</div>
                        <small class="text-muted">Instructor</small>
                    </div>

                    <div class="avatar">
                        <img class="profile-img"
                             alt="Instructor Profile"
                             src="https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?auto=format&fit=crop&w=160&q=80" />
                    </div>
                </div>
            </div>

            <div class="layout">
                <aside class="sidebar">
                    <div class="sidebar-heading">Main Menu</div>

                    <a href="../Dashboard.aspx" class="side-link">
                        <i class="bi bi-grid"></i> Dashboard
                    </a>

                    <a href="../Modules/List.aspx" class="side-link">
                        <i class="bi bi-journal-bookmark"></i> Modules
                    </a>

                    <a href="List.aspx" class="side-link active">
                        <i class="bi bi-book"></i> Lessons
                    </a>

                    <a href="../Materials/Upload.aspx" class="side-link">
                        <i class="bi bi-folder2-open"></i> Materials
                    </a>

                    <a href="../Quizzes/List.aspx" class="side-link">
                        <i class="bi bi-ui-checks"></i> Quizzes
                    </a>

                    <div class="sidebar-heading">Monitoring</div>

                    <a href="../Performance.aspx" class="side-link">
                        <i class="bi bi-graph-up"></i> Performance
                    </a>

                    <a href="../Discussions.aspx" class="side-link">
                        <i class="bi bi-chat-dots"></i> Discussions
                    </a>

                    <a href="../Challenges.aspx" class="side-link">
                        <i class="bi bi-trophy"></i> Challenges
                    </a>

                    <a href="../Events.aspx" class="side-link">
                        <i class="bi bi-calendar-event"></i> Events
                    </a>

                    <div class="help-box">
                        <h6><i class="bi bi-question-circle me-2"></i>Need Help?</h6>
                        <p>Create and manage lessons inside your modules.</p>
                        <button type="button">Read Guide</button>
                    </div>
                </aside>

                <main class="main">
                    <div class="page-header">
                        <div>
                            <h1>Lessons</h1>
                            <p>Manage lesson content, order, and estimated learning time.</p>
                        </div>

                        <div class="d-flex gap-2 flex-wrap">
                            <asp:Button ID="btnRefresh" runat="server"
                                Text="Refresh"
                                CssClass="btn-outline-aidify"
                                OnClick="btnRefresh_Click" />

                            <a href="Edit.aspx" class="btn-aidify">
                                <i class="bi bi-plus-lg"></i> Create Lesson
                            </a>
                        </div>
                    </div>

                    <asp:Label ID="lblLessonStatus" runat="server" Visible="false"></asp:Label>

                    <div class="row g-4 mb-4">
                        <div class="col-md-4">
                            <div class="summary-card">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <span>Total Lessons</span>
                                        <h3><asp:Label ID="lblTotalLessons" runat="server" Text="0"></asp:Label></h3>
                                    </div>
                                    <div class="summary-icon"><i class="bi bi-book"></i></div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="summary-card">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <span>Total Minutes</span>
                                        <h3><asp:Label ID="lblTotalMinutes" runat="server" Text="0"></asp:Label></h3>
                                    </div>
                                    <div class="summary-icon"><i class="bi bi-clock"></i></div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="summary-card">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <span>Modules With Lessons</span>
                                        <h3><asp:Label ID="lblModulesWithLessons" runat="server" Text="0"></asp:Label></h3>
                                    </div>
                                    <div class="summary-icon"><i class="bi bi-journal-bookmark"></i></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="filter-card">
                        <div class="row g-3 align-items-end">
                            <div class="col-md-5">
                                <label class="form-label fw-bold">Search</label>
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search lesson title..."></asp:TextBox>
                            </div>

                            <div class="col-md-5">
                                <label class="form-label fw-bold">Module</label>
                                <asp:DropDownList ID="ddlModuleFilter" runat="server" CssClass="form-select"></asp:DropDownList>
                            </div>

                            <div class="col-md-2">
                                <asp:Button ID="btnApplyFilters" runat="server"
                                    Text="Apply"
                                    CssClass="btn-aidify w-100"
                                    OnClick="btnApplyFilters_Click" />
                            </div>
                        </div>
                    </div>

                    <div class="table-card">
                        <div class="table-card-header">
                            <div>
                                <h2 class="mb-1"><i class="bi bi-list-check text-danger me-2"></i>Lesson List</h2>
                                <small class="text-muted">Lessons loaded from dbo.Lessons</small>
                            </div>

                            <span class="badge-order">
                                <asp:Label ID="lblLessonCount" runat="server" Text="0 Records"></asp:Label>
                            </span>
                        </div>

                        <div class="table-responsive">
                            <table class="table lessons-table">
                                <thead>
                                    <tr>
                                        <th>Lesson Title</th>
                                        <th>Module</th>
                                        <th>Order</th>
                                        <th>Estimated Minutes</th>
                                        <th>Content Preview</th>
                                        <th class="text-end">Actions</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <asp:Repeater ID="rptLessons" runat="server" OnItemCommand="rptLessons_ItemCommand">
                                        <ItemTemplate>
                                            <tr>
                                                <td><strong><%# Eval("Title") %></strong></td>
                                                <td><%# Eval("ModuleTitle") %></td>
                                                <td><span class="badge-order"><%# Eval("SequenceOrder") %></span></td>
                                                <td><%# Eval("EstimatedMinutes") %> mins</td>
                                                <td><%# ShortText(Eval("BodyHtml")) %></td>
                                                <td class="text-end">
                                                    <asp:LinkButton ID="btnEdit" runat="server"
                                                        CssClass="action-btn"
                                                        CommandName="EditLesson"
                                                        CommandArgument='<%# Eval("LessonId") %>'
                                                        CausesValidation="false">
                                                        <i class="bi bi-pencil"></i> Edit
                                                    </asp:LinkButton>

                                                    <asp:LinkButton ID="btnDelete" runat="server"
                                                        CssClass="action-btn danger"
                                                        CommandName="DeleteLesson"
                                                        CommandArgument='<%# Eval("LessonId") %>'
                                                        CausesValidation="false"
                                                        OnClientClick="return confirm('Delete this lesson?');">
                                                        <i class="bi bi-trash"></i> Delete
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>

                            <asp:Panel ID="pnlEmptyState" runat="server" CssClass="empty-state" Visible="false">
                                <i class="bi bi-book fs-1 text-danger"></i>
                                <h4 class="mt-3">No lessons found.</h4>
                                <p>Create a lesson or reset your filters.</p>
                                <a href="Edit.aspx" class="btn-aidify">Create Lesson</a>
                            </asp:Panel>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>