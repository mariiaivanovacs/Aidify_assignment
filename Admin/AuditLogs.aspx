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

    .audit-logo {
        width: 42px;
        height: 42px;
        object-fit: contain;
    }

    .audit-brand {
        color: #E53935;
        font-size: 26px;
        font-weight: 800;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .audit-dropdown {
        text-decoration: none;
        color: #1f2937;
        font-weight: 700;
        font-size: 18px;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .audit-dropdown:hover {
        color: #E53935;
    }

    .dropdown-menu {
        min-width: 180px;
        border-radius: 12px;
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

    .page-btn.ellipsis {
        border: none;
        background: transparent;
        cursor: default;
        color: #888;
    }

    .page-btn.ellipsis:hover {
        border: none;
        color: #888;
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

    /* ── ERROR ALERT ── */
    .audit-error-alert {
        background: #f8d7da;
        color: #842029;
        border: 1px solid #f5c2c7;
        border-radius: 10px;
        padding: 12px 16px;
        font-size: 14px;
        display: none;
        margin-bottom: 16px;
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
            <img src="<%= ResolveUrl("~/Images/aidify-kit.png") %>"
                 alt="Aidify Logo"
                 class="audit-logo" />

            <span>Aidify</span>
        </a>

        <nav class="audit-nav">
            <a href="Dashboard.aspx">Dashboard</a>
            <a href="Users/List.aspx">Users</a>
            <a href="Content/ApprovalQueue.aspx">Approvals</a>
            <a href="Analytics.aspx">Analytics</a>
            <a href="AuditLogs.aspx" class="active">Audit Logs</a>
        </nav>

        <div class="dropdown">

            <a href="#"
               class="audit-dropdown"
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
<main class="audit-page">
    <div class="container">

        <div class="mb-4">
            <h1>Audit Logs</h1>
            <p class="text-muted" style="font-size:15px;">
                Security monitoring and system-wide activity tracking for administrative oversight.
            </p>
        </div>

        <!-- Error alert (shown on AJAX failure or session expiry) -->
        <div id="auditErrorAlert" class="audit-error-alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            <span id="auditErrorMsg">Failed to load audit logs. Please refresh the page or log in again.</span>
        </div>

        <div class="audit-filter-card">
            <div class="row g-3 align-items-end">

                <div class="col-md-5">
                    <label class="form-label">Search Activity</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                        <input type="text" id="txtSearch" class="form-control"
                               placeholder="Search user, action, or IP address..." />
                    </div>
                </div>

                <div class="col-md-2">
                    <label class="form-label">Action Type</label>
                    <select id="ddlAction" class="form-select">
                        <option value="">All Actions</option>
                        <option value="CreateUser">CreateUser</option>
                        <option value="UpdateUser">UpdateUser</option>
                        <option value="EnableUser">EnableUser</option>
                        <option value="DisableUser">DisableUser</option>
                        <option value="ApproveModule">ApproveModule</option>
                        <option value="RejectModule">RejectModule</option>
                        <option value="ForceResetPassword">ForceResetPassword</option>
                    </select>
                </div>

                <div class="col-md-2">
                    <label class="form-label">Date Range</label>
                    <select id="ddlDateRange" class="form-select">
                        <option value="24">Last 24 Hours</option>
                        <option value="168" selected>Last 7 Days</option>
                        <option value="720">Last 30 Days</option>
                        <option value="0">All Time</option>
                    </select>
                </div>

                <div class="col-md-3">
                    <button type="button" class="btn-apply-filter" onclick="loadLogs(1)">
                        <i class="bi bi-funnel"></i> Apply
                    </button>
                </div>

            </div>
        </div>

        <div class="audit-card mb-4">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="audit-card-header">
                        <tr>
                            <th class="ps-4 py-3">Timestamp</th>
                            <th>User / Actor</th>
                            <th>Action</th>
                            <th>Target</th>
                            <th>IP Address</th>
                            <th class="text-end pe-4">Log ID</th>
                        </tr>
                    </thead>
                    <tbody id="auditTableBody">
                        <tr><td colspan="6" class="text-center text-muted py-4">Loading audit logs…</td></tr>
                    </tbody>
                </table>
            </div>

            <div class="pagination-row">
                <div id="paginationInfo" class="small text-muted">Loading results...</div>
                <div id="paginationBtns" class="pagination-btns"></div>
            </div>
        </div>

        <div class="row g-4">

            <div class="col-md-4">
                <div class="stat-card">
                    <h6 class="fw-bold mb-1">Failed Logins</h6>
                    <small class="text-muted">Last 24 Hours</small>
                    <div id="statFailedLogins" class="h2 fw-bold text-danger mt-3">—</div>
                    <small class="text-muted">Failed login attempts today</small>
                </div>
            </div>

            <div class="col-md-4">
                <div class="stat-card">
                    <h6 class="fw-bold mb-1">Total Actions</h6>
                    <small class="text-muted">Last 24 Hours</small>
                    <div id="statTotalActions" class="h2 fw-bold mt-3">—</div>
                    <small class="text-muted">All recorded audit events</small>
                </div>
            </div>

            <div class="col-md-4">
                <div class="stat-card">
                    <h6 class="fw-bold mb-1">Password Resets</h6>
                    <small class="text-muted">Last 24 Hours</small>
                    <div id="statResets" class="h2 fw-bold mt-3">—</div>
                    <small class="text-muted">Admin-forced resets today</small>
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
        </div>
        <hr class="mt-1 mb-2" />
        <p class="text-muted small mb-0 text-center">© 2026 Aidify Admin Panel. Educational use only.</p>
    </div>
</footer>

<script type="text/javascript">

    var currentPage = 1;
    var pageSize = 10;

    $(document).ready(function () {
        loadLogs(1);
        loadStats();

        // Search fires when user types
        $('#txtSearch').on('keyup', function () {
            loadLogs(1);
        });
    });

    function showError(msg) {
        $('#auditErrorMsg').text(msg || 'An unexpected error occurred. Please refresh the page.');
        $('#auditErrorAlert').show();
    }

    function hideError() {
        $('#auditErrorAlert').hide();
    }

    function loadLogs(page) {

        currentPage = page;
        hideError();

        $.ajax({
            type: 'POST',
            url: 'AuditLogs.aspx/GetAuditLogs',
            data: JSON.stringify({
                search: $('#txtSearch').val(),
                action: $('#ddlAction').val(),
                withinHours: parseInt($('#ddlDateRange').val()) || 0,
                page: page,
                pageSize: pageSize
            }),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (r) {

                // Guard against null (e.g. session expired / unauthorised)
                if (!r || !r.d) {
                    $('#auditTableBody').html(
                        '<tr><td colspan="6" class="text-center text-muted py-4">Session expired. Please log in again.</td></tr>'
                    );
                    $('#paginationInfo').text('');
                    $('#paginationBtns').html('');
                    showError('Your session has expired. Please log in again.');
                    return;
                }

                var result = r.d;
                var logs = result.logs;
                var total = result.totalCount;
                var body = document.getElementById('auditTableBody');

                if (!logs || logs.length === 0) {
                    body.innerHTML =
                        '<tr><td colspan="6" class="text-center text-muted py-4">No audit logs found.</td></tr>';
                    $('#paginationInfo').text('No results found');
                    $('#paginationBtns').html('');
                    return;
                }

                var html = '';

                for (var i = 0; i < logs.length; i++) {
                    var l = logs[i];

                    // Support both /Date(ms)/ (ASP.NET JSON) and ISO 8601 strings
                    var rawTs = l.Timestamp || '';
                    var ms = parseInt(rawTs.replace('/Date(', '').replace(')/', ''));
                    var dt = isNaN(ms) ? new Date(rawTs) : new Date(ms);

                    html +=
                        '<tr>' +
                        '<td class="ps-4 py-3">' +
                        '<div class="fw-medium">' + dt.toLocaleDateString('en-MY') + '</div>' +
                        '<small class="text-muted">' + dt.toLocaleTimeString('en-MY') + '</small>' +
                        '</td>' +
                        '<td>' +
                        '<div class="d-flex align-items-center gap-2">' +
                        '<div class="audit-avatar" style="background:#ffe2de;color:#93000a;">' + esc(l.ActorInitials || '?') + '</div>' +
                        '<span class="fw-medium">' + esc(l.ActorName || 'Unknown') + '</span>' +
                        '</div>' +
                        '</td>' +
                        '<td>' + esc(l.Action) + '</td>' +
                        '<td><span class="badge-success-custom">' +
                        esc(l.TargetEntity || '—') +
                        (l.TargetId && l.TargetId !== 0 ? ' #' + l.TargetId : '') +
                        '</span></td>' +
                        '<td class="text-muted">' + esc(l.IPAddress || '—') + '</td>' +
                        '<td class="text-end pe-4"><span class="text-muted small">#' + l.AuditId + '</span></td>' +
                        '</tr>';
                }

                body.innerHTML = html;

                var from = ((page - 1) * pageSize) + 1;
                var to = Math.min(page * pageSize, total);

                $('#paginationInfo').text(
                    'Showing ' + from + ' to ' + to + ' of ' + total + ' result(s)'
                );

                buildPagination(page, Math.ceil(total / pageSize));
            },
            error: function (xhr) {
                $('#auditTableBody').html(
                    '<tr><td colspan="6" class="text-center text-muted py-4">Failed to load audit logs.</td></tr>'
                );
                $('#paginationInfo').text('');
                $('#paginationBtns').html('');
                showError('Could not retrieve audit logs (HTTP ' + xhr.status + '). Please try again.');
            }
        });
    }

    // Pagination
    function buildPagination(current, totalPages) {

        if (totalPages <= 1) {
            $('#paginationBtns').html('');
            return;
        }

        var html = '';

        html += '<a class="page-btn arrow ' + (current === 1 ? 'disabled' : '') + '" ' +
            'onclick="if(' + current + '>1) loadLogs(' + (current - 1) + ')">&lsaquo;</a>';

        for (var i = 1; i <= totalPages; i++) {
            html += '<a class="page-btn ' + (i === current ? 'active' : '') +
                '" onclick="loadLogs(' + i + ')">' + i + '</a>';
        }

        html += '<a class="page-btn arrow ' + (current === totalPages ? 'disabled' : '') + '" ' +
            'onclick="if(' + current + '<' + totalPages + ') loadLogs(' + (current + 1) + ')">&rsaquo;</a>';

        $('#paginationBtns').html(html);
    }

    

    function loadStats() {
        $.ajax({
            type: 'POST',
            url: 'AuditLogs.aspx/GetAuditStats',
            data: '{}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (r) {
                if (!r || !r.d) {
                    $('#statFailedLogins, #statTotalActions, #statResets').text('N/A');
                    return;
                }
                var s = r.d;
                $('#statFailedLogins').text(s.FailedLogins);
                $('#statTotalActions').text(s.TotalActions);
                $('#statResets').text(s.PasswordResets);
            },
            error: function () {
                $('#statFailedLogins, #statTotalActions, #statResets').text('—');
            }
        });
    }

    // Encodes &, <, >, " and ' to prevent XSS in innerHTML contexts
    function esc(s) {
        return String(s || '')
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;');
    }

</script>

</asp:Content>
