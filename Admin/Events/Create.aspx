<%@ Page Title="Create Event" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="Aidify_assigment.Admin.Events.Create" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .aidify-navbar, .aidify-footer { display:none!important; }
    body { background:#f9f9f9; }

    .event-topbar {
        height:80px;
        background:#fff;
        border-bottom:1px solid #e2e2e2;
        display:flex;
        align-items:center;
    }

    .event-brand {
        display:flex;
        align-items:center;
        gap:12px;
        color:#E53935;
        font-size:26px;
        font-weight:800;
        text-decoration:none;
    }

    .event-logo {
        width:42px;
        height:42px;
        object-fit:contain;
    }

    .event-nav a {
        color:#3d2a28;
        text-decoration:none;
        margin-left:22px;
        font-weight:600;
        font-size:14px;
    }

    .event-dropdown {
        text-decoration:none;
        color:#1f2937;
        font-weight:700;
        font-size:18px;
        display:flex;
        align-items:center;
        gap:6px;
    }

    .event-wrap {
        max-width:850px;
        margin:50px auto;
        background:#fff;
        border:1px solid #e2e2e2;
        border-radius:16px;
        padding:35px;
    }

    .event-wrap h1 {
        font-weight:800;
        margin-bottom:8px;
    }

    .form-label {
        font-weight:700;
        margin-top:16px;
    }

    .btn-aidify {
        background:#E53935;
        color:#fff;
        border:none;
        border-radius:10px;
        padding:12px 24px;
        font-weight:800;
    }

    .btn-aidify:hover {
        background:#c62828;
        color:#fff;
    }

    .action-btn {
        min-width:140px;
        padding:12px 24px;
        font-weight:700;
        border-radius:10px;
    }

    @media(max-width:992px) {
        .event-nav { display:none; }
    }
</style>

<header class="event-topbar">
    <div class="container d-flex justify-content-between align-items-center">

        <a href="../Dashboard.aspx" class="event-brand">
            <img src="<%= ResolveUrl("~/Images/aidify-kit.png") %>"
                 alt="Aidify Logo"
                 class="event-logo" />
            <span>Aidify</span>
        </a>

        <nav class="event-nav">
            <a href="../Dashboard.aspx">Dashboard</a>
            <a href="../Users/List.aspx">Users</a>
            <a href="../Content/ApprovalQueue.aspx">Approvals</a>
            <a href="../Analytics.aspx">Analytics</a>
        </nav>

        <div class="dropdown">
            <a href="#" class="event-dropdown" data-bs-toggle="dropdown" aria-expanded="false">
                Admin
                <i class="bi bi-chevron-down"></i>
            </a>

            <ul class="dropdown-menu dropdown-menu-end shadow-sm">
                <li>
                    <a class="dropdown-item" href="<%= ResolveUrl("~/Account/Profile.aspx") %>">
                        <i class="bi bi-person me-2"></i> Profile
                    </a>
                </li>
                <li>
                    <a class="dropdown-item text-danger" href="<%= ResolveUrl("~/Auth/Logout.aspx") %>">
                        <i class="bi bi-box-arrow-right me-2"></i> Logout
                    </a>
                </li>
            </ul>
        </div>

    </div>
</header>

<div class="event-wrap">

    <h1>Create New Event</h1>
    <p class="text-muted">Add a new first aid workshop, talk, or training event to Aidify.</p>

    <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3"></asp:Label>

    <label class="form-label">Event Title</label>
    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" />

    <label class="form-label">Description</label>
    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />

    <label class="form-label">Event Date and Time</label>
    <asp:TextBox ID="txtEventDate" runat="server" CssClass="form-control" TextMode="DateTimeLocal" />

    <label class="form-label">Location</label>
    <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="e.g., APU Campus or Online" />

    <label class="form-label">Meeting URL</label>
    <asp:TextBox ID="txtMeetingUrl" runat="server" CssClass="form-control" placeholder="Optional online meeting link" />

    <div class="mt-4 d-flex justify-content-end gap-3">
        <asp:Button ID="btnClear"
            runat="server"
            Text="Clear"
            CssClass="btn btn-outline-secondary action-btn"
            OnClick="btnClear_Click" />

        <a href="../Dashboard.aspx" class="btn btn-outline-secondary action-btn">
            Go Back
        </a>

        <asp:Button ID="btnCreate"
            runat="server"
            Text="Create Event"
            CssClass="btn-aidify action-btn"
            OnClick="btnCreate_Click" />
    </div>

</div>

</asp:Content>