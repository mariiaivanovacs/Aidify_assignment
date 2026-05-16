<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Take.aspx.cs" Inherits="LearnerDash.Learner.Quiz.Take" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container-fluid px-4 py-4">

    <div class="row justify-content-center">
        <div class="col-md-8">

            <%-- Quiz Header --%>
            <div class="card shadow-sm mb-4" style="border-radius:12px; background: linear-gradient(135deg, #1a1a2e, #16213e);">
                <div class="card-body py-4 px-4 text-white">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <h3 class="fw-bold mb-1">
                                <asp:Label ID="lblQuizTitle" runat="server" />
                            </h3>
                            <p class="text-white-50 mb-0">
                                <asp:Label ID="lblQuizDescription" runat="server" />
                            </p>
                        </div>
                        <div class="text-end">
                            <div class="badge bg-warning text-dark px-3 py-2 fs-6">
                                ⏱ <asp:Label ID="lblTimeRemaining" runat="server" Text="10:00" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Hidden Fields --%>
            <asp:HiddenField ID="hfTimeLimitSec" runat="server" Value="600" />
            <asp:HiddenField ID="hfQuizId" runat="server" />

            <%-- Error Message --%>
            <asp:Label ID="lblQuizError" runat="server"
                CssClass="alert alert-danger d-block mb-3"
                Visible="false" />

            <%-- Questions --%>
            <asp:Repeater ID="rptQuestions" runat="server">
                <ItemTemplate>
                    <div class="card shadow-sm mb-4" style="border-radius:12px;">
                        <div class="card-body p-4">

                            <%-- Question Number + Text --%>
                            <h6 class="fw-bold mb-3">
                                Q<%# Container.ItemIndex + 1 %>.
                                <asp:Label ID="lblQuestionText" runat="server"
                                    Text='<%# Eval("QuestionText") %>' />
                            </h6>

                            <%-- Options --%>
                            <div class="d-flex flex-column gap-2">
                                <asp:RadioButton ID="rbOption_0" runat="server"
                                    Text='<%# Eval("Option1") %>'
                                    GroupName='<%# "q" + Eval("QuestionId") %>'
                                    CssClass="form-check" />
                                <asp:RadioButton ID="rbOption_1" runat="server"
                                    Text='<%# Eval("Option2") %>'
                                    GroupName='<%# "q" + Eval("QuestionId") %>'
                                    CssClass="form-check" />
                                <asp:RadioButton ID="rbOption_2" runat="server"
                                    Text='<%# Eval("Option3") %>'
                                    GroupName='<%# "q" + Eval("QuestionId") %>'
                                    CssClass="form-check" />
                                <asp:RadioButton ID="rbOption_3" runat="server"
                                    Text='<%# Eval("Option4") %>'
                                    GroupName='<%# "q" + Eval("QuestionId") %>'
                                    CssClass="form-check" />
                            </div>

                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <%-- Submit Button --%>
            <div class="d-flex justify-content-end mt-2 mb-5">
                <asp:Button ID="btnSubmitQuiz" runat="server"
                    Text="Submit Quiz"
                    CssClass="btn btn-primary px-5 py-2 fw-semibold"
                    OnClick="btnSubmitQuiz_Click"
                    UseSubmitBehavior="false" />
            </div>

        </div>
    </div>
</div>

<%-- Timer Script --%>
<script>
    window.onload = function () {
        var seconds = parseInt(document.getElementById('<%= hfTimeLimitSec.ClientID %>').value);
        if (!seconds || seconds <= 0) return;

        var display = document.querySelector('[id$="lblTimeRemaining"]');
        var interval = setInterval(function () {
            seconds--;
            var m = Math.floor(seconds / 60);
            var s = seconds % 60;
            display.innerText = m + ":" + (s < 10 ? "0" : "") + s;
            if (seconds <= 0) {
                clearInterval(interval);
                document.querySelector('[id$="btnSubmitQuiz"]').click();
            }
        }, 1000);
    };
</script>

</asp:Content>
