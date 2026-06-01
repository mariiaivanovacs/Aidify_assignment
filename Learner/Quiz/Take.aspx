<%@ Page Title="Take Quiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Take.aspx.cs" Inherits="Aidify_assigment.Learner.Quiz.Take" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .quiz-header    { background: linear-gradient(135deg, #C0392B, #96281B); border-radius: 14px; padding: 28px 32px; color: #fff; margin-bottom: 24px; display: flex; justify-content: space-between; align-items: center; }
    .quiz-header h3 { font-weight: 800; margin: 0 0 4px; }
    .quiz-header p  { opacity: 0.8; margin: 0; font-size: 14px; }
    .timer-badge    { background: #fff; color: #C0392B; font-weight: 800; font-size: 16px; padding: 8px 18px; border-radius: 20px; white-space: nowrap; }
    .question-card  { background: #fff; border: 1px solid #f0d8d8; border-radius: 12px; padding: 24px; margin-bottom: 18px; }
    .question-card h6 { font-weight: 700; margin-bottom: 16px; }
    .form-check     { padding: 10px 14px; border-radius: 8px; border: 1px solid #f0d8d8; margin-bottom: 8px; cursor: pointer; transition: background 0.15s; }
    .form-check:hover { background: #FDF2F2; }
</style>

<div class="row justify-content-center">
    <div class="col-md-8">

        <div class="quiz-header">
            <div>
                <h3><asp:Label ID="lblQuizTitle" runat="server" /></h3>
                <p><asp:Label ID="lblQuizDescription" runat="server" /></p>
            </div>
            <div class="timer-badge">
                ⏱ <asp:Label ID="lblTimeRemaining" runat="server" Text="10:00" />
            </div>
        </div>

        <asp:HiddenField ID="hfTimeLimitSec" runat="server" Value="600" />
        <asp:HiddenField ID="hfQuizId" runat="server" />

        <asp:Label ID="lblQuizError" runat="server"
            CssClass="alert alert-danger d-block mb-3"
            Visible="false" />

        <asp:Repeater ID="rptQuestions" runat="server">
            <ItemTemplate>
                <div class="question-card">
                    <h6>
                        Q<%# Container.ItemIndex + 1 %>.
                        <asp:Label ID="lblQuestionText" runat="server"
                            Text='<%# Eval("QuestionText") %>' />
                    </h6>
                    <div>
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
            </ItemTemplate>
        </asp:Repeater>

        <div class="d-flex justify-content-end mt-2 mb-5">
            <asp:Button ID="btnSubmitQuiz" runat="server"
                Text="Submit Quiz"
                CssClass="btn btn-danger px-5 py-2 fw-semibold"
                OnClick="btnSubmitQuiz_Click"
                UseSubmitBehavior="false" />
        </div>

    </div>
</div>

<script type="text/javascript">
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
