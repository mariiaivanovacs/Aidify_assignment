<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Catalogue.aspx.cs" Inherits="LearnerDash.Learner.Courses.Catalogue" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container-fluid px-4 py-4">

    <%-- Page Header --%>
    <div class="mb-4">
        <h3 class="fw-bold">Browse Courses</h3>
        <p class="text-muted">Find something new to learn today.</p>
    </div>

    <%-- Search & Filter Bar --%>
    <div class="row mb-4 g-2">
        <div class="col-md-6">
            <asp:TextBox ID="txtCatalogueSearch" runat="server"
                CssClass="form-control"
                placeholder="Search by title..." />
        </div>
        <div class="col-md-3">
            <asp:DropDownList ID="ddlDifficultyFilter" runat="server" CssClass="form-select">
                <asp:ListItem Text="All Levels" Value="" />
                <asp:ListItem Text="Beginner" Value="Beginner" />
                <asp:ListItem Text="Intermediate" Value="Intermediate" />
                <asp:ListItem Text="Advanced" Value="Advanced" />
            </asp:DropDownList>
        </div>
        <div class="col-md-2">
            <asp:Button ID="btnCatalogueSearch" runat="server" Text="Search"
                CssClass="btn btn-primary w-100"
                OnClick="btnCatalogueSearch_Click" />
        </div>
    </div>

    <%-- No Results --%>
    <asp:Label ID="lblNoCourses" runat="server"
        Text="No courses match your search."
        CssClass="text-muted fst-italic"
        Visible="false" />

    <%-- Course Cards --%>
    <div class="row g-4">
        <asp:Repeater ID="rptModules" runat="server" OnItemCommand="rptModules_ItemCommand">
            <ItemTemplate>
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm" style="border-radius:12px;">
                        <img src='<%# Eval("CoverImageUrl") %>' class="card-img-top"
                             style="height:160px; object-fit:cover; border-radius:12px 12px 0 0;"
                             onerror="this.src='https://placehold.co/400x160?text=No+Image'" />
                        <div class="card-body d-flex flex-column">
                            <div class="mb-2">
                                <span class='badge <%# GetDifficultyBadge(Eval("Difficulty").ToString()) %>'>
                                    <%# Eval("Difficulty") %>
                                </span>
                            </div>
                            <h5 class="card-title fw-semibold"><%# Eval("ModuleTitle") %></h5>
                            <p class="card-text text-muted small flex-grow-1"><%# Eval("Description") %></p>
                            <div class="mt-3">
                                <asp:Button ID="btnEnrol" runat="server"
                                    Text="Enrol"
                                    CssClass="btn btn-primary btn-sm w-100"
                                    CommandName="Enrol"
                                    CommandArgument='<%# Eval("ModuleId") %>' />
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</div>

</asp:Content>
