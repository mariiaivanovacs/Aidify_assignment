<%@ Page Title="Browse Courses" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Catalogue.aspx.cs" Inherits="Aidify_assigment.Learner.Courses.Catalogue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .course-card-wrap  { border-radius: 12px; border: 1px solid #f0d8d8; background: #fff; overflow: hidden; height: 100%; }
    .course-card-wrap .card-img-top { height: 160px; object-fit: cover; }
    .course-card-body  { padding: 16px; display: flex; flex-direction: column; flex: 1; }
    .difficulty-badge  { display: inline-block; padding: 3px 10px; border-radius: 20px; font-size: 11px; font-weight: 700; margin-bottom: 8px; }
    .diff-beginner     { background: #d8f3e7; color: #198754; }
    .diff-intermediate { background: #fff3cd; color: #856404; }
    .diff-advanced     { background: #ffe1e4; color: #C0392B; }
    .diff-default      { background: #f0f0f0; color: #555; }
    .search-bar        { background: #fff; border: 1px solid #f0d8d8; border-radius: 10px; padding: 20px; margin-bottom: 24px; }
</style>

<div class="mb-4">
    <h3 class="fw-bold mb-1">Browse Courses</h3>
    <p class="text-muted" style="font-size:13px;">Find something new to learn today.</p>
</div>

<div class="search-bar">
    <div class="row g-2 align-items-end">
        <div class="col-md-6">
            <asp:TextBox ID="txtCatalogueSearch" runat="server"
                CssClass="form-control" placeholder="Search by title..." />
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
                CssClass="btn btn-danger w-100"
                OnClick="btnCatalogueSearch_Click" />
        </div>
    </div>
</div>

<asp:Label ID="lblNoCourses" runat="server"
    Text="No courses match your search."
    CssClass="text-muted fst-italic"
    Visible="false" />

<div class="row g-4">
    <asp:Repeater ID="rptModules" runat="server" OnItemCommand="rptModules_ItemCommand">
        <ItemTemplate>
            <div class="col-md-4 d-flex">
                <div class="course-card-wrap d-flex flex-column w-100">
                    <img src='<%# Eval("CoverImageUrl") %>' class="card-img-top"
                         onerror="this.src='https://placehold.co/400x160?text=No+Image'" />
                    <div class="course-card-body">
                        <span class='difficulty-badge <%# GetDifficultyBadge(Eval("Difficulty").ToString()) %>'>
                            <%# Eval("Difficulty") %>
                        </span>
                        <h5 class="fw-semibold mb-1" style="font-size:15px;"><%# Eval("ModuleTitle") %></h5>
                        <p class="text-muted small flex-grow-1"><%# Eval("Description") %></p>
                        <asp:Button ID="btnEnrol" runat="server"
                            Text="Enrol"
                            CssClass="btn btn-danger btn-sm w-100 mt-2"
                            CommandName="Enrol"
                            CommandArgument='<%# Eval("ModuleId") %>' />
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>

</asp:Content>
