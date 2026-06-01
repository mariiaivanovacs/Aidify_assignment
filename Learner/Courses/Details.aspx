<%@ Page Title="Course Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="Aidify_assigment.Learner.Courses.Details" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .detail-card      { background: #fff; border: 1px solid #f0d8d8; border-radius: 12px; padding: 24px; }
    .lesson-row       { background: #fff; border: 1px solid #f0d8d8; border-radius: 10px; padding: 14px 18px; margin-bottom: 10px; display: flex; justify-content: space-between; align-items: center; }
    .lesson-row:hover { background: #FDF2F2; }
    .badge-done       { background: #d8f3e7; color: #198754; padding: 3px 10px; border-radius: 20px; font-size: 11px; font-weight: 700; }
    .badge-pending    { background: #f0f0f0; color: #888; padding: 3px 10px; border-radius: 20px; font-size: 11px; }
    .progress-wrap .progress { height: 10px; border-radius: 8px; background: #f0d8d8; }
    .progress-wrap .progress-bar { background: #C0392B; border-radius: 8px; }
    .breadcrumb-item a { color: #C0392B; text-decoration: none; }
    .diff-badge       { display: inline-block; padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 700; background: #ffe1e4; color: #C0392B; margin-bottom: 12px; }
</style>

<nav aria-label="breadcrumb" class="mb-4">
    <ol class="breadcrumb">
        <li class="breadcrumb-item">
            <a runat="server" href="~/Learner/Courses/Catalogue.aspx">Courses</a>
        </li>
        <li class="breadcrumb-item active">
            <asp:Label ID="lblModuleTitle" runat="server" Text="Course Details" />
        </li>
    </ol>
</nav>

<div class="row">
    <div class="col-md-4 mb-4">
        <asp:Image ID="imgModuleCover" runat="server"
            CssClass="img-fluid w-100"
            style="height:220px; object-fit:cover; border-radius:12px; border:1px solid #f0d8d8;"
            AlternateText="Course Cover" />
        <asp:Panel ID="pnlEnrolCTA" runat="server" CssClass="mt-3">
            <asp:Button ID="btnEnrolFromDetails" runat="server"
                Text="Enrol Now"
                CssClass="btn btn-danger w-100 py-2 fw-semibold"
                OnClick="btnEnrolFromDetails_Click" />
        </asp:Panel>
    </div>

    <div class="col-md-8">
        <div class="detail-card mb-4">
            <h2 class="fw-bold mb-1">
                <asp:Label ID="lblModuleTitleMain" runat="server" />
            </h2>
            <div class="diff-badge">
                <asp:Label ID="lblDifficulty" runat="server" />
            </div>
            <p class="text-muted mb-4">
                <asp:Label ID="lblModuleDescription" runat="server" />
            </p>
            <div class="progress-wrap">
                <div class="d-flex justify-content-between mb-1">
                    <small class="fw-semibold">Your Progress</small>
                    <small class="text-muted">
                        <asp:Label ID="lblProgressPct" runat="server" Text="0% complete" />
                    </small>
                </div>
                <div class="progress">
                    <div id="progressBar" runat="server"
                         class="progress-bar"
                         role="progressbar" style="width:0%;" />
                </div>
            </div>
        </div>

        <h5 class="fw-bold mb-3">Lessons</h5>
        <asp:Repeater ID="rptLessons" runat="server">
            <ItemTemplate>
                <div class="lesson-row">
                    <div>
                        <span class="fw-semibold" style="font-size:14px;"><%# Eval("LessonTitle") %></span>
                        <small class="text-muted ms-2">⏱ <%# Eval("EstimatedMinutes") %> min</small>
                    </div>
                    <div class="d-flex align-items-center gap-3">
                        <%# Convert.ToBoolean(Eval("IsCompleted")) ?
                            "<span class='badge-done'>✓ Done</span>" :
                            "<span class='badge-pending'>Not done</span>" %>
                        <a href='<%# "~/Learner/Courses/Lesson.aspx?lessonId=" + Eval("LessonId") %>'
                           class="btn btn-outline-danger btn-sm">Start</a>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>

</asp:Content>
