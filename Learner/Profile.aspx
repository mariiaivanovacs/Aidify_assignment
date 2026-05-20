<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Aidify_assigment.Learner.Profile" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="container-fluid px-0">

    <%-- Page Header --%>
    <div class="mb-4">
        <h3 class="fw-bold mb-1">My Profile</h3>
        <p class="text-muted" style="font-size:13px;">View and update your personal information.</p>
    </div>

    <div class="row g-4">

        <%-- Left: Avatar Card --%>
        <div class="col-md-4">
            <div class="card shadow-sm text-center" style="border-radius:12px;">
                <div class="card-body p-4">
                    <div class="mb-3">
                        <asp:Image ID="imgAvatar" runat="server"
                            style="width:100px; height:100px; border-radius:50%; object-fit:cover; border:3px solid #C0392B;"
                            AlternateText="Avatar" />
                    </div>
                    <h5 class="fw-bold mb-0">
                        <asp:Label ID="lblDisplayName" runat="server" />
                    </h5>
                    <p class="text-muted" style="font-size:13px;">Learner</p>

                    <%-- Avatar Upload --%>
                    <div class="mt-3">
                        <label class="form-label fw-semibold" style="font-size:13px;">Change Avatar</label>
                        <asp:FileUpload ID="fuAvatar" runat="server" CssClass="form-control form-control-sm" />
                        <small class="text-muted">image/* only · max 2MB</small>
                    </div>
                </div>
            </div>
        </div>

        <%-- Right: Edit Form --%>
        <div class="col-md-8">
            <div class="card shadow-sm" style="border-radius:12px;">
                <div class="card-body p-4">
                    <h5 class="fw-bold mb-4">Account Details</h5>

                    <%-- Full Name --%>
                    <div class="mb-3">
                        <label class="form-label fw-semibold" style="font-size:13px;">Full Name</label>
                        <asp:TextBox ID="txtFullName" runat="server"
                            CssClass="form-control" placeholder="Your full name" />
                        <asp:RequiredFieldValidator ID="rfvFullName" runat="server"
                            ControlToValidate="txtFullName"
                            ErrorMessage="Name is required"
                            CssClass="text-danger small"
                            Display="Dynamic" />
                    </div>

                    <%-- Email --%>
                    <div class="mb-4">
                        <label class="form-label fw-semibold" style="font-size:13px;">Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server"
                            CssClass="form-control"
                            ReadOnly="true"
                            style="background:#f5f5f5; cursor:not-allowed;" />
                        <small class="text-muted">Email cannot be changed here.</small>
                    </div>

                    <%-- Save Button --%>
                    <div class="d-flex align-items-center gap-3">
                        <asp:Button ID="btnSaveProfile" runat="server"
                            Text="Save Changes"
                            CssClass="btn btn-primary px-4 py-2 fw-semibold"
                            OnClick="btnSaveProfile_Click" />
                        <asp:Label ID="lblProfileStatus" runat="server"
                            CssClass="text-success fw-semibold"
                            Visible="false" />
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>

</asp:Content>