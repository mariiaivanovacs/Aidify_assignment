<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Aidify_assigment.Learner.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .welcome-banner {
        background: linear-gradient(135deg, #C0392B, #96281B);
        border-radius: 14px;
        padding: 32px;
        color: #fff;
        margin-bottom: 28px;
    }
    .welcome-banner h2 { font-weight: 800; margin-bottom: 4px; }
    .welcome-banner p  { opacity: 0.8; margin-bottom: 16px; }
    .course-card       { border-radius: 12px; border: 1px solid #f0d8d8; background: #fff; padding: 18px; margin-bottom: 14px; }
    .course-card .progress { height: 8px; border-radius: 8px; background: #f0d8d8; }
    .course-card .progress-bar { background: #C0392B; border-radius: 8px; }
    .side-card         { border-radius: 12px; border: 1px solid #f0d8d8; background: #fff; padding: 24px; text-align: center; margin-bottom: 16px; }
    .side-card h6      { font-weight: 700; margin: 8px 0 4px; }
    .badge-tier        { background: #C0392B; color: #fff; padding: 6px 16px; border-radius: 20px; font-weight: 700; font-size: 13px; display: inline-block; margin-top: 6px; }
</style>

<div class="welcome-banner">
    <h2><asp:Label ID="lblWelcome" runat="server" /></h2>
    <p>Pick up where you left off.</p>
    <asp:HyperLink ID="lnkNextLesson" runat="server" Text="▶ Continue Learning"
        CssClass="btn btn-light fw-semibold px-4" style="color:#C0392B;" />
</div>

<div class="row">
    <div class="col-md-8">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="fw-bold mb-0">My Courses</h5>
            <asp:HyperLink ID="lnkBrowseAll" runat="server" Text="Browse All →"
                NavigateUrl="~/Learner/Courses/Catalogue.aspx"
                CssClass="btn btn-outline-danger btn-sm" />
        </div>
        <asp:Repeater ID="rptEnrolledCourses" runat="server">
            <ItemTemplate>
                <div class="course-card">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="fw-semibold"><%# Eval("ModuleTitle") %></span>
                        <a href='Courses/Details.aspx?moduleId=<%# Eval("ModuleId") %>'
                           class="btn btn-outline-danger btn-sm">Continue</a>
                    </div>
                    <div class="progress">
                        <div class="progress-bar" role="progressbar"
                             data-pct='<%# Eval("ProgressPct") %>'
                             style="width:0%"></div>
                    </div>
                    <small class="text-muted mt-1 d-block"><%# Eval("ProgressPct") %>% complete</small>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <div class="col-md-4">
        <div class="side-card">
            <div style="font-size:2.2rem;">🏆</div>
            <h6>League Tier</h6>
            <div class="badge-tier">
                <asp:Label ID="lblLeagueTier" runat="server" Text="Bronze" />
            </div>
            <div class="text-muted small mt-2">
                Points: <asp:Label ID="lblLeaguePoints" runat="server" Text="0" />
            </div>
        </div>
        <div class="side-card">
            <h6>Latest Badge</h6>
            <asp:Image ID="imgLatestBadge" runat="server"
                style="width:60px; height:60px; object-fit:contain;" />
            <div class="mt-2">
                <asp:Label ID="lblLatestBadgeName" runat="server"
                    Text="No badges yet" CssClass="text-muted small" />
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    document.querySelectorAll('.progress-bar[data-pct]').forEach(function (bar) {
        bar.style.width = bar.getAttribute('data-pct') + '%';
    });
</script>

</asp:Content>
