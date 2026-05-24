<%@ Page Title="Challenges" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Challenges.aspx.cs" Inherits="LearnerDash.Learner.Challenges" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Page Header --%>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="fw-bold mb-0">Challenges</h4>
    </div>

    <%-- Empty State --%>
    <asp:Label ID="lblNoChallenges" runat="server"
        Text="No active challenges right now."
        CssClass="text-muted fst-italic"
        Visible="false" />

    <%-- Challenges List --%>
    <asp:Repeater ID="rptChallenges" runat="server" OnItemCommand="rptChallenges_ItemCommand">
        <ItemTemplate>
            <div class="card shadow-sm mb-3" style="border-radius:10px;">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-start">

                        <div>
                            <h6 class="fw-bold mb-1"><%# Eval("Title") %></h6>
                            <p class="text-muted small mb-2"><%# Eval("Description") %></p>
                            <small class="text-muted">
                                <%# Convert.ToDateTime(Eval("StartDate")).ToString("dd MMM yyyy") %>
                                —
                                <%# Eval("EndDate") == DBNull.Value || Eval("EndDate") == null
                                    ? "Ongoing"
                                    : Convert.ToDateTime(Eval("EndDate")).ToString("dd MMM yyyy") %>
                            </small>
                        </div>

                        <div class="d-flex flex-column align-items-end gap-2">
                            <%-- Points reward badge --%>
                            <span class="badge bg-warning text-dark px-3 py-2">
                                🏆 <%# Eval("PointsReward") %> pts
                            </span>

                            <%-- Join button --%>
                            <asp:Button ID="btnJoin" runat="server"
                                Text="Join"
                                CommandName="Join"
                                CommandArgument='<%# Eval("ChallengeId") %>'
                                CssClass="btn btn-primary btn-sm"
                                Visible='<%# !Convert.ToBoolean(Eval("AlreadyJoined")) %>' />

                            <%-- Already joined indicator --%>
                            <%# Convert.ToBoolean(Eval("AlreadyJoined"))
                                ? "<span class=\"badge bg-success px-3 py-2\">✓ Joined</span>"
                                : "" %>
                        </div>

                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>

</asp:Content>
