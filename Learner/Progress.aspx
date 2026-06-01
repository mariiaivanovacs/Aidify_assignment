<%@ Page Title="My Progress" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Progress.aspx.cs" Inherits="Aidify_assigment.Learner.Progress" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .progress-section  { background: #fff; border: 1px solid #f0d8d8; border-radius: 12px; padding: 24px; margin-bottom: 20px; }
    .progress-section h5 { font-weight: 700; margin-bottom: 20px; }
    .prog-bar-wrap .progress { height: 10px; border-radius: 8px; background: #f0d8d8; }
    .prog-bar-wrap .progress-bar { background: #C0392B; border-radius: 8px; }
    .badge-tile        { background: #FDF2F2; border-radius: 10px; padding: 16px 8px; text-align: center; }
    .badge-tile .icon  { font-size: 2rem; }
    .badge-tile .name  { font-weight: 700; font-size: 12px; margin-top: 6px; }
    .badge-tile .date  { font-size: 11px; color: #888; }
    .cert-row          { background: #FDF2F2; border-radius: 10px; padding: 14px 16px; margin-bottom: 10px; display: flex; justify-content: space-between; align-items: center; }
    .cert-row .title   { font-weight: 600; font-size: 14px; }
    .cert-row .date    { font-size: 12px; color: #888; }
</style>

<div class="mb-4">
    <h3 class="fw-bold mb-1">My Progress</h3>
    <p class="text-muted" style="font-size:13px;">Track your learning journey across all courses.</p>
</div>

<div class="progress-section">
    <h5>Course Progress</h5>
    <asp:Repeater ID="rptModuleProgress" runat="server">
        <ItemTemplate>
            <div class="prog-bar-wrap mb-4">
                <div class="d-flex justify-content-between mb-1">
                    <span class="fw-semibold" style="font-size:14px;"><%# Eval("ModuleName") %></span>
                    <span class="text-muted" style="font-size:13px;">
                        <%# Eval("Completed") %> / <%# Eval("Total") %> lessons
                    </span>
                </div>
                <div class="progress">
                    <div class="progress-bar" role="progressbar"
                         style='width:<%# Eval("Pct") %>%;'></div>
                </div>
                <small class="text-muted"><%# Eval("Pct") %>% complete</small>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>

<div class="row g-4">
    <div class="col-md-6">
        <div class="progress-section h-100">
            <h5>My Badges</h5>
            <asp:Label ID="lblNoBadges" runat="server"
                Text="No badges earned yet."
                CssClass="text-muted fst-italic"
                Visible="false" />
            <div class="row g-3">
                <asp:Repeater ID="rptBadges" runat="server">
                    <ItemTemplate>
                        <div class="col-4">
                            <div class="badge-tile">
                                <div class="icon"><%# Eval("Icon") %></div>
                                <div class="name"><%# Eval("BadgeName") %></div>
                                <div class="date"><%# Eval("AwardedDate") %></div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>

    <div class="col-md-6">
        <div class="progress-section h-100">
            <h5>My Certificates</h5>
            <asp:Label ID="lblNoCertificates" runat="server"
                Text="No certificates yet."
                CssClass="text-muted fst-italic"
                Visible="false" />
            <asp:Repeater ID="rptCertificates" runat="server">
                <ItemTemplate>
                    <div class="cert-row">
                        <div>
                            <div class="title">🎓 <%# Eval("ModuleName") %></div>
                            <div class="date">Issued: <%# Eval("IssueDate") %></div>
                        </div>
                        <a href='<%# Eval("DownloadUrl") %>'
                           class="btn btn-outline-danger btn-sm">Download</a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</div>

</asp:Content>
