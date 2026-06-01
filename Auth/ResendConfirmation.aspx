<%@ Page Title="Resend Confirmation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResendConfirmation.aspx.cs" Inherits="Aidify_assigment.Auth.ResendConfirmation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .resend-wrapper {
        min-height: 70vh;
        display: flex;
        justify-content: center;
        align-items: center;
        background: #f9f9f9;
        padding: 40px 20px;
    }

    .resend-box {
        width: 100%;
        max-width: 430px;
        text-align: center;
    }

    .resend-logo {
        color: #c8102e;
        font-size: 28px;
        font-weight: bold;
        margin-bottom: 25px;
    }

    .resend-title {
        font-size: 32px;
        font-weight: 700;
        margin-bottom: 15px;
        color: #1a1a1a;
    }

    .resend-subtitle {
        font-size: 17px;
        color: #5b403d;
        line-height: 1.6;
        margin-bottom: 30px;
    }

    .resend-card {
        background: white;
        border: 1px solid #eee;
        border-radius: 14px;
        padding: 28px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        text-align: left;
    }

    .resend-label {
        font-weight: 600;
        margin-bottom: 8px;
        color: #5b403d;
    }

    .resend-input {
        width: 100%;
        padding: 14px;
        border: 1px solid #e4beb9;
        border-radius: 10px;
        font-size: 16px;
        margin-bottom: 18px;
    }

    .resend-btn {
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

    .resend-btn:hover {
        background: #a80d25;
    }

    .resend-message {
        display: block;
        text-align: center;
        margin-top: 15px;
        font-weight: 600;
    }

    .resend-back {
        display: block;
        text-align: center;
        margin-top: 28px;
        color: #c8102e;
        font-weight: 600;
        text-decoration: none;
    }
</style>

<div class="resend-wrapper">
    <div class="resend-box">

        <div class="resend-logo">✚ Aidify</div>

        <h1 class="resend-title">Resend Confirmation</h1>

        <p class="resend-subtitle">
            Enter your email address and we will send you a new confirmation link.
        </p>

        <div class="resend-card">

            <div class="resend-label">Email Address</div>

            <asp:TextBox 
                ID="txtEmail" 
                runat="server" 
                CssClass="resend-input"
                TextMode="Email"
                placeholder="e.g., name@example.com">
            </asp:TextBox>

            <asp:RequiredFieldValidator
                ID="rfvEmail"
                runat="server"
                ControlToValidate="txtEmail"
                ErrorMessage="Email is required"
                ForeColor="Red"
                Display="Dynamic">
            </asp:RequiredFieldValidator>

            <asp:Button
                ID="btnResend"
                runat="server"
                Text="Send New Confirmation Link"
                CssClass="resend-btn"
                OnClick="btnResend_Click" />

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="resend-message">
            </asp:Label>

        </div>

        <a href="Login.aspx" class="resend-back">← Back to Login</a>

    </div>
</div>

</asp:Content>