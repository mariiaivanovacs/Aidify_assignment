<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Aidify_assigment.Auth.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="auth-section">
        <div class="container">
            <div class="row auth-card">

                <div class="col-md-6 auth-left">
                    <h1>Aidify</h1>
                    <h2>Master Life-Saving Skills with Confidence.</h2>
                    <p>
                        Access structured first aid and emergency response learning modules designed
                        to build awareness and readiness.
                    </p>

                    <ul>
                        <li>Clinically inspired educational content</li>
                        <li>Preview modules and quizzes</li>
                        <li>Progress tracking after registration</li>
                    </ul>
                </div>

                <div class="col-md-6 auth-right">
                    <h2>Welcome Back</h2>
                    <p>Please enter your credentials to access your dashboard.</p>

                    <asp:Label ID="lblError" runat="server" CssClass="auth-error" Visible="false"></asp:Label>

                    <div class="mb-3">
                        <label>Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="example@email.com"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                            ErrorMessage="Email is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <div class="mb-3">
                        <label>Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                            ErrorMessage="Password is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="auth-check-row">
                            <asp:CheckBox ID="chkRememberMe" runat="server" />
                            <label for="chkRememberMe">Remember me</label>
                        </div>

                        <a href="ForgotPassword.aspx" class="auth-link">Forgot Password?</a>
                    </div>

                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-aidify w-100" />

                    <p class="auth-bottom-text">
                        Don't have an account?
                        <a href="Register.aspx">Register</a>
                    </p>
                </div>

            </div>
        </div>
    </section>

</asp:Content>