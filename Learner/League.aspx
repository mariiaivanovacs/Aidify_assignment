<%@ Page Title="Learner / League" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="League.aspx.cs" Inherits="Aidify_assigment.Learner.League" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="container-fluid px-4 py-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="fw-bold mb-0">League</h4>
    </div>

    <div class="card shadow-sm mb-4" style="border-radius:10px;">
        <div class="card-body p-4 d-flex align-items-center gap-4">
            <div>
                <div class="text-muted small mb-1">Your Tier</div>
                <asp:Label ID="lblTier" runat="server" CssClass="badge fs-6 px-3 py-2" />
            </div>
            <div>
                <div class="text-muted small mb-1">Your Points</div>
                <asp:Label ID="lblPoints" runat="server" CssClass="fw-bold fs-5" />
            </div>
        </div>
    </div>

    <h5 class="fw-semibold mb-3">Top 20 Leaderboard</h5>
    <div class="card shadow-sm" style="border-radius:10px;">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead class="table-light">
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
                            <tr class='<%# Convert.ToBoolean(Eval("IsCurrentUser")) ? "table-warning" : "" %>'>
                                <td class="fw-bold"><%# Eval("Rank") %></td>
                                <td><%# Eval("FullName") %></td>
                                <td>
                                    <span class='badge <%# ((Aidify_assigment.Learner.League)Page).GetTierBadge(Eval("Tier").ToString()) %>'>
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

</div>
</asp:Content>