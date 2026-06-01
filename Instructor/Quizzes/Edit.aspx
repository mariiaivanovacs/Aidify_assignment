<%@ Page Title="Quiz Editor" Language="C#" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="Aidify_assigment.Instructor.Quizzes.Edit" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Aidify - Quiz Editor</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body { margin:0; background:#fff8f7; color:#121c2c; font-family:Arial,sans-serif; }
        .topbar { height:76px; background:#fff; border-bottom:1px solid #e6bdb8; display:flex; align-items:center; justify-content:space-between; padding:0 34px; position:sticky; top:0; z-index:50; }
        .brand { display:flex; align-items:center; gap:10px; font-size:26px; font-weight:800; color:#b70011; }
        .role-badge { background:#b70011; color:white; font-size:11px; padding:4px 10px; border-radius:20px; text-transform:uppercase; }
        .top-links { display:flex; gap:18px; align-items:center; flex-wrap:wrap; }
        .top-links a { color:#5c403c; text-decoration:none; font-size:14px; font-weight:600; }
        .top-links a.active { color:#b70011; border-bottom:2px solid #b70011; padding-bottom:8px; }
        .layout { display:flex; }
        .sidebar { width:260px; min-height:calc(100vh - 76px); background:#fff; border-right:1px solid #e6bdb8; padding:28px 18px; position:sticky; top:76px; }
        .sidebar-heading { font-size:12px; text-transform:uppercase; letter-spacing:1px; color:#916f6b; font-weight:800; margin:18px 12px 10px; }
        .side-link { display:flex; align-items:center; gap:12px; padding:13px 15px; border-radius:10px; color:#5c403c; text-decoration:none; font-weight:600; margin-bottom:6px; }
        .side-link:hover { background:#fff1ef; color:#b70011; }
        .side-link.active { background:#b70011; color:white; }
        .main { flex:1; padding:42px 48px; }
        .back-link { color:#b70011; text-decoration:none; font-weight:800; display:inline-flex; align-items:center; gap:6px; margin-bottom:22px; }
        .page-header { margin-bottom:28px; }
        .page-header h1 { font-size:36px; font-weight:800; margin-bottom:6px; }
        .page-header p { color:#545f72; margin:0; }
        .form-card,.side-card,.action-bar { background:white; border:1px solid #e6bdb8; border-radius:16px; padding:26px; }
        .form-card h2,.side-card h3 { font-size:22px; font-weight:800; margin-bottom:22px; }
        .form-label { font-weight:800; color:#121c2c; }
        .required { color:#b70011; }
        .form-control,.form-select { border:1px solid #e6bdb8; border-radius:10px; padding:11px 13px; }
        .btn-aidify { background:#b70011; color:white; border:1px solid #b70011; font-weight:700; border-radius:8px; padding:10px 16px; text-decoration:none; display:inline-flex; align-items:center; justify-content:center; gap:8px; }
        .btn-outline-aidify { background:white; color:#5c403c; border:1px solid #e6bdb8; font-weight:700; border-radius:8px; padding:10px 16px; text-decoration:none; display:inline-flex; align-items:center; justify-content:center; gap:8px; }
        .action-bar { display:flex; flex-wrap:wrap; justify-content:flex-end; gap:12px; padding:20px; }
        .tip-box { background:#fff8f7; border:1px solid #e6bdb8; border-radius:14px; padding:15px; margin-bottom:12px; color:#545f72; font-size:14px; }
        .message-box { border-radius:10px; padding:12px 14px; margin-bottom:16px; font-weight:700; }
        .message-success { background:#d8f3e7; color:#198754; border:1px solid #9bd9b8; }
        .message-error { background:#ffe1e4; color:#b70011; border:1px solid #ffb4ab; }
        @media(max-width:992px){ .sidebar,.top-links{display:none;} .main{padding:28px 20px;} }
    </style>
</head>

<body>
<form id="form1" runat="server">
    <div class="topbar">
        <div class="brand">Aidify <span class="role-badge">Instructor</span></div>
        <div class="top-links">
            <a href="../Dashboard.aspx">Dashboard</a>
            <a href="../Modules/List.aspx">Modules</a>
            <a href="../Lessons/List.aspx">Lessons</a>
            <a href="../Materials/Upload.aspx">Materials</a>
            <a href="List.aspx" class="active">Quizzes</a>
            <a href="../Performance.aspx">Performance</a>
            <a href="../Challenges.aspx">Challenges</a>
            <a href="../Events.aspx">Events</a>
        </div>
        <div class="fw-bold">Dr. Smith</div>
    </div>

    <div class="layout">
        <aside class="sidebar">
            <div class="sidebar-heading">Main Menu</div>
            <a href="../Dashboard.aspx" class="side-link"><i class="bi bi-grid"></i> Dashboard</a>
            <a href="../Modules/List.aspx" class="side-link"><i class="bi bi-journal-bookmark"></i> Modules</a>
            <a href="../Lessons/List.aspx" class="side-link"><i class="bi bi-book"></i> Lessons</a>
            <a href="../Materials/Upload.aspx" class="side-link"><i class="bi bi-folder2-open"></i> Materials</a>
            <a href="List.aspx" class="side-link active"><i class="bi bi-ui-checks"></i> Quizzes</a>
        </aside>

        <main class="main">
            <a href="List.aspx" class="back-link"><i class="bi bi-arrow-left"></i> Back to Quizzes</a>

            <div class="page-header">
                <h1><asp:Label ID="lblPageTitle" runat="server" Text="Create Quiz"></asp:Label></h1>
                <p>Create assessment details and then add questions.</p>
            </div>

            <asp:Label ID="lblQuizStatus" runat="server" Visible="false"></asp:Label>
            <asp:HiddenField ID="hfQuizId" runat="server" />

            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="form-card mb-4">
                        <h2><i class="bi bi-pencil-square text-danger me-2"></i>Quiz Details</h2>

                        <div class="mb-3">
                            <label class="form-label">Module <span class="required">*</span></label>
                            <asp:DropDownList ID="ddlModule" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Quiz Title <span class="required">*</span></label>
                            <asp:TextBox ID="txtQuizTitle" runat="server" CssClass="form-control" placeholder="e.g., CPR Knowledge Check"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Describe the quiz purpose."></asp:TextBox>
                        </div>

                        <div class="row g-3">
                            <div class="col-md-4">
                                <label class="form-label">Time Limit Minutes <span class="required">*</span></label>
                                <asp:TextBox ID="txtTimeLimitMinutes" runat="server" CssClass="form-control" TextMode="Number" placeholder="20"></asp:TextBox>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">Passing Score % <span class="required">*</span></label>
                                <asp:TextBox ID="txtPassingPct" runat="server" CssClass="form-control" TextMode="Number" placeholder="80"></asp:TextBox>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">Preview</label>
                                <div class="form-control d-flex align-items-center gap-2">
                                    <asp:CheckBox ID="chkIsPreview" runat="server" />
                                    <span>Allow preview</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="action-bar">
                        <a href="List.aspx" class="btn-outline-aidify"><i class="bi bi-x-circle"></i> Cancel</a>

                        <asp:Button ID="btnSaveQuiz" runat="server"
                            Text="Save Quiz"
                            CssClass="btn-outline-aidify"
                            OnClick="btnSaveQuiz_Click" />

                        <asp:Button ID="btnSaveAndAddQuestions" runat="server"
                            Text="Save and Add Questions"
                            CssClass="btn-aidify"
                            OnClick="btnSaveAndAddQuestions_Click" />
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="side-card">
                        <h3><i class="bi bi-lightbulb text-danger me-2"></i>Quiz Tips</h3>
                        <div class="tip-box">Link each quiz to the correct module.</div>
                        <div class="tip-box">Use clear question wording.</div>
                        <div class="tip-box">Set a realistic passing score.</div>
                        <div class="tip-box mb-0">Add questions after saving the quiz.</div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</form>
</body>
</html>