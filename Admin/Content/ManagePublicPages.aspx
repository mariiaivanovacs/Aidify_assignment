<%@ Page Title="Manage Public Pages" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManagePublicPages.aspx.cs" Inherits="Aidify_assigment.Admin.Content.ManagePublicPages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .aidify-navbar,
    .aidify-footer {
        display: none !important;
    }

    body {
        background-color: #f9f9f9;
    }

    /* ── TOPBAR ── */
    .pages-topbar {
        height: 80px;
        background: #ffffff;
        border-bottom: 1px solid #e2e2e2;
        display: flex;
        align-items: center;
        position: sticky;
        top: 0;
        z-index: 50;
    }

    .pages-brand {
        color: #E53935;
        font-size: 26px;
        font-weight: 800;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .admin-badge {
        background-color: #db322f;
        color: #fff;
        font-size: 11px;
        padding: 3px 9px;
        border-radius: 20px;
        font-weight: 700;
    }

    .pages-nav a {
        color: #3d2a28;
        text-decoration: none;
        margin-left: 22px;
        font-weight: 600;
        font-size: 14px;
    }

    .pages-nav a.active {
        color: #E53935;
        border-bottom: 2px solid #E53935;
        padding-bottom: 8px;
    }

    .admin-avatar {
        width: 42px;
        height: 42px;
        border-radius: 50%;
        background: #E53935;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 800;
        flex-shrink: 0;
    }

    /* ── PAGE ── */
    .manage-pages-wrapper {
        padding: 44px 0 60px;
    }

    .manage-pages-wrapper h1 {
        font-size: 32px;
        font-weight: 800;
        color: #1a1a1a;
        margin-bottom: 4px;
    }

    /* ── PAGE CARDS ── */
    .page-card {
        background: white;
        border: 1px solid #e2e2e2;
        border-radius: 16px;
        padding: 24px;
        transition: box-shadow 0.2s;
    }

    .page-card:hover {
        box-shadow: 0 4px 14px rgba(0,0,0,0.06);
    }

    /* ── STATUS BADGES ── */
    .page-status {
        font-size: 12px;
        font-weight: 700;
        padding: 5px 14px;
        border-radius: 999px;
    }

    .published-badge {
        background: #ffdad6;
        color: #93000d;
    }

    .draft-badge {
        background: #e2e2e2;
        color: #555;
    }

    /* ── WORKING TOGGLE SWITCH ── */
    /*
        How it works (beginner explanation):
        - We hide the real checkbox input (opacity:0, width:0, height:0)
        - We style the <label> to LOOK like a toggle pill
        - The label's ::after pseudo-element is the white circle/knob
        - When the checkbox is :checked, CSS changes the background color
          and moves the knob to the right using translateX
        - Because the <label> is linked to the <input> via htmlFor/for,
          clicking the label toggles the real checkbox — so it works!
    */

    .toggle-wrap {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-top: 10px;
        justify-content: flex-end;
    }

    .toggle-label-text {
        font-size: 13px;
        font-weight: 600;
        color: #888;
        min-width: 42px;
        text-align: right;
    }

    /* Hide the real checkbox */
    .toggle-input {
        opacity: 0;
        width: 0;
        height: 0;
        position: absolute;
    }

    /* The pill-shaped track */
    .toggle-track {
        display: inline-block;
        width: 46px;
        height: 26px;
        background: #d6d6d6;
        border-radius: 999px;
        position: relative;
        cursor: pointer;
        transition: background 0.25s;
        flex-shrink: 0;
    }

    /* The white knob */
    .toggle-track::after {
        content: "";
        position: absolute;
        width: 20px;
        height: 20px;
        background: #ffffff;
        border-radius: 50%;
        top: 3px;
        left: 3px;
        transition: transform 0.25s;
        box-shadow: 0 1px 3px rgba(0,0,0,0.2);
    }

    /* When checked: turn red and slide knob right */
    .toggle-input:checked + .toggle-track {
        background: #E53935;
    }

    .toggle-input:checked + .toggle-track::after {
        transform: translateX(20px);
    }

    /* ── FOOTER ── */
    .pages-footer {
        background: #f3f3f3;
        border-top: 1px solid #e2e2e2;
        padding: 28px 0 16px;
    }

    .pages-footer .footer-brand {
        color: #E53935;
        font-weight: 800;
        font-size: 18px;
    }

    .pages-footer a {
        color: #555;
        text-decoration: none;
        font-size: 13px;
    }

    .pages-footer a:hover {
        color: #E53935;
    }

    @media (max-width: 992px) {
        .pages-nav { display: none; }
    }
</style>

<!-- ── TOPBAR ── -->
<header class="pages-topbar">
    <div class="container d-flex justify-content-between align-items-center">

        <a href="../Dashboard.aspx" class="pages-brand">
            Aidify
            <span class="admin-badge">ADMIN</span>
        </a>

        <nav class="pages-nav">
            <a href="../Dashboard.aspx">Dashboard</a>
            <a href="../Users/List.aspx">Users</a>
            <a href="../Roles.aspx">Roles</a>
            <a href="ManagePublicPages.aspx" class="active">Public Pages</a>
            <a href="ApprovalQueue.aspx">Approvals</a>
            <a href="../Analytics.aspx">Analytics</a>
        </nav>

        <div class="d-flex align-items-center gap-3">
            <i class="bi bi-bell fs-5"></i>
            <div class="text-end d-none d-md-block">
                <div class="fw-bold" style="font-size:14px;"><%: Aidify_assigment.AuthHelper.GetName() %></div>
                <small class="text-muted"><%: Aidify_assigment.AuthHelper.GetRole() %></small>
            </div>
            <div class="admin-avatar">A</div>
        </div>

    </div>
</header>

<!-- ── MAIN ── -->
<main class="manage-pages-wrapper">
    <div class="container">

        <div class="mb-4">
            <h1>Manage Public Pages</h1>
            <p class="text-muted" style="font-size:15px;">
                Update and monitor visitor-facing educational and informational content.
            </p>
        </div>

        <div class="d-flex flex-column gap-4">

            <!-- Home Page -->
            <div class="page-card">
                <div class="d-flex justify-content-between align-items-start mb-4">
                    <div>
                        <h3 class="fw-bold mb-1">Home Page</h3>
                        <p class="text-muted mb-0">Hero section, welcome text, and featured content.</p>
                    </div>
                    <div class="text-end">
                        <span class="page-status published-badge">Published</span>
                        <div class="toggle-wrap">
                            <span class="toggle-label-text">Visible</span>
                            <input type="checkbox" id="toggle-home" class="toggle-input" checked="checked" />
                            <label for="toggle-home" class="toggle-track"></label>
                        </div>
                    </div>
                </div>
                <div class="border-top pt-4">
                    <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                        <small class="text-muted">Last updated: <strong><%: System.IO.File.GetLastWriteTime(Server.MapPath("~/Default.aspx")).ToString("MMM dd, yyyy") %></strong></small>
                        <div class="d-flex gap-2">
                            <a href="~/Default.aspx" target="_blank" class="btn btn-aidify">
                                <i class="bi bi-pencil-square me-1"></i> View Page
                            </a>
                            <a href="~/Default.aspx" target="_blank" class="btn btn-outline-secondary">
                                <i class="bi bi-eye me-1"></i> Preview
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- About Page -->
            <div class="page-card">
                <div class="d-flex justify-content-between align-items-start mb-4">
                    <div>
                        <h3 class="fw-bold mb-1">About Page</h3>
                        <p class="text-muted mb-0">Mission, platform overview, and team introduction.</p>
                    </div>
                    <div class="text-end">
                        <span class="page-status draft-badge">Draft</span>
                        <div class="toggle-wrap">
                            <span class="toggle-label-text">Hidden</span>
                            <input type="checkbox" id="toggle-about" class="toggle-input" />
                            <label for="toggle-about" class="toggle-track"></label>
                        </div>
                    </div>
                </div>
                <div class="border-top pt-4">
                    <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                        <small class="text-muted">Last updated: <strong><%: System.IO.File.GetLastWriteTime(Server.MapPath("~/Public/About.aspx")).ToString("MMM dd, yyyy") %></strong></small>
                        <div class="d-flex gap-2">
                            <a href="~/Public/About.aspx" target="_blank" class="btn btn-aidify">
                                <i class="bi bi-pencil-square me-1"></i> View Page
                            </a>
                            <a href="~/Public/About.aspx" target="_blank" class="btn btn-outline-secondary">
                                <i class="bi bi-eye me-1"></i> Preview
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- FAQ Page -->
            <div class="page-card">
                <div class="d-flex justify-content-between align-items-start mb-4">
                    <div>
                        <h3 class="fw-bold mb-1">FAQ Page</h3>
                        <p class="text-muted mb-0">Frequently asked questions and support guidance.</p>
                    </div>
                    <div class="text-end">
                        <span class="page-status published-badge">Published</span>
                        <div class="toggle-wrap">
                            <span class="toggle-label-text">Visible</span>
                            <input type="checkbox" id="toggle-faq" class="toggle-input" checked="checked" />
                            <label for="toggle-faq" class="toggle-track"></label>
                        </div>
                    </div>
                </div>
                <div class="border-top pt-4">
                    <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                        <small class="text-muted">Last updated: <strong><%: System.IO.File.GetLastWriteTime(Server.MapPath("~/Public/FAQ.aspx")).ToString("MMM dd, yyyy") %></strong></small>
                        <div class="d-flex gap-2">
                            <a href="~/Public/FAQ.aspx" target="_blank" class="btn btn-aidify">
                                <i class="bi bi-pencil-square me-1"></i> View Page
                            </a>
                            <a href="~/Public/FAQ.aspx" target="_blank" class="btn btn-outline-secondary">
                                <i class="bi bi-eye me-1"></i> Preview
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Contact Page -->
            <div class="page-card">
                <div class="d-flex justify-content-between align-items-start mb-4">
                    <div>
                        <h3 class="fw-bold mb-1">Contact Page</h3>
                        <p class="text-muted mb-0">Contact information, support email, and inquiries.</p>
                    </div>
                    <div class="text-end">
                        <span class="page-status published-badge">Published</span>
                        <div class="toggle-wrap">
                            <span class="toggle-label-text">Visible</span>
                            <input type="checkbox" id="toggle-contact" class="toggle-input" checked="checked" />
                            <label for="toggle-contact" class="toggle-track"></label>
                        </div>
                    </div>
                </div>
                <div class="border-top pt-4">
                    <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                        <small class="text-muted">Last updated: <strong><%: System.IO.File.GetLastWriteTime(Server.MapPath("~/Public/Contact.aspx")).ToString("MMM dd, yyyy") %></strong></small>
                        <div class="d-flex gap-2">
                            <a href="~/Public/Contact.aspx" target="_blank" class="btn btn-aidify">
                                <i class="bi bi-pencil-square me-1"></i> View Page
                            </a>
                            <a href="~/Public/Contact.aspx" target="_blank" class="btn btn-outline-secondary">
                                <i class="bi bi-eye me-1"></i> Preview
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Emergency Awareness -->
            <div class="page-card">
                <div class="d-flex justify-content-between align-items-start mb-4">
                    <div>
                        <h3 class="fw-bold mb-1">Emergency Awareness</h3>
                        <p class="text-muted mb-0">Emergency procedures, safety guidance, and awareness tips.</p>
                    </div>
                    <div class="text-end">
                        <span class="page-status published-badge">Published</span>
                        <div class="toggle-wrap">
                            <span class="toggle-label-text">Visible</span>
                            <input type="checkbox" id="toggle-emergency" class="toggle-input" checked="checked" />
                            <label for="toggle-emergency" class="toggle-track"></label>
                        </div>
                    </div>
                </div>
                <div class="border-top pt-4">
                    <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                        <small class="text-muted">Last updated: <strong><%: System.IO.File.GetLastWriteTime(Server.MapPath("~/Public/EmergencyAwareness.aspx")).ToString("MMM dd, yyyy") %></strong></small>
                        <div class="d-flex gap-2">
                            <a href="~/Public/EmergencyAwareness.aspx" target="_blank" class="btn btn-aidify">
                                <i class="bi bi-pencil-square me-1"></i> View Page
                            </a>
                            <a href="~/Public/EmergencyAwareness.aspx" target="_blank" class="btn btn-outline-secondary">
                                <i class="bi bi-eye me-1"></i> Preview
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Preview Modules -->
            <div class="page-card">
                <div class="d-flex justify-content-between align-items-start mb-4">
                    <div>
                        <h3 class="fw-bold mb-1">Preview Modules</h3>
                        <p class="text-muted mb-0">Guest-access learning previews and sample modules.</p>
                    </div>
                    <div class="text-end">
                        <span class="page-status published-badge">Published</span>
                        <div class="toggle-wrap">
                            <span class="toggle-label-text">Visible</span>
                            <input type="checkbox" id="toggle-modules" class="toggle-input" checked="checked" />
                            <label for="toggle-modules" class="toggle-track"></label>
                        </div>
                    </div>
                </div>
                <div class="border-top pt-4">
                    <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                        <small class="text-muted">Last updated: <strong><%: System.IO.File.GetLastWriteTime(Server.MapPath("~/Public/PreviewModules.aspx")).ToString("MMM dd, yyyy") %></strong></small>
                        <div class="d-flex gap-2">
                            <a href="~/Public/PreviewModules.aspx" target="_blank" class="btn btn-aidify">
                                <i class="bi bi-pencil-square me-1"></i> View Page
                            </a>
                            <a href="~/Public/PreviewModules.aspx" target="_blank" class="btn btn-outline-secondary">
                                <i class="bi bi-eye me-1"></i> Preview
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Preview Quiz -->
            <div class="page-card">
                <div class="d-flex justify-content-between align-items-start mb-4">
                    <div>
                        <h3 class="fw-bold mb-1">Preview Quiz</h3>
                        <p class="text-muted mb-0">Sample quiz questions and visitor assessment previews.</p>
                    </div>
                    <div class="text-end">
                        <span class="page-status draft-badge">Draft</span>
                        <div class="toggle-wrap">
                            <span class="toggle-label-text">Hidden</span>
                            <input type="checkbox" id="toggle-quiz" class="toggle-input" />
                            <label for="toggle-quiz" class="toggle-track"></label>
                        </div>
                    </div>
                </div>
                <div class="border-top pt-4">
                    <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                        <small class="text-muted">Last updated: <strong><%: System.IO.File.GetLastWriteTime(Server.MapPath("~/Public/PreviewQuiz.aspx")).ToString("MMM dd, yyyy") %></strong></small>
                        <div class="d-flex gap-2">
                            <a href="~/Public/PreviewQuiz.aspx" target="_blank" class="btn btn-aidify">
                                <i class="bi bi-pencil-square me-1"></i> View Page
                            </a>
                            <a href="~/Public/PreviewQuiz.aspx" target="_blank" class="btn btn-outline-secondary">
                                <i class="bi bi-eye me-1"></i> Preview
                            </a>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</main>

<!-- ── FOOTER ── -->
<footer class="pages-footer">
    <div class="container">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-3 mb-3">
            <div>
                <div class="footer-brand">Aidify</div>
                <p class="text-muted small mb-0">Administrative control center for the Aidify learning platform.</p>
            </div>
            <div class="d-flex align-items-center gap-3">
                <a href="../Dashboard.aspx">Dashboard</a>
                <span class="text-muted">|</span>
                <a href="#">Privacy Policy</a>
                <span class="text-muted">|</span>
                <a href="#">Terms of Service</a>
            </div>
        </div>
        <hr class="mt-1 mb-2" />
        <p class="text-muted small mb-0 text-center">© 2026 Aidify Admin Panel. Educational use only.</p>
    </div>
</footer>

<!-- Toggle label text update script -->
<script>
    // When a toggle is clicked, update the "Visible"/"Hidden" text next to it
    document.querySelectorAll('.toggle-input').forEach(function (checkbox) {
        checkbox.addEventListener('change', function () {
            var labelText = this.parentElement.querySelector('.toggle-label-text');
            if (this.checked) {
                labelText.textContent = 'Visible';
            } else {
                labelText.textContent = 'Hidden';
            }
        });
    });
</script>

</asp:Content>
