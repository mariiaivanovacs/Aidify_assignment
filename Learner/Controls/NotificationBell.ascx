<%@ Control Language="C#" AutoEventWireup="true"
    CodeBehind="NotificationBell.ascx.cs"
    Inherits="LearnerDash.Learner.Controls.NotificationBell" %>

<span class="position-relative">
    <i class="bi bi-bell fs-5"></i>
    <asp:Label ID="lblUnreadCount" runat="server"
        CssClass="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
        Visible="false" />
</span>

<script>
    setInterval(function () {
        $.get('/Learner/Api/UnreadCount.ashx', function (d) {
            var el = document.getElementById('<%= lblUnreadCount.ClientID %>');
            if (d > 0) { el.textContent = d; el.style.display = ''; }
            else { el.style.display = 'none'; }
        });
    }, 60000); // poll every 60 seconds
</script>