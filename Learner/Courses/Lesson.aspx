<%@ Page Title="Lesson" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lesson.aspx.cs" Inherits="Aidify_assigment.Learner.Courses.Lesson" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .lesson-body-card  { background: #fff; border: 1px solid #f0d8d8; border-radius: 12px; padding: 32px; line-height: 1.85; font-size: 15px; margin-bottom: 24px; }
    .breadcrumb-item a { color: #C0392B; text-decoration: none; }
    .complete-badge    { display: inline-block; background: #d8f3e7; color: #198754; padding: 6px 16px; border-radius: 20px; font-weight: 700; font-size: 13px; margin-bottom: 16px; }
    .after-links       { display: flex; gap: 12px; margin-top: 8px; }
    .pop-option        { border: 1px solid #f0d8d8; border-radius: 8px; padding: 10px 12px; margin-bottom: 8px; cursor: pointer; }
    .pop-option:hover  { background: #FDF2F2; }
</style>

<nav aria-label="breadcrumb" class="mb-4">
    <ol class="breadcrumb">
        <li class="breadcrumb-item">
            <a runat="server" href="~/Learner/Courses/Catalogue.aspx">Courses</a>
        </li>
        <li class="breadcrumb-item">
            <asp:Label ID="lblModuleBreadcrumb" runat="server" />
        </li>
        <li class="breadcrumb-item active">Lesson</li>
    </ol>
</nav>

<div class="row justify-content-center">
    <div class="col-md-8">

        <h2 class="fw-bold mb-4">
            <asp:Label ID="lblLessonTitle" runat="server" />
        </h2>

        <div class="lesson-body-card">
            <asp:Literal ID="litLessonBody" runat="server" />
        </div>

        <asp:HiddenField ID="hfModuleId" runat="server" />
        <asp:HiddenField ID="hfLessonId" runat="server" />

        <asp:Label ID="lblAlreadyComplete" runat="server"
            Text="✓ Lesson completed"
            CssClass="complete-badge"
            Visible="false" />

        <asp:Panel ID="pnlMarkComplete" runat="server" CssClass="mb-3">
            <asp:Button ID="btnMarkComplete" runat="server"
                Text="Mark as Complete"
                CssClass="btn btn-danger px-4 py-2 fw-semibold"
                OnClick="btnMarkComplete_Click" />
        </asp:Panel>

        <asp:Panel ID="pnlAfterComplete" runat="server" Visible="false" CssClass="after-links">
            <asp:HyperLink ID="lnkNextLesson" runat="server"
                Text="Next Lesson →"
                CssClass="btn btn-danger px-4" />
            <asp:HyperLink ID="lnkStartQuiz" runat="server"
                Text="Take Lesson Quiz"
                CssClass="btn btn-outline-danger px-4" />
        </asp:Panel>

    </div>
</div>

<div class="modal fade" id="popQuizModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Quick Check</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="popQuizQuestion" class="fw-semibold mb-3"></div>
                <div id="popQuizOptions"></div>
                <div id="popQuizResult" class="small mt-3"></div>
            </div>
            <div class="modal-footer">
                <button type="button" id="btnSubmitPopQuiz" class="btn btn-danger">Submit</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    (function () {
        var moduleId = parseInt(document.getElementById('<%= hfModuleId.ClientID %>').value, 10);
        var probability = parseFloat('<%= System.Configuration.ConfigurationManager.AppSettings["PopQuizProbability"] ?? "0.15" %>');
        var force = new URLSearchParams(window.location.search).get('forcePopQuiz') === '1';
        var currentQuestion = null;
        var selectedOptionId = 0;

        if (!moduleId || (!force && Math.random() >= probability)) return;

        function showResult(message, ok) {
            var result = document.getElementById('popQuizResult');
            result.className = ok ? 'small mt-3 text-success fw-semibold' : 'small mt-3 text-danger fw-semibold';
            result.textContent = message;
        }

        $.ajax({
            type: 'POST',
            url: 'Lesson.aspx/GetPopQuizQuestion',
            data: JSON.stringify({ moduleId: moduleId }),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var data = response.d;
                if (!data || !data.QuestionId) return;

                currentQuestion = data;
                document.getElementById('popQuizQuestion').textContent = data.QuestionText;
                var options = document.getElementById('popQuizOptions');
                options.innerHTML = '';

                data.Options.forEach(function (option) {
                    var label = document.createElement('label');
                    label.className = 'pop-option d-block';
                    label.innerHTML = '<input type="radio" name="popQuizOption" class="me-2" value="' + option.OptionId + '"> ' + option.OptionText;
                    options.appendChild(label);
                });

                options.addEventListener('change', function (event) {
                    if (event.target.name === 'popQuizOption') {
                        selectedOptionId = parseInt(event.target.value, 10);
                    }
                });

                bootstrap.Modal.getOrCreateInstance(document.getElementById('popQuizModal')).show();
            }
        });

        document.getElementById('btnSubmitPopQuiz').addEventListener('click', function () {
            if (!currentQuestion || !selectedOptionId) {
                showResult('Choose an answer first.', false);
                return;
            }

            $.ajax({
                type: 'POST',
                url: 'Lesson.aspx/SubmitPopQuizAnswer',
                data: JSON.stringify({
                    questionId: currentQuestion.QuestionId,
                    selectedOptionId: selectedOptionId
                }),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    var data = response.d;
                    showResult(data.Message, data.IsCorrect);
                    document.getElementById('btnSubmitPopQuiz').disabled = true;
                },
                error: function () {
                    showResult('Could not submit the answer.', false);
                }
            });
        });
    })();
</script>

</asp:Content>
