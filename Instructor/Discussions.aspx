<%@ Page Title="Discussions" Language="C#" AutoEventWireup="true" CodeBehind="Discussions.aspx.cs" Inherits="Aidify_assigment.Instructor.Discussions" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Aidify - Discussions</title>
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

        .form-card,
        .filter-card,
        .thread-card,
        .summary-card,
        .side-card {
            background: white;
            border: 1px solid #e6bdb8;
            border-radius: 16px;
        }

        .form-card,
        .filter-card,
        .side-card {
            padding: 24px;
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

        .form-card h2,
        .side-card h3 {
            font-size: 22px;
            font-weight: 800;
            margin-bottom: 20px;
        }

        .form-label {
            font-weight: 800;
            color: #121c2c;
        }

        .required {
            color: #b70011;
        }

        .form-control,
        .form-select {
            border: 1px solid #e6bdb8;
            border-radius: 10px;
            padding: 11px 13px;
        }

        .thread-card {
            padding: 22px;
            margin-bottom: 18px;
        }

        .thread-title {
            font-size: 20px;
            font-weight: 800;
            margin-bottom: 4px;
        }

        .thread-meta {
            color: #6b7280;
            font-size: 13px;
            margin-bottom: 12px;
        }

        .thread-body {
            color: #374151;
            margin-bottom: 16px;
        }

        .reply-box {
            background: #fff8f7;
            border: 1px solid #e6bdb8;
            border-radius: 12px;
            padding: 14px;
            margin-bottom: 10px;
        }

        .reply-meta {
            font-size: 12px;
            color: #6b7280;
            margin-bottom: 5px;
        }

        .reply-body {
            color: #374151;
            margin-bottom: 0;
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
            background: white;
            border: 1px solid #e6bdb8;
            border-radius: 16px;
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
                <a href="Performance.aspx">Performance</a>
                <a href="Discussions.aspx" class="active">Discussions</a>
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

                <a href="Performance.aspx" class="side-link">
                    <i class="bi bi-graph-up"></i> Performance
                </a>

                <a href="Discussions.aspx" class="side-link active">
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
                    <p>Manage module discussions and learner replies.</p>
                    <button type="button">Read Guide</button>
                </div>
            </aside>

            <main class="main">
                <div class="page-header">
                    <div>
                        <h1>Discussions</h1>
                        <p>Create discussion threads and respond to learners.</p>
                    </div>

                    <asp:Button ID="btnRefresh" runat="server"
                        Text="Refresh"
                        CssClass="btn-outline-aidify"
                        CausesValidation="false"
                        OnClick="btnRefresh_Click" />
                </div>

                <asp:Label ID="lblDiscussionStatus" runat="server" Visible="false"></asp:Label>

                <div class="row g-4 mb-4">
                    <div class="col-md-4">
                        <div class="summary-card">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span>Total Threads</span>
                                    <h3><asp:Label ID="lblTotalThreads" runat="server" Text="0"></asp:Label></h3>
                                </div>
                                <div class="summary-icon"><i class="bi bi-chat-dots"></i></div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="summary-card">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span>Total Replies</span>
                                    <h3><asp:Label ID="lblTotalReplies" runat="server" Text="0"></asp:Label></h3>
                                </div>
                                <div class="summary-icon"><i class="bi bi-reply"></i></div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="summary-card">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span>Modules Discussed</span>
                                    <h3><asp:Label ID="lblModulesDiscussed" runat="server" Text="0"></asp:Label></h3>
                                </div>
                                <div class="summary-icon"><i class="bi bi-journal-bookmark"></i></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row g-4">
                    <div class="col-lg-8">
                        <div class="form-card mb-4">
                            <h2><i class="bi bi-plus-circle text-danger me-2"></i>Create Discussion Thread</h2>

                            <div class="mb-3">
                                <label class="form-label">Module <span class="required">*</span></label>
                                <asp:DropDownList ID="ddlModule" runat="server" CssClass="form-select"></asp:DropDownList>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Thread Title <span class="required">*</span></label>
                                <asp:TextBox ID="txtThreadTitle" runat="server" CssClass="form-control" placeholder="e.g., CPR scenario discussion"></asp:TextBox>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Thread Body <span class="required">*</span></label>
                                <asp:TextBox ID="txtThreadBody" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Write the discussion prompt or question."></asp:TextBox>
                            </div>

                            <div class="d-flex justify-content-end gap-2">
                                <asp:Button ID="btnClearThread" runat="server"
                                    Text="Clear"
                                    CssClass="btn-outline-aidify"
                                    CausesValidation="false"
                                    OnClick="btnClearThread_Click" />

                                <asp:Button ID="btnCreateThread" runat="server"
                                    Text="Create Thread"
                                    CssClass="btn-aidify"
                                    OnClick="btnCreateThread_Click" />
                            </div>
                        </div>

                        <div class="filter-card mb-4">
                            <div class="row g-3 align-items-end">
                                <div class="col-md-8">
                                    <label class="form-label">Filter by Module</label>
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

                        <asp:Repeater ID="rptThreads" runat="server" OnItemCommand="rptThreads_ItemCommand">
                            <ItemTemplate>
                                <div class="thread-card">
                                    <div class="d-flex justify-content-between align-items-start gap-3">
                                        <div>
                                            <div class="thread-title"><%# Eval("Title") %></div>
                                            <div class="thread-meta">
                                                <span class="badge-soft"><i class="bi bi-journal-bookmark"></i> <%# Eval("ModuleTitle") %></span>
                                                &nbsp; Posted by <%# Eval("UserName") %>
                                                &nbsp; • &nbsp; <%# FormatDate(Eval("CreatedAt")) %>
                                                &nbsp; • &nbsp; <%# Eval("ReplyCount") %> replies
                                            </div>
                                        </div>

                                        <asp:LinkButton ID="btnDeleteThread" runat="server"
                                            CssClass="action-btn danger"
                                            CommandName="DeleteThread"
                                            CommandArgument='<%# Eval("ThreadId") %>'
                                            CausesValidation="false"
                                            OnClientClick="return confirm('Delete this thread and all replies?');">
                                            <i class="bi bi-trash"></i> Delete
                                        </asp:LinkButton>
                                    </div>

                                    <div class="thread-body"><%# Eval("Body") %></div>

                                    <hr />

                                    <strong>Replies</strong>

                                    <asp:Repeater ID="rptReplies" runat="server" DataSource='<%# GetReplies(Eval("ThreadId")) %>' OnItemCommand="rptReplies_ItemCommand">
                                        <ItemTemplate>
                                            <div class="reply-box">
                                                <div class="d-flex justify-content-between align-items-start gap-2">
                                                    <div>
                                                        <div class="reply-meta">
                                                            <%# Eval("UserName") %> • <%# FormatDate(Eval("CreatedAt")) %>
                                                        </div>
                                                        <p class="reply-body"><%# Eval("Body") %></p>
                                                    </div>

                                                    <asp:LinkButton ID="btnDeleteReply" runat="server"
                                                        CssClass="action-btn danger"
                                                        CommandName="DeleteReply"
                                                        CommandArgument='<%# Eval("ReplyId") %>'
                                                        CausesValidation="false"
                                                        OnClientClick="return confirm('Delete this reply?');">
                                                        <i class="bi bi-trash"></i>
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                    <div class="mt-3">
                                        <asp:TextBox ID="txtReplyBody" runat="server"
                                            CssClass="form-control mb-2"
                                            TextMode="MultiLine"
                                            Rows="2"
                                            placeholder="Write a reply..."></asp:TextBox>

                                        <asp:LinkButton ID="btnAddReply" runat="server"
                                            CssClass="btn-aidify"
                                            CommandName="AddReply"
                                            CommandArgument='<%# Eval("ThreadId") %>'>
                                            <i class="bi bi-send"></i> Add Reply
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <asp:Panel ID="pnlEmptyState" runat="server" CssClass="empty-state" Visible="false">
                            <i class="bi bi-chat-dots fs-1 text-danger"></i>
                            <h4 class="mt-3">No discussions found.</h4>
                            <p>Create a new discussion thread or reset your filter.</p>
                        </asp:Panel>
                    </div>

                    <div class="col-lg-4">
                        <div class="side-card mb-4">
                            <h3><i class="bi bi-lightbulb text-danger me-2"></i>Discussion Tips</h3>
                            <div class="reply-box">Use clear module-specific questions.</div>
                            <div class="reply-box">Encourage learners to explain their reasoning.</div>
                            <div class="reply-box">Reply with practical emergency-response feedback.</div>
                            <div class="reply-box mb-0">Keep discussions educational and respectful.</div>
                        </div>

                        <div class="side-card">
                            <h3><i class="bi bi-info-circle text-danger me-2"></i>Database Mapping</h3>
                            <p class="small text-muted mb-0">
                                This page saves threads into dbo.DiscussionThreads and replies into dbo.DiscussionReplies.
                            </p>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>