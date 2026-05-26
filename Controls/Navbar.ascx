<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Navbar.ascx.cs" Inherits="Aidify_assigment.Controls.Navbar" %>

<nav class="navbar navbar-expand-lg aidify-navbar">
    <div class="container">
        <a class="navbar-brand fw-bold" href="<%= ResolveUrl("~/Default.aspx") %>">Aidify</a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="mainNavbar">

            <!-- Visitor Navbar -->
            <asp:Panel ID="pnlVisitor" runat="server" CssClass="navbar-nav ms-auto">
                <a class="nav-link" href="<%= ResolveUrl("~/Default.aspx") %>">Home</a>
                <a class="nav-link" href="<%= ResolveUrl("~/Public/About.aspx") %>">About</a>
                <a class="nav-link" href="<%= ResolveUrl("~/Public/FAQ.aspx") %>">FAQ</a>
                <a class="nav-link" href="<%= ResolveUrl("~/Auth/Login.aspx") %>">Login</a>
                <a class="btn btn-aidify ms-lg-2" href="<%= ResolveUrl("~/Auth/Register.aspx") %>">Register</a>
            </asp:Panel>

            <!-- Learner Navbar Placeholder -->
            <asp:Panel ID="pnlLearner" runat="server" CssClass="navbar-nav ms-auto" Visible="false">
                <a class="nav-link" href="#">Learner Dashboard</a>
                <a class="nav-link" href="#">Courses</a>
                <a class="nav-link" href="#">Progress</a>
                <a class="nav-link" href="<%= ResolveUrl("~/Auth/Logout.aspx") %>">Logout</a>
            </asp:Panel>

            <!-- Instructor Navbar Placeholder -->
            <asp:Panel ID="pnlInstructor" runat="server" CssClass="navbar-nav ms-auto" Visible="false">
                <a class="nav-link" href="#">Instructor Dashboard</a>
                <a class="nav-link" href="#">Modules</a>
                <a class="nav-link" href="#">Quizzes</a>
                <a class="nav-link" href="<%= ResolveUrl("~/Auth/Logout.aspx") %>">Logout</a>
            </asp:Panel>

            <!-- Admin Navbar Placeholder -->
            <asp:Panel ID="pnlAdmin" runat="server" CssClass="navbar-nav ms-auto" Visible="false">
                <a class="nav-link" href="#">Admin Dashboard</a>
                <a class="nav-link" href="#">Users</a>
                <a class="nav-link" href="#">Analytics</a>
                <a class="nav-link" href="<%= ResolveUrl("~/Auth/Logout.aspx") %>">Logout</a>
            </asp:Panel>

        </div>
    </div>
</nav>