<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lesson.aspx.cs" Inherits="Aidify_assigment.Learner.Courses.Lesson" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="container-fluid px-4 py-4">

    <%-- Breadcrumb --%>
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="~/Learner/Courses/Catalogue.aspx">Courses</a>
            </li>
            <li class="breadcrumb-item">
                <asp:Label ID="lblModuleBreadcrumb" runat="server" />
            </li>
            <li class="breadcrumb-item active">Lesson</li>
        </ol>
    </nav>

    <div class="row justify-content-center">
        <div class="col-md-8">

            <%-- Lesson Title --%>
            <h2 class="fw-bold mb-4">
                <asp:Label ID="lblLessonTitle" runat="server" />
            </h2>

            <%-- Lesson Body --%>
            <div class="card shadow-sm mb-4" style="border-radius:12px;">
                <div class="card-body p-4" style="line-height:1.8; font-size:15px;">
                    <asp:Literal ID="litLessonBody" runat="server" />
                </div>
            </div>

            <%-- Hidden Fields --%>
            <asp:HiddenField ID="hfModuleId" runat="server" />
            <asp:HiddenField ID="hfLessonId" runat="server" />

            <%-- Already Complete --%>
            <asp:Label ID="lblAlreadyComplete" runat="server"
                Text="✓ Lesson completed"
                CssClass="badge bg-success px-3 py-2 fs-6 mb-3"
                Visible="false" />

            <%-- Mark Complete Button --%>
            <asp:Panel ID="pnlMarkComplete" runat="server" CssClass="mb-3">
                <asp:Button ID="btnMarkComplete" runat="server"
                    Text="Mark as Complete"
                    CssClass="btn btn-success px-4 py-2 fw-semibold"
                    OnClick="btnMarkComplete_Click" />
            </asp:Panel>

            <%-- After Completion Links --%>
            <asp:Panel ID="pnlAfterComplete" runat="server" Visible="false"
                CssClass="d-flex gap-3 mt-2">
                <asp:HyperLink ID="lnkNextLesson" runat="server"
                    Text="Next Lesson →"
                    CssClass="btn btn-primary px-4" />
                <asp:HyperLink ID="lnkStartQuiz" runat="server"
                    Text="Take Lesson Quiz"
                    CssClass="btn btn-outline-warning px-4" />
            </asp:Panel>

        </div>
    </div>
</div>

</asp:Content>
