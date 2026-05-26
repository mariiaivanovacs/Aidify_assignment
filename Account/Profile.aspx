<%@ Page Title="User Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Aidify_assigment.Account.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .profile-page { padding: 48px; background: #f9f9f9; font-family: Inter, Arial, sans-serif; }
    .profile-card { background: #fff; border: 1px solid #e4beb9; border-radius: 16px; padding: 28px; margin-bottom: 24px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
    .profile-header { display: flex; gap: 28px; align-items: center; }
    .profile-avatar { width: 140px; height: 140px; border-radius: 16px; object-fit: cover; border: 4px solid #fff; box-shadow: 0 4px 12px rgba(0,0,0,0.12); }
    .profile-title { font-size: 36px; font-weight: 700; margin: 0; color: #1a1c1c; }
    .badge { display: inline-block; padding: 6px 12px; border-radius: 999px; background: #ffdad6; color: #93000d; font-weight: 600; font-size: 13px; margin-right: 8px; }
    .grid { display: grid; grid-template-columns: 2fr 1fr; gap: 24px; }
    .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 18px; }
    .form-group label { display: block; font-weight: 600; font-size: 13px; margin-bottom: 6px; color: #5b403d; }
    .input { width: 100%; padding: 10px 12px; border: 1px solid #d8c4c1; border-radius: 10px; }
    .full { grid-column: span 2; }
    .btn-primary { background: #b7131a; color: white; border: none; padding: 12px 24px; border-radius: 10px; font-weight: 600; cursor: pointer; }
    .btn-secondary { background: #eeeeee; color: #1a1c1c; border: none; padding: 10px 18px; border-radius: 10px; font-weight: 600; cursor: pointer; }
    .info-row { margin-bottom: 16px; }
    .info-label { display: block; font-size: 12px; font-weight: 700; color: #5b403d; text-transform: uppercase; }
    .info-value { display: block; margin-top: 4px; }
    .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; }
    .stat-box { background: white; border: 1px solid #e4beb9; border-radius: 12px; padding: 18px; text-align: center; }
    .stat-number { font-size: 24px; font-weight: 700; }
    
}
</style>

<div class="profile-page">

    <div class="profile-card profile-header">
        <asp:Image ID="imgProfile" runat="server" CssClass="profile-avatar" ImageUrl="~/Images/auth-bg.jpg" />
        <div>
            <h1 class="profile-title">
                <asp:Label ID="lblFullNameHeader" runat="server" Text="User Name"></asp:Label>
            </h1>
            <span class="badge"><asp:Label ID="lblRoleHeader" runat="server" Text="Learner"></asp:Label></span>
            <p>Member since: <asp:Label ID="lblMemberSince" runat="server" Text="January 2026"></asp:Label></p>
            <asp:FileUpload ID="fuProfilePhoto" runat="server" />
            <asp:Button ID="btnUploadPhoto" runat="server" Text="Upload Photo" CssClass="btn-secondary" />
        </div>
    </div>

    <div class="grid">

        <div>
            <div class="profile-card">
                <h2>Personal Information</h2>

                <div class="form-grid">
                    <div class="form-group">
                        <label>Full Name</label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="input" TextMode="Email"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Phone Number</label>
                        <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Gender</label>
                        <asp:DropDownList ID="ddlGender" runat="server" CssClass="input">
                            <asp:ListItem>Female</asp:ListItem>
                            <asp:ListItem>Male</asp:ListItem>
                            <asp:ListItem>Other</asp:ListItem>
                            <asp:ListItem>Prefer not to say</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label>Date of Birth</label>
                        <asp:TextBox ID="txtDateOfBirth" runat="server" CssClass="input" TextMode="Date"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Emergency Contact</label>
                        <asp:TextBox ID="txtEmergencyContact" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <div class="form-group full">
                        <label>Bio / About Me</label>
                        <asp:TextBox ID="txtBio" runat="server" CssClass="input" TextMode="MultiLine" Rows="4"></asp:TextBox>
                    </div>
                </div>

                <br />
                <asp:Button ID="btnUpdateProfile" runat="server" Text="Update Profile" CssClass="btn-primary" />
                <asp:Label ID="lblProfileMessage" runat="server"></asp:Label>
            </div>

            <div class="profile-card">
                <h2>Security & Password</h2>

                <div class="form-grid">
                    <div class="form-group">
                        <label>Current Password</label>
                        <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="input" TextMode="Password"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>New Password</label>
                        <asp:TextBox ID="txtNewPassword" runat="server" CssClass="input" TextMode="Password"></asp:TextBox>
                    </div>

                    <div class="form-group full">
                        <label>Confirm New Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="input" TextMode="Password"></asp:TextBox>
                    </div>
                </div>

                <br />
                <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" CssClass="btn-secondary" />
                <asp:Label ID="lblPasswordMessage" runat="server"></asp:Label>
            </div>

            <div class="profile-card">
                <h2>Learner Progress</h2>
                <div class="stats-grid">
                    <div class="stat-box">
                        <div class="stat-number"><asp:Label ID="lblCompletedModules" runat="server" Text="0"></asp:Label></div>
                        <div>Completed Modules</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-number"><asp:Label ID="lblBadgesEarned" runat="server" Text="0"></asp:Label></div>
                        <div>Badges Earned</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-number"><asp:Label ID="lblLeagueTier" runat="server" Text="Bronze"></asp:Label></div>
                        <div>League Tier</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-number"><asp:Label ID="lblCertificates" runat="server" Text="0"></asp:Label></div>
                        <div>Certificates</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="profile-card">
            <h2>Account Info</h2>

            <div class="info-row">
                <span class="info-label">User ID</span>
                <span class="info-value"><asp:Label ID="lblUserId" runat="server" Text="#AID-0000"></asp:Label></span>
            </div>

            <div class="info-row">
                <span class="info-label">Role</span>
                <span class="info-value"><asp:Label ID="lblRole" runat="server" Text="Learner"></asp:Label></span>
            </div>

            <div class="info-row">
                <span class="info-label">Registration Date</span>
                <span class="info-value"><asp:Label ID="lblRegistrationDate" runat="server" Text="-"></asp:Label></span>
            </div>

            <div class="info-row">
                <span class="info-label">Email Status</span>
                <span class="info-value"><asp:Label ID="lblEmailStatus" runat="server" Text="Verified"></asp:Label></span>
            </div>
        </div>

    </div>
</div>

</asp:Content>