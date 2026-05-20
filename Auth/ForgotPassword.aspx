<%@ Page Title="Forgot Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="Aidify_assigment.Auth.ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .forgot-wrapper {
        min-height: 70vh;
        display: flex;
        justify-content: center;
        align-items: center;
        background: #f9f9f9;
        padding: 40px 20px;
    }

    .forgot-box {
        width: 100%;
        max-width: 430px;
        text-align: center;
    }

    .forgot-logo {
        color: #c8102e;
        font-size: 28px;
        font-weight: bold;
        margin-bottom: 25px;
    }

    .forgot-title {
        font-size: 32px;
        font-weight: 700;
        margin-bottom: 15px;
        color: #1a1a1a;
    }

    .forgot-subtitle {
        font-size: 17px;
        color: #5b403d;
        line-height: 1.6;
        margin-bottom: 30px;
    }

    .forgot-card {
        background: white;
        border: 1px solid #eee;
        border-radius: 14px;
        padding: 28px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        text-align: left;
    }

    .forgot-label {
        font-weight: 600;
        margin-bottom: 8px;
        color: #5b403d;
    }

    .forgot-input {
        width: 100%;
        padding: 14px;
        border: 1px solid #e4beb9;
        border-radius: 10px;
        font-size: 16px;
        margin-bottom: 18px;
    }

    .forgot-btn {
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

    .forgot-btn:hover {
        background: #a80d25;
    }

    .forgot-back {
        display: block;
        text-align: center;
        margin-top: 28px;
        color: #c8102e;
        font-weight: 600;
        text-decoration: none;
    }

    .forgot-message {
        display: block;
        text-align: center;
        margin-top: 15px;
        font-weight: 600;
    }
</style>

<div class="forgot-wrapper">
    <div class="forgot-box">

        <div class="forgot-logo">✚ Aidify</div>

        <h1 class="forgot-title">Forgot Password</h1>

        <p class="forgot-subtitle">
            Enter your email address and we will send you a link to reset your password.
        </p>

        <div class="forgot-card">

            <div class="forgot-label">Email Address</div>

            <asp:TextBox 
                ID="txtEmail" 
                runat="server" 
                CssClass="forgot-input"
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
                ID="btnSubmit"
                runat="server"
                Text="Send Reset Link  →"
                CssClass="forgot-btn"
                OnClick="btnSubmit_Click" />

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="forgot-message">
            </asp:Label>

        </div>

        <a href="Login.aspx" class="forgot-back">← Back to Login</a>

    </div>
</div>

</asp:Content>