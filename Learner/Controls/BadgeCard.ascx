<%@ Control Language="C#" AutoEventWireup="true"
    CodeBehind="BadgeCard.ascx.cs"
    Inherits="Aidify_assigment.Learner.Controls.BadgeCard" %>

<style>
    .badge-card       { background: #FDF2F2; border: 2px solid #C0392B; border-radius: 12px; padding: 16px; text-align: center; }
    .badge-card .icon { font-size: 2.2rem; margin-bottom: 8px; }
    .badge-card .name { font-weight: 700; font-size: 13px; color: #222; }
    .badge-card .date { font-size: 11px; color: #888; margin-top: 2px; }
</style>

<div class="badge-card">
    <div class="icon">
        <asp:Image ID="imgBadge" runat="server" style="width:48px; height:48px;" />
        <asp:Label ID="lblBadgeEmoji" runat="server" Text="🏅" />
    </div>
    <div class="name">
        <asp:Label ID="lblBadgeName" runat="server" />
    </div>
    <div class="date">
        <asp:Label ID="lblAwardedDate" runat="server" />
    </div>
</div>
