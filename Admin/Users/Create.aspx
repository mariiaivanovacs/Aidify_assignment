<%@ Page Title="Create User" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="Aidify_assigment.Admin.Users.Create" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .aidify-navbar, .aidify-footer { display:none!important; }
    body { background:#f9f9f9; }

    .create-user-page { padding:45px 0 70px; }

    .create-card {
        background:#fff;
        border:1px solid #e2e2e2;
        border-radius:16px;
        padding:34px;
        max-width:900px;
        box-shadow:0 8px 22px rgba(0,0,0,.05);
    }

    .form-label { font-weight:700; color:#111827; }

    .form-control, .form-select {
        border-radius:9px;
        padding:13px 15px;
        border:1px solid #f0a2a2;
    }

    .btn-aidify {
        background:#d90429;
        color:white;
        border:none;
        border-radius:10px;
        padding:12px 28px;
        font-weight:800;
    }

    .btn-aidify:hover { background:#b70323; color:white; }

    .status-box {
        border:1px solid #e2e2e2;
        border-radius:10px;
        padding:18px 20px;
        display:flex;
        justify-content:space-between;
        align-items:center;
        margin-top:10px;
    }

    .toggle-switch input[type="checkbox"] {
        width:46px;
        height:24px;
        cursor:pointer;
        accent-color:#e53935;
    }

    .btn-cancel {
        border:1px solid #d0d0d0;
        background:#fff;
        color:#333;
        font-weight:600;
        border-radius:8px;
        padding:10px 28px;
        text-decoration:none;
        display:inline-block;
        cursor:pointer;
    }

    .btn-cancel:hover {
        background-color:#6c757d;
        border-color:#6c757d;
        color:#ffffff;
    }

    .info-box {
        background:#fff5f5;
        border:1px solid #f3b6b6;
        border-radius:12px;
        padding:16px 18px;
        color:#5b403d;
        margin-bottom:20px;
        font-size:14px;
    }
</style>

<main class="create-user-page">
    <div class="container">

        <div class="mb-4">
            <div class="text-muted small mb-2">Admin Module / Users / Create User</div>
            <h1 class="fw-bold display-6">Create New User</h1>
            <p class="text-muted fs-5 mb-0">
                Add a new learner, instructor, or administrator account to Aidify.
            </p>
        </div>

        <div class="create-card">

            <asp:Label ID="lblMessage" runat="server" CssClass="text-success fw-bold d-block mb-3" Visible="false"></asp:Label>
            <asp:Label ID="lblError" runat="server" CssClass="text-danger fw-bold d-block mb-3" Visible="false"></asp:Label>

            <div class="info-box">
                A password setup link will be emailed to the new user. Admin does not set or view the user password.
            </div>

            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter full name"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFullName" ErrorMessage="Full name is required." CssClass="text-danger small" Display="Dynamic" />
            </div>

            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="example@aidify.edu"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." CssClass="text-danger small" Display="Dynamic" />
            </div>

            <div class="mb-3">
                <label class="form-label">Role Selection</label>
                <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Learner" Value="Learner"></asp:ListItem>
                    <asp:ListItem Text="Instructor" Value="Instructor"></asp:ListItem>
                    <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="status-box">
                <div>
                    <strong>Account Status</strong><br />
                    <small class="text-muted">Enable or disable user access to the Aidify platform.</small>
                </div>
                <asp:CheckBox ID="chkIsActive" runat="server" CssClass="toggle-switch" Checked="true" />
            </div>

            <div class="d-flex justify-content-end gap-3 mt-4">
                <button type="button" onclick="clearFields()" class="btn-cancel">
                    Clear
                </button>

                <a href="List.aspx" class="btn-cancel">Go Back</a>

                <asp:Button ID="btnCreateUser" runat="server" Text="Create User" CssClass="btn btn-aidify" />
            </div>

        </div>
    </div>
</main>

<script>
    function clearFields() {
        document.getElementById('<%= txtFullName.ClientID %>').value = '';
        document.getElementById('<%= txtEmail.ClientID %>').value = '';
        document.getElementById('<%= ddlRole.ClientID %>').selectedIndex = 0;
    }
</script>

</asp:Content>