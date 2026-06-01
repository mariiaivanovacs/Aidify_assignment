<%@ Page Title="Quiz Questions" Language="C#" AutoEventWireup="true" CodeBehind="Questions.aspx.cs" Inherits="Aidify_assigment.Instructor.Quizzes.Questions" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Aidify - Quiz Questions</title>
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
        .main { padding:42px 48px; }
        .back-link { color:#b70011; text-decoration:none; font-weight:800; display:inline-flex; align-items:center; gap:6px; margin-bottom:22px; }
        .page-header { display:flex; justify-content:space-between; align-items:end; margin-bottom:28px; gap:20px; }
        .page-header h1 { font-size:36px; font-weight:800; margin-bottom:6px; }
        .page-header p { color:#545f72; margin:0; }
        .form-card,.table-card,.side-card { background:white; border:1px solid #e6bdb8; border-radius:16px; padding:24px; }
        .form-card h2,.side-card h3 { font-size:22px; font-weight:800; margin-bottom:20px; }
        .form-label { font-weight:800; color:#121c2c; }
        .required { color:#b70011; }
        .form-control,.form-select { border:1px solid #e6bdb8; border-radius:10px; padding:11px 13px; }
        .btn-aidify { background:#b70011; color:white; border:1px solid #b70011; font-weight:700; border-radius:8px; padding:10px 16px; text-decoration:none; display:inline-flex; align-items:center; justify-content:center; gap:8px; }
        .btn-outline-aidify { background:white; color:#5c403c; border:1px solid #e6bdb8; font-weight:700; border-radius:8px; padding:10px 16px; text-decoration:none; display:inline-flex; align-items:center; justify-content:center; gap:8px; }
        .message-box { border-radius:10px; padding:12px 14px; margin-bottom:16px; font-weight:700; }
        .message-success { background:#d8f3e7; color:#198754; border:1px solid #9bd9b8; }
        .message-error { background:#ffe1e4; color:#b70011; border:1px solid #ffb4ab; }
        .question-card { border:1px solid #e6bdb8; border-radius:14px; padding:18px; margin-bottom:14px; background:#fff; }
        .option-line { margin-left:18px; color:#545f72; }
        .correct { color:#198754; font-weight:800; }
        .action-btn { border:1px solid #e6bdb8; background:white; color:#5c403c; border-radius:8px; padding:7px 10px; font-size:13px; text-decoration:none; display:inline-flex; align-items:center; gap:5px; margin:2px; font-weight:700; }
        .action-btn.danger { color:#b70011; }
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

    <main class="main">
        <a href="List.aspx" class="back-link"><i class="bi bi-arrow-left"></i> Back to Quizzes</a>

        <div class="page-header">
            <div>
                <h1>Quiz Questions</h1>
                <p>
                    Quiz:
                    <strong><asp:Label ID="lblQuizTitle" runat="server" Text="-"></asp:Label></strong>
                </p>
            </div>
            <a href="List.aspx" class="btn-outline-aidify">Finish</a>
        </div>

        <asp:Label ID="lblQuestionStatus" runat="server" Visible="false"></asp:Label>
        <asp:HiddenField ID="hfQuizId" runat="server" />

        <div class="row g-4">
            <div class="col-lg-7">
                <div class="form-card mb-4">
                    <h2><i class="bi bi-plus-circle text-danger me-2"></i>Add Question</h2>

                    <div class="mb-3">
                        <label class="form-label">Question Text <span class="required">*</span></label>
                        <asp:TextBox ID="txtQuestionText" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Write the question here."></asp:TextBox>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Question Type</label>
                            <asp:DropDownList ID="ddlQuestionType" runat="server" CssClass="form-select">
                                <asp:ListItem Text="MCQ" Value="MCQ"></asp:ListItem>
                                <asp:ListItem Text="True / False" Value="TrueFalse"></asp:ListItem>
                                <asp:ListItem Text="Short Answer" Value="ShortAnswer"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Points</label>
                            <asp:TextBox ID="txtPoints" runat="server" CssClass="form-control" TextMode="Number" Text="1"></asp:TextBox>
                        </div>
                    </div>

                    <hr />

                    <label class="form-label">Answers <span class="required">*</span></label>

                    <div class="input-group mb-2">
                        <span class="input-group-text">
                            <asp:RadioButton ID="rbCorrect1" runat="server" GroupName="CorrectOption" Checked="true" />
                        </span>
                        <asp:TextBox ID="txtOption1" runat="server" CssClass="form-control" placeholder="Option 1"></asp:TextBox>
                    </div>

                    <div class="input-group mb-2">
                        <span class="input-group-text">
                            <asp:RadioButton ID="rbCorrect2" runat="server" GroupName="CorrectOption" />
                        </span>
                        <asp:TextBox ID="txtOption2" runat="server" CssClass="form-control" placeholder="Option 2"></asp:TextBox>
                    </div>

                    <div class="input-group mb-2">
                        <span class="input-group-text">
                            <asp:RadioButton ID="rbCorrect3" runat="server" GroupName="CorrectOption" />
                        </span>
                        <asp:TextBox ID="txtOption3" runat="server" CssClass="form-control" placeholder="Option 3"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                        <span class="input-group-text">
                            <asp:RadioButton ID="rbCorrect4" runat="server" GroupName="CorrectOption" />
                        </span>
                        <asp:TextBox ID="txtOption4" runat="server" CssClass="form-control" placeholder="Option 4"></asp:TextBox>
                    </div>

                    <div class="d-flex justify-content-end gap-2">
                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn-outline-aidify" CausesValidation="false" OnClick="btnClear_Click" />
                        <asp:Button ID="btnAddQuestion" runat="server" Text="Add Question" CssClass="btn-aidify" OnClick="btnAddQuestion_Click" />
                    </div>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="side-card">
                    <h3><i class="bi bi-list-check text-danger me-2"></i>Questions</h3>

                    <asp:Repeater ID="rptQuestions" runat="server" OnItemCommand="rptQuestions_ItemCommand">
                        <ItemTemplate>
                            <div class="question-card">
                                <div class="d-flex justify-content-between align-items-start gap-2">
                                    <div>
                                        <strong><%# Eval("QuestionText") %></strong><br />
                                        <small class="text-muted">Type: <%# Eval("QuestionType") %> | Points: <%# Eval("Points") %></small>
                                    </div>
                                    <asp:LinkButton ID="btnDeleteQuestion" runat="server"
                                        CssClass="action-btn danger"
                                        CommandName="DeleteQuestion"
                                        CommandArgument='<%# Eval("QuestionId") %>'
                                        CausesValidation="false"
                                        OnClientClick="return confirm('Delete this question?');">
                                        <i class="bi bi-trash"></i>
                                    </asp:LinkButton>
                                </div>

                                <asp:Repeater ID="rptOptions" runat="server" DataSource='<%# GetOptions(Eval("QuestionId")) %>'>
                                    <ItemTemplate>
                                        <div class="option-line <%# Convert.ToBoolean(Eval("IsCorrect")) ? "correct" : "" %>">
                                            <%# Convert.ToBoolean(Eval("IsCorrect")) ? "✓ " : "• " %><%# Eval("OptionText") %>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <asp:Panel ID="pnlEmptyState" runat="server" Visible="false" CssClass="text-muted">
                        No questions added yet.
                    </asp:Panel>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</form>
</body>
</html>
