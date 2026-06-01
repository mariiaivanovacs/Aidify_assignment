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
        max-width: 380px;
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
    }

    .confirm-title {
        font-size: 24px;
        font-weight: 700;
        color: #1a1a1a;
        margin-bottom: 10px;
    }

    .confirm-subtitle {
        font-size: 14px;
        color: #5b403d;
        line-height: 1.6;
        margin-bottom: 18px;
    }

    .confirm-message {
        display: block;
        text-align: center;
        margin: 16px 0;
        font-weight: 600;
        font-size: 15px;
    }

    .confirm-btn {
        display: inline-block;
        width: 100%;
        background: #c8102e;
        color: white;
        border-radius: 10px;
        padding: 14px;
        font-size: 16px;
        font-weight: 600;
        text-decoration: none;
        margin-top: 10px;
    }

    .confirm-btn:hover {
        background: #a80d25;
        color: white;
    }

    .confirm-login-link {
        display: block;
        margin-top: 12px;
        color: #c8102e;
        font-weight: 600;
        text-decoration: none;
    }

    .confirm-login-link:hover {
        color: #a80d25;
    }

    .confirm-footer {
        border-top: 1px solid #eee;
        padding-top: 16px;
        margin-top: 22px;
        font-size: 11px;
        color: #aaa;
        text-align: center;
        line-height: 1.8;
    }
</style>

<div class="confirm-wrapper">
    <div class="confirm-popup">

        <a href="Login.aspx" class="confirm-close">&#x2715;</a>

        <div class="confirm-logo-top">Aidify</div>

        <div class="confirm-img-wrap">
            <asp:Literal ID="litIcon" runat="server" Text="✉️" />
        </div>

        <div class="confirm-title">
            <asp:Literal ID="litTitle" runat="server" Text="Confirm Email" />
        </div>

        <p class="confirm-subtitle">
            <asp:Literal ID="litSubtitle" runat="server" Text="Checking your confirmation link..." />
        </p>

        <asp:Label
            ID="lblMessage"
            runat="server"
            CssClass="confirm-message">
        </asp:Label>

        <asp:HyperLink
            ID="lnkResend"
            runat="server"
            NavigateUrl="~/Auth/ResendConfirmation.aspx"
            CssClass="confirm-btn"
            Visible="false">
            Request New Link
        </asp:HyperLink>

        <a href="Login.aspx" class="confirm-login-link">
            Go to Login
        </a>

        <div class="confirm-footer">
            <div>🔒 Secure Email Confirmation</div>
            <div>AIDIFY HEALTH SYSTEMS</div>
        </div>

    </div>
</div>

</asp:Content>