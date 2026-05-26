<%@ Page Title="Discussions" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Discussions.aspx.cs" Inherits="Aidify_assigment.Instructor.Discussions" %>

<asp:Content ID="DiscussionsContent" ContentPlaceHolderID="MainContent" runat="server">

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

<style>
    body {
        font-family: 'Inter', sans-serif !important;
        background: #fff8f7 !important;
        color: #281715 !important;
    }

    .material-symbols-outlined {
        font-variation-settings: 'FILL' 0, 'wght' 500, 'GRAD' 0, 'opsz' 24;
        vertical-align: middle;
    }

    .aidify-page {
        min-height: 100vh;
        background: #fff8f7;
    }

    .aidify-sidebar {
        position: fixed;
        left: 0;
        top: 0;
        width: 220px;
        height: 100vh;
        background: #fff0ee;
        border-right: 1px solid #e6bdb8;
        padding: 20px 12px;
        display: flex;
        flex-direction: column;
        z-index: 20;
    }

    .aidify-brand {
        padding: 0 12px 30px;
    }

    .aidify-brand h1 {
        margin: 0;
        color: #b70011;
        font-size: 18px;
        font-weight: 800;
    }

    .aidify-brand p {
        margin: 3px 0 0;
        color: #5c403c;
        font-size: 11px;
    }

    .aidify-nav {
        display: flex;
        flex-direction: column;
        gap: 6px;
        flex: 1;
    }

    .aidify-nav a,
    .aidify-sidebar-bottom a {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 10px 12px;
        border-radius: 8px;
        color: #5c403c;
        text-decoration: none !important;
        font-size: 13px;
        font-weight: 700;
        transition: .2s ease;
    }

    .aidify-nav a:hover,
    .aidify-sidebar-bottom a:hover {
        background: #fbdbd7;
        color: #281715;
    }

    .aidify-nav a.active {
        background: #b70011;
        color: #fff;
        box-shadow: 0 8px 18px rgba(183, 0, 17, .16);
    }

    .aidify-nav .material-symbols-outlined,
    .aidify-sidebar-bottom .material-symbols-outlined {
        font-size: 18px;
    }

    .aidify-sidebar-bottom {
        border-top: 1px solid #e6bdb8;
        padding-top: 14px;
        display: flex;
        flex-direction: column;
        gap: 6px;
    }

    .aidify-topbar {
        position: fixed;
        top: 0;
        left: 220px;
        right: 0;
        height: 56px;
        background: rgba(255, 248, 247, .94);
        border-bottom: 1px solid #e6bdb8;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 24px;
        z-index: 15;
    }

    .topbar-search {
        position: relative;
        width: min(460px, 100%);
    }

    .topbar-search .material-symbols-outlined {
        position: absolute;
        left: 13px;
        top: 50%;
        transform: translateY(-50%);
        color: #5c403c;
        font-size: 20px;
    }

    .topbar-search input {
        width: 100%;
        height: 38px;
        border-radius: 999px;
        border: 1px solid #e6bdb8;
        background: #fff0ee;
        padding: 0 16px 0 42px;
        color: #281715;
        font-size: 13px;
        outline: none;
        box-sizing: border-box;
    }

    .topbar-actions {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .topbar-icon {
        width: 34px;
        height: 34px;
        border: 0;
        background: transparent;
        color: #281715;
        border-radius: 999px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
    }

    .topbar-icon:hover {
        background: #fbdbd7;
        color: #b70011;
    }

    .profile-chip {
        display: flex;
        align-items: center;
        gap: 8px;
        color: #281715;
        text-decoration: none !important;
        font-size: 12px;
        font-weight: 800;
    }

    .profile-chip img {
        width: 30px;
        height: 30px;
        border-radius: 999px;
        object-fit: cover;
        border: 1px solid #e6bdb8;
    }

    .aidify-main {
        margin-left: 220px;
        margin-top: 56px;
        padding: 28px;
        min-height: calc(100vh - 56px);
    }

    .page-container {
        max-width: 1220px;
        margin: 0 auto;
    }

    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        gap: 18px;
        margin-bottom: 22px;
    }

    .page-title {
        font-size: 30px;
        font-weight: 800;
        letter-spacing: -.035em;
        margin: 0 0 4px;
        color: #281715;
    }

    .page-subtitle {
        color: #5c403c;
        font-size: 14px;
        margin: 0;
        line-height: 1.5;
    }

    .header-actions,
    .button-row {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
    }

    .btn-primary-red,
    .btn-outline-red,
    .btn-muted {
        border-radius: 8px;
        padding: 10px 16px;
        font-size: 13px;
        font-weight: 800;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 7px;
        text-decoration: none !important;
        cursor: pointer;
    }

    .btn-primary-red {
        background: #b70011;
        color: #fff !important;
        border: 1px solid #b70011;
        box-shadow: 0 10px 22px rgba(183, 0, 17, .16);
    }

    .btn-outline-red {
        background: #fff;
        color: #b70011 !important;
        border: 1px solid #e6bdb8;
    }

    .btn-muted {
        background: #fff;
        color: #281715 !important;
        border: 1px solid #e6bdb8;
    }

    .summary-grid {
        display: grid;
        grid-template-columns: repeat(4, minmax(0, 1fr));
        gap: 16px;
        margin-bottom: 24px;
    }

    .summary-card,
    .filters-card,
    .reply-card,
    .discussion-card {
        background: #fff;
        border: 1px solid #e6bdb8;
        border-radius: 12px;
        box-shadow: 0 4px 14px rgba(40, 23, 21, .06);
    }

    .summary-card {
        padding: 18px;
        min-height: 112px;
    }

    .summary-icon {
        width: 34px;
        height: 34px;
        border-radius: 8px;
        background: #ffe9e6;
        color: #b70011;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 14px;
    }

    .summary-label {
        color: #5c403c;
        font-size: 11px;
        font-weight: 800;
        text-transform: uppercase;
        letter-spacing: .04em;
        margin-bottom: 5px;
    }

    .summary-value {
        color: #281715;
        font-size: 28px;
        line-height: 1;
        font-weight: 800;
        margin: 0;
    }

    .filters-card {
        padding: 16px;
        margin-bottom: 22px;
    }

    .filter-row {
        display: grid;
        grid-template-columns: auto minmax(260px, 1fr) auto;
        gap: 14px;
        align-items: center;
    }

    .filter-tabs {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
    }

    .filter-tabs button {
        border: 1px solid #e6bdb8;
        background: #fff;
        color: #5c403c;
        border-radius: 999px;
        padding: 8px 13px;
        font-size: 12px;
        font-weight: 800;
        cursor: pointer;
    }

    .filter-tabs button.active {
        background: #b70011;
        color: #fff;
        border-color: #b70011;
    }

    .filter-search {
        position: relative;
    }

    .filter-search .material-symbols-outlined {
        position: absolute;
        left: 12px;
        top: 50%;
        transform: translateY(-50%);
        color: #5c403c;
        font-size: 18px;
    }

    .filter-search input,
    .form-textarea {
        width: 100% !important;
        max-width: none !important;
        border: 1px solid #e6bdb8;
        background: #fff8f7;
        border-radius: 8px;
        color: #281715;
        font-size: 13px;
        outline: none;
        padding: 10px 12px;
        box-sizing: border-box;
    }

    .filter-search input {
        padding-left: 38px;
    }

    .reply-card {
        display: none;
        margin-bottom: 22px;
        overflow: hidden;
        scroll-margin-top: 88px;
    }

    .reply-card.visible {
        display: block;
    }

    .reply-header {
        padding: 16px 18px;
        border-bottom: 1px solid #e6bdb8;
        background: #fff8f7;
        display: flex;
        justify-content: space-between;
        gap: 16px;
        align-items: flex-start;
    }

    .reply-title {
        margin: 0;
        color: #281715;
        font-size: 18px;
        font-weight: 800;
    }

    .reply-subtitle {
        color: #5c403c;
        font-size: 12px;
        margin: 4px 0 0;
    }

    .reply-body {
        padding: 18px;
    }

    .form-textarea {
        min-height: 120px;
        resize: vertical;
        line-height: 1.5;
        margin-bottom: 12px;
    }

    .discussion-list {
        display: grid;
        gap: 16px;
    }

    .discussion-card {
        padding: 18px;
        transition: .2s ease;
    }

    .discussion-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 14px 28px rgba(40, 23, 21, .10);
    }

    .discussion-top {
        display: flex;
        justify-content: space-between;
        gap: 14px;
        align-items: flex-start;
        margin-bottom: 12px;
    }

    .learner-info {
        display: flex;
        gap: 12px;
        align-items: center;
    }

    .learner-avatar {
        width: 42px;
        height: 42px;
        border-radius: 999px;
        background: #ffe9e6;
        color: #b70011;
        font-weight: 800;
        display: flex;
        align-items: center;
        justify-content: center;
        border: 1px solid #e6bdb8;
    }

    .learner-name {
        color: #281715;
        font-size: 14px;
        font-weight: 800;
        margin-bottom: 3px;
    }

    .module-name {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        color: #5c403c;
        font-size: 12px;
        font-weight: 700;
    }

    .discussion-badges {
        display: flex;
        gap: 7px;
        flex-wrap: wrap;
        justify-content: flex-end;
    }

    .badge {
        border-radius: 999px;
        padding: 6px 10px;
        font-size: 11px;
        font-weight: 800;
        white-space: nowrap;
    }

    .badge-open {
        background: #ffdad6;
        color: #b70011;
    }

    .badge-pending {
        background: #fef3c7;
        color: #a16207;
    }

    .badge-answered {
        background: #dcfce7;
        color: #15803d;
    }

    .badge-high {
        background: #ba1a1a;
        color: #fff;
    }

    .badge-normal {
        background: #f3f4f6;
        color: #374151;
    }

    .discussion-title {
        color: #281715;
        font-size: 18px;
        line-height: 1.25;
        font-weight: 800;
        margin: 0 0 8px;
    }

    .discussion-preview {
        color: #5c403c;
        font-size: 13px;
        line-height: 1.55;
        margin: 0 0 14px;
    }

    .instructor-reply-preview {
        background: #fff8f7;
        border: 1px solid #e6bdb8;
        border-radius: 8px;
        padding: 10px;
        color: #281715;
        font-size: 13px;
        line-height: 1.55;
        margin: 0 0 14px;
    }

    .instructor-reply-preview strong {
        color: #b70011;
    }

    .discussion-meta {
        display: flex;
        align-items: center;
        gap: 18px;
        color: #5c403c;
        font-size: 12px;
        font-weight: 700;
        margin-bottom: 16px;
        flex-wrap: wrap;
    }

    .discussion-meta span {
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }

    .discussion-actions {
        border-top: 1px solid #e6bdb8;
        padding-top: 14px;
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
    }

    .discussion-action {
        color: #281715 !important;
        text-decoration: none !important;
        border-radius: 8px;
        padding: 9px 12px;
        font-size: 12px;
        font-weight: 800;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 5px;
        transition: .18s ease;
        background: #fff;
        border: 1px solid #e6bdb8;
        cursor: pointer;
    }

    .discussion-action:hover {
        background: #fff0ee;
        color: #b70011 !important;
    }

    .discussion-action.primary {
        background: #b70011;
        color: #fff !important;
        border-color: #b70011;
    }

    .discussion-action.answered-action {
        background: #dcfce7;
        color: #15803d !important;
        border-color: #86efac;
    }

    .discussion-action.answered-action:hover {
        background: #bbf7d0;
        color: #15803d !important;
    }

    .pagination-row {
        margin-top: 28px;
        border-top: 1px solid #e6bdb8;
        padding-top: 18px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        color: #5c403c;
        font-size: 13px;
        font-weight: 700;
    }

    .pagination {
        display: flex;
        gap: 7px;
        align-items: center;
    }

    .page-btn {
        width: 36px;
        height: 36px;
        border: 1px solid #e6bdb8;
        background: #fff;
        color: #281715;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 800;
        cursor: pointer;
    }

    .page-btn.active {
        background: #b70011;
        border-color: #b70011;
        color: #fff;
    }

    .page-btn:disabled {
        opacity: .45;
        cursor: not-allowed;
    }

    .toast {
        position: fixed;
        right: 24px;
        bottom: 24px;
        background: #281715;
        color: #fff;
        border-radius: 12px;
        padding: 14px 16px;
        font-size: 13px;
        font-weight: 800;
        box-shadow: 0 12px 30px rgba(40, 23, 21, .25);
        opacity: 0;
        pointer-events: none;
        transform: translateY(10px);
        transition: .25s ease;
        z-index: 100;
    }

    .toast.show {
        opacity: 1;
        transform: translateY(0);
    }

    @media (max-width: 1150px) {
        .summary-grid {
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }

        .filter-row {
            grid-template-columns: 1fr;
        }
    }
</style>

<div class="aidify-page">

    <aside class="aidify-sidebar">
        <div class="aidify-brand">
            <h1>Aidify</h1>
            <p>Instructor Portal</p>
        </div>

        <nav class="aidify-nav">
            <a href="/Instructor/Dashboard.aspx"><span class="material-symbols-outlined">dashboard</span>Dashboard</a>
            <a href="/Instructor/Modules/List.aspx"><span class="material-symbols-outlined">school</span>Modules</a>
            <a href="/Instructor/Materials/Upload.aspx"><span class="material-symbols-outlined">description</span>Materials</a>
            <a href="/Instructor/Quizzes/List.aspx"><span class="material-symbols-outlined">quiz</span>Quizzes</a>
            <a href="/Instructor/Performance.aspx"><span class="material-symbols-outlined">trending_up</span>Performance</a>
            <a class="active" href="/Instructor/Discussions.aspx"><span class="material-symbols-outlined">forum</span>Discussions</a>
            <a href="/Instructor/Challenges.aspx"><span class="material-symbols-outlined">military_tech</span>Challenges</a>
            <a href="/Instructor/Events.aspx"><span class="material-symbols-outlined">calendar_today</span>Events</a>
        </nav>

        <div class="aidify-sidebar-bottom">
            <a href="#" onclick="showToast('Settings selected.'); return false;"><span class="material-symbols-outlined">settings</span>Settings</a>
            <a href="#" style="color:#ba1a1a;" onclick="showToast('Logout selected.'); return false;"><span class="material-symbols-outlined">logout</span>Logout</a>
        </div>
    </aside>

    <header class="aidify-topbar">
        <div class="topbar-search">
            <span class="material-symbols-outlined">search</span>
            <input id="globalSearch" type="text" placeholder="Search discussions, learners, or modules..." />
        </div>

        <div class="topbar-actions">
            <button type="button" class="topbar-icon" onclick="openNotifications()">
                <span class="material-symbols-outlined">notifications</span>
            </button>

            <button type="button" class="topbar-icon" onclick="openHelp()">
                <span class="material-symbols-outlined">help_outline</span>
            </button>

            <a href="#" class="profile-chip" onclick="openProfile(); return false;">
                <img alt="Instructor" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBXsMkMFUJTraaiiBiKzgKj7zUOathxYepxlzKePooHo_1QLZSJZRV7fx_lpr7bF1c6pk1zJFoxlpIt8-qOoxggRqjwSnxvCfkqYeVxvcHDqaSoVAeiX4FaTBC3K1rscvbSFbJwapxCffY01KxBilHs4_-aoB20kHd3jvfZLt9MDdIbRAde7T-REZPaGEdBF7IHm9XA-CpgnCAhrpra-VGpluI4Kr_-7ZekahbaHI2Y4EgIgjzIMAb8PqQHUDfcvtsC55t6sq9pHdY" />
                <span>Dr. Sarah Mitchell</span>
            </a>
        </div>
    </header>

    <main class="aidify-main">
        <div class="page-container">

            <section class="page-header">
                <div>
                    <h2 class="page-title">Discussions</h2>
                    <p class="page-subtitle">Review learner questions, respond to module discussions, and resolve pending support requests.</p>
                </div>

                <div class="header-actions">
                    <button type="button" class="btn-primary-red" onclick="openNewReplyBox()">
                        <span class="material-symbols-outlined">add_comment</span>
                        New Reply
                    </button>

                    <button type="button" class="btn-outline-red" onclick="exportDiscussionReport()">
                        <span class="material-symbols-outlined">ios_share</span>
                        Export Report
                    </button>
                </div>
            </section>

            <section class="summary-grid">
                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">forum</span></div>
                    <div class="summary-label">Open Discussions</div>
                    <p class="summary-value" id="openValue">0</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">pending_actions</span></div>
                    <div class="summary-label">Pending Replies</div>
                    <p class="summary-value" id="pendingValue">0</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">check_circle</span></div>
                    <div class="summary-label">Answered Threads</div>
                    <p class="summary-value" id="answeredValue">0</p>
                </div>

                <div class="summary-card">
                    <div class="summary-icon"><span class="material-symbols-outlined">priority_high</span></div>
                    <div class="summary-label">High Priority</div>
                    <p class="summary-value" id="highValue">0</p>
                </div>
            </section>

            <section id="replyCard" class="reply-card">
                <div class="reply-header">
                    <div>
                        <h3 class="reply-title" id="replyTitle">Reply to Discussion</h3>
                        <p class="reply-subtitle" id="replySubtitle">Write a clear instructor response.</p>
                    </div>

                    <button type="button" class="btn-muted" onclick="closeReplyBox()">Cancel</button>
                </div>

                <div class="reply-body">
                    <textarea id="replyText" class="form-textarea" placeholder="Write your reply here..."></textarea>

                    <div class="button-row">
                        <button type="button" class="btn-primary-red" onclick="sendReply()">
                            <span class="material-symbols-outlined">send</span>
                            Send Reply
                        </button>

                        <button type="button" class="btn-outline-red" onclick="saveDraftReply()">
                            <span class="material-symbols-outlined">draft</span>
                            Save Draft
                        </button>
                    </div>
                </div>
            </section>

            <section class="filters-card">
                <div class="filter-row">
                    <div class="filter-tabs">
                        <button type="button" class="active" onclick="setDiscussionFilter('all', this)">All</button>
                        <button type="button" onclick="setDiscussionFilter('Open', this)">Open</button>
                        <button type="button" onclick="setDiscussionFilter('Answered', this)">Answered</button>
                        <button type="button" onclick="setDiscussionFilter('Pending', this)">Pending</button>
                        <button type="button" onclick="setDiscussionFilter('High Priority', this)">High Priority</button>
                    </div>

                    <div class="filter-search">
                        <span class="material-symbols-outlined">search</span>
                        <input id="discussionSearch" type="text" placeholder="Search discussions..." />
                    </div>

                    <button type="button" class="btn-muted" onclick="showFilterSummary()">
                        <span class="material-symbols-outlined">filter_list</span>
                        Filter
                    </button>
                </div>
            </section>

            <section id="discussionList" class="discussion-list"></section>

            <section class="pagination-row">
                <p id="paginationLabel">Showing 0 of 0 discussions</p>

                <div class="pagination">
                    <button type="button" id="prevPageBtn" class="page-btn" onclick="previousPage()">
                        <span class="material-symbols-outlined">chevron_left</span>
                    </button>

                    <button type="button" class="page-btn active" onclick="goToPage(1)">1</button>
                    <button type="button" class="page-btn" onclick="goToPage(2)">2</button>
                    <button type="button" class="page-btn" onclick="goToPage(3)">3</button>

                    <button type="button" id="nextPageBtn" class="page-btn" onclick="nextPage()">
                        <span class="material-symbols-outlined">chevron_right</span>
                    </button>
                </div>
            </section>

        </div>
    </main>
</div>

<div id="discussionToast" class="toast">Action completed.</div>

<script>
    var discussions = [
        {
            learner: "Aisha Rahman",
            initials: "AR",
            module: "CPR Fundamentals",
            status: "Open",
            priority: "Normal",
            title: "Clarification on compression depth",
            preview: "I understand the recommended compression depth is 5–6 cm, but how strict is this range during real emergency practice?",
            replies: 4,
            time: "12 minutes ago",
            instructorReply: "",
            markedAnswered: false
        },
        {
            learner: "Daniel Lim",
            initials: "DL",
            module: "Airway Emergencies",
            status: "Pending",
            priority: "High Priority",
            title: "Choking response timing",
            preview: "When should we switch from back blows to abdominal thrusts during an adult choking scenario?",
            replies: 2,
            time: "28 minutes ago",
            instructorReply: "",
            markedAnswered: false
        },
        {
            learner: "Omar Hassan",
            initials: "OH",
            module: "Burn Treatment Basics",
            status: "Open",
            priority: "Normal",
            title: "Burn classification question",
            preview: "I am confused about identifying partial thickness burns versus full thickness burns in the chart example.",
            replies: 3,
            time: "2 hours ago",
            instructorReply: "",
            markedAnswered: false
        },
        {
            learner: "Mei Wong",
            initials: "MW",
            module: "Pediatric First Aid",
            status: "Pending",
            priority: "High Priority",
            title: "Pediatric CPR ratio",
            preview: "Does the compression-to-breath ratio change when two rescuers are present for a child patient?",
            replies: 1,
            time: "3 hours ago",
            instructorReply: "",
            markedAnswered: false
        },
        {
            learner: "Nabil Ahmad",
            initials: "NA",
            module: "Emergency Wound Care",
            status: "Answered",
            priority: "Normal",
            title: "Wound cleaning sequence",
            preview: "Should irrigation always happen before antiseptic application, or does it depend on the wound type?",
            replies: 5,
            time: "Yesterday",
            instructorReply: "Irrigation usually comes first to remove debris before applying any antiseptic. The exact approach still depends on wound type and contamination level.",
            markedAnswered: true
        },
        {
            learner: "Sara Wong",
            initials: "SW",
            module: "Trauma Response",
            status: "Open",
            priority: "High Priority",
            title: "Trauma triage priority",
            preview: "How do we decide which trauma patient gets immediate attention when several symptoms appear severe?",
            replies: 6,
            time: "Yesterday",
            instructorReply: "",
            markedAnswered: false
        },
        {
            learner: "Jason Lee",
            initials: "JL",
            module: "CPR Fundamentals",
            status: "Answered",
            priority: "Normal",
            title: "AED placement question",
            preview: "Where exactly should AED pads be placed when the patient has a very small chest frame?",
            replies: 4,
            time: "2 days ago",
            instructorReply: "Use the standard pad placement when possible. If pads risk touching, use an anterior-posterior placement according to the device guidance.",
            markedAnswered: true
        },
        {
            learner: "Lina Tan",
            initials: "LT",
            module: "Airway Emergencies",
            status: "Pending",
            priority: "Normal",
            title: "Recovery position doubt",
            preview: "Should we always place an unconscious breathing patient in the recovery position immediately?",
            replies: 0,
            time: "2 days ago",
            instructorReply: "",
            markedAnswered: false
        },
        {
            learner: "Ahmed Zaki",
            initials: "AZ",
            module: "Emergency Wound Care",
            status: "Answered",
            priority: "Normal",
            title: "Bleeding control order",
            preview: "Do we apply pressure first or elevate the limb first during heavy bleeding?",
            replies: 7,
            time: "3 days ago",
            instructorReply: "Direct pressure is the first priority for heavy bleeding. Elevation may support control, but it should not delay direct pressure.",
            markedAnswered: true
        }
    ];

    var activeFilter = "all";
    var currentPage = 1;
    var pageSize = 3;
    var selectedDiscussionIndex = -1;

    document.addEventListener("DOMContentLoaded", function () {
        var discussionSearch = document.getElementById("discussionSearch");
        var globalSearch = document.getElementById("globalSearch");

        discussionSearch.addEventListener("input", function () {
            currentPage = 1;
            renderDiscussions();
        });

        globalSearch.addEventListener("input", function () {
            discussionSearch.value = globalSearch.value;
            currentPage = 1;
            renderDiscussions();
        });

        renderDiscussions();
        updateSummary();
    });

    function showToast(message) {
        var toast = document.getElementById("discussionToast");
        toast.textContent = message;
        toast.classList.add("show");

        clearTimeout(window.__discussionToastTimer);
        window.__discussionToastTimer = setTimeout(function () {
            toast.classList.remove("show");
        }, 2200);
    }

    function getFilteredDiscussions() {
        var query = (document.getElementById("discussionSearch").value || "").toLowerCase().trim();

        return discussions.filter(function (item) {
            var matchesFilter =
                activeFilter === "all" ||
                item.status === activeFilter ||
                item.priority === activeFilter;

            var searchable = (item.learner + " " + item.module + " " + item.title + " " + item.preview + " " + item.instructorReply).toLowerCase();
            var matchesSearch = !query || searchable.indexOf(query) !== -1;

            return matchesFilter && matchesSearch;
        });
    }

    function renderDiscussions() {
        var list = document.getElementById("discussionList");
        var filtered = getFilteredDiscussions();
        var totalPages = Math.max(1, Math.ceil(filtered.length / pageSize));

        if (currentPage > totalPages) {
            currentPage = totalPages;
        }

        var start = (currentPage - 1) * pageSize;
        var pageItems = filtered.slice(start, start + pageSize);

        list.innerHTML = "";

        pageItems.forEach(function (item) {
            var realIndex = discussions.indexOf(item);
            var card = document.createElement("article");
            card.className = "discussion-card";

            var instructorReplyBlock = "";

            if (item.instructorReply && item.instructorReply.trim()) {
                instructorReplyBlock =
                    '<p class="instructor-reply-preview">' +
                    '<strong>Instructor Reply:</strong> ' + escapeHtml(item.instructorReply) +
                    '</p>';
            }

            var markAnsweredClass = item.markedAnswered === true
                ? "discussion-action answered-action"
                : "discussion-action";

            var markAnsweredText = item.markedAnswered === true
                ? "Answered"
                : "Mark Answered";

            card.innerHTML =
                '<div class="discussion-top">' +
                '<div class="learner-info">' +
                '<div class="learner-avatar">' + escapeHtml(item.initials) + '</div>' +
                '<div>' +
                '<div class="learner-name">' + escapeHtml(item.learner) + '</div>' +
                '<div class="module-name"><span class="material-symbols-outlined" style="font-size:15px;">school</span>' + escapeHtml(item.module) + '</div>' +
                '</div>' +
                '</div>' +
                '<div class="discussion-badges">' +
                '<span class="badge ' + getStatusClass(item.status) + '">' + escapeHtml(item.status) + '</span>' +
                '<span class="badge ' + getPriorityClass(item.priority) + '">' + escapeHtml(item.priority) + '</span>' +
                '</div>' +
                '</div>' +
                '<h3 class="discussion-title">' + escapeHtml(item.title) + '</h3>' +
                '<p class="discussion-preview">' + escapeHtml(item.preview) + '</p>' +
                instructorReplyBlock +
                '<div class="discussion-meta">' +
                '<span><span class="material-symbols-outlined">forum</span>' + item.replies + ' Replies</span>' +
                '<span><span class="material-symbols-outlined">schedule</span>' + escapeHtml(item.time) + '</span>' +
                '</div>' +
                '<div class="discussion-actions">' +
                '<button type="button" class="discussion-action" onclick="viewDiscussion(' + realIndex + ')"><span class="material-symbols-outlined">visibility</span>View</button>' +
                '<button type="button" class="discussion-action primary" onclick="replyDiscussion(' + realIndex + ')"><span class="material-symbols-outlined">reply</span>Reply</button>' +
                '<button type="button" class="' + markAnsweredClass + '" onclick="markAnswered(' + realIndex + ')"><span class="material-symbols-outlined">check_circle</span>' + markAnsweredText + '</button>' +
                '</div>';

            list.appendChild(card);
        });

        updatePagination(filtered.length, start, pageItems.length, totalPages);
    }

    function updatePagination(total, start, count, totalPages) {
        var from = total === 0 ? 0 : start + 1;
        var to = start + count;

        document.getElementById("paginationLabel").textContent =
            "Showing " + from + " - " + to + " of " + total + " discussions";

        document.getElementById("prevPageBtn").disabled = currentPage <= 1;
        document.getElementById("nextPageBtn").disabled = currentPage >= totalPages;

        var numericButtons = Array.prototype.slice.call(document.querySelectorAll(".pagination .page-btn")).filter(function (button) {
            return /^\d+$/.test(button.textContent.trim());
        });

        numericButtons.forEach(function (button) {
            var page = parseInt(button.textContent.trim(), 10);
            button.classList.remove("active");
            button.style.display = page <= totalPages ? "flex" : "none";

            if (page === currentPage) {
                button.classList.add("active");
            }
        });
    }

    function setDiscussionFilter(filter, button) {
        activeFilter = filter;
        currentPage = 1;

        document.querySelectorAll(".filter-tabs button").forEach(function (btn) {
            btn.classList.remove("active");
        });

        button.classList.add("active");
        renderDiscussions();

        showToast(filter === "all" ? "Showing all discussions." : "Filtered by " + filter + ".");
    }

    function showFilterSummary() {
        var count = getFilteredDiscussions().length;
        showToast("Current filter shows " + count + " discussion(s).");
    }

    function viewDiscussion(index) {
        var item = discussions[index];

        var replyText = item.instructorReply && item.instructorReply.trim()
            ? item.instructorReply
            : "No instructor reply has been added yet.";

        alert(
            "Discussion Details\n\n" +
            "Learner: " + item.learner + "\n" +
            "Module: " + item.module + "\n" +
            "Status: " + item.status + "\n" +
            "Priority: " + item.priority + "\n" +
            "Replies: " + item.replies + "\n\n" +
            "Learner Question:\n" +
            item.title + "\n\n" +
            item.preview + "\n\n" +
            "Instructor Reply:\n" +
            replyText
        );
    }

    function replyDiscussion(index) {
        selectedDiscussionIndex = index;
        var item = discussions[index];

        document.getElementById("replyTitle").textContent = "Reply to: " + item.title;
        document.getElementById("replySubtitle").textContent = item.learner + " • " + item.module;
        document.getElementById("replyText").value = item.instructorReply || "";

        document.getElementById("replyCard").classList.add("visible");

        setTimeout(function () {
            document.getElementById("replyCard").scrollIntoView({ behavior: "smooth", block: "start" });
        }, 50);

        showToast("Reply box opened.");
    }

    function openNewReplyBox() {
        selectedDiscussionIndex = -1;

        document.getElementById("replyTitle").textContent = "New Instructor Reply";
        document.getElementById("replySubtitle").textContent = "Write a general clarification reply for learners.";
        document.getElementById("replyText").value = "";

        document.getElementById("replyCard").classList.add("visible");

        setTimeout(function () {
            document.getElementById("replyCard").scrollIntoView({ behavior: "smooth", block: "start" });
        }, 50);

        showToast("New reply box opened.");
    }

    function closeReplyBox() {
        document.getElementById("replyCard").classList.remove("visible");
        selectedDiscussionIndex = -1;
        showToast("Reply closed.");
    }

    function sendReply() {
        var reply = document.getElementById("replyText").value.trim();

        if (!reply) {
            showToast("Reply text is required.");
            document.getElementById("replyText").focus();
            return;
        }

        if (selectedDiscussionIndex >= 0) {
            var existingReply = discussions[selectedDiscussionIndex].instructorReply || "";

            discussions[selectedDiscussionIndex].instructorReply = reply;

            if (!existingReply.trim()) {
                discussions[selectedDiscussionIndex].replies += 1;
            }

            discussions[selectedDiscussionIndex].status = "Answered";
            discussions[selectedDiscussionIndex].markedAnswered = true;
            discussions[selectedDiscussionIndex].time = "Just now";

            showToast("Reply sent and saved to discussion.");
        } else {
            localStorage.setItem("aidifyGeneralInstructorReply", reply);
            showToast("General reply saved.");
        }

        document.getElementById("replyText").value = "";
        document.getElementById("replyCard").classList.remove("visible");

        renderDiscussions();
        updateSummary();
    }

    function saveDraftReply() {
        var reply = document.getElementById("replyText").value.trim();

        if (!reply) {
            showToast("Nothing to save.");
            return;
        }

        if (selectedDiscussionIndex >= 0) {
            localStorage.setItem("aidifyDiscussionDraft_" + selectedDiscussionIndex, reply);
        } else {
            localStorage.setItem("aidifyGeneralInstructorReply", reply);
        }

        showToast("Reply draft saved.");
    }

    function markAnswered(index) {
        if (discussions[index].markedAnswered === true) {
            showToast("Discussion is already marked as answered.");
            return;
        }

        discussions[index].status = "Answered";
        discussions[index].markedAnswered = true;
        discussions[index].time = "Just now";

        if (!discussions[index].instructorReply || !discussions[index].instructorReply.trim()) {
            discussions[index].instructorReply = "Marked as answered without a written reply.";
        }

        renderDiscussions();
        updateSummary();
        showToast("Discussion marked as answered.");
    }

    function previousPage() {
        if (currentPage > 1) {
            currentPage--;
            renderDiscussions();
            showToast("Previous page.");
        }
    }

    function nextPage() {
        var totalPages = Math.max(1, Math.ceil(getFilteredDiscussions().length / pageSize));

        if (currentPage < totalPages) {
            currentPage++;
            renderDiscussions();
            showToast("Next page.");
        }
    }

    function goToPage(page) {
        var totalPages = Math.max(1, Math.ceil(getFilteredDiscussions().length / pageSize));

        if (page <= totalPages) {
            currentPage = page;
            renderDiscussions();
            showToast("Page " + page + " selected.");
        }
    }

    function updateSummary() {
        var open = 0;
        var pending = 0;
        var answered = 0;
        var high = 0;

        discussions.forEach(function (item) {
            if (item.status === "Open") open++;
            if (item.status === "Pending") pending++;
            if (item.status === "Answered") answered++;
            if (item.priority === "High Priority") high++;
        });

        document.getElementById("openValue").textContent = open;
        document.getElementById("pendingValue").textContent = pending;
        document.getElementById("answeredValue").textContent = answered;
        document.getElementById("highValue").textContent = high;
    }

    function exportDiscussionReport() {
        updateSummary();

        var rows = discussions.map(function (item) {
            return "<tr>" +
                "<td>" + escapeHtml(item.learner) + "</td>" +
                "<td>" + escapeHtml(item.module) + "</td>" +
                "<td>" + escapeHtml(item.title) + "</td>" +
                "<td>" + escapeHtml(item.status) + "</td>" +
                "<td>" + escapeHtml(item.priority) + "</td>" +
                "<td>" + item.replies + "</td>" +
                "<td>" + escapeHtml(item.instructorReply || "No reply") + "</td>" +
                "</tr>";
        }).join("");

        var reportWindow = window.open("", "_blank", "width=1100,height=800");

        if (!reportWindow) {
            alert("Popup blocked. Please allow popups to export the report.");
            return;
        }

        reportWindow.document.open();
        reportWindow.document.write(
            "<!DOCTYPE html><html><head><title>Aidify Discussion Report</title>" +
            "<style>" +
            "body{font-family:Arial,sans-serif;margin:32px;color:#281715;}" +
            "h1{color:#b70011;margin-bottom:6px;}" +
            ".sub{color:#5c403c;margin-bottom:22px;}" +
            ".summary{display:grid;grid-template-columns:repeat(4,1fr);gap:12px;margin-bottom:24px;}" +
            ".box{border:1px solid #e6bdb8;border-radius:10px;background:#fff8f7;padding:14px;}" +
            ".label{font-size:11px;text-transform:uppercase;font-weight:800;color:#5c403c;}" +
            ".value{font-size:24px;font-weight:800;margin-top:6px;}" +
            "table{width:100%;border-collapse:collapse;}" +
            "th{background:#fff0ee;color:#5c403c;text-align:left;padding:10px;border:1px solid #e6bdb8;font-size:11px;text-transform:uppercase;}" +
            "td{padding:10px;border:1px solid #e6bdb8;font-size:13px;vertical-align:top;}" +
            "</style></head><body>" +
            "<h1>Aidify Discussion Report</h1>" +
            "<div class='sub'>Generated from Instructor Discussion Manager</div>" +
            "<div class='summary'>" +
            "<div class='box'><div class='label'>Open</div><div class='value'>" + document.getElementById("openValue").textContent + "</div></div>" +
            "<div class='box'><div class='label'>Pending</div><div class='value'>" + document.getElementById("pendingValue").textContent + "</div></div>" +
            "<div class='box'><div class='label'>Answered</div><div class='value'>" + document.getElementById("answeredValue").textContent + "</div></div>" +
            "<div class='box'><div class='label'>High Priority</div><div class='value'>" + document.getElementById("highValue").textContent + "</div></div>" +
            "</div>" +
            "<table><thead><tr><th>Learner</th><th>Module</th><th>Discussion</th><th>Status</th><th>Priority</th><th>Replies</th><th>Instructor Reply</th></tr></thead><tbody>" +
            rows +
            "</tbody></table></body></html>"
        );
        reportWindow.document.close();

        showToast("Discussion report exported.");
    }

    function openNotifications() {
        alert(
            "Discussion Notifications\n\n" +
            "• 3 high-priority discussions need attention.\n" +
            "• 3 pending replies are waiting for instructor response.\n" +
            "• New CPR and Trauma questions were posted recently."
        );
    }

    function openHelp() {
        alert(
            "Discussions Help\n\n" +
            "View: opens discussion details and shows instructor reply if available.\n" +
            "Reply: opens the instructor reply box.\n" +
            "Send Reply: saves the reply and marks the discussion as answered.\n" +
            "Mark Answered: turns the button green and resolves the discussion.\n" +
            "Filters: show discussions by status or priority.\n" +
            "Export Report: opens a clean printable report."
        );
    }

    function openProfile() {
        alert(
            "Instructor Profile\n\n" +
            "Dr. Sarah Mitchell\n" +
            "Lead Medical Instructor\n" +
            "Verified Educator"
        );
    }

    function getStatusClass(status) {
        if (status === "Answered") return "badge-answered";
        if (status === "Pending") return "badge-pending";
        return "badge-open";
    }

    function getPriorityClass(priority) {
        if (priority === "High Priority") return "badge-high";
        return "badge-normal";
    }

    function escapeHtml(value) {
        return String(value || "")
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }
</script>

</asp:Content>