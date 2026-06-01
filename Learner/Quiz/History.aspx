<%@ Page Title="Quiz History" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="History.aspx.cs" Inherits="Aidify_assigment.Learner.Quiz.History" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .history-card      { background: #fff; border: 1px solid #f0d8d8; border-radius: 12px; padding: 18px 24px; margin-bottom: 12px; display: flex; justify-content: space-between; align-items: center; gap: 16px; }
    .history-card:hover { background: #FDF2F2; }
    .history-card h6   { font-weight: 700; margin-bottom: 3px; font-size: 15px; }
    .history-card .date { font-size: 12px; color: #888; }
    .score-wrap        { text-align: center; min-width: 60px; }
    .score-wrap .score { font-size: 20px; font-weight: 800; color: #C0392B; }
    .pass-badge        { background: #d8f3e7; color: #198754; padding: 3px 10px; border-radius: 20px; font-size: 11px; font-weight: 700; }
    .fail-badge        { background: #ffe1e4; color: #C0392B; padding: 3px 10px; border-radius: 20px; font-size: 11px; font-weight: 700; }
</style>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-1">Quiz History</h3>
        <p class="text-muted" style="font-size:13px;">Review all your past quiz attempts.</p>
    </div>
    <a runat="server" href="~/Learner/Courses/Catalogue.aspx"
       class="btn btn-outline-danger btn-sm">← Back to Courses</a>
</div>

<asp:Label ID="lblNoAttempts" runat="server"
    Text="You haven't taken any quizzes yet."
    CssClass="text-muted fst-italic"
    Visible="false" />

<asp:Repeater ID="rptAttempts" runat="server">
    <ItemTemplate>
        <div class="history-card">
            <div>
                <h6><%# Eval("Title") %></h6>
                <div class="date"><%# Convert.ToDateTime(Eval("SubmittedAt")).ToString("dd MMM yyyy") %></div>
            </div>
            <div class="d-flex align-items-center gap-3">
                <div class="score-wrap">
                    <div class="score"><%# Eval("Score") %>%</div>
                    <%# Convert.ToBoolean(Eval("Passed"))
                        ? "<span class='pass-badge'>Pass</span>"
                        : "<span class='fail-badge'>Fail</span>" %>
                </div>
                <a href='<%# ResolveUrl("~/Learner/Quiz/Results.aspx?attemptId=" + Eval("AttemptId")) %>'
                   class="btn btn-outline-danger btn-sm">View Results</a>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>

</asp:Content>
