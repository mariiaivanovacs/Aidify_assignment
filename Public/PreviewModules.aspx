<%@ Page Title="Preview Modules" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PreviewModules.aspx.cs" Inherits="Aidify_assigment.Public.PreviewModules" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="page-header">
        <div class="container text-center">
            <h1>Explore Life-Saving Knowledge</h1>
            <p>
                Access selected preview modules to learn basic first aid and emergency response topics
                before registering.
            </p>
        </div>
    </section>

    <section class="module-section">
        <div class="container">
            <!-- Real modules from DB -->
            <div class="row" id="liveModulesRow">
                <div class="col-12 text-center text-muted py-3">Loading modules…</div>
            </div>

            <!-- Static fallback content kept below -->
            <div class="row" style="display:none;">

                <!-- Burns -->
                <div class="col-md-4">
                    <div class="module-card">
                        <h4>Burns & Scalds</h4>

                        <p>
                            Learn basic burn safety, cooling steps, and when to seek medical help.
                        </p>

                        <span>Intermediate • 15 mins • 6 lessons</span>

                        <a href="PreviewQuiz.aspx"
                            class="btn btn-aidify mt-3">
                            Preview Content
                        </a>
                    </div>
                </div>

                <!-- Choking -->
                <div class="col-md-4">
                    <div class="module-card">
                        <h4>Choking Relief</h4>

                        <p>
                            Understand how to identify choking and respond safely in an emergency.
                        </p>

                        <span>Beginner • 10 mins • 4 lessons</span>

                        <a href="PreviewQuiz.aspx"
                            class="btn btn-aidify mt-3">
                            Preview Content
                        </a>
                    </div>
                </div>

                <!-- CPR -->
                <div class="col-md-4">
                    <div class="module-card locked-card">
                        <h4>CPR Awareness</h4>

                        <p>
                            Learn basic CPR awareness and AED emergency response concepts.
                        </p>

                        <span>Locked • Register to unlock full access</span>

                        <a href="../Auth/Register.aspx"
                            class="btn btn-outline-aidify mt-3">
                            Register to Unlock
                        </a>
                    </div>
                </div>

                <!-- Fractures -->
                <div class="col-md-4">
                    <div class="module-card">
                        <h4>Fractures & Breaks</h4>

                        <p>
                            Learn basic response steps for suspected fractures and injury support.
                        </p>

                        <span>Intermediate • 20 mins • 5 lessons</span>

                        <a href="PreviewQuiz.aspx"
                            class="btn btn-aidify mt-3">
                            Preview Content
                        </a>
                    </div>
                </div>

                <!-- Severe Bleeding -->
                <div class="col-md-4">
                    <div class="module-card locked-card">
                        <h4>Severe Bleeding</h4>

                        <p>
                            Learn awareness of bleeding control and when to call emergency services.
                        </p>

                        <span>Locked • Register to unlock full access</span>

                        <a href="../Auth/Register.aspx"
                            class="btn btn-outline-aidify mt-3">
                            Register to Unlock
                        </a>
                    </div>
                </div>

                <!-- Allergic Reactions -->
                <div class="col-md-4">
                    <div class="module-card">
                        <h4>Allergic Reactions</h4>

                        <p>
                            Understand basic warning signs of severe allergic reactions.
                        </p>

                        <span>Beginner • 12 mins • 3 lessons</span>

                        <a href="PreviewQuiz.aspx"
                            class="btn btn-aidify mt-3">
                            Preview Content
                        </a>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <section class="preview-cta">
        <div class="container text-center">

            <h2>Ready to Unlock Full Learning?</h2>

            <p>
                Register to access complete modules, full quizzes,
                progress tracking, badges, and certificates.
            </p>

            <a href="../Auth/Register.aspx"
                class="btn btn-aidify">
                Get Full Access
            </a>

        </div>
    </section>

<script type="text/javascript">
$.ajax({
    type:'POST', url:'PreviewModules.aspx/GetPreviewModules', data:'{}',
    contentType:'application/json; charset=utf-8', dataType:'json',
    success: function(r) {
        var modules = r.d;
        var row = document.getElementById('liveModulesRow');
        if (!modules || modules.length === 0) {
            row.innerHTML = '<div class="col-12 text-center text-muted py-3">No published modules yet. Check back soon!</div>';
            return;
        }
        var html = '';
        for (var i = 0; i < modules.length; i++) {
            var m = modules[i];
            html += '<div class="col-md-4"><div class="module-card">' +
                '<h4>' + esc(m.title) + '</h4>' +
                '<p>' + esc(m.description) + '</p>' +
                '<span>' + esc(m.difficulty) + '</span>' +
                '<a href="../Auth/Register.aspx" class="btn btn-sm btn-aidify mt-3">Register to Access</a>' +
                '</div></div>';
        }
        row.innerHTML = html;
    },
    error: function() { document.getElementById('liveModulesRow').innerHTML = ''; }
});
function esc(s) { return String(s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'); }
</script>

</asp:Content>