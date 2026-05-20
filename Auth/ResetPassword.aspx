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
        margin-bottom: 0;
    }

    .reset-input.input-error {
        border-color: #c8102e;
        background: #fff5f5;
    }

    .error-text {
        color: #c8102e;
        font-size: 13px;
        font-weight: 600;
        margin-top: 6px;
        margin-bottom: 10px;
        display: none;
    }

    .strength-row {
        display: flex;
        justify-content: space-between;
        font-size: 14px;
        font-weight: 600;
        color: #5b403d;
        margin-bottom: 8px;
    }

    .strength-bar-bg {
        width: 100%;
        height: 6px;
        background: #ddd;
        border-radius: 10px;
        overflow: hidden;
        margin-bottom: 20px;
    }

    .strength-bar-fill {
        width: 25%;
        height: 100%;
        background: #c8102e;
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

    .reset-message {
        display: block;
        text-align: center;
        margin-top: 15px;
        font-weight: 600;
    }

    .reset-back {
        display: block;
        text-align: center;
        margin-top: 28px;
        color: #c8102e;
        font-weight: 600;
        text-decoration: none;
    }

    .password-wrapper {
        position: relative;
        margin-bottom: 0;
    }

    .password-wrapper .reset-input {
        margin-bottom: 0;
        padding-right: 44px;
    }

    .eye-toggle {
        position: absolute;
        right: 14px;
        top: 50%;
        transform: translateY(-50%);
        background: none;
        border: none;
        cursor: pointer;
        font-size: 18px;
        color: #5b403d;
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

            <div class="password-wrapper">
                <asp:TextBox 
                    ID="txtNewPassword" 
                    runat="server" 
                    CssClass="reset-input"
                    TextMode="Password"
                    placeholder="Min. 8 characters">
                </asp:TextBox>
                <button type="button" class="eye-toggle" onclick="toggleVisibility('<%=txtNewPassword.ClientID%>', this)">👁️</button>
            </div>
            <div class="error-text" id="errNewPassword">⚠ Please fill in this field.</div>

            <div class="reset-label" style="margin-top:14px;">Confirm New Password</div>

            <div class="password-wrapper">
                <asp:TextBox 
                    ID="txtConfirmPassword" 
                    runat="server" 
                    CssClass="reset-input"
                    TextMode="Password"
                    placeholder="Repeat new password">
                </asp:TextBox>
                <button type="button" class="eye-toggle" onclick="toggleVisibility('<%=txtConfirmPassword.ClientID%>', this)">👁️</button>
            </div>
            <div class="error-text" id="errConfirmPassword">⚠ Please fill in this field.</div>
            <div class="error-text" id="errMismatch">⚠ Passwords do not match. Please try again.</div>

            <div class="strength-row" style="margin-top:14px;">
                <span>Password Strength</span>
                <span id="strengthText">Weak</span>
            </div>

            <div class="strength-bar-bg">
                <div class="strength-bar-fill" id="strengthBar"></div>
            </div>

            <asp:Button
                ID="btnReset"
                runat="server"
                Text="Reset Password"
                CssClass="reset-btn"
                OnClientClick="return validateForm()"
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
    const passwordInput = document.getElementById('<%= txtNewPassword.ClientID %>');
    const strengthBar = document.getElementById('strengthBar');
    const strengthText = document.getElementById('strengthText');

    passwordInput.addEventListener('input', function () {
        let length = passwordInput.value.length;

        if (length < 5) {
            strengthBar.style.width = '25%';
            strengthBar.style.background = '#c8102e';
            strengthText.innerText = 'Weak';
        }
        else if (length < 8) {
            strengthBar.style.width = '60%';
            strengthBar.style.background = 'orange';
            strengthText.innerText = 'Medium';
        }
        else {
            strengthBar.style.width = '100%';
            strengthBar.style.background = 'green';
            strengthText.innerText = 'Strong';
        }

        clearError('<%= txtNewPassword.ClientID %>', 'errNewPassword');
    });

    document.getElementById('<%= txtConfirmPassword.ClientID %>').addEventListener('input', function () {
        this.classList.remove('input-error');
        hideError('errConfirmPassword');
        hideError('errMismatch');
    });

    function toggleVisibility(inputId, btn) {
        const input = document.getElementById(inputId);
        if (input.type === 'password') {
            input.type = 'text';
            btn.innerText = '🙈';
        } else {
            input.type = 'password';
            btn.innerText = '👁️';
        }
    }

    function validateForm() {
        const newPass = document.getElementById('<%= txtNewPassword.ClientID %>');
        const confirmPass = document.getElementById('<%= txtConfirmPassword.ClientID %>');
        let valid = true;

        hideError('errNewPassword');
        hideError('errConfirmPassword');
        hideError('errMismatch');
        newPass.classList.remove('input-error');
        confirmPass.classList.remove('input-error');

        if (!newPass.value.trim()) {
            showError('errNewPassword');
            newPass.classList.add('input-error');
            valid = false;
        }

        if (!confirmPass.value.trim()) {
            showError('errConfirmPassword');
            confirmPass.classList.add('input-error');
            valid = false;
        }

        if (newPass.value.trim() && confirmPass.value.trim() && newPass.value !== confirmPass.value) {
            showError('errMismatch');
            confirmPass.classList.add('input-error');
            valid = false;
        }

        return valid;
    }

    function showError(id) {
        document.getElementById(id).style.display = 'block';
    }

    function hideError(id) {
        document.getElementById(id).style.display = 'none';
    }

    function clearError(inputId, errorId) {
        document.getElementById(inputId).classList.remove('input-error');
        hideError(errorId);
    }
</script>

</asp:Content>