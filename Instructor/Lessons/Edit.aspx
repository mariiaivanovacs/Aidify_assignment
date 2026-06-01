<%@ Page Title="Lesson Editor" Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="Edit.aspx.cs" Inherits="Aidify_assigment.Instructor.Lessons.Edit" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Aidify - Lesson Editor</title>
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

        .back-link {
            color: #b70011;
            text-decoration: none;
            font-weight: 800;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            margin-bottom: 22px;
        }

        .back-link:hover {
            color: #8b000a;
            text-decoration: underline;
        }

        .page-header {
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

        .form-card,
        .side-card {
            background: white;
            border: 1px solid #e6bdb8;
            border-radius: 16px;
            padding: 26px;
        }

        .form-card h2,
        .side-card h3 {
            font-size: 22px;
            font-weight: 800;
            margin-bottom: 22px;
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

        .form-control:focus,
        .form-select:focus {
            border-color: #b70011;
            box-shadow: 0 0 0 0.18rem rgba(183, 0, 17, 0.12);
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

        .action-bar {
            background: white;
            border: 1px solid #e6bdb8;
            border-radius: 16px;
            padding: 20px;
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-end;
            gap: 12px;
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
                        <p>Create lessons connected to a module.</p>
                        <button type="button">Read Guide</button>
                    </div>
                </aside>

                <main class="main">

                    <a href="List.aspx" class="back-link">
                        <i class="bi bi-arrow-left"></i> Back to Lessons
                    </a>

                    <div class="page-header">
                        <h1><asp:Label ID="lblPageTitle" runat="server" Text="Create Lesson"></asp:Label></h1>
                        <p>Add structured lesson content to an existing first aid module.</p>
                    </div>

                    <asp:Label ID="lblLessonStatus" runat="server" Visible="false"></asp:Label>

                    <asp:HiddenField ID="hfLessonId" runat="server" />

                    <div class="row g-4">
                        <div class="col-lg-8">
                            <div class="form-card mb-4">
                                <h2><i class="bi bi-pencil-square text-danger me-2"></i>Lesson Details</h2>

                                <div class="mb-3">
                                    <label class="form-label">Module <span class="required">*</span></label>
                                    <asp:DropDownList ID="ddlModule" runat="server" CssClass="form-select"></asp:DropDownList>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Lesson Title <span class="required">*</span></label>
                                    <asp:TextBox ID="txtLessonTitle" runat="server" CssClass="form-control" placeholder="e.g., Introduction to CPR"></asp:TextBox>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Lesson Content <span class="required">*</span></label>
                                    <asp:TextBox ID="txtBodyHtml" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="8" placeholder="Write the lesson explanation, steps, and learning content here. HTML is allowed."></asp:TextBox>
                                </div>

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Sequence Order <span class="required">*</span></label>
                                        <asp:TextBox ID="txtSequenceOrder" runat="server" CssClass="form-control" TextMode="Number" placeholder="1"></asp:TextBox>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">Estimated Minutes</label>
                                        <asp:TextBox ID="txtEstimatedMinutes" runat="server" CssClass="form-control" TextMode="Number" placeholder="15"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="action-bar">
                                <a href="List.aspx" class="btn-outline-aidify">
                                    <i class="bi bi-x-circle"></i> Cancel
                                </a>

                                <asp:Button ID="btnSaveLesson" runat="server"
                                    Text="Save Lesson"
                                    CssClass="btn-aidify"
                                    OnClick="btnSaveLesson_Click" />

                                <asp:Button ID="btnSaveAndNew" runat="server"
                                    Text="Save and Add Another"
                                    CssClass="btn-outline-aidify"
                                    OnClick="btnSaveAndNew_Click" />
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="side-card mb-4">
                                <h3><i class="bi bi-lightbulb text-danger me-2"></i>Lesson Tips</h3>
                                <div class="tip-box">Use clear emergency response steps.</div>
                                <div class="tip-box">Keep each lesson focused on one topic.</div>
                                <div class="tip-box">Set sequence order correctly.</div>
                                <div class="tip-box mb-0">Estimate realistic completion time.</div>
                            </div>

                            <div class="side-card">
                                <h3><i class="bi bi-info-circle text-danger me-2"></i>Database Mapping</h3>
                                <p class="small text-muted mb-0">
                                    This page saves lesson data into dbo.Lessons using ModuleId, Title, BodyHtml, SequenceOrder, and EstimatedMinutes.
                                </p>
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