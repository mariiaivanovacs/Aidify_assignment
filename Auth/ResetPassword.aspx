<%@ Page Title="Reset Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="Aidify_assigment.Auth.ResetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .reset-wrapper {
        min-height: 70vh;
        display: flex;
        justify-content: center;
        align-items: center;
        background: #f9f9f9;
        padding: 40px 20px;
    }

    .reset-box {
        width: 100%;
        max-width: 430px;
        text-align: center;
    }

    .reset-logo {
        color: #c8102e;
        font-size: 28px;
        font-weight: bold;
        margin-bottom: 25px;
    }

    .reset-title {
        font-size: 32px;
        font-weight: 700;
        margin-bottom: 15px;
        color: #1a1a1a;
    }

    .reset-subtitle {
        font-size: 17px;
        color: #5b403d;
        line-height: 1.6;
        margin-bottom: 30px;
    }

    .reset-card {
        background: white;
        border: 1px solid #eee;
        border-radius: 14px;
        padding: 28px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        text-align: left;
    }

    .reset-label {
        font-weight: 600;
        margin-bottom: 8px;
        color: #5b403d;
    }

    .reset-input {
        width: 100%;
        padding: 14px;
        border: 1px solid #e4beb9;
        border-radius: 10px;
        font-size: 16px;
        margin-bottom: 12px;
    }

    .password-help {
        font-size: 12px;
        color: #6c757d;
        margin-top: -4px;
        margin-bottom: 16px;
        line-height: 1.4;
    }

    .reset-btn {
        width: 100%;
        background: #c8102e;
        color: white;
        border: none;
        border-radius: 10px;
        padding: 15px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
    }

    .reset-btn:hover {
        background: #a80d25;
    }

    .reset-message {
        display: block;
        text-align: center;
        margin-top: 15px;
        font-weight: 600;
    }

    .tip-card {
        margin-top: 22px;
        background: #eeeeee;
        border: 1px solid #ddd;
        border-radius: 14px;
        padding: 18px;
        text-align: left;
        display: flex;
        gap: 14px;
    }

    .tip-icon {
        color: #c8102e;
        font-size: 22px;
    }

    .tip-title {
        font-weight: 700;
        margin-bottom: 4px;
        color: #1a1a1a;
    }

    .tip-text {
        font-size: 14px;
        color: #5b403d;
        line-height: 1.4;
    }

    .reset-back {
        display: block;
        text-align: center;
        margin-top: 28px;
        color: #c8102e;
        font-weight: 600;
        text-decoration: none;
    }

    .reset-pass-wrapper {
        position: relative;
    }

    .reset-pass-wrapper .reset-input {
        padding-right: 45px;
    }

    .reset-eye-toggle {
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
    }


</style>

<div class="reset-wrapper">
    <div class="reset-box">

        <div class="reset-logo">✚ Aidify</div>

        <h1 class="reset-title">Reset Password</h1>

        <p class="reset-subtitle">
            Create a new, strong password for your account.
        </p>

        <div class="reset-card">

            <div class="reset-label">New Password</div>

           <div class="reset-pass-wrapper">
                <asp:TextBox
                    ID="txtNewPassword"
                    runat="server"
                    CssClass="reset-input"
                    TextMode="Password"
                    placeholder="Enter new password">
                </asp:TextBox>

                <button type="button"
                        class="reset-eye-toggle"
                        onclick="togglePassword('<%= txtNewPassword.ClientID %>', this)">
                    👁️
                </button>
            </div>

            <div class="reset-label">Confirm New Password</div>

            <div class="reset-pass-wrapper">
                <asp:TextBox
                    ID="txtConfirmPassword"
                    runat="server"
                    CssClass="reset-input"
                    TextMode="Password"
                    placeholder="Repeat new password">
                </asp:TextBox>

                <button type="button"
                        class="reset-eye-toggle"
                        onclick="togglePassword('<%= txtConfirmPassword.ClientID %>', this)">
                    👁️
                </button>
            </div>

            <div class="password-help">
                Use at least 8 characters with uppercase, lowercase, number, and special symbol.
            </div>

            <asp:Button
                ID="btnReset"
                runat="server"
                Text="Reset Password"
                CssClass="reset-btn"
                OnClick="btnReset_Click" />

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="reset-message">
            </asp:Label>

        </div>

        <div class="tip-card">
            <div class="tip-icon">🛡</div>
            <div>
                <div class="tip-title">Security Tip</div>
                <div class="tip-text">
                    Avoid using common words or personal information like your birthdate or phone number.
                </div>
            </div>
        </div>

        <a href="Login.aspx" class="reset-back">← Back to Login</a>

    </div>
</div>

<script>
    function togglePassword(inputId, btn) {
        var input = document.getElementById(inputId);

        if (input.type === "password") {
            input.type = "text";
            btn.innerText = "🙈";
        }
        else {
            input.type = "password";
            btn.innerText = "👁️";
        }
    }
</script>

</asp:Content>