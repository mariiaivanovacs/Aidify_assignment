<%@ Page Title="Preview Quiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PreviewQuiz.aspx.cs" Inherits="Aidify_assigment.Public.PreviewQuiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="quiz-page-section">
        <div class="container">
            <div class="row">

                <div class="col-lg-8">

                    <!-- Preview Content -->
                    <div class="quiz-header">
                        <span class="quiz-label">Module Preview</span>

                        <h1 id="previewModuleTitle">Basic First Aid Awareness</h1>

                        <p id="previewModuleDescription">
                            This preview content introduces visitors to basic emergency response awareness
                            and first aid concepts before attempting the preview quiz.
                        </p>
                    </div>

                    <!-- Learning Content loaded from DB when a module is selected -->
                    <div id="previewLessonsContainer">
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
                                <span id="quizProgressLabel">Preview Questions</span>
                                <span id="previewQuizTitle">Preview Quiz</span>
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
                                CssClass="btn btn-aidify"
                                OnClientClick="return gradePreviewQuiz();" />
                        </div>

                        <div id="previewQuizResult" class="mt-3"></div>

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
        var previewLoaded = false;
        var previewQuestions = [];

        function getQueryInt(name) {
            var match = new RegExp('[?&]' + name + '=([^&]+)').exec(window.location.search);
            return match ? parseInt(decodeURIComponent(match[1]), 10) || 0 : 0;
        }

        document.addEventListener('DOMContentLoaded', function () {
            loadPreviewContent(function () {
                if (getQueryInt('startQuiz') === 1) showQuiz();
            });
        });

        function showQuiz() {
            document.getElementById("quizSection").style.display = "block";
            document.getElementById("quizSection").scrollIntoView({ behavior: "smooth" });
            if (!previewLoaded) loadPreviewContent();
        }

        function loadPreviewContent(afterLoad) {
            $.ajax({
                type: 'POST', url: 'PreviewQuiz.aspx/GetPreviewContent',
                data: JSON.stringify({
                    moduleId: getQueryInt('moduleId'),
                    quizId: getQueryInt('quizId')
                }),
                contentType: 'application/json; charset=utf-8', dataType: 'json',
                success: function (r) {
                    previewLoaded = true;
                    var data = r.d || {};
                    renderModule(data.module, data.lessons || []);
                    renderQuestions(data.quiz, data.questions || []);
                    if (typeof afterLoad === 'function') afterLoad();
                },
                error: function () {
                    document.getElementById('previewQuestionsContainer').innerHTML =
                        '<p class="text-muted">Could not load questions. Please try again.</p>';
                    if (typeof afterLoad === 'function') afterLoad();
                }
            });
        }

        function renderModule(module, lessons) {
            if (module) {
                document.getElementById('previewModuleTitle').textContent = module.title || 'Module Preview';
                document.getElementById('previewModuleDescription').textContent = module.description || 'Review the preview lessons before attempting the quiz.';
            }

            if (!lessons || lessons.length === 0) return;

            var html = '';
            for (var i = 0; i < lessons.length; i++) {
                var lesson = lessons[i];
                var minutes = lesson.estimatedMinutes > 0 ? '<span class="quiz-label">' + lesson.estimatedMinutes + ' mins</span>' : '';
                html += '<div class="quiz-question-card">' +
                    minutes +
                    '<h3>' + esc(lesson.title) + '</h3>' +
                    '<div>' + cleanLessonHtml(lesson.bodyHtml) + '</div>' +
                    '</div>';
            }
            document.getElementById('previewLessonsContainer').innerHTML = html;
        }

        function renderQuestions(quiz, qs) {
            if (quiz) {
                document.getElementById('previewQuizTitle').textContent = quiz.title || 'Preview Quiz';
            }

            document.getElementById('quizProgressLabel').textContent =
                qs && qs.length ? 'Question 1 of ' + qs.length : 'Preview Questions';

            var container = document.getElementById('previewQuestionsContainer');
            if (!qs || qs.length === 0) {
                container.innerHTML = '<p class="text-muted">No preview questions available yet.</p>';
                previewQuestions = [];
                return;
            }

            previewQuestions = qs;
            document.getElementById('previewQuizResult').innerHTML = '';
            var html = '';
            for (var i = 0; i < qs.length; i++) {
                var q = qs[i];
                html += '<div class="quiz-question-card preview-question" id="previewQuestion' + q.questionId + '">' +
                    '<h3>' + esc(q.questionText) + '</h3><div class="quiz-options">';
                for (var j = 0; j < q.options.length; j++) {
                    html += '<label><input type="radio" name="pq' + q.questionId + '" value="' + j + '" /> ' + esc(q.options[j]) + '</label>';
                }
                html += '<div class="preview-answer-feedback mt-2" id="previewFeedback' + q.questionId + '"></div>';
                html += '</div></div>';
            }
            container.innerHTML = html;
        }

        function gradePreviewQuiz() {
            if (!previewQuestions || previewQuestions.length === 0) {
                document.getElementById('previewQuizResult').innerHTML =
                    '<div class="alert alert-warning">No preview questions are available to score.</div>';
                return false;
            }

            var answered = 0;
            var correct = 0;

            for (var i = 0; i < previewQuestions.length; i++) {
                var q = previewQuestions[i];
                var selected = document.querySelector('input[name="pq' + q.questionId + '"]:checked');
                var selectedIndex = selected ? parseInt(selected.value, 10) : -1;
                var isCorrect = selectedIndex === q.correctIndex;
                var feedback = document.getElementById('previewFeedback' + q.questionId);
                var card = document.getElementById('previewQuestion' + q.questionId);

                if (selectedIndex >= 0) answered++;
                if (isCorrect) correct++;

                if (card) {
                    card.classList.remove('border-success', 'border-danger');
                    card.classList.add(isCorrect ? 'border-success' : 'border-danger');
                }

                if (feedback) {
                    if (selectedIndex < 0) {
                        feedback.innerHTML = '<span class="text-danger fw-semibold">Not answered.</span> Correct answer: <strong>' +
                            esc(q.options[q.correctIndex] || '') + '</strong>';
                    } else if (isCorrect) {
                        feedback.innerHTML = '<span class="text-success fw-semibold">Correct.</span>';
                    } else {
                        feedback.innerHTML = '<span class="text-danger fw-semibold">Incorrect.</span> Correct answer: <strong>' +
                            esc(q.options[q.correctIndex] || '') + '</strong>';
                    }
                }
            }

            var resultClass = correct === previewQuestions.length ? 'alert-success' : 'alert-info';
            document.getElementById('previewQuizResult').innerHTML =
                '<div class="alert ' + resultClass + '">' +
                '<strong>Preview score: ' + correct + ' / ' + previewQuestions.length + '</strong><br />' +
                answered + ' question(s) answered. Register for full quizzes with saved attempts, progress tracking, badges, and certificates.' +
                '</div>';

            document.getElementById('previewQuizResult').scrollIntoView({ behavior: 'smooth', block: 'nearest' });
            return false;
        }

        function cleanLessonHtml(html) {
            if (!html) return '<p class="text-muted">Preview lesson content is being prepared.</p>';
            var wrapper = document.createElement('div');
            wrapper.innerHTML = repairText(html);
            var unsafe = wrapper.querySelectorAll('script, iframe, object, embed');
            for (var i = 0; i < unsafe.length; i++) unsafe[i].remove();
            return wrapper.innerHTML;
        }

        function esc(s) {
            s = repairText(s);
            return String(s || '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
        }

        function repairText(s) {
            return String(s || '')
                .replace(/â€“/g, '-')
                .replace(/â€”/g, '-')
                .replace(/â€˜|â€™/g, "'")
                .replace(/â€œ|â€�/g, '"')
                .replace(/Â/g, '');
        }
    </script>

</asp:Content>
