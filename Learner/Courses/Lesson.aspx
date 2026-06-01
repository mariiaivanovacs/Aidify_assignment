<%@ Page Title="Lesson" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lesson.aspx.cs" Inherits="Aidify_assigment.Learner.Courses.Lesson" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .lesson-body-card  { background: #fff; border: 1px solid #f0d8d8; border-radius: 12px; padding: 32px; line-height: 1.85; font-size: 15px; margin-bottom: 24px; }
    .breadcrumb-item a { color: #C0392B; text-decoration: none; }
    .complete-badge    { display: inline-block; background: #d8f3e7; color: #198754; padding: 6px 16px; border-radius: 20px; font-weight: 700; font-size: 13px; margin-bottom: 16px; }
    .after-links       { display: flex; gap: 12px; margin-top: 8px; }
</style>

<nav aria-label="breadcrumb" class="mb-4">
    <ol class="breadcrumb">
        <li class="breadcrumb-item">
            <a runat="server" href="~/Learner/Courses/Catalogue.aspx">Courses</a>
        </li>
        <li class="breadcrumb-item">
            <asp:Label ID="lblModuleBreadcrumb" runat="server" />
        </li>
        <li class="breadcrumb-item active">Lesson</li>
    </ol>
</nav>

<div class="row justify-content-center">
    <div class="col-md-8">

        <h2 class="fw-bold mb-4">
            <asp:Label ID="lblLessonTitle" runat="server" />
        </h2>

        <div class="lesson-body-card">
            <asp:Literal ID="litLessonBody" runat="server" />
        </div>

        <asp:HiddenField ID="hfModuleId" runat="server" />
        <asp:HiddenField ID="hfLessonId" runat="server" />

        <asp:Label ID="lblAlreadyComplete" runat="server"
            Text="✓ Lesson completed"
            CssClass="complete-badge"
            Visible="false" />

        <asp:Panel ID="pnlMarkComplete" runat="server" CssClass="mb-3">
            <asp:Button ID="btnMarkComplete" runat="server"
                Text="Mark as Complete"
                CssClass="btn btn-danger px-4 py-2 fw-semibold"
                OnClick="btnMarkComplete_Click" />
        </asp:Panel>

        <asp:Panel ID="pnlAfterComplete" runat="server" Visible="false" CssClass="after-links">
            <asp:HyperLink ID="lnkNextLesson" runat="server"
                Text="Next Lesson →"
                CssClass="btn btn-danger px-4" />
            <asp:HyperLink ID="lnkStartQuiz" runat="server"
                Text="Take Lesson Quiz"
                CssClass="btn btn-outline-danger px-4" />
        </asp:Panel>

    </div>
</div>

</asp:Content>
