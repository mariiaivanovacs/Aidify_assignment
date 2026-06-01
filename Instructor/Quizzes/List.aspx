<%@ Page Title="Quizzes" Language="C#" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Aidify_assigment.Instructor.Quizzes.List" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Aidify - Quizzes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            margin: 0;
            background: #fff8f7;
            color: #121c2c;
            font-family: Arial, sans-serif;
        }

        .topbar {
            height: 76px;
            background: #fff;
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

        .profile {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            overflow: hidden;
            border: 1px solid #e6bdb8;
        }

        .profile-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .layout {
            display: flex;
        }

        .sidebar {
            width: 260px;
            min-height: calc(100vh - 76px);
            background: #fff;
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

        .btn-outline-aidify:hover {
            background: #fff1ef;
            color: #b70011;
            border-color: #b70011;
        }

        .filter-card {
            background: white;
            border: 1px solid #e6bdb8;
            border-radius: 16px;
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

        .card-shell {
            background: #fff;
            border: 1px solid #e6bdb8;
            border-radius: 16px;
            overflow: hidden;
        }

        .card-head {
            padding: 22px 24px;
            border-bottom: 1px solid #e6bdb8;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-head h2 {
            font-size: 28px;
            margin: 0;
        }

        table {
            margin-bottom: 0 !important;
        }

        th {
            background: #fff8f7 !important;
            color: #916f6b !important;
            font-size: 12px;
            text-transform: uppercase;
            padding: 15px !important;
            border-bottom: 1px solid #e6bdb8 !important;
            white-space: nowrap;
        }

        td {
            padding: 16px !important;
            vertical-align: middle;
            border-bottom: 1px solid #f1d6d2 !important;
        }

        .badge-soft {
            background: #ffdad6;
            color: #b70011;
            border-radius: 14px;
            padding: 5px 10px;
            font-weight: 800;
            font-size: 12px;
            display: inline-flex;
            gap: 5px;
            align-items: center;
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

        .action-btn {
            border: 1px solid #e6bdb8;
            background: white;
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

        @media(max-width: 992px) {
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
                <a href="../Dashboard.aspx">Dashboard</a>
                <a href="../Modules/List.aspx">Modules</a>
                <a href="../Lessons/List.aspx">Lessons</a>
                <a href="../Materials/Upload.aspx">Materials</a>
                <a href="List.aspx" class="active">Quizzes</a>
                <a href="../Performance.aspx">Performance</a>
                <a href="../Discussions.aspx">Discussions</a>
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
                         alt="Instructor"
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

                <a href="../Lessons/List.aspx" class="side-link">
                    <i class="bi bi-book"></i> Lessons
                </a>

                <a href="../Materials/Upload.aspx" class="side-link">
                    <i class="bi bi-folder2-open"></i> Materials
                </a>

                <a href="List.aspx" class="side-link active">
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
                    <p>Create quizzes, manage questions, and generate AI-based assessments.</p>
                    <button type="button">Read Guide</button>
                </div>
            </aside>

            <main class="main">
                <div class="page-header">
                    <div>
                        <h1>Quizzes</h1>
                        <p>Create and manage assessments linked to modules.</p>
                    </div>

                    <div class="d-flex gap-2 flex-wrap">
                        <asp:Button ID="btnRefresh" runat="server"
                            Text="Refresh"
                            CssClass="btn-outline-aidify"
                            CausesValidation="false"
                            OnClick="btnRefresh_Click" />

                        <a href="GenerateWithAI.aspx" class="btn-outline-aidify">
                            <i class="bi bi-stars"></i> Generate with AI
                        </a>

                        <a href="Edit.aspx" class="btn-aidify">
                            <i class="bi bi-plus-lg"></i> Create Quiz
                        </a>
                    </div>
                </div>

                <asp:Label ID="lblQuizStatus" runat="server" Visible="false"></asp:Label>

                <div class="filter-card">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-5">
                            <label class="form-label fw-bold">Search</label>
                            <asp:TextBox ID="txtSearch" runat="server"
                                CssClass="form-control"
                                placeholder="Search quiz title..."></asp:TextBox>
                        </div>

                        <div class="col-md-5">
                            <label class="form-label fw-bold">Module</label>
                            <asp:DropDownList ID="ddlModuleFilter" runat="server"
                                CssClass="form-select"></asp:DropDownList>
                        </div>

                        <div class="col-md-2">
                            <asp:Button ID="btnApplyFilter" runat="server"
                                Text="Apply"
                                CssClass="btn-aidify w-100"
                                OnClick="btnApplyFilter_Click" />
                        </div>
                    </div>
                </div>

                <div class="card-shell">
                    <div class="card-head">
                        <div>
                            <h2 class="mb-1">
                                <i class="bi bi-ui-checks text-danger me-2"></i>Quiz List
                            </h2>
                            <small class="text-muted">Quizzes loaded from dbo.Quizzes</small>
                        </div>

                        <span class="badge-soft">
                            <asp:Label ID="lblQuizCount" runat="server" Text="0 Records"></asp:Label>
                        </span>
                    </div>

                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Quiz Title</th>
                                    <th>Module</th>
                                    <th>Time Limit</th>
                                    <th>Passing %</th>
                                    <th>Preview</th>
                                    <th>Questions</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>

                            <tbody>
                                <asp:Repeater ID="rptQuizzes" runat="server" OnItemCommand="rptQuizzes_ItemCommand">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <strong><%# Eval("Title") %></strong><br />
                                                <small class="text-muted"><%# ShortText(Eval("Description")) %></small>
                                            </td>

                                            <td><%# Eval("ModuleTitle") %></td>

                                            <td><%# FormatTime(Eval("TimeLimitSec")) %></td>

                                            <td>
                                                <span class="badge-soft"><%# Eval("PassingPct") %>%</span>
                                            </td>

                                            <td><%# Convert.ToBoolean(Eval("IsPreview")) ? "Yes" : "No" %></td>

                                            <td>
                                                <span class="badge-green"><%# Eval("QuestionCount") %></span>
                                            </td>

                                            <td class="text-end">
                                                <asp:LinkButton ID="btnEdit" runat="server"
                                                    CssClass="action-btn"
                                                    CommandName="EditQuiz"
                                                    CommandArgument='<%# Eval("QuizId") %>'
                                                    CausesValidation="false">
                                                    <i class="bi bi-pencil"></i> Edit
                                                </asp:LinkButton>

                                                <asp:LinkButton ID="btnQuestions" runat="server"
                                                    CssClass="action-btn"
                                                    CommandName="ManageQuestions"
                                                    CommandArgument='<%# Eval("QuizId") %>'
                                                    CausesValidation="false">
                                                    <i class="bi bi-list-check"></i> Questions
                                                </asp:LinkButton>

                                                <asp:LinkButton ID="btnDelete" runat="server"
                                                    CssClass="action-btn danger"
                                                    CommandName="DeleteQuiz"
                                                    CommandArgument='<%# Eval("QuizId") %>'
                                                    CausesValidation="false"
                                                    OnClientClick="return confirm('Delete this quiz and all its questions?');">
                                                    <i class="bi bi-trash"></i> Delete
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>

                        <asp:Panel ID="pnlEmptyState" runat="server" CssClass="empty-state" Visible="false">
                            <i class="bi bi-ui-checks fs-1 text-danger"></i>
                            <h4 class="mt-3">No quizzes found.</h4>
                            <p>Create a quiz or reset your filters.</p>

                            <div class="d-flex justify-content-center gap-2 flex-wrap">
                                <a href="GenerateWithAI.aspx" class="btn-outline-aidify">
                                    <i class="bi bi-stars"></i> Generate with AI
                                </a>

                                <a href="Edit.aspx" class="btn-aidify">
                                    Create Quiz
                                </a>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>