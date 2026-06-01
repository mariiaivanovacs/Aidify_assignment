<%@ Page Title="Create Module" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="Aidify_assigment.Admin.Modules.Create" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .aidify-navbar,
    .aidify-footer {
        display: none !important;
    }

    body {
        background-color: #f9f9f9;
    }

    .create-topbar {
        height: 80px;
        background: #fff;
        border-bottom: 1px solid #e2e2e2;
        display: flex;
        align-items: center;
    }

    .create-logo {
        width: 42px;
        height: 42px;
        object-fit: contain;
    }

    .create-brand {
        display: flex;
        align-items: center;
        gap: 12px;
        color: #E53935;
        font-size: 26px;
        font-weight: 800;
        text-decoration: none;
    }

    .create-nav a {
        color: #3d2a28;
        text-decoration: none;
        margin-left: 22px;
        font-weight: 600;
        font-size: 14px;
    }

    .create-nav a.active {
        color: #E53935;
        border-bottom: 2px solid #E53935;
        padding-bottom: 8px;
    }

    .create-dropdown {
        text-decoration: none;
        color: #1f2937;
        font-weight: 700;
        font-size: 18px;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .create-dropdown:hover {
        color: #E53935;
    }

    .dropdown-menu {
        min-width: 180px;
        border-radius: 12px;
    }

    .create-module-wrap {
        max-width: 900px;
        margin: 50px auto;
        background: #fff;
        border: 1px solid #e2e2e2;
        border-radius: 16px;
        padding: 35px;
    }

    .create-module-wrap h1 {
        font-weight: 800;
        margin-bottom: 8px;
    }

    .section-title {
        font-weight: 800;
        margin-top: 30px;
        margin-bottom: 8px;
        color: #1f2933;
    }

    .lesson-box {
        border: 1px solid #e2e2e2;
        border-radius: 14px;
        padding: 22px;
        margin-top: 20px;
        background: #fff;
    }

    .lesson-box summary {
        cursor: pointer;
        font-weight: 800;
        color: #E53935;
        font-size: 18px;
        list-style: none;
    }

    .lesson-box summary::-webkit-details-marker {
        display: none;
    }

    .lesson-box summary::before {
        content: "+ ";
        font-size: 22px;
        font-weight: 800;
    }

    .lesson-box[open] summary::before {
        content: "− ";
    }

    .lesson-box[open] summary {
        margin-bottom: 15px;
    }

    .lesson-box h5 {
        font-weight: 800;
        margin-bottom: 10px;
    }

    .form-label {
        font-weight: 700;
        margin-top: 16px;
    }

    .btn-aidify {
        background: #E53935;
        color: white;
        font-weight: 700;
        border-radius: 8px;
        padding: 10px 22px;
        border: none;
    }

    .btn-aidify:hover {
        background: #c62828;
        color: white;
    }

    .option-card {
        border: 1px solid #e2e2e2;
        border-radius: 14px;
        padding: 22px 24px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: #fff;
    }

    .option-card h5 {
        font-weight: 800;
        margin-bottom: 6px;
    }

    .option-card p {
        color: #666;
        margin: 0;
    }

    .preview-check input {
        width: 28px;
        height: 28px;
        accent-color: #E53935;
    }

    .action-btn {
        min-width: 140px;
        padding: 12px 24px;
        font-weight: 700;
        border-radius: 10px;
    }

    @media (max-width: 992px) {
        .create-nav {
            display: none;
        }
    }
</style>

<header class="create-topbar">
    <div class="container d-flex justify-content-between align-items-center">

        <a href="../Dashboard.aspx" class="create-brand">
            <img src="<%= ResolveUrl("~/Images/aidify-kit.png") %>"
                 alt="Aidify Logo"
                 class="create-logo" />
            <span>Aidify</span>
        </a>

        <nav class="create-nav">
            <a href="../Dashboard.aspx">Dashboard</a>
            <a href="../Users/List.aspx">Users</a>
            <a href="../Content/ApprovalQueue.aspx">Approvals</a>
            <a href="../Analytics.aspx">Analytics</a>
        </nav>

        <div class="dropdown">
            <a href="#"
               class="create-dropdown"
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

<div class="create-module-wrap">

    <h1>Create New Module</h1>
    <p class="text-muted">Add a new learning module and up to four lessons to Aidify.</p>

    <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3"></asp:Label>

    <h4 class="section-title">Module Details</h4>

    <label class="form-label">Module Title</label>
    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" />

    <label class="form-label">Description</label>
    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />

    <label class="form-label">Difficulty Level</label>
    <asp:DropDownList ID="ddlDifficulty" runat="server" CssClass="form-select">
        <asp:ListItem Text="Beginner" Value="Beginner" />
        <asp:ListItem Text="Intermediate" Value="Intermediate" />
        <asp:ListItem Text="Advanced" Value="Advanced" />
    </asp:DropDownList>

    <div class="option-card mt-4">
        <div>
            <h5>Preview Module</h5>
            <p>Allow visitors or learners to preview this module before full access.</p>
        </div>

        <asp:CheckBox ID="chkPreview" runat="server" CssClass="preview-check" />
    </div>

    <h4 class="section-title">Lessons</h4>

    <div class="lesson-box">
        <h5>Lesson 1 <span class="text-danger">(Required)</span></h5>

        <label class="form-label">Lesson Title</label>
        <asp:TextBox ID="txtLessonTitle" runat="server" CssClass="form-control" />

        <label class="form-label">Lesson Content</label>
        <asp:TextBox ID="txtLessonContent" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" />

        <label class="form-label">Estimated Minutes</label>
        <asp:TextBox ID="txtEstimatedMinutes" runat="server" CssClass="form-control" TextMode="Number" />
    </div>

    <details class="lesson-box">
        <summary>Add Lesson 2 (Optional)</summary>

        <label class="form-label">Lesson Title</label>
        <asp:TextBox ID="txtLesson2Title" runat="server" CssClass="form-control" />

        <label class="form-label">Lesson Content</label>
        <asp:TextBox ID="txtLesson2Content" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" />

        <label class="form-label">Estimated Minutes</label>
        <asp:TextBox ID="txtLesson2Minutes" runat="server" CssClass="form-control" TextMode="Number" />
    </details>

    <details class="lesson-box">
        <summary>Add Lesson 3 (Optional)</summary>

        <label class="form-label">Lesson Title</label>
        <asp:TextBox ID="txtLesson3Title" runat="server" CssClass="form-control" />

        <label class="form-label">Lesson Content</label>
        <asp:TextBox ID="txtLesson3Content" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" />

        <label class="form-label">Estimated Minutes</label>
        <asp:TextBox ID="txtLesson3Minutes" runat="server" CssClass="form-control" TextMode="Number" />
    </details>

    <details class="lesson-box">
        <summary>Add Lesson 4 (Optional)</summary>

        <label class="form-label">Lesson Title</label>
        <asp:TextBox ID="txtLesson4Title" runat="server" CssClass="form-control" />

        <label class="form-label">Lesson Content</label>
        <asp:TextBox ID="txtLesson4Content" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" />

        <label class="form-label">Estimated Minutes</label>
        <asp:TextBox ID="txtLesson4Minutes" runat="server" CssClass="form-control" TextMode="Number" />
    </details>

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
            Text="Create Module"
            CssClass="btn-aidify action-btn"
            OnClick="btnCreate_Click" />

    </div>

</div>

</asp:Content>