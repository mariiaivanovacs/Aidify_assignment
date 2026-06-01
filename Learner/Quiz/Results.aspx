<%@ Page Title="Quiz Result" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Results.aspx.cs" Inherits="Aidify_assigment.Learner.Quiz.Results" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .result-header     { background: #fff; border: 1px solid #f0d8d8; border-radius: 14px; padding: 40px 24px; text-align: center; margin-bottom: 20px; }
    .score-circle      { width: 120px; height: 120px; border-radius: 50%; border: 6px solid #C0392B; display: flex; align-items: center; justify-content: center; font-size: 2rem; font-weight: 800; color: #C0392B; margin: 20px auto; }
    .verdict-badge     { display: inline-block; padding: 8px 24px; border-radius: 20px; font-size: 16px; font-weight: 800; margin-bottom: 8px; }
    .verdict-passed    { background: #d8f3e7; color: #198754; }
    .verdict-failed    { background: #ffe1e4; color: #C0392B; }
    .result-panel      { border-radius: 12px; padding: 16px 20px; margin-bottom: 16px; display: flex; justify-content: space-between; align-items: center; }
    .panel-passed      { background: #d8f3e7; border: 1px solid #a3d9b8; color: #198754; }
    .panel-failed      { background: #ffe1e4; border: 1px solid #f3a6ad; color: #C0392B; }
    .feedback-card     { background: #fff; border: 1px solid #f0d8d8; border-radius: 10px; padding: 20px; margin-bottom: 14px; }
    .answer-correct    { color: #198754; font-weight: 600; }
    .answer-wrong      { color: #C0392B; font-weight: 600; }
</style>

<div class="row justify-content-center">
    <div class="col-md-8">

        <div class="result-header">
            <h3 class="fw-bold mb-1">
                <asp:Label ID="lblQuizTitle" runat="server" />
            </h3>
            <div class="score-circle">
                <asp:Label ID="lblScore" runat="server" Text="0%" />
            </div>
            <asp:Label ID="lblVerdict" runat="server" CssClass="verdict-badge" />
            <div class="text-muted mt-2" style="font-size:13px;">
                <asp:Label ID="lblPassingPct" runat="server" />
            </div>
        </div>

        <asp:Panel ID="pnlPassed" runat="server" Visible="false" CssClass="result-panel panel-passed">
            <span class="fw-semibold">🎉 Congratulations! You passed!</span>
            <asp:HyperLink ID="lnkDownloadCert" runat="server"
                Text="Download Certificate"
                CssClass="btn btn-success btn-sm" />
        </asp:Panel>

        <asp:Panel ID="pnlFailed" runat="server" Visible="false" CssClass="result-panel panel-failed">
            <span class="fw-semibold">😔 You didn't pass this time. Keep trying!</span>
            <asp:HyperLink ID="lnkRetakeQuiz" runat="server"
                Text="Retake Quiz"
                CssClass="btn btn-danger btn-sm" />
        </asp:Panel>

        <h5 class="fw-bold mb-3 mt-2">Question Breakdown</h5>
        <asp:Repeater ID="rptFeedback" runat="server">
            <ItemTemplate>
                <div class="feedback-card">
                    <p class="fw-semibold mb-2">
                        Q<%# Container.ItemIndex + 1 %>. <%# Eval("QuestionText") %>
                    </p>
                    <div class="mb-1">
                        <small class="text-muted">Your answer: </small>
                        <span class='<%# Convert.ToBoolean(Eval("IsCorrect")) ? "answer-correct" : "answer-wrong" %>'>
                            <%# Eval("YourAnswer") %>
                        </span>
                    </div>
                    <div class="mb-1">
                        <small class="text-muted">Correct answer: </small>
                        <span class="answer-correct"><%# Eval("CorrectAnswer") %></span>
                    </div>
                    <div class="mt-2 text-muted small fst-italic">
                        <%# Eval("Explanation") %>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <div class="d-flex gap-3 mt-4 mb-5">
            <asp:HyperLink ID="lnkBackToLesson" runat="server"
                Text="← Back to Lesson"
                CssClass="btn btn-outline-danger" />
        </div>

    </div>
</div>

</asp:Content>
