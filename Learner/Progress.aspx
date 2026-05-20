<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Progress.aspx.cs" Inherits="Aidify_assigment.Learner.Progress" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="container-fluid px-0">

    <%-- Page Header --%>
    <div class="mb-4">
        <h3 class="fw-bold mb-1">My Progress</h3>
        <p class="text-muted" style="font-size:13px;">Track your learning journey across all courses.</p>
    </div>

    <div class="row g-4">

        <%-- Module Progress --%>
        <div class="col-12">
            <div class="card shadow-sm" style="border-radius:12px;">
                <div class="card-body p-4">
                    <h5 class="fw-bold mb-4">Course Progress</h5>
                    <asp:Repeater ID="rptModuleProgress" runat="server">
                        <ItemTemplate>
                            <div class="mb-4">
                                <div class="d-flex justify-content-between mb-1">
                                    <span class="fw-semibold" style="font-size:14px;"><%# Eval("ModuleName") %></span>
                                    <span class="text-muted" style="font-size:13px;">
                                        <%# Eval("Completed") %> / <%# Eval("Total") %> lessons
                                    </span>
                                </div>
                                <div class="progress" style="height:10px; border-radius:8px;">
                                    <div class="progress-bar" role="progressbar"
                                         style='width:<%# Eval("Pct") %>%;'></div>
                                </div>
                                <small class="text-muted"><%# Eval("Pct") %>% complete</small>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>

        <%-- Badges --%>
        <div class="col-md-6">
            <div class="card shadow-sm h-100" style="border-radius:12px;">
                <div class="card-body p-4">
                    <h5 class="fw-bold mb-4">My Badges</h5>
                    <asp:Label ID="lblNoBadges" runat="server"
                        Text="No badges earned yet."
                        CssClass="text-muted fst-italic"
                        Visible="false" />
                    <div class="row g-3">
                        <asp:Repeater ID="rptBadges" runat="server">
                            <ItemTemplate>
                                <div class="col-4 text-center">
                                    <div class="p-3 rounded" style="background:#FDF2F2;">
                                        <div style="font-size:2rem;"><%# Eval("Icon") %></div>
                                        <div class="fw-semibold mt-2" style="font-size:12px;"><%# Eval("BadgeName") %></div>
                                        <div class="text-muted" style="font-size:11px;"><%# Eval("AwardedDate") %></div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>

        <%-- Certificates --%>
        <div class="col-md-6">
            <div class="card shadow-sm h-100" style="border-radius:12px;">
                <div class="card-body p-4">
                    <h5 class="fw-bold mb-4">My Certificates</h5>
                    <asp:Label ID="lblNoCertificates" runat="server"
                        Text="No certificates yet."
                        CssClass="text-muted fst-italic"
                        Visible="false" />
                    <asp:Repeater ID="rptCertificates" runat="server">
                        <ItemTemplate>
                            <div class="d-flex justify-content-between align-items-center p-3 mb-2 rounded"
                                 style="background:#FDF2F2;">
                                <div>
                                    <div class="fw-semibold" style="font-size:14px;">🎓 <%# Eval("ModuleName") %></div>
                                    <div class="text-muted" style="font-size:12px;">Issued: <%# Eval("IssueDate") %></div>
                                </div>
                                <a href='<%# Eval("DownloadUrl") %>'
                                   class="btn btn-outline-primary btn-sm">Download</a>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>

    </div>
</div>

</asp:Content>
