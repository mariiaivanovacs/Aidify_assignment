<%@ Page Title="User Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Aidify_assigment.Admin.Users.List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .aidify-navbar,
        .aidify-footer {
            display: none !important;
        }

        body {
            background-color: #f9f9f9;
        }

        .user-management-page {
            background-color: #f9f9f9;
            padding: 50px 0 70px;
        }

        .um-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            color: #E53935;
            font-weight: 800;
            font-size: 26px;
            text-decoration: none;
        }

        .um-logo {
            width: 42px;
            height: 42px;
            object-fit: contain;
        }

        .um-topbar {
            height: 78px;
            background: white;
            border-bottom: 1px solid #e2e2e2;
            display: flex;
            align-items: center;
        }

        .um-nav a {
            color: #3d2a28;
            text-decoration: none;
            margin-left: 22px;
            font-weight: 600;
            font-size: 14px;
        }

        .um-nav a.active {
            color: #E53935;
            border-bottom: 2px solid #E53935;
            padding-bottom: 8px;
        }

        .stat-card,
        .table-box,
        .security-card {
            background: white;
            border: 1px solid #e2e2e2;
            border-radius: 16px;
        }

        .stat-card {
            padding: 24px;
        }

        .stat-card h3 {
            font-weight: 800;
            margin: 6px 0;
        }

        .role-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
        }

        .role-instructor {
            background: #e0e0ff;
            color: #000767;
        }

        .role-learner {
            background: #cfe6f2;
            color: #071e27;
        }

        .role-admin {
            background: #ffdad6;
            color: #410002;
        }

        .status-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 8px;
        }

        .avatar-circle {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            margin-right: 12px;
        }

        .avatar-circle img {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            object-fit: cover;
        }
        .um-footer {
            background: #eeeeee;
            border-top: 1px solid #dcdcdc;
            padding: 36px 0 22px;
        }

        .um-footer h5 {
            color: #E53935;
            font-weight: 800;
        }

        .admin-dropdown-toggle {
            text-decoration: none;
            color: #1f2937;
            font-weight: 700;
            font-size: 18px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .admin-dropdown-toggle:hover {
            color: #E53935;
        }

        .dropdown-menu {
            min-width: 180px;
            border-radius: 12px;
            border: 1px solid #eee;
        }

        @media (max-width: 768px) {
            .um-nav {
                display: none;
            }
        }
    </style>

    <header class="um-topbar">
        <div class="container d-flex justify-content-between align-items-center">

            <a href="../Dashboard.aspx" class="um-brand">

                <img src="../../Images/aidify-kit.png"
                     alt="Aidify Logo"
                     class="um-logo" />

                <span>Aidify</span>

            </a>

            <nav class="um-nav">
                <a href="../Dashboard.aspx">Dashboard</a>
                <a href="List.aspx" class="active">Users</a>
                <a href="../Content/ApprovalQueue.aspx">Approvals</a>
                <a href="../Analytics.aspx">Analytics</a>
            </nav>

            <div class="admin-profile dropdown">

                <a href="../../Account/Profile.aspx"
                   class="admin-dropdown-toggle"
                   data-bs-toggle="dropdown"
                   aria-expanded="false">

                    Admin
                    <i class="bi bi-chevron-down"></i>

                </a>

                <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                    <li>
                        <a class="dropdown-item" href="../../Account/Profile.aspx">
                            <i class="bi bi-person me-2"></i> Profile
                        </a>
                    </li>


                    <li>
                        <a class="dropdown-item text-danger" href="../../Auth/Logout.aspx">
                            <i class="bi bi-box-arrow-right me-2"></i> Logout
                        </a>
                    </li>
                </ul>
            </div>

        </div>
</header>

    <main class="user-management-page">
        <div class="container">

            <div class="row align-items-end mb-5">
                <div class="col-md-8">
                    <div class="text-muted small mb-2">Admin / User Management</div>
                    <h1 class="fw-bold display-6">User Management</h1>
                    <p class="text-muted fs-5 mb-0">
                        Manage system access, roles, and status for all learners and instructors within the Aidify platform.
                    </p>
                </div>

                <div class="col-md-4 text-md-end mt-3 mt-md-0">
                    <a href="Create.aspx" class="btn btn-aidify btn-lg">
                        <i class="bi bi-person-plus me-2"></i>Add New User
                    </a>
                </div>
            </div>

            <div class="row g-4 mb-5">
                <div class="col-md-6 col-lg-3">
                    <div class="stat-card">
                        <small class="text-muted fw-bold">ACTIVE USERS</small>
                        <h3 id="ulStatTotal">—</h3>
                        <small class="text-muted">Currently active accounts</small>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3">
                    <div class="stat-card">
                        <small class="text-muted fw-bold">ACTIVE LEARNERS</small>
                        <h3 id="ulStatLearners">—</h3>
                        <div class="progress mt-2" style="height: 5px;">
                            <div class="progress-bar bg-secondary" style="width: 74%;"></div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3">
                    <div class="stat-card">
                        <small class="text-muted fw-bold">PENDING APPROVALS</small>
                        <h3 id="ulStatPending">—</h3>
                        <small class="text-danger">Requires attention</small>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3">
                    <div class="stat-card">
                        <small class="text-muted fw-bold">AVG. COMPLETION</small>
                        <h3 id="ulStatCompletion">—</h3>
                        <small class="text-muted">Platform target met</small>
                    </div>
                </div>
            </div>

            <div class="table-box shadow-sm mb-5">
                <div class="p-4 border-bottom">
                    <div class="row g-3 align-items-center">
                        <div class="col-lg-5">
                            <div class="input-group">
                                <span class="input-group-text bg-light">
                                    <i class="bi bi-search"></i>
                                </span>
                                <input type="text" id="userSearchBox" class="form-control bg-light" placeholder="Search by name, email, or ID..." />
                            </div>
                        </div>

                        <div class="col-lg-7 d-flex justify-content-lg-end gap-2">
                            <select id="roleFilter" class="form-select w-auto">
                                <option value="">All Roles</option>
                                <option value="Admin">Admin</option>
                                <option value="Instructor">Instructor</option>
                                <option value="Learner">Learner</option>
                            </select>

                            

                            <button type="button"
                                    class="btn btn-light border"
                                    onclick="downloadVisibleUsersCsv()"
                                    title="Export visible users">
                                <i class="bi bi-download"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-4">User Profile</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Last Active</th>
                                <th class="text-end pe-4">Actions</th>
                            </tr>
                        </thead>

                        <tbody id="userTableBody">
                            <tr><td colspan="5" class="text-center text-muted py-4">Loading users…</td></tr>
                        </tbody>
                    </table>
                </div>

                <div class="p-4 bg-light border-top d-flex justify-content-between align-items-center">
                    <small class="text-muted" id="userCountLabel">Loading…</small>

                    <div id="paginationControls"></div>
                </div>
            </div>

            <div class="security-card p-4">
                <h3 class="fw-bold mb-4">Security Logs</h3>

                <div id="securityLogsBody">
                    <small class="text-muted">Loading logs...</small>
                </div>
            </div>

        </div>
    </main>

    <footer class="um-footer">
        <div class="container">
            <div class="d-flex justify-content-between align-items-start flex-wrap gap-3 mb-3">
                <div>
                    <h5>Aidify</h5>
                    <p class="text-muted small mb-0">Administrative control center for the Aidify learning platform.</p>
                </div>
            </div>
            <hr class="mt-1 mb-2" />
            <p class="text-muted small mb-0 text-center">© 2026 Aidify Admin Panel. Educational use only.</p>
        </div>
    </footer>

<script type="text/javascript">
    var allUsers = [];
    var currentPage = 1;
    var pageSize = 5;
    var appRoot = '<%= ResolveUrl("~/") %>';

    function loadUsers() {
        $.ajax({
            type: 'POST',
            url: 'List.aspx/GetUsers',
            data: '{}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (r) {
                allUsers = r.d || [];
                currentPage = 1;
                renderUsers();
            },
            error: function () {
                document.getElementById('userTableBody').innerHTML =
                    '<tr><td colspan="5" class="text-danger text-center py-4">Failed to load users.</td></tr>';
            }
        });
    }

    function getFilteredUsers() {
        var search = document.getElementById('userSearchBox').value.toLowerCase();
        var role = document.getElementById('roleFilter').value;

        return allUsers.filter(function (u) {
            var matchesSearch =
                String(u.userId).includes(search) ||
                String(u.fullName).toLowerCase().includes(search) ||
                String(u.email).toLowerCase().includes(search);

            var matchesRole = role === '' || u.roleName === role;

            return matchesSearch && matchesRole;
        });
    }

    function renderUsers() {
        var users = getFilteredUsers();
        var body = document.getElementById('userTableBody');
        var label = document.getElementById('userCountLabel');

        if (!users || users.length === 0) {
            body.innerHTML = '<tr><td colspan="5" class="text-center text-muted py-4">No users found.</td></tr>';
            label.textContent = 'No users';
            document.getElementById('paginationControls').innerHTML = '';
            return;
        }

        var totalPages = Math.ceil(users.length / pageSize);
        if (currentPage > totalPages) currentPage = totalPages;

        var start = (currentPage - 1) * pageSize;
        var pageUsers = users.slice(start, start + pageSize);

        var html = '';

        for (var i = 0; i < pageUsers.length; i++) {
            var u = pageUsers[i];
            var active = u.isActive;
            var dotCss = active ? 'bg-success' : 'bg-secondary';
            var status = active ? 'Active' : 'Disabled';
            var toggleLabel = active ? 'Disable' : 'Enable';

            html +=
                '<tr>' +
                '<td class="ps-4">' +
                renderUserAvatar(u) +
                '<strong>' + esc(u.fullName) + '</strong><br/>' +
                '<small class="text-muted ms-5">' + esc(u.email) + '</small>' +
                '</td>' +
                '<td><span class="role-badge ' + esc(u.roleBadgeCss) + '">' + esc(u.roleName) + '</span></td>' +
                '<td><span class="status-dot ' + dotCss + '"></span>' + status + '</td>' +
                '<td><small class="text-muted">' + esc(u.lastActive) + '</small></td>' +
                '<td class="text-end pe-4">' +
                '<a href="Edit.aspx?userId=' + u.userId + '" class="text-dark me-3"><i class="bi bi-pencil"></i></a>' +
                '<a href="#" class="' + (active ? 'text-danger' : 'text-success') + '" ' +
                'onclick="toggleUser(' + u.userId + ',' + (!active) + ');return false;">' +
                '<i class="bi bi-person-' + (active ? 'x' : 'check') + '"></i> ' + toggleLabel +
                '</a>' +
                '<a href="#" class="text-danger ms-3" ' +
                'onclick="softDeleteUser(' + u.userId + ');return false;">' +
                '<i class="bi bi-trash"></i> Delete' +
                '</a>' +
                '</td>' +
                '</tr>';
        }

        body.innerHTML = html;

        var end = start + pageUsers.length;

        label.innerHTML =
            'Showing <strong>' + (start + 1) +
            '</strong> - <strong>' + end +
            '</strong> of <strong>' +
            users.length +
            '</strong> user(s)';

        renderPagination(totalPages);
    }

    function renderPagination(totalPages) {
        var html = '';

        html += '<button type="button" class="btn btn-sm btn-light border me-1" ' +
            (currentPage === 1 ? 'disabled' : '') +
            ' onclick="currentPage--; renderUsers();">Previous</button>';

        for (var i = 1; i <= totalPages; i++) {
            html += '<button type="button" class="btn btn-sm ' +
                (i === currentPage ? 'btn-primary' : 'btn-light border') +
                ' me-1" onclick="currentPage=' + i + '; renderUsers();">' + i + '</button>';
        }

        html += '<button type="button" class="btn btn-sm btn-light border" ' +
            (currentPage === totalPages ? 'disabled' : '') +
            ' onclick="currentPage++; renderUsers();">Next</button>';

        document.getElementById('paginationControls').innerHTML = html;
    }

    function toggleUser(userId, makeActive) {
        $.ajax({
            type: 'POST',
            url: 'List.aspx/SetUserActive',
            data: JSON.stringify({ userId: userId, active: makeActive }),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function () {
                loadUsers();
            }
        });
    }

    function softDeleteUser(userId) {
        if (!confirm('Soft-delete this user account? Historical records will remain, but the user will be hidden and cannot log in.')) {
            return;
        }

        $.ajax({
            type: 'POST',
            url: 'List.aspx/SoftDeleteUser',
            data: JSON.stringify({ userId: userId }),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function () {
                loadUsers();
            }
        });
    }

    function esc(s) {
        return String(s || '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    }

    function avatarUrl(path) {
        path = String(path || '');
        if (path.indexOf('~/') === 0) return appRoot + path.substring(2);
        return path;
    }

    function renderUserAvatar(u) {
        if (u.avatarPath) {
            return '<span class="avatar-circle">' +
                '<img src="' + esc(avatarUrl(u.avatarPath)) + '" alt="' + esc(u.fullName) + ' avatar" />' +
                '</span>';
        }

        return '<span class="avatar-circle bg-danger-subtle text-danger">' + esc(u.initials) + '</span>';
    }

    function downloadVisibleUsersCsv() {
        var users = getFilteredUsers();

        if (!users || users.length === 0) {
            alert('No users to export.');
            return;
        }

        var csv = 'UserId,FullName,Email,Role,Status,LastActive\n';

        for (var i = 0; i < users.length; i++) {
            var u = users[i];
            var status = u.isActive ? 'Active' : 'Disabled';

            csv += [
                u.userId,
                '"' + String(u.fullName || '').replace(/"/g, '""') + '"',
                '"' + String(u.email || '').replace(/"/g, '""') + '"',
                '"' + String(u.roleName || '').replace(/"/g, '""') + '"',
                status,
                '"' + String(u.lastActive || '').replace(/"/g, '""') + '"'
            ].join(',') + '\n';
        }

        var blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
        var link = document.createElement('a');

        link.href = URL.createObjectURL(blob);
        link.download = 'Aidify_Users_Export.csv';
        link.click();

        URL.revokeObjectURL(link.href);
    }

    $(document).ready(function () {
        loadUsers();

        $('#userSearchBox').on('input', function () {
            currentPage = 1;
            renderUsers();
        });

        $('#roleFilter').on('change', function () {
            currentPage = 1;
            renderUsers();
        });

        $.ajax({
            type: 'POST',
            url: 'List.aspx/GetUserStats',
            data: '{}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (r) {
                var d = r.d;
                if (!d) {
                    showUserStatsError();
                    return;
                }
                document.getElementById('ulStatTotal').textContent = d.totalUsers.toLocaleString();
                document.getElementById('ulStatLearners').textContent = d.activeLearners.toLocaleString();
                document.getElementById('ulStatPending').textContent = d.pendingModules;
                document.getElementById('ulStatCompletion').textContent = d.completionRate + '%';
            },
            error: function () {
                showUserStatsError();
            }
        });

        $.ajax({
            type: 'POST',
            url: 'List.aspx/GetRecentAuditLogs',
            data: '{}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (r) {
                var logs = r.d || [];
                var html = '';

                if (logs.length === 0) {
                    html = '<small class="text-muted">No recent activity.</small>';
                }

                for (var i = 0; i < logs.length; i++) {
                    html +=
                        '<div class="d-flex gap-3 mb-4">' +
                        '<i class="bi bi-clock-history text-muted"></i>' +
                        '<small>' +
                        esc(logs[i].ActorName) +
                        ' performed ' +
                        esc(logs[i].Action) +
                        '</small>' +
                        '</div>';
                }

                document.getElementById('securityLogsBody').innerHTML = html;
            },
            error: function () {
                document.getElementById('securityLogsBody').innerHTML =
                    '<small class="text-danger">Unable to load security logs.</small>';
            }
        });
    });

    function showUserStatsError() {
        document.getElementById('ulStatTotal').textContent = 'Error';
        document.getElementById('ulStatLearners').textContent = 'Error';
        document.getElementById('ulStatPending').textContent = 'Error';
        document.getElementById('ulStatCompletion').textContent = 'Error';
    }
</script>

</asp:Content>
