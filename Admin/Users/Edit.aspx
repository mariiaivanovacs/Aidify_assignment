<%@ Page Title="Edit User" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="Aidify_assigment.Admin.Users.Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        /* Hide public navbar and footer */
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
        }

        .btn-cancel:hover {
            border-color: #E53935;
            color: #E53935;
        }

        .activity-card {
            background-color: #ffffff;
            border: 1px solid #e2e2e2;
            border-radius: 16px;
            padding: 25px;
            height: 100%;
        }

        .activity-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
            font-size: 14px;
        }

        .activity-row:last-child {
            border-bottom: none;
        }

        .certified-card {
            background-color: #E53935;
            color: #ffffff;
            border-radius: 16px;
            padding: 32px 24px;
            text-align: center;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .certified-card h5 {
            font-weight: 800;
            margin-top: 14px;
            margin-bottom: 6px;
        }

        .certified-card p {
            font-size: 13px;
            opacity: 0.9;
            margin: 0;
        }

        /* Simple footer matching Image 2 */
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

        .certified-card {
            background: linear-gradient(145deg, #E53935 0%, #c62828 100%);
            position: relative;
            overflow: hidden;
        }

        .certified-card::before {
            content: "";
            position: absolute;
            top: -30px;
            right: -30px;
            width: 120px;
            height: 120px;
            background: rgba(255,255,255,0.08);
            border-radius: 50%;
        }

        .certified-card::after {
            content: "";
            position: absolute;
            bottom: -20px;
            left: -20px;
            width: 80px;
            height: 80px;
            background: rgba(255,255,255,0.06);
            border-radius: 50%;
        }

        .certified-icon-wrap {
            width: 64px;
            height: 64px;
            background: rgba(255,255,255,0.15);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin-bottom: 4px;
        }

        .certified-badge {
            margin-top: 12px;
            background: rgba(255,255,255,0.2);
            border-radius: 20px;
            padding: 4px 16px;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 0.5px;
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
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" Text="Julian" placeholder="Enter first name"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label>Last Name</label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" Text="Vance" placeholder="Enter last name"></asp:TextBox>
                    </div>
                </div>

                <div class="mb-4">
                    <label>Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" Text="julian.vance@medical-center.org" placeholder="Enter email address"></asp:TextBox>
                    <small class="text-muted">Professional email used for system notifications.</small>
                </div>

                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <label>Role Selection</label>
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select">
                            <asp:ListItem>Learner</asp:ListItem>
                            <asp:ListItem>Instructor</asp:ListItem>
                            <asp:ListItem Selected="True">Administrator</asp:ListItem>
                            <asp:ListItem>Supervisor</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-6">
                        <label>Department</label>
                        <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-select">
                            <asp:ListItem>Emergency Response</asp:ListItem>
                            <asp:ListItem Selected="True">First Aid Training</asp:ListItem>
                            <asp:ListItem>Clinical Operations</asp:ListItem>
                            <asp:ListItem>Logistics</asp:ListItem>
                        </asp:DropDownList>
                    </div>
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

                <div class="d-flex justify-content-end gap-3">
                    <a href="List.aspx" class="btn-cancel">Cancel</a>
                    <button type="submit" name="forceReset" value="1"
                            class="btn btn-outline-danger px-4"
                            onclick="return confirm('Send a password-reset link to this user?');">
                        <i class="bi bi-key me-1"></i> Send Reset Link
                    </button>
                    <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn btn-aidify px-4" />
                </div>

            </div>

            <!-- Bottom: Activity + Certified -->
            <div class="row g-4">
                <div class="col-md-8">
                    <div class="activity-card">
                        <h5 class="fw-bold mb-3">
                            <i class="bi bi-clock-history text-danger me-2"></i>
                            Recent Activity
                        </h5>
                        <div class="activity-row">
                            <span>Completed CPR Module</span>
                            <small class="text-muted">2h ago</small>
                        </div>
                        <div class="activity-row">
                            <span>Password Reset</span>
                            <small class="text-muted">Oct 12</small>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="certified-card">
                        <div class="certified-icon-wrap">
                            <i class="bi bi-shield-check"></i>
                        </div>
                        <h5>Certified User</h5>
                        <p>Level 4 First Responder Access</p>
                        <div class="certified-badge">✓ Verified</div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- Footer matching Image 2 dark style -->
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

</asp:Content>