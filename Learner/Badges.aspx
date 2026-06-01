<%@ Page Title="Learner / Badges" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Badges.aspx.cs" Inherits="Aidify_assigment.Learner.Badges" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="container-fluid px-4 py-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="fw-bold mb-0">My Badges</h4>
    </div>

    <asp:Label ID="lblNoBadges" runat="server"
        Text="Keep learning to earn your first badge!"
        CssClass="text-muted fst-italic"
        Visible="false" />

    <div class="row">
        <asp:Repeater ID="rptBadges" runat="server">
            <ItemTemplate>
                <div class="col-md-3 mb-4">
                    <div class="card text-center p-3 shadow-sm" style="border-radius:12px; border:2px solid #E53935;">
                        <div style="font-size:2.5rem; margin-bottom:8px;">
                            <%# string.IsNullOrEmpty(Eval("IconPath").ToString())
                                ? "🏅"
                                : "<img src='" + ResolveUrl(Eval("IconPath").ToString()) + "' style='width:48px;height:48px;' />" %>
                        </div>
                        <div class="fw-bold"><%# Eval("Name") %></div>
                        <small class="text-muted">
                            Awarded: <%# Convert.ToDateTime(Eval("AwardedAt")).ToString("MMM yyyy") %>
                        </small>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</div>
</asp:Content>