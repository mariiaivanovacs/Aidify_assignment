<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="Aidify_assigment.Auth.ResetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password"></asp:TextBox>

<br /><br />

<asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>

<br /><br />

<asp:Button ID="btnReset" runat="server" Text="Reset Password" />

<br /><br />

<asp:Label ID="lblMessage" runat="server"></asp:Label>
</asp:Content>
