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

    .analytics-brand {
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

    /* Bar chart */
    .fake-bar-chart {
        height: 220px;
        display: flex;
        align-items: flex-end;
        gap: 10px;
        margin-bottom: 12px;
    }

    .fake-bar-chart .bar {
        flex: 1;
        background: rgba(229, 57, 53, 0.22);
        border-radius: 6px 6px 0 0;
    }

    .chart-labels {
        display: flex;
        justify-content: space-between;
        font-size: 12px;
        font-weight: 700;
        color: #999;
        padding: 0 2px;
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

    .dist-bar-wrap {
        height: 120px;
        display: flex;
        align-items: flex-end;
        gap: 16px;
        margin: 24px 0 10px;
    }

    .dist-bar-wrap .dbar {
        flex: 1;
        border-radius: 6px 6px 0 0;
    }

    .dbar-grey {
        background: #e2e2e2;
    }

    .dbar-red {
        background: #b71c1c;
    }

    .dist-labels {
        display: flex;
        justify-content: space-between;
        font-size: 12px;
        font-weight: 700;
        color: #888;
        padding: 0 2px;
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

    .analytics-footer a {
        color: #555;
        text-decoration: none;
        font-size: 13px;
    }

    .analytics-footer a:hover {
        color: #E53935;
    }

    @media (max-width: 992px) {
        .analytics-nav { display: none; }
    }
</style>

<!-- ── TOPBAR ── -->
<header class="analytics-topbar">
    <div class="container d-flex justify-content-between align-items-center">

        <a href="Dashboard.aspx" class="analytics-brand">
            Aidify
            <span class="admin-badge">ADMIN</span>
        </a>

        <nav class="analytics-nav">
                <a href="Dashboard.aspx">Dashboard</a>
                <a href="Users/List.aspx">Users</a>
                <a href="Roles.aspx">Roles</a>
                <a href="Content/ManagePublicPages.aspx">Public Pages</a>
                <a href="Content/ApprovalQueue.aspx">Approvals</a>
                <a href="Analytics.aspx" class="active">Analytics</a>
        </nav>

        <div class="d-flex align-items-center gap-3">
            <i class="bi bi-bell fs-5"></i>
            <div class="text-end d-none d-md-block">
                <div class="fw-bold" style="font-size:14px;">Dr. Sarah Chen</div>
                <small class="text-muted">System Administrator</small>
            </div>
            <div class="admin-avatar">A</div>
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
                <button class="btn-export-csv">
                    <i class="bi bi-download"></i> Export CSV
                </button>
                <button class="btn-export-pdf">
                    <i class="bi bi-file-earmark-pdf"></i> Export PDF
                </button>
            </div>
        </div>

        <!-- Filter Card -->
        <div class="filter-card">
            <div class="row g-3">
                <div class="col-md-3">
                    <span class="mini-label">Date Range</span>
                    <select class="form-select">
                        <option>Last 30 Days</option>
                        <option>Last 3 Months</option>
                        <option>Year to Date</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <span class="mini-label">Course Module</span>
                    <select class="form-select">
                        <option>All Modules</option>
                        <option>Basic CPR</option>
                        <option>First Aid Fundamentals</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <span class="mini-label">User Group</span>
                    <select class="form-select">
                        <option>General Public</option>
                        <option>Healthcare Staff</option>
                        <option>Corporate Teams</option>
                    </select>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button class="btn-apply">Apply Filters</button>
                </div>
            </div>
        </div>

        <!-- Stat Cards -->
        <div class="row g-4 mb-4">
            <div class="col-sm-6 col-lg-3">
                <div class="analytics-card">
                    <span class="mini-label">Total Enrollments</span>
                    <div class="d-flex align-items-baseline gap-2">
                        <div class="stat-number">12,842</div>
                        <small class="text-danger fw-bold">↑ 12%</small>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="analytics-card">
                    <span class="mini-label">Avg. Quiz Score</span>
                    <div class="d-flex align-items-baseline gap-2">
                        <div class="stat-number">86.4%</div>
                        <small class="text-danger fw-bold">↑ 3%</small>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="analytics-card">
                    <span class="mini-label">Completion Rate</span>
                    <div class="d-flex align-items-baseline gap-2">
                        <div class="stat-number">74.2%</div>
                        <small class="text-muted fw-bold">Steady</small>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="analytics-card">
                    <span class="mini-label">Active Learners</span>
                    <div class="d-flex align-items-baseline gap-2">
                        <div class="stat-number">2,105</div>
                        <small class="text-danger fw-bold">↑ 8%</small>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts Row -->
        <div class="row g-4 mb-4">

            <!-- Bar Chart -->
            <div class="col-lg-8">
                <div class="chart-card">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3>Performance Trends</h3>
                        <small class="text-muted fw-bold">2024 Performance</small>
                    </div>
                    <div class="fake-bar-chart">
                        <div class="bar" style="height:60%;"></div>
                        <div class="bar" style="height:75%;"></div>
                        <div class="bar" style="height:85%;"></div>
                        <div class="bar" style="height:70%;"></div>
                        <div class="bar" style="height:92%;"></div>
                        <div class="bar" style="height:80%;"></div>
                        <div class="bar" style="height:88%;"></div>
                    </div>
                    <div class="chart-labels">
                        <span>JAN</span>
                        <span>FEB</span>
                        <span>MAR</span>
                        <span>APR</span>
                        <span>MAY</span>
                        <span>JUN</span>
                        <span>JUL</span>
                    </div>
                </div>
            </div>

            <!-- Popular Modules -->
            <div class="col-lg-4">
                <div class="chart-card">
                    <h3 class="mb-4">Popular Modules</h3>

                    <div class="ranking-row">
                        <div class="ranking-info">
                            <span>Basic Life Support</span>
                            <span>4.8k students</span>
                        </div>
                        <div class="ranking-track">
                            <div class="ranking-fill" style="width:92%;"></div>
                        </div>
                    </div>

                    <div class="ranking-row">
                        <div class="ranking-info">
                            <span>Choking Emergency</span>
                            <span>3.2k students</span>
                        </div>
                        <div class="ranking-track">
                            <div class="ranking-fill" style="width:65%;"></div>
                        </div>
                    </div>

                    <div class="ranking-row">
                        <div class="ranking-info">
                            <span>Severe Bleeding</span>
                            <span>2.9k students</span>
                        </div>
                        <div class="ranking-track">
                            <div class="ranking-fill" style="width:58%;"></div>
                        </div>
                    </div>

                    <div class="ranking-row" style="margin-bottom:24px;">
                        <div class="ranking-info">
                            <span>Burns and Scalds</span>
                            <span>1.5k students</span>
                        </div>
                        <div class="ranking-track">
                            <div class="ranking-fill" style="width:30%;"></div>
                        </div>
                    </div>

                    <button class="btn btn-outline-secondary w-100" style="font-size:13px;">
                        View Full Ranking
                    </button>
                </div>
            </div>

        </div>

        <!-- Quiz Score Distribution -->
        <div class="quiz-dist-card">
            <div class="d-flex align-items-center gap-3 mb-1">
                <div class="quiz-icon-box">
                    <i class="bi bi-clipboard-data"></i>
                </div>
                <div>
                    <h3 style="font-size:17px;font-weight:800;margin:0;color:#1a1a1a;">
                        Quiz Score Distribution
                    </h3>
                    <small class="text-muted">Last assessment cycle</small>
                </div>
            </div>

            <div class="dist-bar-wrap">
                <div class="dbar dbar-grey" style="height:25%;"></div>
                <div class="dbar dbar-grey" style="height:35%;"></div>
                <div class="dbar dbar-grey" style="height:45%;"></div>
                <div class="dbar dbar-grey" style="height:55%;"></div>
                <div class="dbar dbar-red"  style="height:100%;"></div>
                <div class="dbar dbar-grey" style="height:40%;"></div>
            </div>

            <div class="dist-labels">
                <span>&lt;50%</span>
                <span>70%</span>
                <span>85%</span>
                <span>100%</span>
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

</asp:Content>