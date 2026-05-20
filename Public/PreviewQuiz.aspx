<%@ Page Title="Preview Quiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PreviewQuiz.aspx.cs" Inherits="Aidify_assigment.Public.PreviewQuiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="quiz-page-section">
        <div class="container">
            <div class="row">

                <div class="col-lg-8">

                    <!-- Preview Content -->
                    <div class="quiz-header">
                        <span class="quiz-label">Module Preview</span>

                        <h1>Basic First Aid Awareness</h1>

                        <p>
                            This preview content introduces visitors to basic emergency response awareness
                            and first aid concepts before attempting the preview quiz.
                        </p>
                    </div>

                    <!-- Learning Content -->
                    <div class="quiz-question-card">
                        <h3>What is First Aid?</h3>

                        <p>
                            First aid refers to the immediate assistance given to a person suffering from
                            an injury or sudden illness before professional medical help arrives.
                        </p>

                        <p>
                            The goal of first aid is to preserve life, prevent the condition from worsening,
                            and promote recovery.
                        </p>
                    </div>

                    <div class="quiz-question-card">
                        <h3>Important Emergency Awareness Steps</h3>

                        <ul>
                            <li>Stay calm during emergencies.</li>
                            <li>Check that the scene is safe.</li>
                            <li>Call emergency services immediately if needed.</li>
                            <li>Provide only basic aid you understand.</li>
                            <li>Wait for trained professionals to arrive.</li>
                        </ul>
                    </div>

                    <div class="quiz-question-card">
                        <h3>Emergency Reminder</h3>

                        <p>
                            Online learning platforms like Aidify provide educational awareness only.
                            In real emergencies, always contact emergency services immediately.
                        </p>
                    </div>

                    <!-- Attempt Quiz Button -->
                    <div class="quiz-action-box">

                        <button type="button"
                            class="btn btn-aidify"
                            onclick="showQuiz()">

                            Attempt Preview Quiz

                        </button>

                        <a href="PreviewModules.aspx"
                            class="btn btn-outline-aidify">

                            Back to Modules

                        </a>

                    </div>

                    <!-- Quiz Section -->
                    <div id="quizSection" style="display:none;">

                        <div class="quiz-progress-box mt-5">
                            <div class="d-flex justify-content-between">
                                <span>Question 1 of 3</span>
                                <span>Preview Quiz</span>
                            </div>

                            <div class="progress mt-2">
                                <div class="progress-bar aidify-progress" style="width: 33%;"></div>
                            </div>
                        </div>

                        <!-- Questions loaded from DB via WebMethod -->
                        <div id="previewQuestionsContainer">
                            <p class="text-muted">Loading questions…</p>
                        </div>

                        <!-- Submit Button -->
                        <div class="quiz-action-box">
                            <asp:Button
                                ID="btnSubmitPreviewQuiz"
                                runat="server"
                                Text="Submit Preview Quiz"
                                CssClass="btn btn-aidify" />
                        </div>

                    </div>

                </div>

                <!-- Sidebar -->
                <div class="col-lg-4">

                    <div class="quiz-sidebar-card">
                        <h4>Preview Learning Content</h4>

                        <ul>
                            <li>What is First Aid?</li>
                            <li>Emergency Awareness Steps</li>
                            <li>Emergency Reminder</li>
                            <li>Preview Quiz Available</li>
                        </ul>
                    </div>

                    <div class="quiz-register-card">
                        <h4>Unlock Full Learning</h4>

                        <p>
                            Register to access complete modules, full quizzes,
                            progress tracking, badges, certificates,
                            and learner dashboards.
                        </p>

                        <a href="../Auth/Register.aspx"
                            class="btn btn-aidify w-100">
                            Register Now
                        </a>
                    </div>

                    <div class="quiz-warning-card">
                        <h5>Medical Disclaimer</h5>

                        <p>
                            Aidify provides educational awareness only and does not replace
                            professional medical training or emergency services.
                        </p>
                    </div>

                </div>

            </div>
        </div>
    </section>

    <script>
        var questionsLoaded = false;

        function showQuiz() {
            document.getElementById("quizSection").style.display = "block";
            document.getElementById("quizSection").scrollIntoView({ behavior: "smooth" });
            if (!questionsLoaded) loadPreviewQuestions();
        }

        function loadPreviewQuestions() {
            $.ajax({
                type: 'POST', url: 'PreviewQuiz.aspx/GetPreviewQuestions',
                data: '{}', contentType: 'application/json; charset=utf-8', dataType: 'json',
                success: function (r) {
                    questionsLoaded = true;
                    var qs = r.d;
                    var container = document.getElementById('previewQuestionsContainer');
                    if (!qs || qs.length === 0) {
                        container.innerHTML = '<p class="text-muted">No preview questions available yet.</p>';
                        return;
                    }
                    var html = '';
                    for (var i = 0; i < qs.length; i++) {
                        var q = qs[i];
                        html += '<div class="quiz-question-card"><h3>' + esc(q.questionText) + '</h3><div class="quiz-options">';
                        for (var j = 0; j < q.options.length; j++) {
                            html += '<label><input type="radio" name="pq' + q.questionId + '" value="' + j + '" /> ' + esc(q.options[j]) + '</label>';
                        }
                        html += '</div></div>';
                    }
                    container.innerHTML = html;
                },
                error: function () {
                    document.getElementById('previewQuestionsContainer').innerHTML =
                        '<p class="text-muted">Could not load questions. Please try again.</p>';
                }
            });
        }

        function esc(s) {
            return String(s || '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
        }
    </script>

</asp:Content>