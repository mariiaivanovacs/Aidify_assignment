<%@ Page Title="Audit Logs" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AuditLogs.aspx.cs" Inherits="Aidify_assigment.Admin.AuditLogs" %>

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
    .audit-topbar {
        height: 80px;
        background: #ffffff;
        border-bottom: 1px solid #e2e2e2;
        display: flex;
        align-items: center;
        position: sticky;
        top: 0;
        z-index: 50;
    }

    .audit-brand {
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

    .audit-nav a {
        color: #3d2a28;
        text-decoration: none;
        margin-left: 22px;
        font-weight: 600;
        font-size: 14px;
    }

    .audit-nav a.active {
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
    .audit-page {
        padding: 44px 0 60px;
        background-color: #f9f9f9;
    }

    .audit-page h1 {
        font-size: 32px;
        font-weight: 800;
        color: #1a1a1a;
        margin-bottom: 4px;
    }

    /* ── FILTER CARD ── */
    .audit-filter-card {
        background: #ffffff;
        border: 1px solid #e2e2e2;
        border-radius: 14px;
        padding: 22px 24px;
        margin-bottom: 24px;
    }

    .audit-filter-card .form-label {
        font-size: 11px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.6px;
        color: #888;
        margin-bottom: 8px;
    }

    .audit-filter-card .input-group-text {
        background: #fff;
        border-right: none;
        border-color: #e2e2e2;
        color: #888;
    }

    .audit-filter-card .form-control {
        border-left: none;
        border-color: #e2e2e2;
        font-size: 14px;
        height: 42px;
    }

    .audit-filter-card .form-control:focus {
        border-color: #E53935;
        box-shadow: none;
    }

    .audit-filter-card .input-group:focus-within .input-group-text {
        border-color: #E53935;
    }

    .audit-filter-card .form-select {
        border: 1px solid #e2e2e2;
        border-radius: 8px;
        font-size: 14px;
        height: 42px;
        color: #333;
    }

    .audit-filter-card .form-select:focus {
        border-color: #E53935;
        box-shadow: none;
    }

    .btn-apply-filter {
        background: #E53935;
        color: #fff;
        border: none;
        border-radius: 8px;
        height: 42px;
        font-weight: 700;
        font-size: 14px;
        width: 100%;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        transition: background 0.2s;
    }

    .btn-apply-filter:hover {
        background: #c62828;
    }

    /* ── TABLE CARD ── */
    .audit-card {
        background: white;
        border: 1px solid #e2e2e2;
        border-radius: 16px;
        overflow: hidden;
    }

    .audit-card-header {
        background: #f3f3f3;
    }

    .audit-card thead th {
        font-size: 13px;
        font-weight: 700;
        color: #555;
        border-bottom: 1px solid #e2e2e2;
        padding-top: 14px;
        padding-bottom: 14px;
    }

    .audit-card tbody tr {
        border-bottom: 1px solid #f0f0f0;
    }

    .audit-card tbody tr:last-child {
        border-bottom: none;
    }

    .audit-card tbody tr:hover {
        background-color: #fafafa;
    }

    /* ── AVATAR ── */
    .audit-avatar {
        width: 34px;
        height: 34px;
        border-radius: 50%;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 12px;
        font-weight: 700;
        flex-shrink: 0;
    }

    /* ── BADGES ── */
    .badge-success-custom {
        background: #d1e7dd;
        color: #0f5132;
        font-size: 12px;
        font-weight: 600;
        padding: 5px 12px;
        border-radius: 20px;
    }

    .badge-danger-custom {
        background: #f8d7da;
        color: #842029;
        font-size: 12px;
        font-weight: 600;
        padding: 5px 12px;
        border-radius: 20px;
    }

    .badge-warning-custom {
        background: #fff3cd;
        color: #664d03;
        font-size: 12px;
        font-weight: 600;
        padding: 5px 12px;
        border-radius: 20px;
    }

    /* ── PAGINATION ── */
    .pagination-row {
        background: #f9f9f9;
        border-top: 1px solid #e2e2e2;
        padding: 12px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .pagination-btns {
        display: flex;
        align-items: center;
        gap: 4px;
    }

    .page-btn {
        width: 34px;
        height: 34px;
        border-radius: 8px;
        border: 1px solid #e2e2e2;
        background: #fff;
        color: #444;
        font-weight: 600;
        font-size: 13px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        text-decoration: none;
        transition: 0.15s;
    }

    .page-btn:hover {
        border-color: #E53935;
        color: #E53935;
    }

    .page-btn.active {
        background: #E53935;
        color: #fff;
        border-color: #E53935;
    }

    .page-btn.arrow {
        color: #888;
    }

    .page-btn.arrow:hover {
        color: #E53935;
        border-color: #E53935;
    }

    /* ── STAT CARDS ── */
    .stat-card {
        background: white;
        border: 1px solid #e2e2e2;
        border-radius: 16px;
        padding: 24px;
        height: 100%;
    }

    .stat-card .stat-icon-box {
        width: 40px;
        height: 40px;
        border-radius: 10px;
        background: #f3f3f3;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 17px;
        flex-shrink: 0;
    }

    /* ── FOOTER ── */
    .audit-footer {
        background: #f3f3f3;
        border-top: 1px solid #e2e2e2;
        padding: 28px 0 16px;
    }

    .audit-footer .footer-brand {
        color: #E53935;
        font-weight: 800;
        font-size: 18px;
    }

    .audit-footer a {
        color: #555;
        text-decoration: none;
        font-size: 13px;
    }

    .audit-footer a:hover {
        color: #E53935;
    }

    @media (max-width: 992px) {
        .audit-nav { display: none; }
    }
</style>

<!-- ── TOPBAR ── -->
<header class="audit-topbar">
    <div class="container d-flex justify-content-between align-items-center">

        <a href="Dashboard.aspx" class="audit-brand">
            Aidify
            <span class="admin-badge">ADMIN</span>
        </a>

        <nav class="audit-nav">
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
                <div class="fw-bold" style="font-size:14px;">Dr. Sarah Chen</div>
                <small class="text-muted">System Administrator</small>
            </div>
            <div class="admin-avatar">A</div>
        </div>

    </div>
</header>

<!-- ── MAIN ── -->
<main class="audit-page">
    <div class="container">

        <!-- Page Header -->
        <div class="mb-4">
            <h1>Audit Logs</h1>
            <p class="text-muted" style="font-size:15px;">
                Security monitoring and system-wide activity tracking for administrative oversight.
            </p>
        </div>

        <!-- Filter Card -->
        <div class="audit-filter-card">
            <div class="row g-3 align-items-end">

                <div class="col-md-5">
                    <label class="form-label">Search Activity</label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-search"></i>
                        </span>
                        <input type="text"
                               class="form-control"
                               placeholder="Search User ID, Action, or IP Address..." />
                    </div>
                </div>

                <div class="col-md-2">
                    <label class="form-label">Action Type</label>
                    <select class="form-select">
                        <option>All Actions</option>
                        <option>User Login</option>
                        <option>Module Update</option>
                        <option>Security Alert</option>
                    </select>
                </div>

                <div class="col-md-2">
                    <label class="form-label">Date Range</label>
                    <select class="form-select">
                        <option>Last 24 Hours</option>
                        <option>Last 7 Days</option>
                        <option>Last 30 Days</option>
                    </select>
                </div>

                <div class="col-md-3">
                    <button class="btn-apply-filter">
                        <i class="bi bi-funnel"></i> Apply
                    </button>
                </div>

            </div>
        </div>

        <!-- Audit Table -->
        <div class="audit-card mb-4">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">

                    <thead class="audit-card-header">
                        <tr>
                            <th class="ps-4 py-3">Timestamp</th>
                            <th>User ID / Actor</th>
                            <th>Action</th>
                            <th>Result</th>
                            <th>Origin</th>
                            <th class="text-end pe-4">Details</th>
                        </tr>
                    </thead>

                    <tbody>

                        <tr>
                            <td class="ps-4 py-3">
                                <div class="fw-medium">2026-11-20</div>
                                <small class="text-muted">14:22:05 UTC</small>
                            </td>
                            <td>
                                <div class="d-flex align-items-center gap-2">
                                    <div class="audit-avatar" style="background:#959efd;color:#27308a;">JD</div>
                                    <span class="fw-medium">john_doe_99</span>
                                </div>
                            </td>
                            <td>Module Update</td>
                            <td><span class="badge-success-custom">Success</span></td>
                            <td class="text-muted">192.168.1.1</td>
                            <td class="text-end pe-4">
                                <a href="#" class="text-danger fw-semibold text-decoration-none">View JSON</a>
                            </td>
                        </tr>

                        <tr>
                            <td class="ps-4 py-3">
                                <div class="fw-medium">2026-11-20</div>
                                <small class="text-muted">14:18:12 UTC</small>
                            </td>
                            <td>
                                <div class="d-flex align-items-center gap-2">
                                    <div class="audit-avatar" style="background:#ffdad6;color:#93000a;">SA</div>
                                    <span class="fw-medium">sys_admin</span>
                                </div>
                            </td>
                            <td>Security Config</td>
                            <td><span class="badge-danger-custom">Failed</span></td>
                            <td class="text-muted">45.23.1.88</td>
                            <td class="text-end pe-4">
                                <a href="#" class="text-danger fw-semibold text-decoration-none">View Error</a>
                            </td>
                        </tr>

                        <tr>
                            <td class="ps-4 py-3">
                                <div class="fw-medium">2026-11-20</div>
                                <small class="text-muted">13:55:40 UTC</small>
                            </td>
                            <td>
                                <div class="d-flex align-items-center gap-2">
                                    <div class="audit-avatar" style="background:#d8f3e7;color:#0a6640;">MK</div>
                                    <span class="fw-medium">m_kingston</span>
                                </div>
                            </td>
                            <td>User Login</td>
                            <td><span class="badge-success-custom">Success</span></td>
                            <td class="text-muted">210.12.94.3</td>
                            <td class="text-end pe-4">
                                <a href="#" class="text-danger fw-semibold text-decoration-none">View Session</a>
                            </td>
                        </tr>

                    </tbody>
                </table>
            </div>

            <!-- Pagination row -->
            <div class="pagination-row">
                <div class="small text-muted">Showing 1 to 25 of 1,204 results</div>
                <div class="pagination-btns">
                    <a class="page-btn arrow">&lsaquo;</a>
                    <a class="page-btn active">1</a>
                    <a class="page-btn">2</a>
                    <a class="page-btn">3</a>
                    <a class="page-btn arrow">&rsaquo;</a>
                </div>
            </div>
        </div>

        <!-- Stat Cards -->
        <div class="row g-4">

            <div class="col-md-4">
                <div class="stat-card">
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div class="stat-icon-box text-danger">
                            <i class="bi bi-exclamation-triangle"></i>
                        </div>
                        <div>
                            <h6 class="fw-bold mb-0">Failed Logins</h6>
                            <small class="text-muted">Last 24 Hours</small>
                        </div>
                    </div>
                    <div class="h2 fw-bold text-danger mb-1">12</div>
                    <small class="text-danger">↑ 8% increase from yesterday</small>
                </div>
            </div>

            <div class="col-md-4">
                <div class="stat-card">
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div class="stat-icon-box" style="color:#4B50C7;">
                            <i class="bi bi-shield-lock"></i>
                        </div>
                        <div>
                            <h6 class="fw-bold mb-0">Privileged Access</h6>
                            <small class="text-muted">Active Sessions</small>
                        </div>
                    </div>
                    <div class="h2 fw-bold mb-1">3</div>
                    <small class="text-success">All verified identities</small>
                </div>
            </div>

            <div class="col-md-4">
                <div class="stat-card">
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div class="stat-icon-box" style="color:#0ea5e9;">
                            <i class="bi bi-database"></i>
                        </div>
                        <div>
                            <h6 class="fw-bold mb-0">Data Integrity</h6>
                            <small class="text-muted">System Status</small>
                        </div>
                    </div>
                    <div class="h2 fw-bold mb-1">100%</div>
                    <small class="text-success">Secure &amp; Consistent</small>
                </div>
            </div>

        </div>

    </div>
</main>

<!-- ── FOOTER ── -->
<footer class="audit-footer">
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
