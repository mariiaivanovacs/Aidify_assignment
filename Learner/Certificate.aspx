<%@ Page Title="Learner / Certificates" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Certificates.aspx.cs" Inherits="Aidify_assigment.Learner.Certificates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="container-fluid px-4 py-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="fw-bold mb-0">My Certificates</h4>
    </div>

    <asp:Label ID="lblNoCerts" runat="server"
        Text="Complete a module to earn your first certificate."
        CssClass="text-muted fst-italic"
        Visible="false" />

    <asp:Repeater ID="rptCertificates" runat="server">
        <ItemTemplate>
            <div class="card shadow-sm mb-3" style="border-radius:10px;">
                <div class="card-body p-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="fw-bold mb-1"><%# Eval("Title") %></h6>
                        <small class="text-muted">
                            Issued: <%# Convert.ToDateTime(Eval("IssuedAt")).ToString("MMMM yyyy") %>
                        </small>
                    </div>
                    <%# string.IsNullOrEmpty(Eval("PdfPath").ToString())
                        ? "<span class=\"btn btn-outline-secondary btn-sm disabled\">Download PDF</span>"
                        : "<a href='" + ResolveUrl(Eval("PdfPath").ToString()) + "' class=\"btn btn-outline-primary btn-sm\">Download PDF</a>" %>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>

</div>
</asp:Content>