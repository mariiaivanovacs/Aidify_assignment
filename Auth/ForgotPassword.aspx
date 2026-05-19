<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="Aidify_assigment.Auth.ForgotPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
    <br />
    <br />
    <asp:Button ID="btnSubmit" runat="server" Text="Send Reset Link" />
    <br />
    <br />
    <asp:Label ID="lblMessage" runat="server"></asp:Label>
</asp:Content>
