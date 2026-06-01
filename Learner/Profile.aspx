<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" ValidateRequest="false" CodeBehind="Profile.aspx.cs" Inherits="Aidify_assigment.Learner.Profile" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .profile-card      { background: #fff; border: 1px solid #f0d8d8; border-radius: 12px; padding: 24px; }
    .avatar-wrap       { text-align: center; margin-bottom: 12px; }
    .avatar-wrap img   { width: 100px; height: 100px; border-radius: 50%; object-fit: cover; border: 3px solid #C0392B; }
    .avatar-wrap h5    { font-weight: 700; margin: 10px 0 2px; }
    .avatar-wrap p     { color: #888; font-size: 13px; margin: 0; }
    .form-control:focus { border-color: #C0392B; box-shadow: 0 0 0 0.2rem rgba(192,57,43,0.15); }
    .form-label        { font-weight: 600; font-size: 13px; }
</style>

<div class="mb-4">
    <h3 class="fw-bold mb-1">My Profile</h3>
    <p class="text-muted" style="font-size:13px;">View and update your personal information.</p>
</div>

<div class="row g-4">
    <div class="col-md-4">
        <div class="profile-card text-center">
            <div class="avatar-wrap">
                <asp:Image ID="imgAvatar" runat="server" AlternateText="Avatar" />
                <h5><asp:Label ID="lblDisplayName" runat="server" /></h5>
                <p>Learner</p>
            </div>
            <div class="mt-3 text-start">
                <label class="form-label">Change Avatar</label>
                <asp:FileUpload ID="fuAvatar" runat="server" CssClass="form-control form-control-sm" />
                <small class="text-muted">image/* only · max 2MB</small>
            </div>
        </div>
    </div>

    <div class="col-md-8">
        <div class="profile-card">
            <h5 class="fw-bold mb-4">Account Details</h5>

            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server"
                    CssClass="form-control" placeholder="Your full name" />
                <asp:RequiredFieldValidator ID="rfvFullName" runat="server"
                    ControlToValidate="txtFullName"
                    ErrorMessage="Name is required"
                    CssClass="text-danger small"
                    Display="Dynamic" />
            </div>

            <div class="mb-4">
                <label class="form-label">Email Address</label>
                <asp:TextBox ID="txtEmail" runat="server"
                    CssClass="form-control"
                    ReadOnly="true"
                    style="background:#f5f5f5; cursor:not-allowed;" />
                <small class="text-muted">Email cannot be changed here.</small>
            </div>

            <div class="d-flex align-items-center gap-3">
                <asp:Button ID="btnSaveProfile" runat="server"
                    Text="Save Changes"
                    CssClass="btn btn-danger px-4 py-2 fw-semibold"
                    OnClick="btnSaveProfile_Click" />
                <asp:Label ID="lblProfileStatus" runat="server"
                    CssClass="fw-semibold"
                    Visible="false" />
            </div>
        </div>
    </div>
</div>

</asp:Content>
