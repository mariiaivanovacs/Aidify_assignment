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

    .ai-logo {
        width: 42px;
        height: 42px;
        object-fit: contain;
    }

    .ai-brand {
        color: #E53935;
        font-size: 26px;
        font-weight: 800;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 12px;
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

    .ai-dropdown {
        text-decoration: none;
        color: #1f2937;
        font-weight: 700;
        font-size: 18px;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .ai-dropdown:hover {
        color: #E53935;
    }

    .dropdown-menu {
        min-width: 180px;
        border-radius: 12px;
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
            <img src="<%= ResolveUrl("~/Images/aidify-kit.png") %>"
                 alt="Aidify Logo"
                 class="ai-logo" />

            <span>Aidify</span>
        </a>

        <nav class="ai-nav">
            <a href="Dashboard.aspx">Dashboard</a>
            <a href="Users/List.aspx">Users</a>
          
            <a href="Content/ApprovalQueue.aspx">Approvals</a>
            <a href="Analytics.aspx">Analytics</a>
        </nav>

        <div class="dropdown">

            <a href="#"
               class="ai-dropdown"
               data-bs-toggle="dropdown"
               aria-expanded="false">
                Admin
                <i class="bi bi-chevron-down"></i>
            </a>

            <ul class="dropdown-menu dropdown-menu-end shadow-sm">
                <li>
                    <a class="dropdown-item"
                       href="<%= ResolveUrl("~/Account/Profile.aspx") %>">
                        <i class="bi bi-person me-2"></i>
                        Profile
                    </a>
                </li>

                <li>
                    <a class="dropdown-item text-danger"
                       href="<%= ResolveUrl("~/Auth/Logout.aspx") %>">
                        <i class="bi bi-box-arrow-right me-2"></i>
                        Logout
                    </a>
                </li>
            </ul>

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

            <!-- Dynamic Overview Cards -->
            <div class="col-lg-6">
                <div class="ai-card">
                    <h3 class="h5 fw-bold mb-3">User Overview</h3>
                    <p class="text-muted small mb-4">Live user distribution from the Aidify database.</p>

                    <div class="row g-3">
                        <div class="col-4">
                            <div class="stat-mini-label">Total Users</div>
                            <div class="h4 fw-bold" id="cardTotalUsers">—</div>
                        </div>
                        <div class="col-4">
                            <div class="stat-mini-label">Learners</div>
                            <div class="h4 fw-bold" id="cardActiveLearners">—</div>
                        </div>
                        <div class="col-4">
                            <div class="stat-mini-label">Instructors</div>
                            <div class="h4 fw-bold" id="cardTotalInstructors">—</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="ai-card">
                    <h3 class="h5 fw-bold mb-3">Module Overview</h3>
                    <p class="text-muted small mb-4">Current module status based on database records.</p>

                    <div class="row g-3">
                        <div class="col-3">
                            <div class="stat-mini-label">Total</div>
                            <div class="h4 fw-bold" id="cardTotalModules">—</div>
                        </div>
                        <div class="col-3">
                            <div class="stat-mini-label">Published</div>
                            <div class="h4 fw-bold" id="cardPublishedModules">—</div>
                        </div>
                        <div class="col-3">
                            <div class="stat-mini-label">Draft</div>
                            <div class="h4 fw-bold" id="cardDraftModules">—</div>
                        </div>
                        <div class="col-3">
                            <div class="stat-mini-label">Pending</div>
                            <div class="h4 fw-bold" id="cardPendingModules">—</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="ai-card">
                    <h3 class="h5 fw-bold mb-3">Learning Activity</h3>
                    <p class="text-muted small mb-4">Learner progress and quiz participation summary.</p>

                    <div class="row g-3">
                        <div class="col-4">
                            <div class="stat-mini-label">Quiz Attempts</div>
                            <div class="h4 fw-bold" id="cardTotalAttempts">—</div>
                        </div>
                        <div class="col-4">
                            <div class="stat-mini-label">Completed Lessons</div>
                            <div class="h4 fw-bold" id="cardCompletedLessons">—</div>
                        </div>
                        <div class="col-4">
                            <div class="stat-mini-label">Completion Rate</div>
                            <div class="h4 fw-bold" id="cardCompletionRate">—</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="ai-card ai-card-critical">
                    <h3 class="h5 fw-bold mb-3">Platform Health Insight</h3>
                    <p class="text-muted small mb-4" id="cardHealthInsight">
                        Loading platform insight...
                    </p>

                    <a href="Analytics.aspx" class="btn btn-aidify w-100 py-3"
                        style="background:#E53935;border-color:#E53935;color:#fff;">
                        Review Platform Activity
                    </a>
                </div>
            </div>
            
            <!-- Bottom stat mini boxes -->
            <div class="col-md-3">
                <div class="stat-mini-box">
                    <div class="stat-mini-label">Total Users</div>
                    <div class="h5 mb-0 fw-bold" id="aiTotalUsers">—</div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-mini-box">
                    <div class="stat-mini-label">Active Learners</div>
                    <div class="h5 mb-0 fw-bold" id="aiActiveLearners">—</div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-mini-box">
                    <div class="stat-mini-label">Pending Modules</div>
                    <div class="h5 mb-0 fw-bold" id="aiPendingModules">—</div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-mini-box">
                    <div class="stat-mini-label">Completion Rate</div>
                    <div class="h5 mb-0 fw-bold" id="aiCompletionRate">—</div>
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
            <button type="button" onclick="askAI()" class="btn btn-aidify px-4 fw-bold"
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

        if (input) {
            input.addEventListener('keydown', function (e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    askAI();
                }
            });
        }
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
        </div>
        <hr class="mt-1 mb-2" />
        <p class="text-muted small mb-0 text-center">© 2026 Aidify Admin Panel. Educational use only.</p>
    </div>
</footer>

<script type="text/javascript">
    $(document).ready(function () {
        $.ajax({
            type: "POST",
            url: "AI_Insights.aspx/GetStats",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (r) {
                if (r.d == null) return;

                $("#aiTotalUsers").text(r.d.TotalUsers.toLocaleString());
                $("#aiActiveLearners").text(r.d.ActiveLearners.toLocaleString());
                $("#aiPendingModules").text(r.d.PendingModules.toLocaleString());
                $("#aiCompletionRate").text(r.d.CompletionRate + "%");

                $("#cardTotalUsers").text(r.d.TotalUsers.toLocaleString());
                $("#cardActiveLearners").text(r.d.ActiveLearners.toLocaleString());
                $("#cardTotalInstructors").text(r.d.TotalInstructors.toLocaleString());

                $("#cardTotalModules").text(r.d.TotalModules.toLocaleString());
                $("#cardPublishedModules").text(r.d.PublishedModules.toLocaleString());
                $("#cardDraftModules").text(r.d.DraftModules.toLocaleString());
                $("#cardPendingModules").text(r.d.PendingModules.toLocaleString());

                $("#cardTotalAttempts").text(r.d.TotalAttempts.toLocaleString());
                $("#cardCompletedLessons").text(r.d.CompletedLessons.toLocaleString());
                $("#cardCompletionRate").text(r.d.CompletionRate + "%");

                var insight = "";

                if (r.d.CompletionRate === 0) {
                    insight = "Learning activity is currently very low. There are active learners, but no completed lessons yet. The admin should check whether learners can access modules and quizzes properly.";
                }
                else if (r.d.PendingModules > 0) {
                    insight = "There are modules waiting for admin review. Approving or rejecting pending modules can help keep the learning content available and up to date.";
                }
                else {
                    insight = "The platform is operating normally based on the available database metrics. Continue monitoring learner progress and quiz participation.";
                }

                $("#cardHealthInsight").text(insight);
            },
            error: function () {
                $("#aiTotalUsers").text("Error");
                $("#aiActiveLearners").text("Error");
                $("#aiPendingModules").text("Error");
                $("#aiCompletionRate").text("Error");
            }
        });
    });
</script>

</asp:Content>
