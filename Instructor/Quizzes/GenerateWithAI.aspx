<%@ Page Title="AI Quiz Generation" Language="C#" AutoEventWireup="true" CodeBehind="GenerateWithAI.aspx.cs" Inherits="Aidify_assigment.Instructor.Quizzes.GenerateWithAI" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Aidify - AI Quiz Generation</title>
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

        .main {
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

        .form-card,
        .preview-card,
        .side-card {
            background: white;
            border: 1px solid #e6bdb8;
            border-radius: 16px;
            padding: 26px;
        }

        .form-card h2,
        .preview-card h2,
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

        .question-preview {
            border: 1px solid #e6bdb8;
            border-radius: 14px;
            padding: 18px;
            margin-bottom: 14px;
            background: #fff;
        }

        .option-line {
            margin-left: 18px;
            color: #545f72;
            margin-top: 5px;
        }

        .correct {
            color: #198754;
            font-weight: 800;
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

        @media (max-width: 992px) {
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
    <form id="form1" runat="server" enctype="multipart/form-data">
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

            <div class="fw-bold">Dr. Smith</div>
        </div>

        <main class="main">
            <a href="List.aspx" class="back-link">
                <i class="bi bi-arrow-left"></i> Back to Quizzes
            </a>

            <div class="page-header">
                <div>
                    <h1>AI Quiz Generation</h1>
                    <p>Generate quiz questions from a knowledge file and save them after review.</p>
                </div>

                <a href="List.aspx" class="btn-outline-aidify">
                    <i class="bi bi-list-check"></i> Quiz List
                </a>
            </div>

            <asp:Label ID="lblAIStatus" runat="server" Visible="false"></asp:Label>
            <asp:HiddenField ID="hfTaskId" runat="server" />

            <div class="row g-4">
                <div class="col-lg-7">
                    <div class="form-card mb-4">
                        <h2><i class="bi bi-stars text-danger me-2"></i>Generate Questions</h2>

                        <div class="mb-3">
                            <label class="form-label">Target Quiz <span class="required">*</span></label>
                            <asp:DropDownList ID="ddlQuiz" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Number of Questions <span class="required">*</span></label>
                                <asp:TextBox ID="txtQuestionCount" runat="server" CssClass="form-control" TextMode="Number" Text="5"></asp:TextBox>
                                <small class="text-muted">Allowed range: 1 to 20</small>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Difficulty <span class="required">*</span></label>
                                <asp:DropDownList ID="ddlDifficulty" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Beginner" Value="Beginner"></asp:ListItem>
                                    <asp:ListItem Text="Intermediate" Value="Intermediate" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Advanced" Value="Advanced"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Knowledge File <span class="required">*</span></label>
                            <asp:FileUpload ID="fuKnowledgeFile" runat="server" CssClass="form-control" />
                            <small class="text-muted">Allowed file types: .txt or .md. Content is capped at 30,000 characters.</small>
                        </div>

                        <div class="d-flex justify-content-end gap-2">
                            <asp:Button ID="btnClear" runat="server"
                                Text="Clear"
                                CssClass="btn-outline-aidify"
                                CausesValidation="false"
                                OnClick="btnClear_Click" />

                            <asp:Button ID="btnGenerate" runat="server"
                                Text="Generate AI Questions"
                                CssClass="btn-aidify"
                                OnClick="btnGenerate_Click" />
                        </div>
                    </div>

                    <asp:Panel ID="pnlPreview" runat="server" Visible="false" CssClass="preview-card">
                        <h2><i class="bi bi-eye text-danger me-2"></i>Generated Questions Preview</h2>

                        <asp:Repeater ID="rptGeneratedQuestions" runat="server">
                            <ItemTemplate>
                                <div class="question-preview">
                                    <strong>Q<%# Eval("Index") %>. <%# Eval("QuestionText") %></strong><br />
                                    <small class="text-muted">Type: <%# Eval("QuestionType") %> | Points: <%# Eval("Points") %></small>

                                    <asp:Repeater ID="rptPreviewOptions" runat="server" DataSource='<%# GetPreviewOptions(Eval("Index")) %>'>
                                        <ItemTemplate>
                                            <div class="option-line <%# Convert.ToBoolean(Eval("IsCorrect")) ? "correct" : "" %>">
                                                <%# Convert.ToBoolean(Eval("IsCorrect")) ? "✓ " : "• " %><%# Eval("OptionText") %>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <div class="d-flex justify-content-end gap-2 mt-3">
                            <asp:Button ID="btnDiscard" runat="server"
                                Text="Discard"
                                CssClass="btn-outline-aidify"
                                CausesValidation="false"
                                OnClick="btnDiscard_Click" />

                            <asp:Button ID="btnSaveGenerated" runat="server"
                                Text="Save Generated Questions"
                                CssClass="btn-aidify"
                                OnClick="btnSaveGenerated_Click" />
                        </div>
                    </asp:Panel>
                </div>

                <div class="col-lg-5">
                    <div class="side-card mb-4">
                        <h3><i class="bi bi-info-circle text-danger me-2"></i>How it works</h3>
                        <div class="tip-box">The AI reads your uploaded knowledge file.</div>
                        <div class="tip-box">Questions are generated as MCQ format.</div>
                        <div class="tip-box">Generation history is saved in AIGeneratedTasks.</div>
                        <div class="tip-box">Saved questions go into Questions and Options.</div>
                        <div class="tip-box mb-0">A summary is saved into AIInsights.</div>
                    </div>

                    <div class="side-card">
                        <h3><i class="bi bi-exclamation-triangle text-danger me-2"></i>Important</h3>
                        <p class="text-muted mb-0">
                            If Gemini fails or returns no candidates, the page will generate demo fallback questions so the workflow can still be tested.
                        </p>
                    </div>
                </div>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>