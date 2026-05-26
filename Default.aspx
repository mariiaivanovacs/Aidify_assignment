<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Aidify_assigment.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <span class="hero-badge">Immediate Action Saves Lives</span>

                    <h1>Learn First Aid <span>Before It Matters</span></h1>

                    <p>
                        Aidify helps learners understand first aid and emergency response through
                        structured lessons, preview modules, quizzes, and awareness tips.
                    </p>

                     <div class="d-flex gap-3 flex-wrap mt-4">
                        <a href="Auth/Register.aspx" class="btn btn-aidify">
                            Get Started for Free
                        </a>

                        <a href="Public/PreviewModules.aspx" class="btn btn-outline-aidify">
                            Browse Modules
                        </a>
                   </div>
                </div>

                <div class="col-md-6 text-center">
                    <div class="hero-image-box">
                        <img src="Images/firstaid-hero.jpg" alt="First aid learning" class="img-fluid rounded" />
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row text-center">
                <div class="col-md-4">
                    <div class="stat-card">
                        <h2 id="statTotalModules">4+</h2>
                        <p>Published Modules</p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="stat-card">
                        <h2 id="statTotalAttempts">10+</h2>
                        <p>Quiz Attempts</p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="stat-card">
                        <h2>24/7</h2>
                        <p>Accessible Learning</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Preview Modules -->
    <section class="module-section">
        <div class="container">
            <div class="section-title">
                <h2>Preview Our Modules</h2>
                <p>Explore selected first aid topics before registering for full access.</p>
            </div>

            <div class="row" id="homeModuleRow">
                <div class="col-12 text-center text-muted py-3">Loading modules…</div>
            </div>
        </div>
    </section>

    <!-- Emergency Awareness -->
    <section class="awareness-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-7">
                    <h2>In an Emergency, Every Second Counts</h2>

                    <div class="awareness-step">
                        <strong>1. Assess the Scene</strong>
                        <p>Check that the area is safe before helping others.</p>
                    </div>

                    <div class="awareness-step">
                        <strong>2. Call for Help</strong>
                        <p>Contact emergency services immediately when needed.</p>
                    </div>

                    <div class="awareness-step">
                        <strong>3. Provide Basic Aid</strong>
                        <p>Follow simple first aid steps while waiting for professionals.</p>
                    </div>
                </div>

                <div class="col-md-5">
                    <div class="warning-box">
                        <h4>Important Reminder</h4>
                        <p>
                            Aidify provides educational awareness only. It does not replace
                            professional medical training or advice.
                        </p>
                        <a href="Public/EmergencyAwareness.aspx" class="btn btn-aidify">Learn More</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

<script type="text/javascript">
$.ajax({
    type:'POST', url:'Default.aspx/GetHomeData', data:'{}',
    contentType:'application/json; charset=utf-8', dataType:'json',
    success: function(r) {
        var d = r.d;
        document.getElementById('statTotalModules').textContent  = d.modules.length + '+';
        document.getElementById('statTotalAttempts').textContent = d.totalAttempts > 0 ? d.totalAttempts + '+' : '10+';
        var row = document.getElementById('homeModuleRow');
        if (!d.modules || d.modules.length === 0) {
            row.innerHTML = '<div class="col-12 text-center text-muted py-3">No modules available yet.</div>';
            return;
        }
        var html = '';
        for (var i = 0; i < d.modules.length; i++) {
            var m = d.modules[i];
            html += '<div class="col-md-4"><div class="module-card">' +
                '<h4>' + esc(m.title) + '</h4>' +
                '<p>' + esc(m.description) + '</p>' +
                '<span>' + esc(m.difficulty) + '</span>' +
                '<a href="Public/PreviewModules.aspx?moduleId=' + m.moduleId + '" class="btn btn-sm btn-aidify mt-3">Preview</a>' +
                '</div></div>';
        }
        row.innerHTML = html;
    }
});
function esc(s) { return String(s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'); }
</script>

</asp:Content>