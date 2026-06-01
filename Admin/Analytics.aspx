<%@ Page Title="Analytics & Reports" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Analytics.aspx.cs" Inherits="Aidify_assigment.Admin.Analytics" %>

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
    .analytics-topbar {
        height: 80px;
        background: #ffffff;
        border-bottom: 1px solid #e2e2e2;
        display: flex;
        align-items: center;
        position: sticky;
        top: 0;
        z-index: 50;
    }

    .analytics-logo {
        width: 42px;
        height: 42px;
        object-fit: contain;
    }

    .analytics-brand {
        color: #E53935;
        font-size: 26px;
        font-weight: 800;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .analytics-dropdown {
        text-decoration: none;
        color: #1f2937;
        font-weight: 700;
        font-size: 18px;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .analytics-dropdown:hover {
        color: #E53935;
    }

    .dropdown-menu {
        min-width: 180px;
        border-radius: 12px;
    }

    .analytics-nav a {
        color: #3d2a28;
        text-decoration: none;
        margin-left: 22px;
        font-weight: 600;
        font-size: 14px;
    }

    .analytics-nav a.active {
        color: #E53935;
        border-bottom: 2px solid #E53935;
        padding-bottom: 8px;
    }

    

    /* ── PAGE ── */
    .analytics-page {
        padding: 44px 0 60px;
        background-color: #f9f9f9;
    }

    .analytics-page h1 {
        font-size: 32px;
        font-weight: 800;
        color: #1a1a1a;
        margin-bottom: 4px;
    }

    /* ── FILTER CARD ── */
    .filter-card {
        background: #ffffff;
        border: 1px solid #e2e2e2;
        border-radius: 14px;
        padding: 22px 24px;
        margin-bottom: 28px;
    }

    .mini-label {
        font-size: 11px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.6px;
        color: #888;
        margin-bottom: 8px;
        display: block;
    }

    .filter-card .form-select {
        border: 1px solid #e2e2e2;
        border-radius: 8px;
        font-size: 14px;
        height: 42px;
        color: #333;
    }

    .filter-card .form-select:focus {
        border-color: #E53935;
        box-shadow: none;
    }

    .btn-apply {
        background: #4B50C7;
        color: #fff;
        border: none;
        border-radius: 8px;
        height: 42px;
        font-weight: 700;
        font-size: 14px;
        width: 100%;
        cursor: pointer;
        transition: background 0.2s;
    }

    .btn-apply:hover {
        background: #3b3fa8;
    }

    /* ── STAT CARDS ── */
    .analytics-card {
        background: #ffffff;
        border: 1px solid #e2e2e2;
        border-radius: 14px;
        padding: 20px 22px;
        height: 100%;
    }

    .stat-number {
        font-size: 30px;
        font-weight: 800;
        color: #1a1a1a;
    }

    /* ── CHART CARDS ── */
    .chart-card {
        background: #ffffff;
        border: 1px solid #e2e2e2;
        border-radius: 14px;
        padding: 28px;
        height: 100%;
    }

    .chart-card h3 {
        font-size: 16px;
        font-weight: 800;
        color: #1a1a1a;
        margin-bottom: 0;
    }

   

    /* Progress bars */
    .ranking-row {
        margin-bottom: 18px;
    }

    .ranking-info {
        display: flex;
        justify-content: space-between;
        font-size: 13px;
        font-weight: 600;
        margin-bottom: 6px;
        color: #1a1a1a;
    }

    .ranking-info span:last-child {
        color: #E53935;
        font-weight: 700;
    }

    .ranking-track {
        height: 7px;
        border-radius: 999px;
        background: #efefef;
        overflow: hidden;
    }

    .ranking-fill {
        height: 100%;
        background: #E53935;
        border-radius: 999px;
    }

    /* ── QUIZ DISTRIBUTION CARD ── */
    .quiz-dist-card {
        background: #ffffff;
        border: 1px solid #e2e2e2;
        border-radius: 14px;
        padding: 28px;
        margin-bottom: 0;
    }

    .quiz-icon-box {
        width: 42px;
        height: 42px;
        background: #e8eaf6;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #4B50C7;
        font-size: 18px;
        flex-shrink: 0;
    }

    .quiz-dist-card h3 {
    font-size: 16px;
    font-weight: 800;
    color: #1a1a1a;
    }

    .score-row {
        display: grid;
        grid-template-columns: 78px minmax(0, 1fr) 72px;
        gap: 14px;
        align-items: center;
        margin-top: 14px;
    }

    .score-range {
        color: #1a1a1a;
        font-size: 13px;
        font-weight: 800;
    }

    .score-count {
        color: #666;
        font-size: 13px;
        font-weight: 700;
        text-align: right;
    }

    .score-track {
        background: #efefef;
        border-radius: 999px;
        height: 10px;
        overflow: hidden;
    }

    .score-fill {
        background: #E53935;
        border-radius: 999px;
        height: 100%;
        min-width: 8px;
    }

    /* ── EXPORT BUTTONS ── */
    .btn-export-csv {
        border: 1.5px solid #ccc;
        background: #fff;
        color: #333;
        font-weight: 600;
        border-radius: 8px;
        padding: 8px 18px;
        font-size: 13px;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        cursor: pointer;
        white-space: nowrap;
    }

    .btn-export-csv:hover {
        border-color: #888;
    }

    .btn-export-pdf {
        background: #E53935;
        color: #fff;
        border: none;
        font-weight: 700;
        border-radius: 8px;
        padding: 8px 18px;
        font-size: 13px;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        cursor: pointer;
        white-space: nowrap;
    }

    .btn-export-pdf:hover {
        background: #c62828;
        color: #fff;
    }

    /* ── FOOTER ── */
    .analytics-footer {
        background: #f3f3f3;
        border-top: 1px solid #e2e2e2;
        padding: 28px 0 16px;
    }

    .analytics-footer .footer-brand {
        color: #E53935;
        font-weight: 800;
        font-size: 18px;
    }


    @media (max-width: 992px) {
        .analytics-nav { display: none; }
    }
</style>

<!-- ── TOPBAR ── -->
<header class="analytics-topbar">
    <div class="container d-flex justify-content-between align-items-center">

        <a href="Dashboard.aspx" class="analytics-brand">
            <img src="<%= ResolveUrl("~/Images/aidify-kit.png") %>"
                 alt="Aidify Logo"
                 class="analytics-logo" />

            <span>Aidify</span>
        </a>

        <nav class="analytics-nav">
                <a href="Dashboard.aspx">Dashboard</a>
                <a href="Users/List.aspx">Users</a>
           
                <a href="Content/ApprovalQueue.aspx">Approvals</a>
                <a href="Analytics.aspx" class="active">Analytics</a>
        </nav>

        <div class="dropdown">

            <a href="#"
               class="analytics-dropdown"
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
<main class="analytics-page">
    <div class="container">

        <!-- Page Header -->
        <div class="row align-items-center mb-4">
            <div class="col-md-8">
                <h1>Analytics &amp; Reports</h1>
                <p class="text-muted mb-0" style="font-size:15px;">
                    Real-time oversight of learner performance and platform trends.
                </p>
            </div>
            <div class="col-md-4 d-flex justify-content-md-end gap-2 mt-3 mt-md-0">
                <a href="Analytics.aspx?export=users_csv" class="btn-export-csv">
                    <i class="bi bi-download"></i> Export Users CSV
                </a>
                <a href="Analytics.aspx?export=admin_report" class="btn-export-pdf" target="_blank">
                    <i class="bi bi-printer"></i> Printable Report
                </a>
            </div>
        </div>

        
        <!-- Stat Cards -->
        <div class="row g-4 mb-4">
            <div class="col-sm-6 col-lg-3">
                <div class="analytics-card">
                    <span class="mini-label">Total Users</span>
                    <div class="d-flex align-items-baseline gap-2">
                        <div class="stat-number" id="anTotalUsers">—</div>
                        <small class="text-muted fw-bold">Live Data</small>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="analytics-card">
                    <span class="mini-label">Active Learners</span>
                    <div class="d-flex align-items-baseline gap-2">
                        <div class="stat-number" id="anActiveLearners">—</div>
                        <small class="text-muted fw-bold">Live Data</small>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="analytics-card">
                    <span class="mini-label">Completion Rate</span>
                    <div class="d-flex align-items-baseline gap-2">
                        <div class="stat-number" id="anCompletionRate">—</div>
                        <small class="text-muted fw-bold">Live Data</small>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="analytics-card">
                    <span class="mini-label">Quiz Attempts</span>
                    <div class="d-flex align-items-baseline gap-2">
                        <div class="stat-number" id="anTotalAttempts">—</div>
                        <small class="text-muted fw-bold">Live Data</small>
                    </div>
                </div>
            </div>
        </div>

<!-- Charts Row -->
<div class="row g-4 mb-4">

    <!-- Performance Trends -->
    <div class="col-lg-8">
        <div class="chart-card">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3>Performance Trends</h3>
                <small class="text-muted fw-bold">Live Platform Data</small>
            </div>

            <canvas id="chartAttempts" height="120"></canvas>
        </div>
    </div>

    <!-- Popular Modules -->
    <div class="col-lg-4">
        <div class="chart-card">
            <h3 class="mb-4">Popular Modules</h3>

            <div id="popularModulesContainer">
                <p class="text-muted small">
                    Loading module enrolment data...
                </p>
            </div>
        </div>
    </div>

</div>

<!-- Quiz Distribution -->
<div class="quiz-dist-card">

    <div class="d-flex align-items-start gap-3 mb-3">
        <div class="quiz-icon-box">
            <i class="bi bi-bar-chart"></i>
        </div>

        <div>
            <h3 class="mb-0">Quiz Score Distribution</h3>
            <small class="text-muted">
                Last assessment cycle
            </small>
        </div>
    </div>

    <div id="scoreDistributionContainer">
        <p class="text-muted small mt-4 mb-0">
            Loading quiz score distribution...
        </p>
    </div>

</div>
  </div>
</main>

<!-- ── FOOTER ── -->
<footer class="analytics-footer">
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

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
    $.ajax({
        type: 'POST', url: 'Analytics.aspx/GetAnalyticsData',
        data: '{}', contentType: 'application/json; charset=utf-8', dataType: 'json',
        success: function (r) {
            var d = r.d;

            // Stat cards
            document.getElementById('anTotalUsers').textContent      = d.totalUsers.toLocaleString();
            document.getElementById('anActiveLearners').textContent  = d.activeLearners.toLocaleString();
            document.getElementById('anTotalAttempts').textContent   = d.totalAttempts.toLocaleString();
            document.getElementById('anCompletionRate').textContent  = d.completionRate + '%';

            // Bar chart — quiz attempts per module (top 7)
            var labels = [], values = [];
            for (var i = 0; i < d.attemptsByModule.length; i++) {
                labels.push(d.attemptsByModule[i].title);
                values.push(d.attemptsByModule[i].attempts);
            }
            new Chart(document.getElementById('chartAttempts'), {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Quiz Attempts',
                        data: values,
                        backgroundColor: 'rgba(229,57,53,0.75)',
                        borderRadius: 6
                    }]
                },
                options: {
                    responsive: true,
                    plugins: { legend: { display: false } },
                    scales: { y: { beginAtZero: true, ticks: { precision: 0 } } }
                }
            });

            // Popular Modules ranking bars
            var container = document.getElementById('popularModulesContainer');

            if (!d.popularModules || d.popularModules.length === 0) {
                container.innerHTML =
                    '<p class="text-muted small">No enrolment data yet.</p>';
            }
            else {
                var maxEnrol = d.popularModules[0].enrolments || 1;
                var html = '';

                for (var j = 0; j < d.popularModules.length; j++) {
                    var m = d.popularModules[j];
                    var pct = Math.round(m.enrolments / maxEnrol * 100);

                    html +=
                        '<div class="ranking-row">' +
                        '<div class="ranking-info">' +
                        '<span>' + esc(m.title) + '</span>' +
                        '<span>' + m.enrolments + ' enrolled</span>' +
                        '</div>' +
                        '<div class="ranking-track">' +
                        '<div class="ranking-fill" data-width="' + pct + '" style="width:0%"></div>' +
                        '</div>' +
                        '</div>';
                }

                container.innerHTML = html;

                // Animate bars
                container.querySelectorAll('.ranking-fill[data-width]').forEach(function (el) {
                    el.style.width = el.getAttribute('data-width') + '%';
                });
            }

            var scoreBox = document.getElementById('scoreDistributionContainer');

            if (!d.scoreDistribution || d.scoreDistribution.length === 0 || d.totalAttempts === 0) {
                scoreBox.innerHTML =
                    '<p class="text-muted small mt-4 mb-0">' +
                    'No quiz attempts recorded yet. Score distribution will appear once learners submit quizzes.' +
                    '</p>';
            }
            else {
                var maxScoreCount = 1;

                for (var k = 0; k < d.scoreDistribution.length; k++) {
                    if (d.scoreDistribution[k].total > maxScoreCount) {
                        maxScoreCount = d.scoreDistribution[k].total;
                    }
                }

                var scoreHtml = '<div class="score-distribution-list">';

                for (var s = 0; s < d.scoreDistribution.length; s++) {
                    var item = d.scoreDistribution[s];
                    var width = Math.max(6, Math.round(item.total / maxScoreCount * 100));

                    scoreHtml +=
                        '<div class="score-row">' +
                        '<div class="score-range">' + esc(item.range) + '</div>' +
                        '<div class="score-track">' +
                        '<div class="score-fill" style="width:' + width + '%;"></div>' +
                        '</div>' +
                        '<div class="score-count">' + item.total + ' attempt' + (item.total === 1 ? '' : 's') + '</div>' +
                        '</div>';
                }

                scoreHtml += '</div>';

                scoreBox.innerHTML = scoreHtml;
            }
        },
        error: function () {
            console.warn('Analytics data failed to load.');
        }
    });
});
function esc(s) {
    return String(s || '').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
}
</script>

</asp:Content>
