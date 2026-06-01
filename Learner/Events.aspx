<%@ Page Title="Events" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Events.aspx.cs" Inherits="Aidify_assigment.Learner.Events" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .event-card        { background: #fff; border: 1px solid #f0d8d8; border-radius: 12px; padding: 20px 24px; margin-bottom: 14px; display: flex; justify-content: space-between; align-items: flex-start; gap: 16px; }
    .event-card:hover  { background: #FDF2F2; }
    .event-card h6     { font-weight: 700; margin-bottom: 4px; font-size: 15px; }
    .event-card .meta  { font-size: 12px; color: #888; margin-top: 6px; display: flex; flex-direction: column; gap: 3px; }
    .event-card .meta a { color: #C0392B; text-decoration: none; }
    .registered-badge  { background: #d8f3e7; color: #198754; padding: 5px 14px; border-radius: 20px; font-size: 12px; font-weight: 700; }
</style>

<div class="mb-4">
    <h3 class="fw-bold mb-1">Upcoming Events</h3>
    <p class="text-muted" style="font-size:13px;">Browse and register for upcoming learning events.</p>
</div>

<asp:Label ID="lblNoEvents" runat="server"
    Text="No upcoming events."
    CssClass="text-muted fst-italic"
    Visible="false" />

<asp:Repeater ID="rptEvents" runat="server" OnItemCommand="rptEvents_ItemCommand">
    <ItemTemplate>
        <div class="event-card">
            <div>
                <h6><%# Eval("Title") %></h6>
                <p class="text-muted small mb-2"><%# Eval("Description") %></p>
                <div class="meta">
                    <span><i class="bi bi-calendar-event"></i>
                        <%# Convert.ToDateTime(Eval("EventDate")).ToString("dd MMM yyyy HH:mm") %>
                    </span>
                    <span>
                        <%# string.IsNullOrEmpty(Eval("MeetingUrl").ToString())
                            ? "<i class='bi bi-geo-alt'></i> " + Eval("Location")
                            : "<i class='bi bi-camera-video'></i> <a href='" + Eval("MeetingUrl") + "' target='_blank'>Join Online</a>" %>
                    </span>
                </div>
            </div>
            <div class="d-flex flex-column align-items-end gap-2 flex-shrink-0">
                <asp:Button ID="btnRegister" runat="server"
                    Text="Register"
                    CommandName="Register"
                    CommandArgument='<%# Eval("EventId") %>'
                    CssClass="btn btn-danger btn-sm"
                    Visible='<%# !Convert.ToBoolean(Eval("AlreadyRegistered")) %>' />
                <%# Convert.ToBoolean(Eval("AlreadyRegistered")) ? "<span class='registered-badge'>✓ Registered</span>" : "" %>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>

</asp:Content>
