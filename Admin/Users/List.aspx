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
            color: #E53935;
            font-weight: 800;
            font-size: 26px;
            text-decoration: none;
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

        .bulk-card {
            background: #4B50C7;
            color: white;
            border-radius: 16px;
            padding: 42px;
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

        @media (max-width: 768px) {
            .um-nav {
                display: none;
            }
        }
    </style>

    <header class="um-topbar">
        <div class="container d-flex justify-content-between align-items-center">

            <a href="../Dashboard.aspx" class="um-brand" style="display:flex; align-items:center; gap:10px;">
                Aidify
                <span style="background:#db322f; color:#fff; font-size:11px; padding:3px 9px; border-radius:20px; font-weight:700;">ADMIN</span>
            </a>

            <nav class="um-nav">
                <a href="../Dashboard.aspx">Dashboard</a>
                <a href="List.aspx" class="active">Users</a>
                <a href="../Roles.aspx">Roles</a>
                <a href="../Content/ManagePublicPages.aspx">Public Pages</a>
                <a href="../Content/ApprovalQueue.aspx">Approvals</a>
                <a href="../Analytics.aspx">Analytics</a>
            </nav>

            <div class="d-flex align-items-center gap-3">
                <i class="bi bi-bell fs-5"></i>
                <div class="text-end d-none d-md-block">
                    <div class="fw-bold" style="font-size:14px;"><%: Aidify_assigment.AuthHelper.GetName() %></div>
                    <small class="text-muted"><%: Aidify_assigment.AuthHelper.GetRole() %></small>
                </div>
                <div style="width:42px; height:42px; border-radius:50%; background:#E53935; color:white; display:flex; align-items:center; justify-content:center; font-weight:800;">A</div>
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
                    <a href="Edit.aspx" class="btn btn-aidify btn-lg">
                        <i class="bi bi-person-plus me-2"></i>Add New User
                    </a>
                </div>
            </div>

            <div class="row g-4 mb-5">
                <div class="col-md-6 col-lg-3">
                    <div class="stat-card">
                        <small class="text-muted fw-bold">TOTAL USERS</small>
                        <h3 id="ulStatTotal">—</h3>
                        <small class="text-muted">All registered accounts</small>
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
                                <input type="text" class="form-control bg-light" placeholder="Search by name, email, or ID..." />
                            </div>
                        </div>

                        <div class="col-lg-7 d-flex justify-content-lg-end gap-2">
                            <button type="button" class="btn btn-light border">
                                <i class="bi bi-filter me-1"></i> Filter Roles
                            </button>

                            <button type="button" class="btn btn-light border">
                                <i class="bi bi-calendar me-1"></i> Date Range
                            </button>

                            <button type="button" class="btn btn-light border">
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

                    <div>
                        <button type="button" class="btn btn-sm btn-light border" disabled>Previous</button>
                        <button type="button" class="btn btn-sm btn-primary">1</button>
                        <button type="button" class="btn btn-sm btn-light border">2</button>
                        <button type="button" class="btn btn-sm btn-light border">3</button>
                        <button type="button" class="btn btn-sm btn-light border">Next</button>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="bulk-card h-100">
                        <h3 class="fw-bold mb-3">Bulk User Registration</h3>
                        <p class="opacity-75 mb-4">
                            Need to onboard a full class of students? Use our CSV template to upload multiple users with predefined roles.
                        </p>
                        <button type="button" class="btn btn-light fw-bold px-4">
                            Download Template
                        </button>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="security-card p-4 h-100">
                        <h3 class="fw-bold mb-4">Security Logs</h3>

                        <div class="d-flex gap-3 mb-4">
                            <i class="bi bi-shield-check text-danger"></i>
                            <small>Admin Chen updated Learner permissions</small>
                        </div>

                        <div class="d-flex gap-3 mb-4">
                            <i class="bi bi-arrow-counterclockwise text-muted"></i>
                            <small>Password reset requested for User ID: #9284</small>
                        </div>

                        <div class="d-flex gap-3">
                            <i class="bi bi-clock-history text-muted"></i>
                            <small>View full audit log...</small>
                        </div>
                    </div>
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
                <div class="d-flex align-items-center gap-3">
                    <a href="../Dashboard.aspx" class="text-muted text-decoration-none small">Dashboard</a>
                    <span class="text-muted">|</span>
                    <a href="#" class="text-muted text-decoration-none small">Privacy Policy</a>
                    <span class="text-muted">|</span>
                    <a href="#" class="text-muted text-decoration-none small">Terms of Service</a>
                </div>
            </div>
            <hr class="mt-1 mb-2" />
            <p class="text-muted small mb-0 text-center">© 2026 Aidify Admin Panel. Educational use only.</p>
        </div>
    </footer>

<script type="text/javascript">
function loadUsers() {
    $.ajax({
        type: 'POST', url: 'List.aspx/GetUsers',
        data: '{}', contentType: 'application/json; charset=utf-8', dataType: 'json',
        success: function (r) {
            var users = r.d;
            var body  = document.getElementById('userTableBody');
            var label = document.getElementById('userCountLabel');
            if (!users || users.length === 0) {
                body.innerHTML = '<tr><td colspan="5" class="text-center text-muted py-4">No users found.</td></tr>';
                label.textContent = 'No users';
                return;
            }
            var html = '';
            for (var i = 0; i < users.length; i++) {
                var u      = users[i];
                var active = u.isActive;
                var dotCss = active ? 'bg-success' : 'bg-secondary';
                var status = active ? 'Active' : 'Disabled';
                var toggleLabel = active ? 'Disable' : 'Enable';
                html +=
                    '<tr>' +
                    '<td class="ps-4">' +
                        '<span class="avatar-circle bg-danger-subtle text-danger">' + esc(u.initials) + '</span>' +
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
                    '</td>' +
                    '</tr>';
            }
            body.innerHTML  = html;
            label.innerHTML = 'Showing <strong>' + users.length + '</strong> user(s)';
        },
        error: function () {
            document.getElementById('userTableBody').innerHTML =
                '<tr><td colspan="5" class="text-danger text-center py-4">Failed to load users.</td></tr>';
        }
    });
}

function toggleUser(userId, makeActive) {
    $.ajax({
        type: 'POST', url: 'List.aspx/SetUserActive',
        data: JSON.stringify({ userId: userId, active: makeActive }),
        contentType: 'application/json; charset=utf-8', dataType: 'json',
        success: function () { loadUsers(); }
    });
}

function esc(s) {
    return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
}

$(document).ready(function() {
    loadUsers();
    // populate the 4 stat cards
    $.ajax({
        type:'POST', url:'List.aspx/GetUserStats',
        data:'{}', contentType:'application/json; charset=utf-8', dataType:'json',
        success: function(r) {
            var d = r.d;
            document.getElementById('ulStatTotal').textContent      = d.totalUsers.toLocaleString();
            document.getElementById('ulStatLearners').textContent   = d.activeLearners.toLocaleString();
            document.getElementById('ulStatPending').textContent    = d.pendingModules;
            document.getElementById('ulStatCompletion').textContent = d.completionRate + '%';
        }
    });
});
</script>

</asp:Content>