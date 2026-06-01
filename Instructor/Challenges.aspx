<%@ Page Title="Challenges" Language="C#" AutoEventWireup="true" CodeBehind="Challenges.aspx.cs" Inherits="Aidify_assigment.Instructor.Challenges" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Aidify - Instructor Challenges</title>
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

        .btn-outline-aidify:hover {
            background: #fff1ef;
            color: #b70011;
            border-color: #b70011;
        }

        .summary-card,
        .form-card,
        .table-card,
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

        .form-card,
        .side-card {
            padding: 26px;
        }

        .form-card h2,
        .table-card h2,
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

        .form-control {
            border: 1px solid #e6bdb8;
            border-radius: 10px;
            padding: 11px 13px;
        }

        .form-control:focus {
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

        .challenge-table {
            margin-bottom: 0;
        }

        .challenge-table th {
            background: #fff8f7;
            color: #916f6b;
            font-size: 12px;
            text-transform: uppercase;
            padding: 15px;
            border-bottom: 1px solid #e6bdb8;
            white-space: nowrap;
        }

        .challenge-table td {
            padding: 16px;
            vertical-align: middle;
            border-bottom: 1px solid #f1d6d2;
        }

        .badge-draft,
        .badge-published {
            padding: 5px 9px;
            border-radius: 14px;
            font-size: 12px;
            font-weight: 800;
            display: inline-flex;
            align-items: center;
            gap: 4px;
            white-space: nowrap;
        }

        .badge-draft {
            background: #eeeeee;
            color: #545f72;
            border: 1px solid #d7d7d7;
        }

        .badge-published {
            background: #d8f3e7;
            color: #198754;
            border: 1px solid #9bd9b8;
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

        .tip-box {
            background: #fff8f7;
            border: 1px solid #e6bdb8;
            border-radius: 14px;
            padding: 15px;
            margin-bottom: 12px;
            color: #545f72;
            font-size: 14px;
        }

        .timeline {
            position: relative;
            padding-left: 30px;
        }

        .timeline::before {
            content: "";
            position: absolute;
            left: 9px;
            top: 6px;
            bottom: 6px;
            width: 2px;
            background: #e6bdb8;
        }

        .timeline-step {
            position: relative;
            margin-bottom: 26px;
        }

        .timeline-step:last-child {
            margin-bottom: 0;
        }

        .timeline-dot {
            position: absolute;
            left: -29px;
            top: 2px;
            width: 20px;
            height: 20px;
            background: #ffffff;
            border: 4px solid #e6bdb8;
            border-radius: 50%;
        }

        .timeline-step.active .timeline-dot {
            background: #b70011;
            border-color: #ffdad6;
        }

        .timeline-title {
            font-weight: 800;
            color: #545f72;
        }

        .timeline-step.active .timeline-title {
            color: #b70011;
        }

        .timeline-text {
            font-size: 13px;
            color: #545f72;
            margin-top: 3px;
        }

        .challenge-img {
            width: 100%;
            height: 210px;
            object-fit: cover;
            border-radius: 16px 16px 0 0;
        }

        .empty-state {
            text-align: center;
            padding: 45px 20px;
            color: #545f72;
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
                    <a href="Dashboard.aspx">Dashboard</a>
                    <a href="Modules/List.aspx">Modules</a>
                    <a href="Lessons/List.aspx">Lessons</a>
                    <a href="Materials/Upload.aspx">Materials</a>
                    <a href="Quizzes/List.aspx">Quizzes</a>
                    <a href="Performance.aspx">Performance</a>
                    <a href="Challenges.aspx" class="active">Challenges</a>
                    <a href="Events.aspx">Events</a>
                </div>

                <div class="profile">
                    <div class="text-end d-none d-md-block">
                        <div class="fw-bold">Dr. Smith</div>
                        <small class="text-muted">Instructor</small>
                    </div>

                    <div class="avatar">
                        <img class="profile-img"
                             alt="Instructor Profile"
                             src="https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?auto=format&fit=crop&w=160&q=80"
                             onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1582750433449-648ed127bb54?auto=format&fit=crop&w=160&q=80';" />
                    </div>
                </div>
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

                    <a href="Discussions.aspx" class="side-link">
                        <i class="bi bi-chat-dots"></i> Discussions
                    </a>

                    <a href="Challenges.aspx" class="side-link active">
                        <i class="bi bi-trophy"></i> Challenges
                    </a>

                    <a href="Events.aspx" class="side-link">
                        <i class="bi bi-calendar-event"></i> Events
                    </a>

                    <div class="help-box">
                        <h6><i class="bi bi-question-circle me-2"></i>Need Help?</h6>
                        <p>Create practical challenges that support emergency response learning.</p>
                        <button type="button">Read Guide</button>
                    </div>
                </aside>

                <main class="main">
                    <div class="page-header">
                        <div>
                            <h1>Challenges</h1>
                            <p>Create learner challenges, assign points, and track challenge status.</p>
                        </div>

                        <div class="d-flex gap-2 flex-wrap">
                            <asp:Button ID="btnRefresh" runat="server"
                                Text="Refresh List"
                                CssClass="btn-outline-aidify"
                                OnClick="btnRefresh_Click" />

                            <a href="#challengeFormCard" class="btn-aidify">
                                <i class="bi bi-plus-lg"></i> New Challenge
                            </a>
                        </div>
                    </div>

                    <asp:Label ID="lblChallengeStatus" runat="server" Visible="false"></asp:Label>

                    <div class="row g-4 mb-4">
                        <div class="col-md-6 col-lg-3">
                            <div class="summary-card">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <span>Total Challenges</span>
                                        <h3><asp:Label ID="lblTotalChallenges" runat="server" Text="0"></asp:Label></h3>
                                    </div>
                                    <div class="summary-icon"><i class="bi bi-trophy"></i></div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="summary-card">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <span>Draft Challenges</span>
                                        <h3><asp:Label ID="lblDraftChallenges" runat="server" Text="0"></asp:Label></h3>
                                    </div>
                                    <div class="summary-icon"><i class="bi bi-pencil-square"></i></div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="summary-card">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <span>Published Challenges</span>
                                        <h3><asp:Label ID="lblPublishedChallenges" runat="server" Text="0"></asp:Label></h3>
                                    </div>
                                    <div class="summary-icon"><i class="bi bi-check-circle"></i></div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="summary-card">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <span>Total Reward Points</span>
                                        <h3><asp:Label ID="lblTotalPoints" runat="server" Text="0"></asp:Label></h3>
                                    </div>
                                    <div class="summary-icon"><i class="bi bi-star"></i></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row g-4">
                        <div class="col-lg-8">

                            <div class="form-card mb-4" id="challengeFormCard">
                                <h2>
                                    <i class="bi bi-plus-circle text-danger me-2"></i>
                                    <asp:Label ID="lblFormTitle" runat="server" Text="Create Challenge"></asp:Label>
                                </h2>

                                <asp:HiddenField ID="hfChallengeId" runat="server" />

                                <div class="mb-3">
                                    <label class="form-label">Challenge Title <span class="required">*</span></label>
                                    <asp:TextBox ID="txtChallengeTitle" runat="server" CssClass="form-control" placeholder="e.g., CPR Response Challenge"></asp:TextBox>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Description <span class="required">*</span></label>
                                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Describe the challenge task and expected learner outcome."></asp:TextBox>
                                </div>

                                <div class="row g-3 mb-3">
                                    <div class="col-md-4">
                                        <label class="form-label">Start Date <span class="required">*</span></label>
                                        <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="form-label">End Date <span class="required">*</span></label>
                                        <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="form-label">Points Reward <span class="required">*</span></label>
                                        <asp:TextBox ID="txtPointsReward" runat="server" CssClass="form-control" TextMode="Number" placeholder="50"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-end gap-2 mt-4 pt-4 border-top">
                                    <asp:Button ID="btnClearForm" runat="server"
                                        Text="Clear Form"
                                        CssClass="btn-outline-aidify"
                                        CausesValidation="false"
                                        OnClick="btnClearForm_Click" />

                                    <asp:Button ID="btnSaveChallenge" runat="server"
                                        Text="Save Challenge"
                                        CssClass="btn-aidify"
                                        OnClick="btnSaveChallenge_Click" />
                                </div>
                            </div>

                            <div class="table-card">
                                <div class="table-card-header">
                                    <div>
                                        <h2 class="mb-1"><i class="bi bi-list-check text-danger me-2"></i>Created Challenges</h2>
                                        <small class="text-muted">List of instructor-created learner challenges from database</small>
                                    </div>

                                    <span class="badge-draft">
                                        <asp:Label ID="lblChallengeCount" runat="server" Text="0 Records"></asp:Label>
                                    </span>
                                </div>

                                <div class="table-responsive">
                                    <table class="table challenge-table">
                                        <thead>
                                            <tr>
                                                <th>Challenge Title</th>
                                                <th>Description</th>
                                                <th>Start Date</th>
                                                <th>End Date</th>
                                                <th>Points</th>
                                                <th>Status</th>
                                                <th class="text-end">Actions</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <asp:Repeater ID="rptChallenges" runat="server" OnItemCommand="rptChallenges_ItemCommand">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td><strong><%# Eval("Title") %></strong></td>
                                                        <td><%# Eval("Description") %></td>
                                                        <td><%# FormatDate(Eval("StartDate")) %></td>
                                                        <td><%# FormatDate(Eval("EndDate")) %></td>
                                                        <td><%# Eval("PointsReward") %></td>
                                                        <td>
                                                            <span class="<%# GetStatusCss(Eval("Status")) %>">
                                                                <%# Eval("Status") %>
                                                            </span>
                                                        </td>
                                                        <td class="text-end">
                                                            <asp:LinkButton ID="btnView" runat="server"
                                                                CssClass="action-btn"
                                                                CommandName="ViewChallenge"
                                                                CommandArgument='<%# Eval("ChallengeId") %>'
                                                                CausesValidation="false">
                                                                <i class="bi bi-eye"></i> View
                                                            </asp:LinkButton>

                                                            <asp:LinkButton ID="btnEdit" runat="server"
                                                                CssClass="action-btn"
                                                                CommandName="EditChallenge"
                                                                CommandArgument='<%# Eval("ChallengeId") %>'
                                                                CausesValidation="false">
                                                                <i class="bi bi-pencil"></i> Edit
                                                            </asp:LinkButton>

                                                            <asp:LinkButton ID="btnPublish" runat="server"
                                                                CssClass="action-btn"
                                                                CommandName="PublishChallenge"
                                                                CommandArgument='<%# Eval("ChallengeId") %>'
                                                                Visible='<%# Convert.ToString(Eval("Status")) == "Draft" %>'
                                                                CausesValidation="false">
                                                                <i class="bi bi-send"></i> Publish
                                                            </asp:LinkButton>

                                                            <asp:LinkButton ID="btnDelete" runat="server"
                                                                CssClass="action-btn danger"
                                                                CommandName="DeleteChallenge"
                                                                CommandArgument='<%# Eval("ChallengeId") %>'
                                                                CausesValidation="false"
                                                                OnClientClick="return confirm('Delete this challenge?');">
                                                                <i class="bi bi-trash"></i> Delete
                                                            </asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                    </table>

                                    <asp:Panel ID="pnlEmptyState" runat="server" CssClass="empty-state" Visible="false">
                                        <i class="bi bi-trophy fs-1 text-danger"></i>
                                        <h4 class="mt-3">No challenges found.</h4>
                                        <p>Create a new challenge to display it here.</p>
                                    </asp:Panel>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="side-card mb-4">
                                <h3><i class="bi bi-lightbulb text-danger me-2"></i>Challenge Tips</h3>
                                <div class="tip-box">Keep challenge goals clear.</div>
                                <div class="tip-box">Use realistic first aid scenarios.</div>
                                <div class="tip-box">Assign fair reward points.</div>
                                <div class="tip-box mb-0">Review challenge dates before publishing.</div>
                            </div>

                            <div class="side-card mb-4">
                                <h3><i class="bi bi-diagram-3 text-danger me-2"></i>Challenge Status Timeline</h3>

                                <div class="timeline">
                                    <div class="timeline-step active">
                                        <div class="timeline-dot"></div>
                                        <div class="timeline-title">Draft</div>
                                        <div class="timeline-text">Challenge is being prepared.</div>
                                    </div>

                                    <div class="timeline-step">
                                        <div class="timeline-dot"></div>
                                        <div class="timeline-title">Published</div>
                                        <div class="timeline-text">Visible to learners.</div>
                                    </div>

                                    <div class="timeline-step">
                                        <div class="timeline-dot"></div>
                                        <div class="timeline-title">Completed</div>
                                        <div class="timeline-text">Points awarded and archived.</div>
                                    </div>
                                </div>
                            </div>

                            <div class="side-card p-0 overflow-hidden">
                                <img class="challenge-img"
                                     alt="Medical training challenge"
                                     src="https://images.unsplash.com/photo-1581093588401-fbb62a02f120?auto=format&fit=crop&w=900&q=80"
                                     onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&w=900&q=80';" />

                                <div class="p-4">
                                    <h4 class="fw-bold mb-1">Interactive Learning</h4>
                                    <p class="small text-muted mb-0">
                                        Challenges help learners practice emergency response decisions through structured tasks.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>