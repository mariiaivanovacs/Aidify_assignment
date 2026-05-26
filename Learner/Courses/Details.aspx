<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="Aidify_assigment.Learner.Courses.Details" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="container-fluid px-4 py-4">

    <%-- Breadcrumb --%>
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="~/Learner/Courses/Catalogue.aspx">Courses</a>
            </li>
            <li class="breadcrumb-item active">
                <asp:Label ID="lblModuleTitle" runat="server" Text="Course Details" />
            </li>
        </ol>
    </nav>

    <div class="row">

        <%-- Left: Cover Image + Enrol --%>
        <div class="col-md-4 mb-4">
            <asp:Image ID="imgModuleCover" runat="server"
                CssClass="img-fluid rounded shadow-sm w-100"
                style="height:220px; object-fit:cover;"
                AlternateText="Course Cover" />

            <%-- Enrol Panel --%>
            <asp:Panel ID="pnlEnrolCTA" runat="server" CssClass="mt-3">
                <asp:Button ID="btnEnrolFromDetails" runat="server"
                    Text="Enrol Now"
                    CssClass="btn btn-primary w-100 py-2 fw-semibold"
                    OnClick="btnEnrolFromDetails_Click" />
            </asp:Panel>
        </div>

        <%-- Right: Module Info --%>
        <div class="col-md-8">
            <h2 class="fw-bold mb-1">
                <asp:Label ID="lblModuleTitleMain" runat="server" />
            </h2>

            <span class="badge bg-secondary mb-3">
                <asp:Label ID="lblDifficulty" runat="server" />
            </span>

            <p class="text-muted mb-4">
                <asp:Label ID="lblModuleDescription" runat="server" />
            </p>

            <%-- Progress --%>
            <div class="mb-4">
                <div class="d-flex justify-content-between mb-1">
                    <small class="fw-semibold">Your Progress</small>
                    <small class="text-muted">
                        <asp:Label ID="lblProgressPct" runat="server" Text="0% complete" />
                    </small>
                </div>
                <div class="progress" style="height:10px; border-radius:8px;">
                    <div id="progressBar" runat="server"
                         class="progress-bar bg-primary"
                         role="progressbar" style="width:0%;" />
                </div>
            </div>

            <%-- Lesson List --%>
            <h5 class="fw-semibold mb-3">Lessons</h5>
            <asp:Repeater ID="rptLessons" runat="server">
                <ItemTemplate>
                    <div class="card mb-2 shadow-sm" style="border-radius:10px;">
                        <div class="card-body py-3 px-4 d-flex justify-content-between align-items-center">
                            <div>
                                <span class="fw-semibold"><%# Eval("LessonTitle") %></span>
                                <small class="text-muted ms-2">
                                    ⏱ <%# Eval("EstimatedMinutes") %> min
                                </small>
                            </div>
                            <div class="d-flex align-items-center gap-3">
                                <%# Convert.ToBoolean(Eval("IsCompleted")) ? 
                                    "<span class='badge bg-success'>✓ Done</span>" : 
                                    "<span class='badge bg-light text-muted'>Not done</span>" %>
                                <a href='<%# "~/Learner/Courses/Lesson.aspx?lessonId=" + Eval("LessonId") %>'
                                   class="btn btn-outline-primary btn-sm">Start</a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>
    </div>
</div>

</asp:Content>
