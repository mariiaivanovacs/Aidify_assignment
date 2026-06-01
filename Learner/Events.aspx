<%@ Page Title="Learner / Events" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Events.aspx.cs" Inherits="Aidify_assigment.Learner.Events" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="container-fluid px-4 py-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="fw-bold mb-0">Upcoming Events</h4>
    </div>

    <asp:Label ID="lblNoEvents" runat="server"
        Text="No upcoming events."
        CssClass="text-muted fst-italic"
        Visible="false" />

    <asp:Repeater ID="rptEvents" runat="server" OnItemCommand="rptEvents_ItemCommand">
        <ItemTemplate>
            <div class="card shadow-sm mb-3" style="border-radius:10px;">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <h6 class="fw-bold mb-1"><%# Eval("Title") %></h6>
                            <p class="text-muted small mb-2"><%# Eval("Description") %></p>
                            <small class="text-muted">
                                <i class="bi bi-calendar-event"></i>
                                <%# Convert.ToDateTime(Eval("EventDate")).ToString("dd MMM yyyy HH:mm") %>
                            </small>
                            <br />
                            <small class="text-muted">
                                <%# string.IsNullOrEmpty(Eval("MeetingUrl").ToString())
                                    ? "<i class='bi bi-geo-alt'></i> " + Eval("Location")
                                    : "<i class='bi bi-camera-video'></i> <a href='" + Eval("MeetingUrl") + "' target='_blank'>Join Online</a>" %>
                            </small>
                        </div>
                        <div class="d-flex flex-column align-items-end gap-2">
                            <asp:Button ID="btnRegister" runat="server"
                                Text="Register"
                                CommandName="Register"
                                CommandArgument='<%# Eval("EventId") %>'
                                CssClass="btn btn-primary btn-sm"
                                Visible='<%# !Convert.ToBoolean(Eval("AlreadyRegistered")) %>' />
                            <%# Convert.ToBoolean(Eval("AlreadyRegistered")) ? "<span class=\"badge bg-success px-3 py-2\">✓ Registered</span>" : "" %>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>

</div>
</asp:Content>