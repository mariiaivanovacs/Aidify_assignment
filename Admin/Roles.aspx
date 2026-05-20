<%@ Page Title="Roles Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Roles.aspx.cs" Inherits="Aidify_assigment.Admin.Roles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .aidify-navbar,
        .aidify-footer {
            display: none !important;
        }

        body {
            background-color: #f9f9f9;
        }

        .roles-page {
            background-color: #f9f9f9;
            padding: 50px 0 70px;
        }

        .roles-topbar {
            height: 80px;
            background: #ffffff;
            border-bottom: 1px solid #e4beb9;
            display: flex;
            align-items: center;
        }

        .roles-brand {
            color: #E53935;
            font-size: 28px;
            font-weight: 800;
            text-decoration: none;
        }

        .roles-nav a {
            color: #3d2a28;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            margin-left: 22px;
        }

        .roles-nav a.active {
            color: #E53935;
            border-bottom: 2px solid #E53935;
            padding-bottom: 8px;
        }

        .role-card,
        .permission-card {
            background: white;
            border: 1px solid #e4beb9;
            border-radius: 16px;
            transition: 0.2s;
        }

        .role-card:hover {
            border-color: #E53935;
        }

        .permission-card:hover {
            border-color: #4B50C7;
        }

        .role-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .bg-admin-light {
            background: #ffdad6;
            color: #b7131a;
        }

        .bg-instructor-light {
            background: #e0e0ff;
            color: #4B50C7;
        }

        .bg-learner-light {
            background: #cfe6f2;
            color: #35515c;
        }

        .permission-tag {
            background: #eeeeee;
            border: 1px solid #e4beb9;
            border-radius: 8px;
            padding: 6px 12px;
            font-size: 12px;
            color: #5b403d;
        }

        .badge-primary-role {
            background: #E53935;
            color: white;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
        }

        .roles-footer {
            background: #eeeeee;
            border-top: 1px solid #e4beb9;
            padding: 36px 0 20px;
        }

        .roles-footer h5 {
            color: #E53935;
            font-weight: 800;
        }

        .roles-footer a {
            color: #5b403d;
            text-decoration: none;
        }

        .roles-footer a:hover {
            color: #E53935;
        }

        @media (max-width: 768px) {
            .roles-nav {
                display: none;
            }
        }
    </style>

    <header class="roles-topbar">
        <div class="container d-flex justify-content-between align-items-center">

            <a href="Dashboard.aspx" class="roles-brand" style="display:flex; align-items:center; gap:10px;">
                Aidify
                <span style="background:#db322f; color:#fff; font-size:11px; padding:3px 9px; border-radius:20px; font-weight:700;">ADMIN</span>
            </a>

            <nav class="roles-nav">
                <a href="Dashboard.aspx">Dashboard</a>
                <a href="Users/List.aspx">Users</a>
                <a href="Roles.aspx" class="active">Roles</a>
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
                <div style="width:42px; height:42px; border-radius:50%; background:#E53935; color:white; display:flex; align-items:center; justify-content:center; font-weight:800;">A</div>
            </div>

        </div>
</header>

    <main class="roles-page">
        <div class="container">

            <div class="row align-items-end mb-5">
                <div class="col-md-8">

                    <h1 class="fw-bold mb-3">
                        Roles & Permissions
                    </h1>

                    <p class="text-muted fs-5 mb-0">
                        Manage administrative access levels and define permissions for system users to maintain security and operational efficiency.
                    </p>

                </div>

                <div class="col-md-4 text-md-end mt-4 mt-md-0">
                    <button type="button" class="btn btn-aidify px-4 py-2">
                        <i class="bi bi-plus-lg me-1"></i>
                        New Role
                    </button>
                </div>
            </div>

            <div class="row g-4 mb-4">

                <div class="col-lg-8">
                    <div class="role-card p-4 h-100 shadow-sm">

                        <div class="d-flex justify-content-between align-items-center mb-4">

                            <div class="d-flex align-items-center gap-3">

                                <div class="role-icon bg-admin-light">
                                    <i class="bi bi-shield-lock fs-4"></i>
                                </div>

                                <h3 class="h5 fw-bold mb-0">
                                    System Admin
                                    <span class="badge bg-danger-subtle text-danger ms-2" id="countAdmin">—</span>
                                </h3>

                            </div>

                            <span class="badge-primary-role">
                                Primary Role
                            </span>

                        </div>

                        <p class="text-muted mb-4">
                            Full unrestricted access to all modules, user management, and system-wide configurations.
                        </p>

                        <div class="d-flex flex-wrap gap-2 mb-4">
                            <span class="permission-tag">Edit Users</span>
                            <span class="permission-tag">Approve Content</span>
                            <span class="permission-tag">System Config</span>
                            <span class="permission-tag">Delete Data</span>
                            <span class="permission-tag">+12 more</span>
                        </div>

                        <div class="text-end">
                            <a href="#" class="text-danger text-decoration-none fw-bold small">
                                <i class="bi bi-pencil-square me-1"></i>
                                Edit Permissions
                            </a>
                        </div>

                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="permission-card p-4 h-100 shadow-sm">

                        <div class="d-flex align-items-center gap-3 mb-4">

                            <div class="role-icon bg-instructor-light">
                                <i class="bi bi-mortarboard fs-4"></i>
                            </div>

                            <h3 class="h5 fw-bold mb-0">
                                Instructor
                                <span class="badge bg-danger-subtle text-danger ms-2" id="countInstructor">—</span>
                            </h3>

                        </div>

                        <p class="text-muted mb-4">
                            Manage course modules, grade assessments, and interact with learners.
                        </p>

                        <ul class="list-unstyled mb-4">

                            <li class="mb-3">
                                <i class="bi bi-check-circle-fill text-danger me-2"></i>
                                Can Approve Content
                            </li>

                            <li class="mb-3">
                                <i class="bi bi-check-circle-fill text-danger me-2"></i>
                                Can View Analytics
                            </li>

                            <li class="opacity-50">
                                <i class="bi bi-x-circle me-2"></i>
                                No User Editing
                            </li>

                        </ul>

                        <button type="button" class="btn btn-outline-primary w-100">
                            Manage Role
                        </button>

                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="permission-card p-4 h-100 shadow-sm">

                        <div class="d-flex align-items-center gap-3 mb-4">

                            <div class="role-icon bg-learner-light">
                                <i class="bi bi-person fs-4"></i>
                            </div>

                            <h3 class="h5 fw-bold mb-0">
                                Learner
                                <span class="badge bg-danger-subtle text-danger ms-2" id="countLearner">—</span>
                            </h3>

                        </div>

                        <p class="text-muted mb-4">
                            Standard access to educational modules, quizzes, and progress tracking.
                        </p>

                        <ul class="list-unstyled mb-4">

                            <li class="mb-3">
                                <i class="bi bi-check-circle-fill text-danger me-2"></i>
                                Can View Courses
                            </li>

                            <li class="mb-3">
                                <i class="bi bi-check-circle-fill text-danger me-2"></i>
                                Can Take Quizzes
                            </li>

                        </ul>

                        <button type="button" class="btn btn-outline-secondary w-100">
                            View Details
                        </button>

                    </div>
                </div>

                <div class="col-lg-8">
                    <div class="role-card shadow-sm overflow-hidden h-100">

                        <div class="bg-light border-bottom p-3 d-flex justify-content-between align-items-center">

                            <h5 class="fw-bold mb-0">
                                Permissions Matrix: Instructor
                            </h5>

                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-outline-secondary btn-sm">
                                    Cancel
                                </button>

                                <button type="button" class="btn btn-aidify btn-sm">
                                    Save Changes
                                </button>
                            </div>

                        </div>

                        <div class="table-responsive">

                            <table class="table table-hover mb-0">

                                <thead class="table-light">
                                    <tr>
                                        <th class="px-4 py-3">Module</th>
                                        <th class="px-4 py-3">Permission</th>
                                        <th class="px-4 py-3 text-center">Status</th>
                                    </tr>
                                </thead>

                                <tbody>

                                    <tr>
                                        <td class="px-4 py-3 fw-medium">
                                            Content Management
                                        </td>

                                        <td class="px-4 py-3 text-muted">
                                            Can Approve Content
                                        </td>

                                        <td class="px-4 py-3 text-center">
                                            <div class="form-check form-switch d-inline-block">
                                                <input class="form-check-input" type="checkbox" checked />
                                            </div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="px-4 py-3 fw-medium">
                                            User Relations
                                        </td>

                                        <td class="px-4 py-3 text-muted">
                                            Can Edit Users
                                        </td>

                                        <td class="px-4 py-3 text-center">
                                            <div class="form-check form-switch d-inline-block">
                                                <input class="form-check-input" type="checkbox" />
                                            </div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="px-4 py-3 fw-medium">
                                            Reporting
                                        </td>

                                        <td class="px-4 py-3 text-muted">
                                            Can View Analytics
                                        </td>

                                        <td class="px-4 py-3 text-center">
                                            <div class="form-check form-switch d-inline-block">
                                                <input class="form-check-input" type="checkbox" checked />
                                            </div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="px-4 py-3 fw-medium">
                                            Emergency Alerts
                                        </td>

                                        <td class="px-4 py-3 text-muted">
                                            Can Broadcast Alerts
                                        </td>

                                        <td class="px-4 py-3 text-center">
                                            <div class="form-check form-switch d-inline-block">
                                                <input class="form-check-input" type="checkbox" checked />
                                            </div>
                                        </td>
                                    </tr>

                                </tbody>

                            </table>

                        </div>

                    </div>
                </div>

            </div>

        </div>
    </main>

    <footer class="roles-footer">
        <div class="container">
            <div class="d-flex justify-content-between align-items-start flex-wrap gap-3 mb-3">
                <div>
                    <h5>Aidify</h5>
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
$(document).ready(function () {
    $.ajax({
        type: 'POST', url: 'Roles.aspx/GetRoleCounts',
        data: '{}', contentType: 'application/json; charset=utf-8', dataType: 'json',
        success: function (r) {
            var d = r.d;
            document.getElementById('countAdmin').textContent      = d.adminCount + ' user(s)';
            document.getElementById('countInstructor').textContent = d.instructorCount + ' user(s)';
            document.getElementById('countLearner').textContent    = d.learnerCount + ' user(s)';
        }
    });
});
</script>

</asp:Content>