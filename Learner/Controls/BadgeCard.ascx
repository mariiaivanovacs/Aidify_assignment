<%@ Control Language="C#" AutoEventWireup="true"
    CodeBehind="BadgeCard.ascx.cs"
    Inherits="Aidify_assigment.Learner.Controls.BadgeCard" %>

<div class="card text-center p-3 shadow-sm" style="border-radius:12px; border:2px solid #E53935;">
    <div style="font-size:2.5rem; margin-bottom:8px;">
        <asp:Image ID="imgBadge" runat="server" Style="width:48px; height:48px;" />
        <asp:Label ID="lblBadgeEmoji" runat="server" Text="🏅" />
    </div>
    <div class="fw-bold">
        <asp:Label ID="lblBadgeName" runat="server" />
    </div>
    <small class="text-muted">
        <asp:Label ID="lblAwardedDate" runat="server" />
    </small>
</div>