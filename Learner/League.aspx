<%@ Page Title="League" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="League.aspx.cs" Inherits="Aidify_assigment.Learner.League" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .tier-card         { background: linear-gradient(135deg, #C0392B, #96281B); border-radius: 14px; padding: 28px 32px; color: #fff; margin-bottom: 24px; display: flex; align-items: center; gap: 40px; }
    .tier-card .label  { font-size: 12px; opacity: 0.8; margin-bottom: 4px; }
    .tier-card .value  { font-size: 22px; font-weight: 800; }
    .tier-badge        { display: inline-block; padding: 5px 14px; border-radius: 20px; font-size: 14px; font-weight: 700; }
    .tier-bronze       { background: #fff3cd; color: #856404; }
    .tier-silver       { background: #e9ecef; color: #495057; }
    .tier-gold         { background: #fff3cd; color: #856404; }
    .tier-platinum     { background: #cfe2ff; color: #084298; }
    .leaderboard-table { background: #fff; border: 1px solid #f0d8d8; border-radius: 12px; overflow: hidden; }
    .leaderboard-table table { margin: 0; }
    .leaderboard-table thead th { background: #FDF2F2; color: #888; font-size: 12px; text-transform: uppercase; letter-spacing: 0.05em; padding: 14px 16px; border-bottom: 1px solid #f0d8d8; }
    .leaderboard-table tbody td { padding: 14px 16px; border-bottom: 1px solid #fafafa; vertical-align: middle; }
    .leaderboard-table tbody tr:last-child td { border-bottom: none; }
    .leaderboard-table tbody tr.me-row td { background: #FDF2F2; font-weight: 600; }
    .rank-num          { font-weight: 800; color: #C0392B; }
</style>

<div class="mb-4">
    <h3 class="fw-bold mb-1">League</h3>
    <p class="text-muted" style="font-size:13px;">Compete with other learners and climb the leaderboard.</p>
</div>

<div class="tier-card">
    <div>
        <div class="label">Your Tier</div>
        <asp:Label ID="lblTier" runat="server" CssClass="tier-badge" />
    </div>
    <div>
        <div class="label">Your Points</div>
        <div class="value">
            <asp:Label ID="lblPoints" runat="server" />
        </div>
    </div>
</div>

<h5 class="fw-bold mb-3">Top 20 Leaderboard</h5>
<div class="leaderboard-table">
    <div class="table-responsive">
        <table class="table table-hover mb-0">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Tier</th>
                    <th class="text-end">Points</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptLeaderboard" runat="server">
                    <ItemTemplate>
                        <tr class='<%# Convert.ToBoolean(Eval("IsCurrentUser")) ? "me-row" : "" %>'>
                            <td class="rank-num"><%# Eval("Rank") %></td>
                            <td><%# Eval("FullName") %></td>
                            <td>
                                <span class='tier-badge <%# ((Aidify_assigment.Learner.League)Page).GetTierBadge(Eval("Tier").ToString()) %>'>
                                    <%# Eval("Tier") %>
                                </span>
                            </td>
                            <td class="text-end fw-semibold"><%# Eval("Points") %> pts</td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
</div>

</asp:Content>
