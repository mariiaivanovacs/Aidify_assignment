<%@ Page Title="Notifications" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Notifications.aspx.cs" Inherits="Aidify_assigment.Learner.Notifications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .notif-card        { background: #fff; border: 1px solid #f0d8d8; border-radius: 12px; padding: 16px 20px; margin-bottom: 10px; display: flex; justify-content: space-between; align-items: flex-start; gap: 16px; }
    .notif-card.unread { border-left: 4px solid #C0392B; background: #FDF2F2; }
    .notif-card .msg   { font-size: 14px; margin-bottom: 4px; }
    .notif-card .unread-msg { font-weight: 600; color: #222; }
    .notif-card .read-msg   { color: #888; }
    .notif-card .time  { font-size: 11px; color: #aaa; }
</style>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-1">Notifications</h3>
        <p class="text-muted" style="font-size:13px;">Stay up to date with your learning activity.</p>
    </div>
    <asp:Button ID="btnMarkAllRead" runat="server"
        Text="Mark All as Read"
        CssClass="btn btn-outline-danger btn-sm"
        OnClick="btnMarkAllRead_Click" />
</div>

<asp:Label ID="lblNoNotifications" runat="server"
    Text="You have no notifications."
    CssClass="text-muted fst-italic"
    Visible="false" />

<asp:Repeater ID="rptNotifications" runat="server" OnItemCommand="rptNotifications_ItemCommand">
    <ItemTemplate>
        <div class='notif-card <%# !Convert.ToBoolean(Eval("IsRead")) ? "unread" : "" %>'>
            <div>
                <p class='msg <%# !Convert.ToBoolean(Eval("IsRead")) ? "unread-msg" : "read-msg" %>'>
                    <%# Eval("Message") %>
                </p>
                <div class="time">
                    <%# Convert.ToDateTime(Eval("CreatedAt")).ToString("dd MMM yyyy HH:mm") %>
                </div>
            </div>
            <asp:Button ID="btnMarkRead" runat="server"
                Text="Mark as Read"
                CommandName="MarkRead"
                CommandArgument='<%# Eval("NotificationId") %>'
                CssClass="btn btn-outline-danger btn-sm flex-shrink-0"
                Visible='<%# !Convert.ToBoolean(Eval("IsRead")) %>' />
        </div>
    </ItemTemplate>
</asp:Repeater>

</asp:Content>
