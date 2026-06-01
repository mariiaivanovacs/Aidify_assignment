<%@ Page Title="Edit User" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="Aidify_assigment.Admin.Users.Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .aidify-navbar,
        .aidify-footer {
            display: none !important;
        }

        body {
            background-color: #f9f9f9;
        }

        .admin-edit-page {
            background-color: #f9f9f9;
            padding: 55px 0 70px;
        }

        .breadcrumb-text {
            font-size: 13px;
            color: #5b403d;
            margin-bottom: 12px;
        }

        .breadcrumb-text a {
            color: #5b403d;
            text-decoration: none;
        }

        .breadcrumb-text a:hover {
            color: #E53935;
        }

        .admin-edit-page h1 {
            font-size: 36px;
            font-weight: 800;
            color: #1f2933;
            margin-bottom: 8px;
        }

        .edit-form-card {
            background-color: #ffffff;
            border: 1px solid #e2e2e2;
            border-radius: 16px;
            padding: 34px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.04);
        }

        .edit-form-card label {
            font-weight: 600;
            color: #1f2933;
            margin-bottom: 6px;
            display: block;
        }

        .edit-form-card .form-control,
        .edit-form-card .form-select {
            border: 1.5px solid #e4beb9;
            border-radius: 8px;
            height: 46px;
            font-size: 15px;
            background-color: #fff;
        }

        .edit-form-card .form-control:focus,
        .edit-form-card .form-select:focus {
            border-color: #E53935;
            box-shadow: none;
        }

        .status-box {
            background-color: #f9f9f9;
            border: 1px solid #e2e2e2;
            border-radius: 10px;
            padding: 16px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .btn-cancel {
            border: 1px solid #d0d0d0;
            background: #fff;
            color: #333;
            font-weight: 600;
            border-radius: 8px;
            padding: 10px 28px;
            text-decoration: none;
            display: inline-block;
        }

        .btn-cancel:hover {
            background-color: #6c757d;
            border-color: #6c757d;
            color: #ffffff;
        }

        .btn-aidify {
            background: #d90429;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 28px;
            font-weight: 800;
        }

        .btn-aidify:hover {
            background: #b70323;
            color: white;
        }

        /* Toggle Switch */
        .toggle-switch {
            position: relative;
            width: 48px;
            height: 26px;
            flex-shrink: 0;
        }

        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .toggle-slider {
            position: absolute;
            cursor: pointer;
            top: 0; left: 0; right: 0; bottom: 0;
            background-color: #ccc;
            border-radius: 26px;
            transition: 0.3s;
        }

        .toggle-slider:before {
            position: absolute;
            content: "";
            height: 20px;
            width: 20px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            border-radius: 50%;
            transition: 0.3s;
        }

        .toggle-switch input:checked + .toggle-slider {
            background-color: #E53935;
        }

        .toggle-switch input:checked + .toggle-slider:before {
            transform: translateX(22px);
        }

        /* Footer */
        .admin-edit-footer {
            background-color: #1f2933;
            color: #ffffff;
            padding: 36px 0 20px;
            margin-top: 60px;
        }

        .admin-edit-footer .footer-brand {
            font-size: 18px;
            font-weight: 800;
            color: #ffffff;
        }

        .admin-edit-footer .footer-tagline {
            color: #aaa;
            font-size: 13px;
            margin-top: 4px;
        }

        .admin-edit-footer .footer-disclaimer {
            color: #E53935;
            font-size: 12px;
            margin-top: 8px;
        }

        .admin-edit-footer a {
            color: #ccc;
            text-decoration: none;
            font-size: 14px;
        }

        .admin-edit-footer a:hover {
            color: #ffffff;
        }

        .admin-edit-footer .copyright {
            color: #aaa;
            font-size: 13px;
            margin-top: 6px;
        }
    </style>

    <div class="admin-edit-page">
        <div class="container" style="max-width: 860px;">

            <!-- Breadcrumb -->
            <div class="breadcrumb-text">
                <a href="../Dashboard.aspx">Admin Module</a> /
                <a href="List.aspx">Users</a> /
                Edit User
            </div>

            <h1>Edit User Profile</h1>
            <p class="text-muted mb-4">
                Update user credentials, department assignments, and system access levels.
            </p>

            <!-- Form Card -->
            <div class="edit-form-card mb-4">

                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <label>First Name</label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" placeholder="Enter first name"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label>Last Name</label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" placeholder="Enter last name"></asp:TextBox>
                    </div>
                </div>

                <div class="mb-4">
                    <label>Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Enter email address"></asp:TextBox>
                    <small class="text-muted">Professional email used for system notifications.</small>
                </div>

                <div class="mb-4">
                    <label>Role Selection</label>
                    <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select">
                        <asp:ListItem>Learner</asp:ListItem>
                        <asp:ListItem>Instructor</asp:ListItem>
                        <asp:ListItem>Admin</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="status-box mb-4">
                    <div>
                        <strong>Account Status</strong>
                        <p class="text-muted mb-0 small">Enable or disable user access to the Aidify platform.</p>
                    </div>
                    <label class="toggle-switch">
                        <input type="checkbox" checked="checked" />
                        <span class="toggle-slider"></span>
                    </label>
                </div>

                <%-- ONE button row only --%>
                <div class="d-flex justify-content-end gap-3">
                    <button type="button" onclick="clearFields()" class="btn-cancel">
                        Clear
                    </button>
                    <a href="List.aspx" class="btn-cancel">Go Back</a>
                    <button type="submit" name="forceReset" value="1"
                            class="btn btn-outline-danger px-4"
                            onclick="return confirm('Send a password-reset link to this user?');">
                        <i class="bi bi-key me-1"></i> Send Reset Link
                    </button>
                    <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn btn-aidify px-4" />
                </div>

            </div>

        </div>
    </div>

    <!-- Footer -->
    <footer class="admin-edit-footer">
        <div class="container">
            <div class="d-flex justify-content-between align-items-start flex-wrap gap-4">

                <div>
                    <div class="footer-brand">Aidify</div>
                    <div class="footer-tagline">First Aid &amp; Emergency Response Learning Platform</div>
                    <div class="footer-disclaimer">
                        Aidify is for educational purposes only. Always call emergency services in a real emergency.
                    </div>
                </div>

                <div class="text-end">
                    <div class="d-flex gap-4 justify-content-end mb-2">
                        <a href="../../Default.aspx">Home</a>
                        <a href="../../Public/About.aspx">About</a>
                        <a href="../../Public/FAQ.aspx">FAQ</a>
                        <a href="../../Public/Contact.aspx">Contact</a>
                    </div>
                    <div class="copyright">© 2026 Aidify. All rights reserved.</div>
                </div>

            </div>
        </div>
    </footer>

    <script>
        function clearFields() {
            document.getElementById('<%= txtFirstName.ClientID %>').value = '';
            document.getElementById('<%= txtLastName.ClientID %>').value = '';
            document.getElementById('<%= txtEmail.ClientID %>').value = '';
            document.getElementById('<%= ddlRole.ClientID %>').selectedIndex = 0;
        }
    </script>

</asp:Content>