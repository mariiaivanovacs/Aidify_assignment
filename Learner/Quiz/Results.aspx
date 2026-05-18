<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Results.aspx.cs" Inherits="LearnerDash.Learner.Quiz.Results" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container-fluid px-4 py-4">
    <div class="row justify-content-center">
        <div class="col-md-8">

            <%-- Result Header Card --%>
            <div class="card shadow-sm mb-4 text-center" style="border-radius:12px;">
                <div class="card-body py-5">
                    <h3 class="fw-bold mb-1">
                        <asp:Label ID="lblQuizTitle" runat="server" />
                    </h3>

                    <%-- Score Circle --%>
                    <div class="my-4">
                        <div style="width:120px; height:120px; border-radius:50%; margin:0 auto;
                                    display:flex; align-items:center; justify-content:center;
                                    font-size:2rem; font-weight:800; border: 6px solid #0d6efd;
                                    color:#0d6efd;">
                            <asp:Label ID="lblScore" runat="server" Text="0%" />
                        </div>
                    </div>

                    <%-- Verdict --%>
                    <asp:Label ID="lblVerdict" runat="server"
                        CssClass="badge px-4 py-2 fs-5 mb-2" />
                    <div class="text-muted mt-2">
                        <asp:Label ID="lblPassingPct" runat="server" />
                    </div>
                </div>
            </div>

            <%-- Passed Panel --%>
            <asp:Panel ID="pnlPassed" runat="server" Visible="false"
                CssClass="alert alert-success d-flex justify-content-between align-items-center mb-4"
                style="border-radius:10px;">
                <span>🎉 Congratulations! You passed!</span>
                <asp:HyperLink ID="lnkDownloadCert" runat="server"
                    Text="Download Certificate"
                    CssClass="btn btn-success btn-sm" />
            </asp:Panel>

            <%-- Failed Panel --%>
            <asp:Panel ID="pnlFailed" runat="server" Visible="false"
                CssClass="alert alert-danger d-flex justify-content-between align-items-center mb-4"
                style="border-radius:10px;">
                <span>😔 You didn't pass this time. Keep trying!</span>
                <asp:HyperLink ID="lnkRetakeQuiz" runat="server"
                    Text="Retake Quiz"
                    CssClass="btn btn-danger btn-sm" />
            </asp:Panel>

            <%-- Feedback Per Question --%>
            <h5 class="fw-semibold mb-3">Question Breakdown</h5>
            <asp:Repeater ID="rptFeedback" runat="server">
                <ItemTemplate>
                    <div class="card mb-3 shadow-sm" style="border-radius:10px;">
                        <div class="card-body p-4">
                            <p class="fw-semibold mb-2">
                                Q<%# Container.ItemIndex + 1 %>. <%# Eval("QuestionText") %>
                            </p>
                            <div class="mb-1">
                                <small class="text-muted">Your answer: </small>
                                <span class='<%# Convert.ToBoolean(Eval("IsCorrect")) ? "text-success fw-semibold" : "text-danger fw-semibold" %>'>
                                    <%# Eval("YourAnswer") %>
                                </span>
                            </div>
                            <div class="mb-1">
                                <small class="text-muted">Correct answer: </small>
                                <span class="text-success fw-semibold"><%# Eval("CorrectAnswer") %></span>
                            </div>
                            <div class="mt-2 text-muted small fst-italic">
                                <%# Eval("Explanation") %>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <%-- Bottom Navigation --%>
            <div class="d-flex gap-3 mt-4 mb-5">
                <asp:HyperLink ID="lnkBackToLesson" runat="server"
                    Text="← Back to Lesson"
                    CssClass="btn btn-outline-secondary" />
            </div>

        </div>
    </div>
</div>

</asp:Content>
