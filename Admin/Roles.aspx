<%@ Page Title="Roles & Permissions" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Roles.aspx.cs" Inherits="Aidify_assigment.Admin.Roles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .aidify-navbar,
    .aidify-footer {
        display: none !important;
    }

    body {
        background-color: #f9f9f9;
    }

    .roles-topbar {
        height: 80px;
        background: #fff;
        border-bottom: 1px solid #e2e2e2;
        display: flex;
        align-items: center;
    }

    .roles-brand {
        color: #E53935;
        font-size: 26px;
        font-weight: 800;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .roles-logo {
        width: 42px;
        height: 42px;
        object-fit: contain;
    }

    .roles-nav a {
        color: #3d2a28;
        text-decoration: none;
        margin-left: 22px;
        font-weight: 600;
        font-size: 14px;
    }

    .roles-nav a.active {
        color: #E53935;
        border-bottom: 2px solid #E53935;
        padding-bottom: 8px;
    }

    .roles-page {
        padding: 44px 0 64px;
    }

    .role-card,
    .matrix-card {
        background: #fff;
        border: 1px solid #e2e2e2;
        border-radius: 14px;
    }

    .role-card {
        padding: 22px;
        height: 100%;
    }

    .role-card small {
        color: #777;
        font-weight: 700;
        text-transform: uppercase;
    }

    .role-count {
        font-size: 34px;
        font-weight: 800;
        margin-top: 8px;
    }

    .matrix-card {
        overflow: hidden;
    }

    .matrix-card th {
        background: #f3f3f3;
        font-size: 13px;
        color: #555;
        padding: 14px;
    }

    .matrix-card td {
        padding: 14px;
        vertical-align: top;
    }

    .permission-list {
        margin: 0;
        padding-left: 18px;
    }

    .permission-list li {
        margin-bottom: 6px;
    }

    .roles-note {
        background: #fff4f3;
        border: 1px solid #ffd0cc;
        border-radius: 10px;
        padding: 14px 16px;
        color: #6b1f1c;
    }

    @media (max-width: 992px) {
        .roles-nav { display: none; }
    }
</style>

<header class="roles-topbar">
    <div class="container d-flex justify-content-between align-items-center">
        <a href="Dashboard.aspx" class="roles-brand">
            <img src="<%= ResolveUrl("~/Images/aidify-kit.png") %>" alt="Aidify Logo" class="roles-logo" />
            <span>Aidify</span>
        </a>

        <nav class="roles-nav">
            <a href="Dashboard.aspx">Dashboard</a>
            <a href="Users/List.aspx">Users</a>
            <a href="Roles.aspx" class="active">Roles</a>
            <a href="Content/ApprovalQueue.aspx">Approvals</a>
            <a href="Analytics.aspx">Analytics</a>
            <a href="AuditLogs.aspx">Audit Logs</a>
        </nav>

        <a href="<%= ResolveUrl("~/Auth/Logout.aspx") %>" class="btn btn-sm btn-outline-danger">
            <i class="bi bi-box-arrow-right"></i> Logout
        </a>
    </div>
</header>

<main class="roles-page">
    <div class="container">
        <div class="mb-4">
            <div class="text-muted small mb-2">Admin / Roles &amp; Permissions</div>
            <h1 class="fw-bold display-6">Roles &amp; Permissions</h1>
            <p class="text-muted fs-5 mb-0">
                Review platform roles, current user counts, and the fixed permission model enforced by protected Web Forms pages.
            </p>
        </div>

        <div class="roles-note mb-4">
            Permissions are code-based through <strong>BaseRolePage</strong> and role constants. This page documents the matrix for testing and professor demonstration.
        </div>

        <div class="row g-4 mb-5">
            <%= GetRoleCardsHtml() %>
        </div>

        <div class="matrix-card">
            <div class="table-responsive">
                <table class="table mb-0 align-middle">
                    <thead>
                        <tr>
                            <th style="width:18%;">Role</th>
                            <th>Allowed Areas</th>
                            <th>Blocked Areas</th>
                            <th>Implementation</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%= GetPermissionRowsHtml() %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>
</asp:Content>
