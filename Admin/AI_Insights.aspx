<%@ Page Title="AI Insights" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AI_Insights.aspx.cs" Inherits="Aidify_assigment.Admin.AI_Insights" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .aidify-navbar,
    .aidify-footer {
        display: none !important;
    }

    body {
        background-color: #f9f9f9;
    }

    /* ── TOPBAR ── */
    .ai-topbar {
        height: 80px;
        background: #ffffff;
        border-bottom: 1px solid #e2e2e2;
        display: flex;
        align-items: center;
        position: sticky;
        top: 0;
        z-index: 50;
    }

    .ai-brand {
        color: #E53935;
        font-size: 26px;
        font-weight: 800;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .admin-badge {
        background-color: #db322f;
        color: #fff;
        font-size: 11px;
        padding: 3px 9px;
        border-radius: 20px;
        font-weight: 700;
    }

    .ai-nav a {
        color: #3d2a28;
        text-decoration: none;
        margin-left: 22px;
        font-weight: 600;
        font-size: 14px;
    }

    .ai-nav a.active {
        color: #E53935;
        border-bottom: 2px solid #E53935;
        padding-bottom: 8px;
    }

    .admin-avatar {
        width: 42px;
        height: 42px;
        border-radius: 50%;
        background: #E53935;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 800;
        flex-shrink: 0;
    }

    /* ── PAGE ── */
    .ai-page {
        padding: 44px 0 60px;
        background-color: #f9f9f9;
    }

    .ai-page h1 {
        font-size: 32px;
        font-weight: 800;
        color: #1a1a1a;
        margin-bottom: 6px;
    }

    /* ── CARDS ── */
    .ai-card {
        background: #ffffff;
        border: 1px solid #e2e2e2;
        border-radius: 16px;
        padding: 28px;
        height: 100%;
    }

    .ai-card-critical {
        border: 2px solid #E53935;
    }

    /* ── HEATMAP ── */
    .heatmap-grid {
        display: grid;
        grid-template-columns: repeat(12, 1fr);
        gap: 5px;
        margin-bottom: 20px;
    }

    .heatmap-cell {
        aspect-ratio: 1;
        border-radius: 4px;
    }

    /* ── FORECAST CHART ── */
    .forecast-chart {
        height: 190px;
        display: flex;
        align-items: flex-end;
        gap: 8px;
        margin-bottom: 14px;
    }

    .forecast-bar {
        flex: 1;
        border-radius: 6px 6px 0 0;
    }

    /* ── BOTTOM STAT BOXES ── */
    .stat-mini-box {
        background: #ffffff;
        border: 1px solid #e2e2e2;
        border-radius: 14px;
        padding: 20px 22px;
        height: 100%;
    }

    .stat-mini-box .stat-mini-label {
        font-size: 11px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.7px;
        color: #888;
        margin-bottom: 10px;
    }

    /* ── FOOTER ── */
    .ai-footer {
        background: #f3f3f3;
        border-top: 1px solid #e2e2e2;
        padding: 28px 0 16px;
    }

    .ai-footer .footer-brand {
        color: #E53935;
        font-weight: 800;
        font-size: 18px;
    }

    .ai-footer a {
        color: #555;
        text-decoration: none;
        font-size: 13px;
    }

    .ai-footer a:hover {
        color: #E53935;
    }

    @media (max-width: 992px) {
        .ai-nav { display: none; }
    }
</style>

<!-- ── TOPBAR ── -->
<header class="ai-topbar">
    <div class="container d-flex justify-content-between align-items-center">

        <a href="Dashboard.aspx" class="ai-brand">
            Aidify
            <span class="admin-badge">ADMIN</span>
        </a>

        <nav class="ai-nav">
            <a href="Dashboard.aspx">Dashboard</a>
            <a href="Users/List.aspx">Users</a>
            <a href="Roles.aspx">Roles</a>
            <a href="Content/ManagePublicPages.aspx">Public Pages</a>
            <a href="Content/ApprovalQueue.aspx">Approvals</a>
            <a href="Analytics.aspx">Analytics</a>
        </nav>

        <div class="d-flex align-items-center gap-3">
            <i class="bi bi-bell fs-5"></i>
            <div class="text-end d-none d-md-block">
                <div class="fw-bold" style="font-size:14px;"><%: Aidify_assigment.AuthHelper.GetName() %></div>
                <small class="text-muted"><%: Aidify_assigment.AuthHelper.GetRole() %></small>
            </div>
            <div class="admin-avatar">A</div>
        </div>

    </div>
</header>

<!-- ── MAIN ── -->
<main class="ai-page">
    <div class="container">

        <!-- Page Header -->
        <div class="mb-4">
            <h1>AI Insights &amp; Decision Support</h1>
            <p class="text-muted" style="font-size:15px;">
                Administrative intelligence for medical education performance and optimization.
            </p>
        </div>

        <div class="row g-4">

            <!-- Heatmap card — large -->
            <div class="col-lg-8">
                <div class="ai-card">

                    <div class="d-flex justify-content-between align-items-start mb-4">
                        <div>
                            <h2 class="h5 fw-bold mb-1">Student Competency Heatmap</h2>
                            <p class="text-muted small mb-0">
                                Visualizing certification readiness across all active cohorts.
                            </p>
                        </div>
                        <div class="d-flex gap-2">
                            <span class="badge bg-light text-dark border" style="font-size:11px;">
                                <span class="text-danger">●</span> High Risk
                            </span>
                            <span class="badge bg-light text-dark border" style="font-size:11px;">
                                <span style="color:#4B50C7;">●</span> On Track
                            </span>
                        </div>
                    </div>

                    <!-- Row 1 -->
                    <div class="heatmap-grid">
                        <div class="heatmap-cell" style="background:#f5c6c6;"></div>
                        <div class="heatmap-cell" style="background:#4B50C7;"></div>
                        <div class="heatmap-cell" style="background:#7b80d4;"></div>
                        <div class="heatmap-cell" style="background:#E53935;"></div>
                        <div class="heatmap-cell" style="background:#4B50C7;"></div>
                        <div class="heatmap-cell" style="background:#9da1e0;"></div>
                        <div class="heatmap-cell" style="background:#4B50C7;"></div>
                        <div class="heatmap-cell" style="background:#f5a0a0;"></div>
                        <div class="heatmap-cell" style="background:#4B50C7;"></div>
                        <div class="heatmap-cell" style="background:#c5c8ee;"></div>
                        <div class="heatmap-cell" style="background:#4B50C7;"></div>
                        <div class="heatmap-cell" style="background:#9da1e0;"></div>

                        <!-- Row 2 -->
                        <div class="heatmap-cell" style="background:#4B50C7;"></div>
                        <div class="heatmap-cell" style="background:#c5c8ee;"></div>
                        <div class="heatmap-cell" style="background:#E53935;"></div>
                        <div class="heatmap-cell" style="background:#4B50C7;"></div>
                        <div class="heatmap-cell" style="background:#4B50C7;"></div>
                        <div class="heatmap-cell" style="background:#7b80d4;"></div>
                        <div class="heatmap-cell" style="background:#f5a0a0;"></div>
                        <div class="heatmap-cell" style="background:#4B50C7;"></div>
                        <div class="heatmap-cell" style="background:#c5c8ee;"></div>
                        <div class="heatmap-cell" style="background:#4B50C7;"></div>
                        <div class="heatmap-cell" style="background:#7b80d4;"></div>
                        <div class="heatmap-cell" style="background:#4B50C7;"></div>

                        <!-- Row 3 -->
                        <div class="heatmap-cell" style="background:#4B50C7;"></div>
                        <div class="heatmap-cell" style="background:#dfe0f7;"></div>
                        <div class="heatmap-cell" style="background:#4B50C7;"></div>
                        <div class="heatmap-cell" style="background:#E53935;"></div>
                        <div class="heatmap-cell" style="background:#4B50C7;"></div>
                        <div class="heatmap-cell" style="background:#7b80d4;"></div>
                        <div class="heatmap-cell" style="background:#9da1e0;"></div>
                        <div class="heatmap-cell" style="background:#fadadd;"></div>
                        <div class="heatmap-cell" style="background:#4B50C7;"></div>
                        <div class="heatmap-cell" style="background:#4B50C7;"></div>
                        <div class="heatmap-cell" style="background:#7b80d4;"></div>
                        <div class="heatmap-cell" style="background:#4B50C7;"></div>
                    </div>

                    <div class="alert alert-light border d-flex align-items-center gap-3 mb-0" style="border-radius:10px;">
                        <i class="bi bi-exclamation-triangle-fill text-danger"></i>
                        <p class="mb-0 small fw-medium">
                            AI Observation: A 14% drop in practical test performance detected in the Southeast Cohort.
                            Immediate review recommended.
                        </p>
                    </div>

                </div>
            </div>

            <!-- Critical alert card -->
            <div class="col-lg-4">
                <div class="ai-card ai-card-critical d-flex flex-column">

                    <div class="mb-auto">
                        <div class="rounded-circle bg-danger bg-opacity-10 d-flex align-items-center justify-content-center mb-4"
                             style="width:52px;height:52px;">
                            <i class="bi bi-cpu-fill text-danger fs-4"></i>
                        </div>

                        <h3 class="h5 fw-bold mb-3">
                            Identify students at risk of failing CPR certification
                        </h3>

                        <p class="text-muted small">
                            Predictive analysis indicates 28 students are trending below the passing threshold for
                            upcoming assessments based on manual skill simulations.
                        </p>
                    </div>

                    <button type="button" class="btn btn-aidify w-100 py-3 mt-4">
                        Send Remedial Material
                    </button>

                </div>
            </div>

            <!-- Low engagement card -->
            <div class="col-md-6 col-lg-4">
                <div class="ai-card">

                    <div class="d-flex justify-content-between mb-4">
                        <i class="bi bi-graph-down-arrow fs-4" style="color:#4B50C7;"></i>
                        <span class="badge bg-danger bg-opacity-10 text-danger" style="font-size:12px;">Alert</span>
                    </div>

                    <h3 class="h5 fw-bold mb-2">Highlight modules with low engagement</h3>

                    <p class="text-muted small mb-4">
                        "Pediatric Airway Management" has a 45% drop-off rate at the 3-minute mark.
                        Suggested update: Interactive video elements.
                    </p>

                    <button type="button" class="btn btn-outline-secondary w-100 fw-bold">
                        View Analytics
                    </button>

                </div>
            </div>

            <!-- Bottlenecks card -->
            <div class="col-md-6 col-lg-4">
                <div class="ai-card">

                    <div class="d-flex justify-content-between mb-4">
                        <i class="bi bi-stopwatch fs-4" style="color:#4B50C7;"></i>
                        <span class="badge bg-info bg-opacity-10 text-info" style="font-size:12px;">Optimization</span>
                    </div>

                    <h3 class="h5 fw-bold mb-2">Review Certification Bottlenecks</h3>

                    <p class="text-muted small mb-4">
                        Wait times for clinical check-offs have increased by 3 days.
                        AI recommends opening 2 additional simulation slots on Fridays.
                    </p>

                    <button type="button" class="btn btn-outline-secondary w-100 fw-bold">
                        Adjust Schedule
                    </button>

                </div>
            </div>

            <!-- Forecast chart card -->
            <div class="col-lg-4">
                <div class="ai-card">

                    <h3 class="h5 fw-bold mb-4">Certification Growth Forecast</h3>

                    <div class="forecast-chart">
                        <div class="forecast-bar" style="height:40%;background:#d0d0d0;"></div>
                        <div class="forecast-bar" style="height:55%;background:#d0d0d0;"></div>
                        <div class="forecast-bar" style="height:50%;background:#d0d0d0;"></div>
                        <div class="forecast-bar" style="height:70%;background:#4B50C7;"></div>
                        <div class="forecast-bar" style="height:85%;background:#7b80d4;"></div>
                        <div class="forecast-bar" style="height:95%;background:#c5c8ee;"></div>
                    </div>

                    <p class="text-muted small mb-0">
                        Projecting a 22% increase in certified learners by Q4 based on current enrollment patterns.
                    </p>

                </div>
            </div>

            <!-- Bottom stat mini boxes -->
            <div class="col-md-4">
                <div class="stat-mini-box">
                    <div class="stat-mini-label">System Health</div>
                    <div class="d-flex align-items-center gap-2">
                        <span class="rounded-circle bg-success" style="width:12px;height:12px;flex-shrink:0;"></span>
                        <span class="h5 mb-0 fw-bold">99.9% Uptime</span>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="stat-mini-box">
                    <div class="stat-mini-label">Active Learners</div>
                    <div class="d-flex align-items-center gap-2">
                        <i class="bi bi-people-fill" style="color:#4B50C7;"></i>
                        <span class="h5 mb-0 fw-bold" id="aiActiveLearners">— Online</span>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="stat-mini-box">
                    <div class="stat-mini-label">Protocol Updates</div>
                    <div class="d-flex align-items-center gap-2">
                        <i class="bi bi-shield-check text-danger"></i>
                        <span class="h5 mb-0 fw-bold">AHA 2026 Compliant</span>
                    </div>
                </div>
            </div>

        </div>
    </div>
</main>

<!-- ── AI DECISION SUPPORT CHAT ── -->
<section class="container mb-5">
    <div class="ai-card" style="border-radius:16px;padding:28px;">
        <div class="d-flex align-items-center gap-2 mb-2">
            <i class="bi bi-chat-dots-fill" style="color:#E53935;font-size:22px;"></i>
            <h2 class="h5 fw-bold mb-0">AI Decision Support</h2>
        </div>
        <p class="text-muted small mb-3">
            Ask a natural-language question about platform performance.
            The AI analyses anonymised aggregate data — no personal data is ever sent.
        </p>

        <div id="aiChatHistory"
             style="min-height:80px;max-height:260px;overflow-y:auto;
                    background:#f9f9f9;border:1px solid #e2e2e2;
                    border-radius:10px;padding:16px;margin-bottom:14px;font-size:14px;">
            <p class="text-muted mb-0">Your conversation will appear here.</p>
        </div>

        <div class="d-flex gap-2">
            <input type="text" id="txtAIQuestion" class="form-control"
                   placeholder="e.g. Which module has the lowest completion rate?"
                   maxlength="300" style="border-radius:10px;" />
            <button onclick="askAI()" class="btn btn-aidify px-4 fw-bold"
                    style="background:#E53935;border-color:#E53935;color:#fff;
                           border-radius:10px;white-space:nowrap;">
                Ask AI
            </button>
        </div>
        <div id="aiChatError" class="text-danger small mt-2" style="display:none;"></div>
    </div>
</section>

<script type="text/javascript">
    function askAI() {
        var input   = document.getElementById('txtAIQuestion');
        var q       = input.value.trim();
        if (!q) return;

        var history  = document.getElementById('aiChatHistory');
        var errDiv   = document.getElementById('aiChatError');
        errDiv.style.display = 'none';

        // Append user message
        history.innerHTML += '<div class="mb-2"><strong style="color:#E53935;">You:</strong> ' +
                             escapeHtml(q) + '</div>';
        history.innerHTML += '<div id="aiThinking" class="mb-2 text-muted fst-italic">AI is thinking…</div>';
        history.scrollTop  = history.scrollHeight;
        input.value = '';

        // Call the WebMethod
        $.ajax({
            type:        'POST',
            url:         'AI_Insights.aspx/AskAI',
            data:        JSON.stringify({ question: q }),
            contentType: 'application/json; charset=utf-8',
            dataType:    'json',
            success: function (data) {
                var thinking = document.getElementById('aiThinking');
                if (thinking) thinking.remove();
                history.innerHTML += '<div class="mb-2"><strong style="color:#4B50C7;">Aidify AI:</strong> ' +
                                     escapeHtml(data.d) + '</div>';
                history.scrollTop = history.scrollHeight;
            },
            error: function () {
                var thinking = document.getElementById('aiThinking');
                if (thinking) thinking.remove();
                errDiv.style.display = '';
                errDiv.textContent = 'AI service unavailable. Please try again later.';
            }
        });
    }

    function escapeHtml(str) {
        return String(str)
            .replace(/&/g, '&amp;').replace(/</g, '&lt;')
            .replace(/>/g, '&gt;').replace(/"/g, '&quot;');
    }

    document.addEventListener('DOMContentLoaded', function () {
        var input = document.getElementById('txtAIQuestion');
        if (input) input.addEventListener('keydown', function (e) {
            if (e.key === 'Enter') askAI();
        });
    });
</script>

<!-- ── FOOTER ── -->
<footer class="ai-footer">
    <div class="container">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-3 mb-3">
            <div>
                <div class="footer-brand">Aidify</div>
                <p class="text-muted small mb-0">Administrative control center for the Aidify learning platform.</p>
            </div>
            <div class="d-flex align-items-center gap-3">
                <a href="Dashboard.aspx">Dashboard</a>
                <span class="text-muted">|</span>
                <a href="#">Privacy Policy</a>
                <span class="text-muted">|</span>
                <a href="#">Terms of Service</a>
            </div>
        </div>
        <hr class="mt-1 mb-2" />
        <p class="text-muted small mb-0 text-center">© 2026 Aidify Admin Panel. Educational use only.</p>
    </div>
</footer>

<script type="text/javascript">
$(document).ready(function(){
    $.ajax({type:"POST",url:"AI_Insights.aspx/GetActiveLearners",data:"{}",
    contentType:"application/json; charset=utf-8",dataType:"json",
    success:function(r){if(r.d!=null)document.getElementById("aiActiveLearners").textContent=r.d.toLocaleString()+" Online";}});
});
</script>

</asp:Content>
