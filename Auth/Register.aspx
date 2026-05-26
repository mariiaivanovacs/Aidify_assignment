<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Aidify_assigment.Auth.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .reg-pass-wrapper {
            flex: 1;
            position: relative;
        }

        .reg-pass-wrapper .form-control {
            padding-right: 44px;
        }

        .reg-eye-toggle {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            font-size: 18px;
            padding: 0;
            line-height: 1;
            z-index: 10;
        }
    </style>

    <section class="auth-section">
        <div class="container">
            <div class="row auth-card">

                <div class="col-md-6 auth-left">
                    <h1>Aidify</h1>

                    <h2>Master life-saving skills today.</h2>

                    <p>
                        Create an account to access first aid learning modules,
                        quizzes, badges, certificates, and progress tracking.
                    </p>

                    <ul>
                        <li>Structured first aid modules</li>
                        <li>Interactive quizzes</li>
                        <li>Progress tracking and certificates</li>
                    </ul>
                </div>

                <div class="col-md-6 auth-right">

                    <h2>Create Your Account</h2>

                    <p>
                        Fill in the details below to begin your training.
                    </p>

                    <asp:Panel ID="pnlSuccess"
                        runat="server"
                        CssClass="auth-success"
                        Visible="false">
                        Account created successfully. You can now log in.
                    </asp:Panel>

                    <asp:Label ID="lblError"
                        runat="server"
                        CssClass="auth-error"
                        Visible="false">
                    </asp:Label>

                    <!-- Full Name -->
                    <div class="mb-3">
                        <label>Full Name</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-person"></i>
                            </span>
                            <asp:TextBox ID="txtFullName"
                                runat="server"
                                CssClass="form-control"
                                placeholder="Enter full name">
                            </asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvFullName"
                            runat="server"
                            ControlToValidate="txtFullName"
                            ErrorMessage="Name is required"
                            CssClass="text-danger"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <!-- Email -->
                    <div class="mb-3">
                        <label>Email Address</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-envelope"></i>
                            </span>
                            <asp:TextBox ID="txtEmail"
                                runat="server"
                                CssClass="form-control"
                                TextMode="Email"
                                placeholder="example@email.com">
                            </asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvEmail"
                            runat="server"
                            ControlToValidate="txtEmail"
                            ErrorMessage="Email is required"
                            CssClass="text-danger"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <!-- Password -->
                    <div class="mb-3">
                        <label>Password</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-lock"></i>
                            </span>
                            <div class="reg-pass-wrapper">
                                <asp:TextBox ID="txtPassword"
                                    runat="server"
                                    CssClass="form-control"
                                    TextMode="Password"
                                    placeholder="Enter password">
                                </asp:TextBox>
                                <button type="button" class="reg-eye-toggle" onclick="toggleReg('<%=txtPassword.ClientID%>', this)">👁️</button>
                            </div>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPassword"
                            runat="server"
                            ControlToValidate="txtPassword"
                            ErrorMessage="Password is required"
                            CssClass="text-danger"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <!-- Confirm Password -->
                    <div class="mb-3">
                        <label>Confirm Password</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-shield-check"></i>
                            </span>
                            <div class="reg-pass-wrapper">
                                <asp:TextBox ID="txtConfirmPassword"
                                    runat="server"
                                    CssClass="form-control"
                                    TextMode="Password"
                                    placeholder="Confirm password">
                                </asp:TextBox>
                                <button type="button" class="reg-eye-toggle" onclick="toggleReg('<%=txtConfirmPassword.ClientID%>', this)">👁️</button>
                            </div>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvConfirmPassword"
                            runat="server"
                            ControlToValidate="txtConfirmPassword"
                            ErrorMessage="Please confirm password"
                            CssClass="text-danger"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvConfirmPassword"
                            runat="server"
                            ControlToValidate="txtConfirmPassword"
                            ControlToCompare="txtPassword"
                            ErrorMessage="Passwords do not match"
                            CssClass="text-danger"
                            Display="Dynamic">
                        </asp:CompareValidator>
                    </div>

                    <!-- Terms -->
                    <div class="mb-4 auth-check-row">
                        <asp:CheckBox ID="CheckBox1" runat="server" />
                        <label for="chkTerms">I agree to the Terms and Privacy Policy</label>
                    </div>
                    <div id="termsError" class="text-danger" style="display:none; margin-top:-10px; margin-bottom:10px; font-size:13px;">
                        ⚠ You must agree to the Terms and Privacy Policy.
                    </div>

                    <!-- General error -->
                    <div id="generalError" class="text-danger" style="display:none; margin-bottom:10px; font-size:13px;">
                        ⚠ Please fill in all the fields.
                    </div>

                    <!-- Button -->
                    <asp:Button ID="btnRegister"
                        runat="server"
                        Text="Create Account"
                        CssClass="btn btn-aidify w-100"
                        OnClientClick="return validateAll()" />

                    <!-- Login Link -->
                    <p class="auth-bottom-text">
                        Already have an account?
                        <a href="Login.aspx">Login</a>
                    </p>

                </div>

            </div>
        </div>
    </section>

    <script>
        function toggleReg(inputId, btn) {
            const input = document.getElementById(inputId);
            if (input.type === 'password') {
                input.type = 'text';
                btn.innerText = '🙈';
            } else {
                input.type = 'password';
                btn.innerText = '👁️';
            }
        }

        function validateAll() {
            const fullName = document.getElementById('<%= txtFullName.ClientID %>');
            const email = document.getElementById('<%= txtEmail.ClientID %>');
            const password   = document.getElementById('<%= txtPassword.ClientID %>');
            const confirm    = document.getElementById('<%= txtConfirmPassword.ClientID %>');
            const cb         = document.getElementById('<%= CheckBox1.ClientID %>');
            const termsErr = document.getElementById('termsError');
            const generalErr = document.getElementById('generalError');

            // reset both errors
            termsErr.style.display = 'none';
            generalErr.style.display = 'none';
            generalErr.innerText = '⚠ Please fill in all the fields.';

            // 1. check empty fields first
            if (!fullName.value.trim() || !email.value.trim() || !password.value.trim() || !confirm.value.trim()) {
                generalErr.style.display = 'block';
                return false;
            }

            // 2. check passwords match
            if (password.value !== confirm.value) {
                generalErr.innerText = '⚠ Passwords do not match.';
                generalErr.style.display = 'block';
                return false;
            }

            // 3. check terms last
            if (!cb.checked) {
                termsErr.style.display = 'block';
                return false;
            }

            return true;
        }
    </script>

</asp:Content>