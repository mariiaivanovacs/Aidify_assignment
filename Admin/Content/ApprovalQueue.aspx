<%@ Page Title="Content Approval Queue" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApprovalQueue.aspx.cs" Inherits="Aidify_assigment.Admin.Content.ApprovalQueue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .aidify-navbar, .aidify-footer { display:none!important; }
    body { background-color:#f9f9f9; }

    .approval-topbar {
        height:70px; background:#fff; border-bottom:1px solid #e2e2e2;
        display:flex; align-items:center; position:sticky; top:0; z-index:50;
    }

    .approval-nav a {
        color:#3d2a28; text-decoration:none; margin-left:22px;
        font-weight:600; font-size:14px;
    }

    .approval-nav a.active {
        color:#E53935; border-bottom:2px solid #E53935; padding-bottom:6px;
    }

    .approval-page { padding:44px 0 60px; background-color:#f9f9f9; }

    .approval-page h1 {
        font-size:30px; font-weight:800; color:#1a1a1a; margin-bottom:4px;
    }

    .filter-bar {
        background:#f3f3f3; border-radius:12px; padding:12px 16px;
        border:1px solid #e2e2e2; margin-bottom:24px;
    }

    .filter-btn {
        background:#fff; border:1px solid #e2e2e2; color:#444;
        font-weight:600; font-size:13px; border-radius:8px;
        padding:6px 16px; margin-right:6px; cursor:pointer;
    }

    .filter-btn:hover, .filter-btn.active {
        background:#1f2933; color:#fff; border-color:#1f2933;
    }

    .filter-search {
        border:1px solid #e2e2e2; border-radius:8px; font-size:13px;
        height:36px; padding:0 12px; width:240px; outline:none;
    }

    .filter-search:focus { border-color:#E53935; }

    .approval-card {
        background:#fff; border:1px solid #e2e2e2; border-radius:14px;
        overflow:hidden; transition:box-shadow .2s;
    }

    .approval-card:hover { box-shadow:0 4px 18px rgba(0,0,0,.08); }

    .badge-category {
        font-size:10px; font-weight:800; text-transform:uppercase; letter-spacing:.8px;
    }

    .btn-sm-outline-danger {
        border:1px solid #fca5a5; background:#fff; color:#E53935;
        border-radius:7px; font-size:13px; font-weight:600;
        padding:6px 14px; cursor:pointer; display:inline-flex;
        align-items:center; gap:5px; text-decoration:none;
    }

    .btn-sm-outline-danger:hover { background:#fff5f5; }

    .btn-sm-approve {
        background:#E53935; color:#fff; border:none; border-radius:7px;
        font-size:13px; font-weight:700; padding:6px 14px;
        cursor:pointer; display:inline-flex; align-items:center;
        gap:5px; text-decoration:none;
    }

    .btn-sm-approve:hover { background:#c62828; color:#fff; }

    .pagination-bar {
        display:flex; justify-content:center; align-items:center;
        gap:6px; margin-top:36px;
    }

    .page-btn {
        width:36px; height:36px; border-radius:8px; border:1px solid #e2e2e2;
        background:#fff; color:#444; font-weight:600; font-size:14px;
        display:flex; align-items:center; justify-content:center;
        cursor:pointer; text-decoration:none;
    }

    .page-btn:hover { border-color:#E53935; color:#E53935; }
    .page-btn.active { background:#E53935; color:#fff; border-color:#E53935; }
    .page-btn:disabled { opacity:.45; cursor:not-allowed; }

    
    .approval-logo{
        width:42px;
        height:42px;
        object-fit:contain;
    }

    .approval-brand {
        display:flex;
        align-items:center;
        gap:12px;
        color:#E53935;
        font-size:22px;
        font-weight:800;
        text-decoration:none;
    }
    .approval-footer {
        background:#f3f3f3; border-top:1px solid #e2e2e2; padding:28px 0 16px;
    }

    .approval-footer .footer-brand {
        color:#E53935; font-weight:800; font-size:17px;
    }

    .approval-footer a {
        color:#555; text-decoration:none; font-size:13px;
    }

    .approval-footer a:hover { color:#E53935; }

    @media (max-width:768px) {
        .approval-nav { display:none; }
    }

    .approval-dropdown{
        text-decoration:none;
        color:#1f2937;
        font-weight:700;
        font-size:18px;
        display:flex;
        align-items:center;
        gap:6px;
    }

    .approval-dropdown:hover{
        color:#E53935;
    }

    .dropdown-menu{
        min-width:180px;
        border-radius:12px;
    }
</style>

<header class="approval-topbar">
    <div class="container d-flex justify-content-between align-items-center">

        <a href="../Dashboard.aspx" class="approval-brand">

            <img src="<%= ResolveUrl("~/Images/aidify-kit.png") %>"
                 alt="Aidify Logo"
                 class="approval-logo" />

            <span>Aidify</span>

        </a>

        <nav class="approval-nav">
            <a href="../Dashboard.aspx">Dashboard</a>
            <a href="../Users/List.aspx">Users</a>
            <a href="ApprovalQueue.aspx" class="active">Approvals</a>
            <a href="../Analytics.aspx">Analytics</a>
        </nav>

        <div class="dropdown">

            <a href="#"
               class="approval-dropdown"
               data-bs-toggle="dropdown"
               aria-expanded="false">

                Admin
                <i class="bi bi-chevron-down"></i>

            </a>

            <ul class="dropdown-menu dropdown-menu-end shadow-sm">

                <li>
                    <a class="dropdown-item"
                       href="../../Account/Profile.aspx">
                        <i class="bi bi-person me-2"></i>
                        Profile
                    </a>
                </li>

                <li>
                    <a class="dropdown-item text-danger"
                       href="../../Auth/Logout.aspx">
                        <i class="bi bi-box-arrow-right me-2"></i>
                        Logout
                    </a>
                </li>

            </ul>

        </div>

    </div>
</header>

<main class="approval-page">
    <div class="container">

        <div class="mb-4">
            <h1>Content Approval Queue</h1>
            <p class="text-muted" style="font-size:15px;">
                Review and manage pending modules, events, and challenges submitted for approval.
            </p>
        </div>

        <div class="filter-bar d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div>
                <button type="button" class="filter-btn active" id="btnAllRequests">All Requests (0)</button>
                <button type="button" class="filter-btn" id="btnModules">Modules (0)</button>
                <button type="button" class="filter-btn" id="btnEvents">Events (0)</button>
                <button type="button" class="filter-btn" id="btnChallenges">Challenges (0)</button>
            </div>

            <div class="d-flex align-items-center gap-2">
                <i class="bi bi-search text-muted" style="font-size:13px;"></i>
                <input type="text" id="approvalSearchBox" class="filter-search" placeholder="Search by author or topic..." />
            </div>
        </div>

        <div class="row g-4" id="moduleCardsContainer">
            <div class="col-12 text-center text-muted py-5">Loading pending modules…</div>
        </div>

        <div class="pagination-bar" id="approvalPagination"></div>

    </div>
</main>

<script type="text/javascript">
    var allModules = [];
    var allEvents = [];
    var allChallenges = [];
    var currentView = "all";
    var currentPage = 1;
    var pageSize = 4;

    function loadPendingModules() {
        $.ajax({
            type: 'POST',
            url: 'ApprovalQueue.aspx/GetPendingModules',
            data: '{}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (r) {
                allModules = r.d || [];
                currentPage = 1;
                updateCounts();
                renderModules();
            },
            error: function () {
                document.getElementById('moduleCardsContainer').innerHTML =
                    '<div class="col-12 text-danger text-center py-5">Failed to load pending modules.</div>';
            }
        });
    }

    function loadPendingEvents() {
        $.ajax({
            type: 'POST',
            url: 'ApprovalQueue.aspx/GetPendingEvents',
            data: '{}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (r) {
                allEvents = r.d || [];
                updateCounts();
                renderModules();
            }
        });
    }

    function loadPendingChallenges() {
        $.ajax({
            type: 'POST',
            url: 'ApprovalQueue.aspx/GetPendingChallenges',
            data: '{}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (r) {
                allChallenges = r.d || [];
                updateCounts();
                renderModules();
            }
        });
    }

    function updateCounts() {

        document.getElementById('btnModules').textContent =
            'Modules (' + allModules.length + ')';

        document.getElementById('btnEvents').textContent =
            'Events (' + allEvents.length + ')';

        document.getElementById('btnChallenges').textContent =
            'Challenges (' + allChallenges.length + ')';

        document.getElementById('btnAllRequests').textContent =
            'All Requests (' + (allModules.length + allEvents.length + allChallenges.length) + ')';
    }

    function getFilteredModules() {

        var search =
            document.getElementById('approvalSearchBox')
                .value
                .toLowerCase();

        var items = [];

        if (currentView === "modules")
            items = allModules;

        else if (currentView === "events")
            items = allEvents;

        else if (currentView === "challenges")
            items = allChallenges;

        else
            items = allModules.concat(allEvents).concat(allChallenges);

        return items.filter(function (m) {

            return String(m.title || '')
                .toLowerCase()
                .includes(search)

                ||

                String(m.createdByName || '')
                    .toLowerCase()
                    .includes(search);

        });
    }

    function renderModules() {
        var modules = getFilteredModules();
        var container = document.getElementById('moduleCardsContainer');

        if (!modules || modules.length === 0) {
            container.innerHTML =
                '<div class="col-12 text-center text-muted py-5">' +
                '<i class="bi bi-check-circle fs-1 d-block mb-3"></i>' +
                'No requests awaiting review.</div>';

            document.getElementById('approvalPagination').innerHTML = '';
            return;
        }

        var totalPages = Math.ceil(modules.length / pageSize);
        if (currentPage > totalPages) currentPage = totalPages;

        var start = (currentPage - 1) * pageSize;
        var pageModules = modules.slice(start, start + pageSize);

        var html = '';

        for (var i = 0; i < pageModules.length; i++) {
            var m = pageModules[i];
            var isEvent = m.itemType === "Event";
            var isChallenge = m.itemType === "Challenge";
            var dt = new Date(parseInt(m.submittedAt.replace('/Date(', '').replace(')/', '')));
            var dateStr = dt.toLocaleDateString('en-MY');

            html +=
                '<div class="col-lg-6">' +
                '<div class="approval-card p-4 h-100">' +
                '<div class="d-flex justify-content-between align-items-start mb-2">' +
                '<span class="badge-category text-danger">Pending Review</span>' +
                '<small class="text-muted">Submitted: ' + esc(dateStr) + '</small>' +
                '</div>' +

                '<h3 class="h5 fw-bold mb-1">' + esc(m.title) + '</h3>' +
                (isChallenge
                    ? '<p class="text-muted small mb-1">Reward: <strong>' +
                    esc(m.pointsReward || 0) +
                    ' points</strong></p>'
                    : isEvent
                    ? '<p class="text-muted small mb-1">Location: <strong>' +
                    esc(m.location || '-') +
                    '</strong></p>'
                    : '<p class="text-muted small mb-1">Difficulty: <strong>' +
                    esc(m.difficultyLevel || '-') +
                    '</strong></p>') +
                '<p class="text-muted small mb-3">Author: <strong>' + esc(m.createdByName) + '</strong></p>' +

                '<div class="d-flex flex-wrap gap-2">' +
                '<a href="ApprovalQueue.aspx?action=approve&type=' +
                (isChallenge ? 'challenge' : (isEvent ? 'event' : 'module')) +
                '&id=' + m.itemId +
                '" class="btn-sm-approve" onclick="return confirm(\'Approve this request?\');">' +
                '<i class="bi bi-check-circle"></i> Approve' +
                '</a>' +

                '<a href="#" class="btn-sm-outline-danger" onclick="return rejectRequest(\'' +
                (isChallenge ? 'challenge' : (isEvent ? 'event' : 'module')) +
                '\',' + m.itemId + ');">' +
                '<i class="bi bi-x-circle"></i> Reject' +
                '</a>' +
                '</div>' +
                '</div>' +
                '</div>';
        }

        container.innerHTML = html;
        renderPagination(totalPages);
    }

    function renderPagination(totalPages) {
        var html = '';

        html += '<button type="button" class="page-btn" ' +
            (currentPage === 1 ? 'disabled' : '') +
            ' onclick="currentPage--; renderModules();">&lsaquo;</button>';

        for (var i = 1; i <= totalPages; i++) {
            html += '<button type="button" class="page-btn ' +
                (i === currentPage ? 'active' : '') +
                '" onclick="currentPage=' + i + '; renderModules();">' + i + '</button>';
        }

        html += '<button type="button" class="page-btn" ' +
            (currentPage === totalPages ? 'disabled' : '') +
            ' onclick="currentPage++; renderModules();">&rsaquo;</button>';

        document.getElementById('approvalPagination').innerHTML = html;
    }

    function rejectRequest(type, id) {
        var reason = prompt('Enter the rejection reason for this request:');

        if (reason === null) {
            return false;
        }

        reason = reason.trim();

        if (reason.length === 0) {
            alert('A rejection reason is required.');
            return false;
        }

        window.location.href =
            'ApprovalQueue.aspx?action=reject&type=' +
            encodeURIComponent(type) +
            '&id=' + encodeURIComponent(id) +
            '&reason=' + encodeURIComponent(reason);

        return false;
    }

    function esc(s) {
        return String(s || '')
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;');
    }

    $(document).ready(function () {
        loadPendingModules();
        loadPendingEvents();
        loadPendingChallenges();

        $('#btnAllRequests').click(function () {
            currentView = "all";
            currentPage = 1;
            renderModules();
        });

        $('#btnModules').click(function () {
            currentView = "modules";
            currentPage = 1;
            renderModules();
        });

        $('#btnEvents').click(function () {
            currentView = "events";
            currentPage = 1;
            renderModules();
        });

        $('#btnChallenges').click(function () {
            currentView = "challenges";
            currentPage = 1;
            renderModules();
        });

        $('#approvalSearchBox').on('input', function () {
            currentPage = 1;
            renderModules();
        });
    });
</script>

<footer class="approval-footer">
    <div class="container">
        <div class="d-flex justify-content-between align-items-start flex-wrap gap-3 mb-3">
            <div>
                <div class="footer-brand">Aidify</div>
                <p class="text-muted small mb-0">Administrative control center for the Aidify learning platform.</p>
            </div>

            
        </div>

        <hr class="mt-1 mb-2" />
        <p class="text-muted small mb-0 text-center">© 2026 Aidify Admin Panel. Educational use only.</p>
    </div>
</footer>

</asp:Content>
