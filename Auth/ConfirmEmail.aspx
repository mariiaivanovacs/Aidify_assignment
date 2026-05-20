<%@ Page Title="Confirm Email" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConfirmEmail.aspx.cs" Inherits="Aidify_assigment.Auth.ConfirmEmail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .confirm-wrapper {
        min-height: 70vh;
        display: flex;
        justify-content: center;
        align-items: center;
        background: #f9f9f9;
        padding: 40px 20px;
    }

    .confirm-popup {
        background: white;
        border-radius: 18px;
        box-shadow: 0 8px 30px rgba(0,0,0,0.12);
        padding: 36px 28px 28px;
        width: 100%;
        max-width: 340px;
        text-align: center;
        position: relative;
    }

    .confirm-close {
        position: absolute;
        top: 16px;
        right: 18px;
        font-size: 18px;
        color: #999;
        text-decoration: none;
        font-weight: 400;
        line-height: 1;
    }

    .confirm-logo-top {
        font-size: 15px;
        font-weight: 700;
        color: #c8102e;
        text-align: left;
        margin-bottom: 20px;
    }

    .confirm-img-wrap {
        width: 110px;
        height: 110px;
        border-radius: 50%;
        background: #e8e8e8;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 22px;
        overflow: hidden;
    }

    .confirm-title {
        font-size: 22px;
        font-weight: 700;
        color: #1a1a1a;
        margin-bottom: 10px;
    }

    .confirm-subtitle {
        font-size: 14px;
        color: #5b403d;
        line-height: 1.6;
        margin-bottom: 22px;
    }

    .confirm-label {
        font-size: 13px;
        font-weight: 600;
        color: #1a1a1a;
        text-align: left;
        margin-bottom: 10px;
    }

    .digit-row {
        display: flex;
        justify-content: center;
        gap: 8px;
        margin-bottom: 20px;
    }

    .digit-box {
        width: 42px;
        height: 48px;
        border: 1.5px solid #ddd;
        border-radius: 8px;
        font-size: 20px;
        font-weight: 600;
        text-align: center;
        color: #1a1a1a;
        outline: none;
        transition: border-color 0.2s;
    }

    .digit-box:focus {
        border-color: #c8102e;
    }

    .confirm-input-hidden {
        display: none;
    }

    .confirm-btn {
        width: 100%;
        background: #c8102e;
        color: white;
        border: none;
        border-radius: 10px;
        padding: 14px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        margin-bottom: 14px;
    }

    .confirm-btn:hover {
        background: #a80d25;
    }

    .confirm-message {
        display: block;
        text-align: center;
        margin-bottom: 10px;
        font-weight: 600;
        font-size: 14px;
    }

    .resend-success {
        color: green;
        font-weight: 600;
        font-size: 14px;
        text-align: center;
        margin-bottom: 10px;
        display: none;
    }

    .confirm-resend {
        font-size: 13px;
        color: #5b403d;
        margin-bottom: 24px;
    }

    .confirm-resend a {
        color: #c8102e;
        font-weight: 600;
        text-decoration: none;
    }

    .confirm-resend span {
        color: #5b403d;
        font-weight: 600;
    }

    .confirm-footer {
        border-top: 1px solid #eee;
        padding-top: 16px;
        font-size: 11px;
        color: #aaa;
        text-align: center;
        line-height: 1.8;
    }

    .confirm-footer-lock {
        font-size: 13px;
        margin-bottom: 2px;
    }
</style>

<div class="confirm-wrapper">
    <div class="confirm-popup">

        <a href="Login.aspx" class="confirm-close">&#x2715;</a>

        <div class="confirm-logo-top">Aidify</div>

        <div class="confirm-img-wrap">
            <span style="font-size:52px;">✉️</span>
        </div>

        <div class="confirm-title">Confirm Email</div>

        <p class="confirm-subtitle">
            A verification code has been sent to your email. Please enter it below to continue.
        </p>

        <div class="confirm-label">Verification Code</div>

        <div class="digit-row">
            <input class="digit-box" maxlength="1" type="text" id="d1" inputmode="numeric" />
            <input class="digit-box" maxlength="1" type="text" id="d2" inputmode="numeric" />
            <input class="digit-box" maxlength="1" type="text" id="d3" inputmode="numeric" />
            <input class="digit-box" maxlength="1" type="text" id="d4" inputmode="numeric" />
            <input class="digit-box" maxlength="1" type="text" id="d5" inputmode="numeric" />
            <input class="digit-box" maxlength="1" type="text" id="d6" inputmode="numeric" />
        </div>

        <asp:TextBox ID="txtCode" runat="server" CssClass="confirm-input-hidden" />

        <asp:Button
            ID="btnVerify"
            runat="server"
            Text="Verify ✓"
            CssClass="confirm-btn"
            OnClientClick="combineDigits()"
            OnClick="btnVerify_Click" />

        <asp:Label
            ID="lblMessage"
            runat="server"
            CssClass="confirm-message">
        </asp:Label>

        <div id="resendMsg" class="resend-success">
            ✔ Code resent successfully!
        </div>

        <div class="confirm-resend">
            Didn't receive the code?
            <a href="#" id="resendLink" onclick="resendCode(); return false;">Resend Code</a>
            <span id="resendTimer" style="display:none;"></span>
        </div>

        <div class="confirm-footer">
            <div class="confirm-footer-lock">🔒 Secure Verification Protocol</div>
            <div>AIDIFY HEALTH SYSTEMS</div>
        </div>

    </div>
</div>

<script>
    const digits = [
        document.getElementById('d1'),
        document.getElementById('d2'),
        document.getElementById('d3'),
        document.getElementById('d4'),
        document.getElementById('d5'),
        document.getElementById('d6')
    ];

    digits.forEach((box, i) => {
        box.addEventListener('input', function () {
            this.value = this.value.replace(/[^0-9]/g, '');
            if (this.value && i < 5) digits[i + 1].focus();
        });

        box.addEventListener('keydown', function (e) {
            if (e.key === 'Backspace' && !this.value && i > 0) digits[i - 1].focus();
        });
    });

    function combineDigits() {
        const code = digits.map(b => b.value).join('');
        document.getElementById('<%= txtCode.ClientID %>').value = code;
    }

    function resendCode() {
        const link = document.getElementById('resendLink');
        const timer = document.getElementById('resendTimer');
        const msg = document.getElementById('resendMsg');

        // show success message for 4 seconds
        msg.style.display = 'block';
        setTimeout(() => msg.style.display = 'none', 4000);

        // hide link, show countdown
        link.style.display = 'none';
        timer.style.display = 'inline';

        let seconds = 30;
        timer.innerText = `Resend in ${seconds}s`;

        const interval = setInterval(() => {
            seconds--;
            timer.innerText = `Resend in ${seconds}s`;

            if (seconds <= 0) {
                clearInterval(interval);
                timer.style.display = 'none';
                link.style.display = 'inline';
            }
        }, 1000);
    }
</script>

</asp:Content>