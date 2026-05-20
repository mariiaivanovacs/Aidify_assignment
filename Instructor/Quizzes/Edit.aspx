<%@ Page Title="Create / Edit Quiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="Aidify_assigment.Instructor.Quizzes.Edit" %>

<asp:Content ID="QuizEditContent" ContentPlaceHolderID="MainContent" runat="server">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: #fff8f7;
        }

        .quiz-page {
            min-height: 100vh;
            background: #fff8f7;
            color: #281715;
            display: flex;
        }

        .quiz-sidebar {
            width: 280px;
            min-height: 100vh;
            background: #fff0ee;
            border-right: 1px solid #e6bdb8;
            display: flex;
            flex-direction: column;
            padding: 24px 12px;
            flex-shrink: 0;
            position: sticky;
            top: 0;
            height: 100vh;
        }

        .brand {
            color: #b70011;
            font-size: 24px;
            font-weight: 800;
            padding: 0 16px 28px;
        }

        .instructor-card {
            display: flex;
            align-items: center;
            gap: 13px;
            padding: 0 16px 34px;
        }

        .instructor-avatar {
            width: 48px;
            height: 48px;
            border-radius: 999px;
            background: #ffdad6;
            border: 2px solid #b70011;
            color: #b70011;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
        }

        .instructor-name {
            font-size: 14px;
            font-weight: 800;
            color: #281715;
            line-height: 1.2;
        }

        .instructor-role {
            font-size: 12px;
            color: #5c403c;
            margin-top: 2px;
        }

        .verified {
            font-size: 11px;
            color: #b70011;
            font-weight: 800;
            margin-top: 2px;
        }

        .quiz-nav {
            display: flex;
            flex-direction: column;
            gap: 7px;
            flex: 1;
        }

        .quiz-nav a {
            display: flex;
            align-items: center;
            gap: 13px;
            padding: 13px 15px;
            margin: 0 2px;
            border-radius: 11px;
            color: #5c403c;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: 0.2s ease;
        }

        .quiz-nav a:hover {
            background: #fbdbd7;
            color: #281715;
        }

        .quiz-nav a.active {
            background: #b70011;
            color: #ffffff;
            box-shadow: 0 8px 18px rgba(183, 0, 17, 0.16);
        }

        .quiz-nav .material-symbols-outlined {
            font-size: 20px;
        }

        .sidebar-footer {
            border-top: 1px solid #e6bdb8;
            padding: 16px;
            color: #596373;
            font-size: 12px;
            font-weight: 600;
        }

        .quiz-main {
            flex: 1;
            min-width: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background: #fff8f7;
        }

        .quiz-topbar {
            height: 64px;
            background: #fff8f7;
            border-bottom: 1px solid #e6bdb8;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 32px;
            position: sticky;
            top: 0;
            z-index: 40;
        }

        .portal-title {
            color: #b70011;
            font-size: 20px;
            font-weight: 800;
            margin: 0;
        }

        .topbar-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .btn-preview,
        .btn-save-top {
            border-radius: 10px !important;
            padding: 9px 18px !important;
            font-size: 13px !important;
            font-weight: 800 !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            gap: 7px !important;
        }

        .btn-preview {
            background: #ffffff !important;
            color: #555f6f !important;
            border: 1px solid #916f6b !important;
        }

        .btn-preview:hover {
            background: #fbdbd7 !important;
        }

        .btn-save-top {
            background: #b70011 !important;
            color: #ffffff !important;
            border: 1px solid #b70011 !important;
            box-shadow: 0 10px 22px rgba(183, 0, 17, 0.14);
        }

        .notification {
            width: 34px;
            height: 34px;
            border-radius: 999px;
            color: #5c403c;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        .notification:hover {
            background: #fbdbd7;
            color: #b70011;
        }

        .notification-dot {
            position: absolute;
            top: 9px;
            right: 9px;
            width: 7px;
            height: 7px;
            background: #b70011;
            border-radius: 999px;
            border: 1px solid #ffffff;
        }

        .quiz-scroll {
            flex: 1;
            overflow-y: auto;
        }

        .quiz-container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 32px;
        }

        .page-header {
            margin-bottom: 32px;
        }

        .page-title {
            font-size: 48px;
            line-height: 1.1;
            letter-spacing: -0.04em;
            font-weight: 800;
            color: #281715;
            margin: 0 0 8px;
        }

        .page-subtitle {
            font-size: 18px;
            color: #5c403c;
            margin: 0;
        }

        .status-label {
            display: block;
            color: #596373;
            font-size: 13px;
            margin-top: 8px;
        }

        .quiz-layout {
            display: grid;
            grid-template-columns: 380px minmax(0, 1fr);
            gap: 32px;
            align-items: start;
        }

        .settings-card {
            background: #ffffff;
            border: 1px solid #e6bdb8;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 8px 22px rgba(40, 23, 21, 0.04);
            position: sticky;
            top: 88px;
        }

        .settings-title {
            display: flex;
            align-items: center;
            gap: 11px;
            font-size: 24px;
            font-weight: 800;
            color: #281715;
            margin: 0 0 24px;
        }

        .settings-title .material-symbols-outlined {
            color: #b70011;
        }

        .field-group {
            margin-bottom: 20px;
        }

        .field-label {
            display: block;
            color: #5c403c;
            font-size: 13px;
            font-weight: 800;
            margin-bottom: 8px;
        }

        .quiz-input,
        .quiz-select,
        .quiz-textarea {
            width: 100%;
            background: #fff8f7 !important;
            border: 1px solid #916f6b !important;
            border-radius: 10px !important;
            color: #281715 !important;
            padding: 11px 14px !important;
            font-size: 14px !important;
            box-shadow: none !important;
            outline: none !important;
        }

        .quiz-textarea {
            min-height: 110px;
            resize: vertical;
        }

        .quiz-input:focus,
        .quiz-select:focus,
        .quiz-textarea:focus {
            border-color: #b70011 !important;
            box-shadow: 0 0 0 4px rgba(183, 0, 17, 0.10) !important;
        }

        .validator-custom {
            color: #ba1a1a;
            font-size: 11px;
            font-weight: 700;
            display: block;
            margin-top: 6px;
        }

        .settings-section {
            border-top: 1px solid #e6bdb8;
            padding-top: 18px;
            margin-top: 18px;
        }

        .settings-kicker {
            color: #5c403c;
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.12em;
            margin-bottom: 16px;
        }

        .two-cols {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
        }

        .reference-row {
            border-top: 1px solid #e6bdb8;
            margin-top: 22px;
            padding-top: 18px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 14px;
        }

        .reference-label {
            color: #596373;
            font-size: 12px;
            font-weight: 600;
        }

        .reference-id {
            color: #281715;
            font-size: 14px;
            font-weight: 800;
        }

        .draft-pill {
            background: #d6e0f3;
            color: #404754;
            border-radius: 999px;
            padding: 5px 12px;
            font-size: 10px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.06em;
        }

        .question-area {
            min-width: 0;
        }

        .question-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 18px;
            margin-bottom: 16px;
            position: sticky;
            top: 64px;
            background: #fff8f7;
            z-index: 20;
            padding: 8px 0;
        }

        .question-title {
            font-size: 24px;
            font-weight: 800;
            color: #281715;
            margin: 0;
        }

        .question-count {
            color: #5c403c;
            font-weight: 500;
            font-size: 18px;
            margin-left: 4px;
        }

        .btn-add-question {
            background: #b70011 !important;
            border: 1px solid #b70011 !important;
            color: #ffffff !important;
            border-radius: 13px !important;
            padding: 12px 22px !important;
            font-size: 14px !important;
            font-weight: 800 !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            gap: 8px !important;
            box-shadow: 0 10px 22px rgba(183, 0, 17, 0.14);
        }

        .btn-add-question:hover {
            filter: brightness(1.06);
        }

        .questions-list {
            display: flex;
            flex-direction: column;
            gap: 18px;
            padding-bottom: 32px;
        }

        .question-card {
            background: #ffffff;
            border: 1px solid #e6bdb8;
            border-radius: 16px;
            padding: 28px;
            box-shadow: 0 8px 22px rgba(40, 23, 21, 0.04);
            position: relative;
            overflow: hidden;
        }

        .question-card::before {
            content: "";
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 6px;
            background: #b70011;
        }

        .question-top {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 18px;
            margin-bottom: 22px;
        }

        .question-meta {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .question-number {
            width: 42px;
            height: 42px;
            border-radius: 999px;
            background: #ffdad6;
            color: #410002;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            font-weight: 800;
            flex-shrink: 0;
        }

        .type-pill {
            display: inline-flex;
            width: fit-content;
            background: #fbdbd7;
            color: #5c403c;
            border: 1px solid #e6bdb8;
            border-radius: 999px;
            padding: 5px 11px;
            font-size: 10px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            margin-bottom: 5px;
        }

        .points-text {
            color: #596373;
            font-size: 12px;
            font-weight: 800;
        }

        .question-actions {
            display: flex;
            gap: 7px;
        }

        .question-action-btn {
            border: 0;
            background: transparent;
            color: #555f6f;
            border-radius: 9px;
            padding: 8px 10px;
            font-size: 13px;
            font-weight: 800;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: 0.2s ease;
        }

        .question-action-btn:hover {
            background: #fbdbd7;
            color: #b70011;
        }

        .question-action-btn.delete:hover {
            background: #ffdad6;
            color: #ba1a1a;
        }

        .question-text {
            font-size: 20px;
            line-height: 1.55;
            font-weight: 800;
            color: #281715;
            margin: 0 0 22px;
        }

        .option-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 14px;
        }

        .answer-option {
            border: 1px solid #e6bdb8;
            background: rgba(255, 248, 247, 0.55);
            border-radius: 13px;
            padding: 15px;
            display: flex;
            align-items: center;
            gap: 12px;
            color: #5c403c;
            font-size: 14px;
            font-weight: 600;
        }

        .answer-option.correct {
            border: 2px solid #b70011;
            background: #ffe9e6;
            color: #281715;
            font-weight: 800;
        }

        .answer-option.correct .material-symbols-outlined {
            color: #b70011;
            font-variation-settings: 'FILL' 1, 'wght' 500, 'GRAD' 0, 'opsz' 24;
        }

        .tf-options {
            display: flex;
            gap: 14px;
            flex-wrap: wrap;
        }

        .tf-options .answer-option {
            min-width: 160px;
        }

        .quiz-footer {
            margin-top: auto;
            background: #fff8f7;
            border-top: 1px solid #e6bdb8;
            padding: 16px 32px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 18px;
            color: #596373;
            font-size: 12px;
            font-weight: 600;
        }

        .footer-links {
            display: flex;
            gap: 24px;
        }

        .footer-links a {
            color: #596373;
            text-decoration: none;
        }

        .footer-links a:hover {
            color: #b70011;
        }

        .question-modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.60);
            z-index: 1000;
            display: none;
            align-items: center;
            justify-content: center;
            padding: 18px;
            backdrop-filter: blur(4px);
        }

        .question-modal-overlay.show {
            display: flex;
        }

        .question-modal {
            background: #ffffff;
            width: min(760px, 100%);
            max-height: 92vh;
            overflow-y: auto;
            border-radius: 20px;
            box-shadow: 0 24px 80px rgba(0,0,0,0.30);
        }

        .modal-head {
            background: #fff8f7;
            border-bottom: 1px solid #e6bdb8;
            padding: 24px 30px;
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 18px;
        }

        .modal-title {
            color: #281715;
            font-size: 24px;
            font-weight: 800;
            margin: 0 0 4px;
        }

        .modal-subtitle {
            color: #596373;
            font-size: 12px;
            margin: 0;
        }

        .modal-close {
            border: 0;
            background: transparent;
            color: #555f6f;
            width: 36px;
            height: 36px;
            border-radius: 999px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .modal-close:hover {
            background: #fbdbd7;
            color: #b70011;
        }

        .modal-body-custom {
            padding: 30px;
        }

        .modal-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 18px;
        }

        .modal-full {
            grid-column: 1 / -1;
        }

        .option-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .option-row {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .option-radio {
            width: 18px;
            height: 18px;
            accent-color: #b70011;
            flex-shrink: 0;
        }

        .modal-footer-custom {
            background: #fff8f7;
            border-top: 1px solid #e6bdb8;
            padding: 22px 30px;
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }

        .btn-discard,
        .btn-save-question {
            border-radius: 10px !important;
            padding: 10px 22px !important;
            font-weight: 800 !important;
            font-size: 13px !important;
        }

        .btn-discard {
            background: #ffffff !important;
            border: 1px solid #916f6b !important;
            color: #555f6f !important;
        }

        .btn-save-question {
            background: #b70011 !important;
            border: 1px solid #b70011 !important;
            color: #ffffff !important;
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 500, 'GRAD' 0, 'opsz' 24;
        }

        @media (max-width: 1120px) {
            .quiz-layout {
                grid-template-columns: 1fr;
            }

            .settings-card {
                position: static;
            }
        }

        @media (max-width: 860px) {
            .quiz-page {
                display: block;
            }

            .quiz-sidebar {
                width: 100%;
                min-height: auto;
                height: auto;
                position: relative;
            }

            .quiz-nav {
                flex-direction: row;
                overflow-x: auto;
            }

            .quiz-nav a {
                white-space: nowrap;
            }

            .quiz-topbar {
                padding: 0 16px;
            }

            .btn-preview {
                display: none !important;
            }

            .quiz-container {
                padding: 22px 16px;
            }

            .page-title {
                font-size: 36px;
            }

            .question-header {
                align-items: flex-start;
                flex-direction: column;
                position: static;
            }

            .option-grid {
                grid-template-columns: 1fr;
            }

            .quiz-footer {
                flex-direction: column;
                align-items: flex-start;
            }

            .modal-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <asp:HiddenField ID="hfQuizId" runat="server" />

    <div class="quiz-page">

        <!-- Sidebar -->
        <aside class="quiz-sidebar">
            <div class="brand">Aidify</div>

            <div class="instructor-card">
                <div class="instructor-avatar">M</div>
                <div>
                    <div class="instructor-name"><%: Aidify_assigment.AuthHelper.GetName() %></div>
                    <div class="instructor-role"><%: Aidify_assigment.AuthHelper.GetRole() %></div>
                    <div class="verified">Verified Educator</div>
                </div>
            </div>

            <nav class="quiz-nav">
                <a href="/Instructor/Dashboard.aspx">
                    <span class="material-symbols-outlined">dashboard</span>
                    Dashboard
                </a>

                <a href="/Instructor/Modules/Edit.aspx">
                    <span class="material-symbols-outlined">school</span>
                    My Modules
                </a>

                <a href="/Instructor/Materials/Upload.aspx">
                    <span class="material-symbols-outlined">description</span>
                    Materials
                </a>

                <a class="active" href="/Instructor/Quizzes/Edit.aspx">
                    <span class="material-symbols-outlined">quiz</span>
                    Quizzes
                </a>

                <a href="/Instructor/Quizzes/GenerateWithAI.aspx">
                    <span class="material-symbols-outlined">auto_awesome</span>
                    AI Generator
                </a>
            </nav>

            <div class="sidebar-footer">© 2024 Aidify</div>
        </aside>

        <!-- Main -->
        <main class="quiz-main">

            <!-- Top Bar -->
            <header class="quiz-topbar">
                <h1 class="portal-title">Instructor Portal</h1>

                <div class="topbar-actions">
                    <button type="button" class="btn btn-preview">
                        <span class="material-symbols-outlined" style="font-size:19px;">visibility</span>
                        Preview
                    </button>

                    <asp:Button ID="btnSaveQuiz" runat="server"
                        Text="Save Quiz"
                        CssClass="btn btn-save-top"
                        OnClick="btnSaveQuiz_Click"
                        ValidationGroup="QuizForm" />

                    <div style="width:1px;height:30px;background:#e6bdb8;"></div>

                    <span class="notification">
                        <span class="material-symbols-outlined" style="font-size:20px;">notifications</span>
                        <span class="notification-dot"></span>
                    </span>
                </div>
            </header>

            <div class="quiz-scroll">
                <div class="quiz-container">

                    <!-- Page Header -->
                    <div class="page-header">
                        <h2 class="page-title">Quiz Builder</h2>
                        <p class="page-subtitle">Create and manage high-stakes clinical assessments with precision.</p>
                        <asp:Label ID="lblQuizStatus" runat="server" CssClass="status-label"></asp:Label>
                    </div>

                    <div class="quiz-layout">

                        <!-- General Info -->
                        <section class="settings-card">
                            <h3 class="settings-title">
                                <span class="material-symbols-outlined">settings</span>
                                General Info
                            </h3>

                            <div class="field-group">
                                <asp:Label ID="lblQuizTitle" runat="server"
                                    AssociatedControlID="txtQuizTitle"
                                    CssClass="field-label">
                                    Quiz Title
                                </asp:Label>

                                <asp:TextBox ID="txtQuizTitle" runat="server"
                                    CssClass="quiz-input"
                                    placeholder="e.g. Trauma Response L1">
                                </asp:TextBox>

                                <asp:RequiredFieldValidator ID="rfvQuizTitle" runat="server"
                                    ControlToValidate="txtQuizTitle"
                                    CssClass="validator-custom"
                                    Display="Dynamic"
                                    ErrorMessage="Quiz title is required."
                                    ValidationGroup="QuizForm">
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="field-group">
                                <asp:Label ID="lblQuizDescription" runat="server"
                                    AssociatedControlID="txtQuizDescription"
                                    CssClass="field-label">
                                    Description
                                </asp:Label>

                                <asp:TextBox ID="txtQuizDescription" runat="server"
                                    CssClass="quiz-textarea"
                                    TextMode="MultiLine"
                                    Rows="4"
                                    placeholder="Description...">
                                </asp:TextBox>
                            </div>

                            <div class="settings-section">
                                <div class="settings-kicker">Assessment Parameters</div>

                                <div class="field-group">
                                    <asp:Label ID="lblLinkedModule" runat="server"
                                        AssociatedControlID="ddlLinkedModule"
                                        CssClass="field-label">
                                        Linked Module
                                    </asp:Label>

                                    <asp:DropDownList ID="ddlLinkedModule" runat="server"
                                        CssClass="quiz-select">
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="rfvLinkedModule" runat="server"
                                        ControlToValidate="ddlLinkedModule"
                                        CssClass="validator-custom"
                                        Display="Dynamic"
                                        ErrorMessage="Please select a module."
                                        InitialValue=""
                                        ValidationGroup="QuizForm">
                                    </asp:RequiredFieldValidator>
                                </div>

                                <div class="two-cols">
                                    <div class="field-group">
                                        <asp:Label ID="lblTimeLimit" runat="server"
                                            AssociatedControlID="txtTimeLimitSec"
                                            CssClass="field-label">
                                            Time (Sec)
                                        </asp:Label>

                                        <asp:TextBox ID="txtTimeLimitSec" runat="server"
                                            CssClass="quiz-input"
                                            TextMode="Number">
                                        </asp:TextBox>

                                        <asp:RegularExpressionValidator ID="revTimeLimitSec" runat="server"
                                            ControlToValidate="txtTimeLimitSec"
                                            CssClass="validator-custom"
                                            Display="Dynamic"
                                            ErrorMessage="Time limit must be a number."
                                            ValidationExpression="^\d+$"
                                            ValidationGroup="QuizForm"
                                            ValidateEmptyText="false">
                                        </asp:RegularExpressionValidator>
                                    </div>

                                    <div class="field-group">
                                        <asp:Label ID="lblPassingPct" runat="server"
                                            AssociatedControlID="txtPassingPct"
                                            CssClass="field-label">
                                            Passing %
                                        </asp:Label>

                                        <asp:TextBox ID="txtPassingPct" runat="server"
                                            CssClass="quiz-input"
                                            TextMode="Number">
                                        </asp:TextBox>

                                        <asp:RequiredFieldValidator ID="rfvPassingPct" runat="server"
                                            ControlToValidate="txtPassingPct"
                                            CssClass="validator-custom"
                                            Display="Dynamic"
                                            ErrorMessage="Passing percentage is required."
                                            ValidationGroup="QuizForm">
                                        </asp:RequiredFieldValidator>

                                        <asp:RegularExpressionValidator ID="revPassingPct" runat="server"
                                            ControlToValidate="txtPassingPct"
                                            CssClass="validator-custom"
                                            Display="Dynamic"
                                            ErrorMessage="Passing percentage must be a number."
                                            ValidationExpression="^\d+(\.\d+)?$"
                                            ValidationGroup="QuizForm">
                                        </asp:RegularExpressionValidator>
                                    </div>
                                </div>
                            </div>

                            <div class="reference-row">
                                <div>
                                    <div class="reference-label">Reference ID</div>
                                    <div class="reference-id">QUIZ-TRAUMA-001</div>
                                </div>
                                <span class="draft-pill">Draft</span>
                            </div>
                        </section>

                        <!-- Question Bank -->
                        <section class="question-area">
                            <div class="question-header">
                                <h3 class="question-title">
                                    Question Bank
                                    <span class="question-count">(4)</span>
                                </h3>

                                <asp:Button ID="btnAddQuestion" runat="server"
                                    Text="Add New Question"
                                    CssClass="btn btn-add-question"
                                    CausesValidation="false"
                                    OnClientClick="openQuestionModal(); return false;" />
                            </div>

                            <div class="questions-list">

                                <asp:Repeater ID="rptQuestions" runat="server">
                                    <ItemTemplate>
                                        <article class="question-card">
                                            <div class="question-top">
                                                <div class="question-meta">
                                                    <span class="question-number"><%# Container.ItemIndex + 1 %></span>

                                                    <div>
                                                        <span class="type-pill">Clinical Question</span>
                                                        <div class="points-text">Weight: <%# Eval("Points") %> Points</div>
                                                    </div>
                                                </div>

                                                <div class="question-actions">
                                                    <button type="button" class="question-action-btn">
                                                        <span class="material-symbols-outlined" style="font-size:19px;">edit</span>
                                                        Edit
                                                    </button>

                                                    <button type="button" class="question-action-btn delete">
                                                        <span class="material-symbols-outlined" style="font-size:19px;">delete</span>
                                                    </button>
                                                </div>
                                            </div>

                                            <p class="question-text"><%# Eval("QuestionText") %></p>

                                            <div class="option-grid">
                                                <div class="answer-option correct">
                                                    <span class="material-symbols-outlined">check_circle</span>
                                                    <span><%# Eval("Detail") %></span>
                                                </div>

                                                <div class="answer-option">
                                                    <span class="material-symbols-outlined">radio_button_unchecked</span>
                                                    <span>Alternative clinical response</span>
                                                </div>

                                                <div class="answer-option">
                                                    <span class="material-symbols-outlined">radio_button_unchecked</span>
                                                    <span>Requires instructor review</span>
                                                </div>

                                                <div class="answer-option">
                                                    <span class="material-symbols-outlined">radio_button_unchecked</span>
                                                    <span>Not selected</span>
                                                </div>
                                            </div>
                                        </article>
                                    </ItemTemplate>
                                </asp:Repeater>

                                <!-- Static Premium Example 1 -->
                                <article class="question-card">
                                    <div class="question-top">
                                        <div class="question-meta">
                                            <span class="question-number">1</span>
                                            <div>
                                                <span class="type-pill">Multiple Choice</span>
                                                <div class="points-text">Weight: 10 Points</div>
                                            </div>
                                        </div>

                                        <div class="question-actions">
                                            <button type="button" class="question-action-btn">
                                                <span class="material-symbols-outlined" style="font-size:19px;">edit</span>
                                                Edit
                                            </button>

                                            <button type="button" class="question-action-btn delete">
                                                <span class="material-symbols-outlined" style="font-size:19px;">delete</span>
                                            </button>
                                        </div>
                                    </div>

                                    <p class="question-text">
                                        What is the immediate priority for an unresponsive patient with arterial bleeding in the femoral region?
                                    </p>

                                    <div class="option-grid">
                                        <div class="answer-option correct">
                                            <span class="material-symbols-outlined">check_circle</span>
                                            <span>Apply a tourniquet proximal to the wound</span>
                                        </div>

                                        <div class="answer-option">
                                            <span class="material-symbols-outlined">radio_button_unchecked</span>
                                            <span>Administer high-flow oxygen</span>
                                        </div>

                                        <div class="answer-option">
                                            <span class="material-symbols-outlined">radio_button_unchecked</span>
                                            <span>Perform a jaw-thrust maneuver</span>
                                        </div>

                                        <div class="answer-option">
                                            <span class="material-symbols-outlined">radio_button_unchecked</span>
                                            <span>Initiate chest compressions</span>
                                        </div>
                                    </div>
                                </article>

                                <!-- Static Premium Example 2 -->
                                <article class="question-card">
                                    <div class="question-top">
                                        <div class="question-meta">
                                            <span class="question-number">2</span>
                                            <div>
                                                <span class="type-pill">True / False</span>
                                                <div class="points-text">Weight: 5 Points</div>
                                            </div>
                                        </div>

                                        <div class="question-actions">
                                            <button type="button" class="question-action-btn">
                                                <span class="material-symbols-outlined" style="font-size:19px;">edit</span>
                                                Edit
                                            </button>

                                            <button type="button" class="question-action-btn delete">
                                                <span class="material-symbols-outlined" style="font-size:19px;">delete</span>
                                            </button>
                                        </div>
                                    </div>

                                    <p class="question-text">
                                        In a multi-casualty incident, patients tagged with Red should be treated before those tagged with Yellow.
                                    </p>

                                    <div class="tf-options">
                                        <div class="answer-option correct">
                                            <span class="material-symbols-outlined">check_circle</span>
                                            <span>True</span>
                                        </div>

                                        <div class="answer-option">
                                            <span class="material-symbols-outlined">radio_button_unchecked</span>
                                            <span>False</span>
                                        </div>
                                    </div>
                                </article>

                            </div>
                        </section>

                    </div>
                </div>
            </div>

            <footer class="quiz-footer">
                <div>© 2024 Clinical Clarity Assessment Platform. All Rights Reserved.</div>

                <div class="footer-links">
                    <a href="#">Support</a>
                    <a href="#">Security</a>
                    <a href="#">Compliance</a>
                </div>
            </footer>
        </main>
    </div>

    <!-- Custom Add Question Modal -->
    <div class="question-modal-overlay" id="questionModal">
        <div class="question-modal">

            <div class="modal-head">
                <div>
                    <h4 class="modal-title">Add Clinical Question</h4>
                    <p class="modal-subtitle">Standardize the scenario and response criteria.</p>
                </div>

                <button type="button" class="modal-close" onclick="closeQuestionModal()">
                    <span class="material-symbols-outlined">close</span>
                </button>
            </div>

            <div class="modal-body-custom">
                <div class="modal-grid">

                    <div class="modal-full">
                        <asp:Label ID="lblQuestionText" runat="server"
                            AssociatedControlID="txtQuestionText"
                            CssClass="field-label">
                            Scenario / Question Stem
                        </asp:Label>

                        <asp:TextBox ID="txtQuestionText" runat="server"
                            CssClass="quiz-textarea"
                            TextMode="MultiLine"
                            Rows="3"
                            placeholder="Describe the clinical scenario...">
                        </asp:TextBox>
                    </div>

                    <div>
                        <asp:Label ID="lblQuestionType" runat="server"
                            AssociatedControlID="ddlQuestionType"
                            CssClass="field-label">
                            Question Type
                        </asp:Label>

                        <asp:DropDownList ID="ddlQuestionType" runat="server"
                            CssClass="quiz-select">
                            <asp:ListItem Value="MCQ">MCQ</asp:ListItem>
                            <asp:ListItem Value="True/False">True/False</asp:ListItem>
                            <asp:ListItem Value="Short Answer">Short Answer</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div>
                        <asp:Label ID="lblPoints" runat="server"
                            AssociatedControlID="txtPoints"
                            CssClass="field-label">
                            Points
                        </asp:Label>

                        <asp:TextBox ID="txtPoints" runat="server"
                            CssClass="quiz-input"
                            TextMode="Number">
                        </asp:TextBox>
                    </div>

                    <div class="modal-full">
                        <div class="settings-kicker">Response Options</div>

                        <div class="option-list">
                            <div class="option-row">
                                <input class="option-radio" checked="checked" name="correctOptionVisual" type="radio" />
                                <asp:TextBox ID="txtOption1" runat="server"
                                    CssClass="quiz-input"
                                    placeholder="Option 1">
                                </asp:TextBox>
                            </div>

                            <div class="option-row">
                                <input class="option-radio" name="correctOptionVisual" type="radio" />
                                <asp:TextBox ID="txtOption2" runat="server"
                                    CssClass="quiz-input"
                                    placeholder="Option 2">
                                </asp:TextBox>
                            </div>

                            <div class="option-row">
                                <input class="option-radio" name="correctOptionVisual" type="radio" />
                                <asp:TextBox ID="txtOption3" runat="server"
                                    CssClass="quiz-input"
                                    placeholder="Option 3">
                                </asp:TextBox>
                            </div>

                            <div class="option-row">
                                <input class="option-radio" name="correctOptionVisual" type="radio" />
                                <asp:TextBox ID="txtOption4" runat="server"
                                    CssClass="quiz-input"
                                    placeholder="Option 4">
                                </asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div class="modal-full">
                        <asp:Label ID="lblCorrectOption" runat="server"
                            AssociatedControlID="ddlCorrectOption"
                            CssClass="field-label">
                            Correct Option
                        </asp:Label>

                        <asp:DropDownList ID="ddlCorrectOption" runat="server"
                            CssClass="quiz-select">
                            <asp:ListItem Value="Option 1">Option 1</asp:ListItem>
                            <asp:ListItem Value="Option 2">Option 2</asp:ListItem>
                            <asp:ListItem Value="Option 3">Option 3</asp:ListItem>
                            <asp:ListItem Value="Option 4">Option 4</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                </div>
            </div>

            <div class="modal-footer-custom">
                <button type="button" class="btn btn-discard" onclick="closeQuestionModal()">Discard</button>

                <asp:Button ID="btnSaveQuestion" runat="server"
                    Text="Save Question"
                    CssClass="btn btn-save-question"
                    CausesValidation="false"
                    OnClick="btnSaveQuestion_Click" />
            </div>

        </div>
    </div>

    <script type="text/javascript">
        function openQuestionModal() {
            var modal = document.getElementById('questionModal');
            if (modal) {
                modal.classList.add('show');
                document.body.style.overflow = 'hidden';
            }
        }

        function closeQuestionModal() {
            var modal = document.getElementById('questionModal');
            if (modal) {
                modal.classList.remove('show');
                document.body.style.overflow = '';
            }
        }

        document.addEventListener('click', function (event) {
            var modal = document.getElementById('questionModal');
            if (modal && event.target === modal) {
                closeQuestionModal();
            }
        });

        document.addEventListener('keydown', function (event) {
            if (event.key === 'Escape') {
                closeQuestionModal();
            }
        });
    </script>

</asp:Content>