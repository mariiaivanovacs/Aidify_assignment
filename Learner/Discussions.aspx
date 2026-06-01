<%@ Page Title="Learner / Discussions" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" ValidateRequest="false"
    CodeBehind="Discussions.aspx.cs" Inherits="Aidify_assigment.Learner.Discussions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .discussion-shell { max-width: 980px; margin: 0 auto; }
    .discussion-panel { background: #fff; border: 1px solid #f0d8d8; border-radius: 12px; padding: 22px; margin-bottom: 18px; }
    .discussion-panel h5 { font-weight: 700; margin-bottom: 16px; }
    .thread-card { background: #fff; border: 1px solid #f0d8d8; border-radius: 12px; padding: 20px; margin-bottom: 16px; }
    .thread-title { font-weight: 800; font-size: 17px; margin-bottom: 4px; }
    .thread-meta { color: #888; font-size: 12px; margin-bottom: 12px; }
    .reply-row { background: #FDF2F2; border-radius: 10px; padding: 12px 14px; margin-top: 10px; }
    .reply-meta { color: #888; font-size: 11px; margin-bottom: 4px; }
    .form-label { font-weight: 700; font-size: 13px; }
</style>

<div class="discussion-shell">
    <div class="mb-4">
        <h3 class="fw-bold mb-1">Discussions</h3>
        <p class="text-muted" style="font-size:13px;">Ask questions and reply inside module discussions.</p>
    </div>

    <asp:Label ID="lblDiscussionStatus" runat="server" Visible="false" />

    <div class="discussion-panel">
        <h5>Start A Thread</h5>
        <div class="row g-3">
            <div class="col-md-5">
                <label class="form-label">Module</label>
                <asp:DropDownList ID="ddlModule" runat="server" CssClass="form-select" />
            </div>
            <div class="col-md-7">
                <label class="form-label">Title</label>
                <asp:TextBox ID="txtThreadTitle" runat="server" CssClass="form-control" MaxLength="300" />
            </div>
            <div class="col-12">
                <label class="form-label">Question</label>
                <asp:TextBox ID="txtThreadBody" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" />
            </div>
            <div class="col-12 d-flex justify-content-end">
                <asp:Button ID="btnCreateThread" runat="server"
                    Text="Post Thread"
                    CssClass="btn btn-danger px-4"
                    OnClick="btnCreateThread_Click" />
            </div>
        </div>
    </div>

    <div class="discussion-panel">
        <div class="d-flex justify-content-between align-items-end gap-3 flex-wrap">
            <div>
                <h5 class="mb-1">Threads</h5>
                <span class="text-muted small">Filter by module or view all published-module discussions.</span>
            </div>
            <div class="d-flex gap-2">
                <asp:DropDownList ID="ddlModuleFilter" runat="server" CssClass="form-select form-select-sm" />
                <asp:Button ID="btnApplyFilter" runat="server"
                    Text="Filter"
                    CssClass="btn btn-outline-danger btn-sm"
                    OnClick="btnApplyFilter_Click" />
            </div>
        </div>
    </div>

    <asp:Label ID="lblNoThreads" runat="server"
        Text="No discussions yet."
        CssClass="text-muted fst-italic"
        Visible="false" />

    <asp:Repeater ID="rptThreads" runat="server" OnItemDataBound="rptThreads_ItemDataBound" OnItemCommand="rptThreads_ItemCommand">
        <ItemTemplate>
            <div class="thread-card">
                <div class="thread-title"><%# Eval("Title") %></div>
                <div class="thread-meta">
                    <%# Eval("ModuleTitle") %> · <%# Eval("AuthorName") %> ·
                    <%# Convert.ToDateTime(Eval("CreatedAt")).ToString("dd MMM yyyy HH:mm") %>
                </div>
                <p class="mb-3"><%# Eval("Body") %></p>

                <asp:Repeater ID="rptReplies" runat="server">
                    <ItemTemplate>
                        <div class="reply-row">
                            <div class="reply-meta">
                                <%# Eval("AuthorName") %> · <%# Convert.ToDateTime(Eval("CreatedAt")).ToString("dd MMM yyyy HH:mm") %>
                            </div>
                            <div><%# Eval("Body") %></div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <div class="mt-3">
                    <asp:TextBox ID="txtReplyBody" runat="server"
                        TextMode="MultiLine"
                        Rows="2"
                        CssClass="form-control mb-2"
                        placeholder="Write a reply..." />
                    <asp:Button ID="btnAddReply" runat="server"
                        Text="Reply"
                        CommandName="AddReply"
                        CommandArgument='<%# Eval("ThreadId") %>'
                        CssClass="btn btn-outline-danger btn-sm" />
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>

</asp:Content>
