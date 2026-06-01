<%@ Page Title="Learner / Notifications" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Notifications.aspx.cs" Inherits="Aidify_assigment.Learner.Notifications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="container-fluid px-4 py-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="fw-bold mb-0">Notifications</h4>
        <asp:Button ID="btnMarkAllRead" runat="server"
            Text="Mark All as Read"
            CssClass="btn btn-outline-secondary btn-sm"
            OnClick="btnMarkAllRead_Click" />
    </div>

    <asp:Label ID="lblNoNotifications" runat="server"
        Text="You have no notifications."
        CssClass="text-muted fst-italic"
        Visible="false" />

    <asp:Repeater ID="rptNotifications" runat="server" OnItemCommand="rptNotifications_ItemCommand">
        <ItemTemplate>
            <div class='card shadow-sm mb-3 <%# !Convert.ToBoolean(Eval("IsRead")) ? "border-start border-danger border-3" : "" %>'
                 style="border-radius:10px;">
                <div class="card-body p-4 d-flex justify-content-between align-items-start">
                    <div>
                        <p class='mb-1 <%# !Convert.ToBoolean(Eval("IsRead")) ? "fw-semibold" : "text-muted" %>'>
                            <%# Eval("Message") %>
                        </p>
                        <small class="text-muted">
                            <%# Convert.ToDateTime(Eval("CreatedAt")).ToString("dd MMM yyyy HH:mm") %>
                        </small>
                    </div>
                    <asp:Button ID="btnMarkRead" runat="server"
                        Text="Mark as Read"
                        CommandName="MarkRead"
                        CommandArgument='<%# Eval("NotificationId") %>'
                        CssClass="btn btn-outline-secondary btn-sm ms-3"
                        Visible='<%# !Convert.ToBoolean(Eval("IsRead")) %>' />
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>

</div>
</asp:Content>