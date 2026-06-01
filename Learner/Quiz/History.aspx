<%@ Page Title="Quiz / History" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="History.aspx.cs" Inherits="Aidify_assigment.Learner.Quiz.History" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="container-fluid px-4 py-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="fw-bold mb-0">Quiz History</h4>
        <a runat="server" href="~/Learner/Courses/Catalogue.aspx" class="btn btn-outline-secondary btn-sm">
            ← Back to Courses
        </a>
    </div>

    <asp:Label ID="lblNoAttempts" runat="server"
        Text="You haven't taken any quizzes yet."
        CssClass="text-muted fst-italic"
        Visible="false" />

    <asp:Repeater ID="rptAttempts" runat="server">
        <ItemTemplate>
            <div class="card shadow-sm mb-3" style="border-radius:10px;">
                <div class="card-body p-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="fw-bold mb-1"><%# Eval("Title") %></h6>
                        <small class="text-muted">
                            <%# Convert.ToDateTime(Eval("SubmittedAt")).ToString("dd MMM yyyy") %>
                        </small>
                    </div>
                    <div class="d-flex align-items-center gap-3">
                        <div class="text-center">
                            <div class="fw-bold fs-5"><%# Eval("Score") %>%</div>
                            <span class='badge <%# Convert.ToBoolean(Eval("Passed")) ? "bg-success" : "bg-danger" %>'>
                                <%# Convert.ToBoolean(Eval("Passed")) ? "Pass" : "Fail" %>
                            </span>
                        </div>
                        <a href='<%# ResolveUrl("~/Learner/Quiz/Results.aspx?attemptId=" + Eval("AttemptId")) %>'
                           class="btn btn-outline-primary btn-sm">
                            View Results
                        </a>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>

</div>
</asp:Content>