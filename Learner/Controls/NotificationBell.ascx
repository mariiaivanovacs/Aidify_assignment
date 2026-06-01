<%@ Control Language="C#" AutoEventWireup="true"
    CodeBehind="NotificationBell.ascx.cs"
    Inherits="Aidify_assigment.Learner.Controls.NotificationBell" %>

<style>
    .bell-wrap       { position: relative; display: inline-block; }
    .bell-wrap .bi   { font-size: 18px; color: #555; }
    .bell-wrap:hover .bi { color: #C0392B; }
    .notif-badge     { position: absolute; top: -4px; right: -8px; background: #C0392B; color: #fff; font-size: 10px; font-weight: 700; padding: 1px 5px; border-radius: 10px; min-width: 16px; text-align: center; }
</style>

<span class="bell-wrap">
    <i class="bi bi-bell"></i>
    <asp:Label ID="lblUnreadCount" runat="server"
        CssClass="notif-badge"
        Visible="false" />
</span>

<script type="text/javascript">
    setInterval(function () {
        $.get('/Learner/Api/UnreadCount.ashx', function (d) {
            var el = document.getElementById('<%= lblUnreadCount.ClientID %>');
            if (d > 0) { el.textContent = d; el.style.display = ''; }
            else { el.style.display = 'none'; }
        });
    }, 60000);
</script>
