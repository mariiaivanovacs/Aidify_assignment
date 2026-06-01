<%@ Page Title="User Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Aidify_assigment.Account.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .aidify-navbar,
    .aidify-footer {
        display: none !important;
    }

    body {
        background-color: #f9f9f9;
    }

    .profile-topbar {
        height: 80px;
        background: #ffffff;
        border-bottom: 1px solid #e2e2e2;
        display: flex;
        align-items: center;
    }

    .profile-brand {
        display: flex;
        align-items: center;
        gap: 12px;
        color: #E53935;
        font-size: 26px;
        font-weight: 800;
        text-decoration: none;
    }

    .profile-logo {
        width: 42px;
        height: 42px;
        object-fit: contain;
    }

    .profile-page {
        min-height: calc(100vh - 80px);
        background: #f9f9f9;
        padding: 70px 20px;
    }

    .profile-card {
        max-width: 650px;
        margin: 0 auto;
        background: #fff;
        border: 1px solid #e2e2e2;
        border-radius: 16px;
        padding: 35px;
    }

    .profile-title {
        font-size: 34px;
        font-weight: 800;
        color: #1f2933;
        margin-bottom: 6px;
    }

    .profile-subtitle {
        color: #666;
        margin-bottom: 28px;
    }

    .profile-avatar-box {
        display: flex;
        align-items: center;
        gap: 18px;
        margin-bottom: 22px;
        padding: 18px;
        background: #fafafa;
        border: 1px solid #eeeeee;
        border-radius: 14px;
    }

    .profile-avatar {
        width: 96px;
        height: 96px;
        border-radius: 50%;
        object-fit: cover;
        border: 3px solid #E53935;
        background: #ffe2de;
    }

    .form-label {
        font-weight: 700;
        color: #555;
        margin-top: 14px;
    }

    .form-control[readonly] {
        background-color: #f3f3f3;
        color: #555;
    }

    .profile-actions {
        display: flex;
        justify-content: flex-end;
        gap: 12px;
        margin-top: 30px;
    }

    .btn-aidify {
        background: #E53935;
        color: white;
        border: none;
        border-radius: 10px;
        padding: 11px 22px;
        font-weight: 700;
        text-decoration: none;
    }

    .btn-aidify:hover {
        background: #c62828;
        color: white;
    }

    .message-label {
        display: block;
        margin-top: 18px;
        font-weight: 700;
    }
</style>

<header class="profile-topbar">
    <div class="container">
        <a href="<%= ResolveUrl(GetDashboardUrl()) %>" class="profile-brand">
            <img src="<%= ResolveUrl("~/Images/aidify-kit.png") %>"
                 alt="Aidify Logo"
                 class="profile-logo" />

            <span>Aidify</span>
        </a>
    </div>
</header>

<div class="profile-page">
    <div class="profile-card">

        <h1 class="profile-title">My Profile</h1>
        <p class="profile-subtitle">View and update your basic account information.</p>

        <div class="profile-avatar-box">
            <asp:Image ID="imgAvatar"
                runat="server"
                CssClass="profile-avatar"
                AlternateText="Profile picture" />

            <div class="flex-grow-1">
                <label class="form-label mt-0">Profile Picture</label>
                <asp:FileUpload ID="fuAvatar"
                    runat="server"
                    CssClass="form-control" />
                <small class="text-muted">JPEG, PNG, or GIF only. Max 2 MB.</small>
            </div>
        </div>

        <label class="form-label">Full Name</label>
        <asp:TextBox ID="txtFullName"
            runat="server"
            CssClass="form-control" />

        <label class="form-label">Email</label>
        <asp:TextBox ID="txtEmail"
            runat="server"
            CssClass="form-control"
            ReadOnly="true" />

        <label class="form-label">Role</label>
        <asp:TextBox ID="txtRole"
            runat="server"
            CssClass="form-control"
            ReadOnly="true" />

        <asp:Label ID="lblMessage"
            runat="server"
            CssClass="message-label" />

        <div class="profile-actions">
            <a href="<%= ResolveUrl(GetDashboardUrl()) %>" class="btn btn-outline-secondary">
                Go Back
            </a>

            <asp:Button ID="btnSave"
                runat="server"
                Text="Save Changes"
                CssClass="btn-aidify"
                OnClick="btnSave_Click" />

            <a href="<%= ResolveUrl("~/Auth/Logout.aspx") %>" class="btn-aidify">
                Logout
            </a>
        </div>

    </div>
</div>

</asp:Content>
