<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Aidify_assigment.Learner.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container-fluid px-4 py-4">

    <!-- Welcome Banner -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card bg-dark text-white" style="border-radius:12px; border:none; background: linear-gradient(135deg, #1a1a2e, #16213e) !important;">
                <div class="card-body py-4 px-4">
                    <h2 class="mb-1">
                        <asp:Label ID="lblWelcome" runat="server" />
                    </h2>
                    <p class="text-white-50 mb-3">Pick up where you left off.</p>
                    <asp:HyperLink ID="lnkNextLesson" runat="server" Text="▶ Continue Learning"
                        CssClass="btn btn-primary btn-sm px-4" />
                </div>
            </div>
        </div>
    </div>

    <div class="row mb-4">

        <!-- Enrolled Courses -->
        <div class="col-md-8 mb-4">
            <h5 class="fw-semibold mb-3">My Courses</h5>
            <asp:Repeater ID="rptEnrolledCourses" runat="server">
                <ItemTemplate>
                    <div class="card mb-3 shadow-sm" style="border-radius:10px;">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="fw-semibold"><%# Eval("ModuleTitle") %></span>
                                <a href='Courses/Details.aspx?moduleId=<%# Eval("ModuleId") %>'
                                   class="btn btn-outline-primary btn-sm">Continue</a>
                            </div>
                            <div class="progress" style="height:8px; border-radius:8px;">
                                <div class="progress-bar bg-primary" role="progressbar"
                                     data-pct='<%# Eval("ProgressPct") %>'
                                     style="width:0%"></div>
                            </div>
                            <small class="text-muted mt-1 d-block"><%# Eval("ProgressPct") %>% complete</small>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Right Column -->
        <div class="col-md-4">

            <!-- League Card -->
            <div class="card mb-3 shadow-sm text-center" style="border-radius:10px;">
                <div class="card-body py-4">
                    <div style="font-size:2.5rem;">🏆</div>
                    <h6 class="fw-bold mt-2 mb-0">League Tier</h6>
                    <asp:Label ID="lblLeagueTier" runat="server" Text="Bronze"
                        CssClass="badge bg-warning text-dark mt-2 px-3 py-2 fs-6" />
                    <div class="mt-2 text-muted small">
                        Points: <asp:Label ID="lblLeaguePoints" runat="server" Text="0" />
                    </div>
                </div>
            </div>

            <!-- Latest Badge -->
            <div class="card shadow-sm text-center" style="border-radius:10px;">
                <div class="card-body py-4">
                    <h6 class="fw-bold mb-3">Latest Badge</h6>
                    <asp:Image ID="imgLatestBadge" runat="server"
                        style="width:64px; height:64px; object-fit:contain;" />
                    <div class="mt-2">
                        <asp:Label ID="lblLatestBadgeName" runat="server"
                            Text="No badges yet" CssClass="text-muted small" />
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- Browse All -->
    <div class="text-end">
        <asp:HyperLink ID="lnkBrowseAll" runat="server" Text="Browse All Courses →"
            NavigateUrl="~/Learner/Courses/Catalogue.aspx"
            CssClass="btn btn-outline-secondary" />
    </div>

</div>

<script type="text/javascript">
    document.querySelectorAll('.progress-bar[data-pct]').forEach(function (bar) {
        bar.style.width = bar.getAttribute('data-pct') + '%';
    });
</script>

</asp:Content>