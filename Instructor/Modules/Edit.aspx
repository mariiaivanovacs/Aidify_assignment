<%@ Page Title="Create Module" Language="C#" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="Aidify_assigment.Instructor.Modules.Edit" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Aidify - Create Module</title>
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

        .upload-box {
            border: 2px dashed #e6bdb8;
            background: #fff8f7;
            border-radius: 16px;
            padding: 26px;
            text-align: center;
        }

        .upload-box i {
            font-size: 36px;
            color: #b70011;
        }

        .cover-preview {
            width: 100%;
            max-height: 220px;
            object-fit: cover;
            border-radius: 14px;
            border: 1px solid #e6bdb8;
            margin-top: 16px;
        }

        .status-pill {
            background: #eeeeee;
            color: #545f72;
            border: 1px solid #d7d7d7;
            padding: 7px 12px;
            border-radius: 16px;
            font-size: 13px;
            font-weight: 800;
            display: inline-flex;
            align-items: center;
            gap: 6px;
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

        .btn-secondary-aidify {
            background: #545f72;
            color: white;
            border: 1px solid #545f72;
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

        .check-item {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            padding: 10px 0;
        }

        .check-item input {
            width: 18px;
            height: 18px;
            accent-color: #b70011;
            margin-top: 3px;
        }

        .check-item span {
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

        .info-box {
            background: #ffdad6;
            color: #5c403c;
            border-radius: 14px;
            padding: 18px;
            display: flex;
            gap: 12px;
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
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="instructor-shell">

            <div class="topbar">
                <div class="brand">
                    Aidify
                    <span class="role-badge">Instructor</span>
                </div>

                <div class="top-links">
                    <a href="../Dashboard.aspx">Dashboard</a>
                    <a href="List.aspx" class="active">Modules</a>
                    <a href="../Lessons/List.aspx">Lessons</a>
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

                    <a href="List.aspx" class="side-link active">
                        <i class="bi bi-journal-bookmark"></i> Modules
                    </a>

                    <a href="../Lessons/List.aspx" class="side-link">
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
                        <p>Check the instructor guide for help with module creation.</p>
                        <button type="button">Read Guide</button>
                    </div>
                </aside>

                <main class="main">

                    <a href="List.aspx" class="back-link">
                        <i class="bi bi-arrow-left"></i> Back to My Modules
                    </a>

                    <div class="page-header">
                        <h1><asp:Label ID="lblPageTitle" runat="server" Text="Create Module"></asp:Label></h1>
                        <p>Build a structured first aid learning module for learners.</p>
                    </div>

                    <asp:Label ID="lblModuleStatus" runat="server" Visible="false"></asp:Label>

                    <asp:HiddenField ID="hfModuleId" runat="server" />
                    <asp:HiddenField ID="hfExistingCoverImage" runat="server" />

                    <div class="row g-4">
                        <div class="col-lg-8">
                            <div class="form-card mb-4">
                                <h2><i class="bi bi-pencil-square text-danger me-2"></i>Module Details</h2>

                                <div class="mb-3">
                                    <label class="form-label">Module Title <span class="required">*</span></label>
                                    <asp:TextBox ID="txtModuleTitle" runat="server" CssClass="form-control" placeholder="e.g., Advanced Life Support (ALS)"></asp:TextBox>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Description <span class="required">*</span></label>
                                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Describe the learning objectives, emergency topic, and expected outcomes."></asp:TextBox>
                                </div>

                                <div class="row g-3 mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Difficulty <span class="required">*</span></label>
                                        <asp:DropDownList ID="ddlDifficulty" runat="server" CssClass="form-select">
                                            <asp:ListItem Text="Select Difficulty" Value=""></asp:ListItem>
                                            <asp:ListItem Text="Beginner" Value="Beginner"></asp:ListItem>
                                            <asp:ListItem Text="Intermediate" Value="Intermediate"></asp:ListItem>
                                            <asp:ListItem Text="Advanced" Value="Advanced"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label">Preview Module</label>
                                        <div class="form-control d-flex align-items-center gap-2">
                                            <asp:CheckBox ID="chkIsPreview" runat="server" />
                                            <span>Allow this module to be previewed</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Cover Image</label>

                                    <div class="upload-box">
                                        <i class="bi bi-cloud-arrow-up"></i>
                                        <p class="fw-bold mb-1">Upload JPG or PNG cover image</p>
                                        <small class="text-muted">Recommended size: 1200x600px</small>
                                        <div class="mt-3">
                                            <asp:FileUpload ID="fuCover" runat="server" CssClass="form-control" />
                                        </div>
                                    </div>

                                    <asp:Image ID="imgCoverPreview" runat="server" CssClass="cover-preview" Visible="false" />
                                </div>

                                <div class="mb-3">
                                    <label class="form-label me-2">Current Status:</label>
                                    <span class="status-pill">
                                        <i class="bi bi-pencil-square"></i>
                                        <asp:Label ID="lblCurrentStatus" runat="server" Text="Draft"></asp:Label>
                                    </span>
                                    <div>
                                        <small class="text-muted">Published status is controlled by Admin approval.</small>
                                    </div>
                                </div>

                                <hr />

                                <div class="mb-3">
                                    <label class="form-label">Learning Objectives</label>

                                    <div class="input-group mb-2">
                                        <span class="input-group-text">1</span>
                                        <asp:TextBox ID="txtObjective1" runat="server" CssClass="form-control" placeholder="Understand first response steps for the selected emergency topic."></asp:TextBox>
                                    </div>

                                    <div class="input-group mb-2">
                                        <span class="input-group-text">2</span>
                                        <asp:TextBox ID="txtObjective2" runat="server" CssClass="form-control" placeholder="Identify correct safety and prevention actions."></asp:TextBox>
                                    </div>

                                    <div class="input-group">
                                        <span class="input-group-text">3</span>
                                        <asp:TextBox ID="txtObjective3" runat="server" CssClass="form-control" placeholder="Apply the response protocol through scenario-based learning."></asp:TextBox>
                                    </div>

                                    <small class="text-muted">These are kept in the page for UI completeness. Database storage can be added later if needed.</small>
                                </div>

                                <div class="mb-0">
                                    <label class="form-label">Tags</label>
                                    <asp:TextBox ID="txtTags" runat="server" CssClass="form-control" placeholder="CPR, trauma, wound care"></asp:TextBox>
                                    <small class="text-muted">Tags are currently UI-only unless the database gets a Tags table later.</small>
                                </div>
                            </div>

                            <div class="action-bar">
                                <a href="List.aspx" class="btn-outline-aidify">
                                    <i class="bi bi-x-circle"></i> Cancel
                                </a>

                                <asp:Button ID="btnSaveDraft" runat="server"
                                    Text="Save Draft"
                                    CssClass="btn-outline-aidify"
                                    OnClick="btnSaveDraft_Click" />

                                <asp:Button ID="btnSaveAndAddLesson" runat="server"
                                    Text="Save and Add Lesson"
                                    CssClass="btn-secondary-aidify"
                                    OnClick="btnSaveAndAddLesson_Click" />

                                <asp:Button ID="btnSubmitForReview" runat="server"
                                    Text="Submit for Review"
                                    CssClass="btn-aidify"
                                    OnClick="btnSubmitForReview_Click" />
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="side-card mb-4">
                                <h3>Instructor Checklist</h3>

                                <label class="check-item">
                                    <input type="checkbox" />
                                    <span>Use a clear module title</span>
                                </label>

                                <label class="check-item">
                                    <input type="checkbox" />
                                    <span>Add measurable learning objectives</span>
                                </label>

                                <label class="check-item">
                                    <input type="checkbox" />
                                    <span>Choose the correct difficulty</span>
                                </label>

                                <label class="check-item">
                                    <input type="checkbox" />
                                    <span>Upload a relevant cover image</span>
                                </label>

                                <label class="check-item">
                                    <input type="checkbox" />
                                    <span>Add lessons before submitting for review</span>
                                </label>

                                <div class="mt-3 p-3 rounded" style="background:#fff8f7; border:1px solid #e6bdb8;">
                                    <small class="text-muted">Make sure your content is educational and does not replace professional medical training.</small>
                                </div>
                            </div>

                            <div class="side-card mb-4">
                                <h3>Status Timeline</h3>

                                <div class="timeline">
                                    <div class="timeline-step active">
                                        <div class="timeline-dot"></div>
                                        <div class="timeline-title">Draft</div>
                                        <div class="timeline-text">Currently being edited. Not visible to learners.</div>
                                    </div>

                                    <div class="timeline-step">
                                        <div class="timeline-dot"></div>
                                        <div class="timeline-title">Pending Review</div>
                                        <div class="timeline-text">Submitted to Admin for content approval.</div>
                                    </div>

                                    <div class="timeline-step">
                                        <div class="timeline-dot"></div>
                                        <div class="timeline-title">Published</div>
                                        <div class="timeline-text">Visible to enrolled learners after approval.</div>
                                    </div>
                                </div>
                            </div>

                            <div class="info-box">
                                <i class="bi bi-info-circle fs-4"></i>
                                <div>
                                    <strong>Need Help?</strong>
                                    <p class="mb-0 small">Use clear emergency response language and add lessons before submitting.</p>
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