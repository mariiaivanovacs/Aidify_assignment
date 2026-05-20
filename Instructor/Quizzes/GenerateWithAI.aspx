<%@ Page Title="Generate Quiz with AI" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GenerateWithAI.aspx.cs" Inherits="Aidify_assigment.Instructor.Quizzes.GenerateWithAI" %>

<asp:Content ID="GenerateWithAIContent" ContentPlaceHolderID="MainContent" runat="server">

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

        .ai-page {
            min-height: 100vh;
            background: #fff8f7;
            color: #281715;
            display: flex;
        }

        .ai-sidebar {
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

        .ai-nav {
            display: flex;
            flex-direction: column;
            gap: 7px;
            flex: 1;
        }

        .ai-nav a {
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

        .ai-nav a:hover {
            background: #fbdbd7;
            color: #281715;
        }

        .ai-nav a.active {
            background: #b70011;
            color: #ffffff;
            box-shadow: 0 8px 18px rgba(183, 0, 17, 0.16);
        }

        .ai-nav .material-symbols-outlined {
            font-size: 20px;
        }

        .instructor-mini {
            border-top: 1px solid #e6bdb8;
            padding: 18px 16px 4px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .avatar {
            width: 42px;
            height: 42px;
            border-radius: 999px;
            background: #ffdad6;
            color: #b70011;
            border: 2px solid #b70011;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
        }

        .mini-name {
            font-size: 13px;
            font-weight: 800;
            color: #281715;
        }

        .mini-role {
            font-size: 11px;
            color: #596373;
        }

        .ai-main {
            flex: 1;
            min-width: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background: #fff8f7;
        }

        .ai-topbar {
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

        .ai-active-pill {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            background: #ffe2de;
            color: #b70011;
            border: 1px solid #e6bdb8;
            border-radius: 999px;
            padding: 6px 12px;
            font-size: 10px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.08em;
        }

        .topbar-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .topbar-icon {
            color: #5c403c;
            width: 34px;
            height: 34px;
            border-radius: 999px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .topbar-icon:hover {
            background: #fbdbd7;
            color: #b70011;
        }

        .ai-content {
            flex: 1;
            padding: 32px;
            overflow-y: auto;
        }

        .ai-container {
            max-width: 1180px;
            margin: 0 auto;
        }

        .hero {
            text-align: center;
            margin-bottom: 44px;
        }

        .hero-title {
            font-size: 48px;
            line-height: 1.1;
            letter-spacing: -0.04em;
            font-weight: 800;
            color: #281715;
            margin: 0 0 10px;
        }

        .hero-subtitle {
            color: #596373;
            font-size: 16px;
            line-height: 1.6;
            max-width: 720px;
            margin: 0 auto;
        }

        .stepper {
            max-width: 760px;
            margin: 0 auto 44px;
            position: relative;
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
        }

        .stepper::before {
            content: "";
            position: absolute;
            top: 20px;
            left: 8%;
            right: 8%;
            height: 2px;
            background: #e6bdb8;
            z-index: 0;
        }

        .step-item {
            position: relative;
            z-index: 1;
            background: #fff8f7;
            padding: 0 14px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 8px;
        }

        .step-number {
            width: 42px;
            height: 42px;
            border-radius: 999px;
            background: #fbdbd7;
            color: #5c403c;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            border: 4px solid #fff8f7;
            box-shadow: 0 0 0 1px #e6bdb8;
        }

        .step-item.active .step-number {
            background: #b70011;
            color: #ffffff;
            box-shadow: 0 10px 22px rgba(183, 0, 17, 0.22);
        }

        .step-label {
            color: #5c403c;
            font-size: 13px;
            font-weight: 800;
        }

        .wizard-card {
            background: #ffffff;
            border: 1px solid #e6bdb8;
            border-radius: 22px;
            overflow: hidden;
            box-shadow: 0 18px 44px rgba(40, 23, 21, 0.08);
        }

        .wizard-grid {
            display: grid;
            grid-template-columns: minmax(0, 8fr) minmax(280px, 4fr);
        }

        .wizard-left {
            padding: 34px;
            border-right: 1px solid #e6bdb8;
        }

        .wizard-right {
            background: #fff0ee;
            padding: 28px;
        }

        .field-group {
            margin-bottom: 24px;
        }

        .field-label {
            display: block;
            color: #281715;
            font-size: 13px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            margin-bottom: 10px;
        }

        .upload-zone {
            border: 2px dashed #e6bdb8;
            border-radius: 16px;
            background: #fff8f7;
            padding: 34px;
            text-align: center;
            position: relative;
            transition: 0.2s ease;
        }

        .upload-zone:hover {
            border-color: #b70011;
            background: #fff0ee;
        }

        .file-cover {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
            z-index: 5;
        }

        .upload-icon {
            width: 66px;
            height: 66px;
            border-radius: 999px;
            background: rgba(183, 0, 17, 0.06);
            color: #b70011;
            margin: 0 auto 15px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .upload-title {
            font-size: 18px;
            font-weight: 800;
            margin-bottom: 4px;
            color: #281715;
        }

        .upload-help {
            color: #596373;
            font-size: 12px;
            margin: 0;
        }

        .file-ready {
            display: none;
            color: #b70011;
            font-size: 12px;
            font-weight: 800;
            margin-top: 12px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .ai-input,
        .ai-select {
            width: 100%;
            background: #fff8f7 !important;
            border: 1px solid #916f6b !important;
            border-radius: 11px !important;
            color: #281715 !important;
            padding: 13px 14px !important;
            font-size: 14px !important;
            font-weight: 700;
            box-shadow: none !important;
            outline: none !important;
        }

        .ai-input:focus,
        .ai-select:focus {
            border-color: #b70011 !important;
            box-shadow: 0 0 0 4px rgba(183, 0, 17, 0.10) !important;
        }

        .btn-generate {
            width: 100%;
            background: #b70011 !important;
            border: 1px solid #b70011 !important;
            color: #ffffff !important;
            border-radius: 15px !important;
            padding: 17px 22px !important;
            font-size: 16px !important;
            font-weight: 800 !important;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            box-shadow: 0 14px 28px rgba(183, 0, 17, 0.20);
        }

        .tips-title {
            display: flex;
            align-items: center;
            gap: 9px;
            color: #281715;
            font-size: 18px;
            font-weight: 800;
            margin-bottom: 18px;
        }

        .tip-box {
            background: #ffffff;
            border: 1px solid #e6bdb8;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 18px;
        }

        .tip-kicker {
            color: #b70011;
            font-size: 10px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            margin-bottom: 4px;
        }

        .tip-text {
            color: #596373;
            font-size: 13px;
            line-height: 1.55;
            margin: 0;
        }

        .recent-file {
            display: flex;
            align-items: center;
            gap: 10px;
            background: #ffffff;
            border: 1px solid #e6bdb8;
            border-radius: 10px;
            padding: 11px;
            font-size: 12px;
            font-weight: 700;
            color: #281715;
            margin-bottom: 9px;
        }

        .generating-card,
        .done-card {
            background: #ffffff;
            border: 1px solid #e6bdb8;
            border-radius: 22px;
            box-shadow: 0 18px 44px rgba(40, 23, 21, 0.08);
            padding: 70px 24px;
            text-align: center;
        }

        .spinner-shell {
            width: 190px;
            height: 190px;
            border-radius: 999px;
            margin: 0 auto 28px;
            position: relative;
            background: #fff0ee;
            border: 7px solid #ffe2de;
        }

        .spinner-shell::before {
            content: "";
            position: absolute;
            inset: -7px;
            border-radius: 999px;
            border: 7px solid #b70011;
            border-top-color: transparent;
            animation: spin 1s linear infinite;
        }

        .spinner-inner {
            position: absolute;
            inset: 34px;
            border-radius: 18px;
            background: #fff8f7;
            border: 1px solid #e6bdb8;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #b70011;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        .generating-title,
        .done-title {
            font-size: 34px;
            font-weight: 800;
            letter-spacing: -0.03em;
            color: #281715;
            margin-bottom: 10px;
        }

        .generating-text {
            color: #596373;
            font-size: 15px;
            line-height: 1.6;
            max-width: 560px;
            margin: 0 auto 24px;
        }

        .log-box {
            max-width: 380px;
            margin: 26px auto 0;
            background: rgba(40, 23, 21, 0.04);
            border: 1px solid #e6bdb8;
            border-radius: 12px;
            padding: 13px;
            text-align: left;
            font-size: 11px;
            font-family: Consolas, monospace;
        }

        .review-head {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 22px;
        }

        .review-badge {
            display: inline-flex;
            background: rgba(183, 0, 17, 0.08);
            color: #b70011;
            border-radius: 6px;
            padding: 4px 8px;
            font-size: 10px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            margin-bottom: 6px;
        }

        .review-title {
            color: #281715;
            font-size: 32px;
            font-weight: 800;
            margin: 0 0 5px;
        }

        .review-subtitle {
            color: #596373;
            margin: 0;
            font-size: 14px;
        }

        .review-actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .btn-soft,
        .btn-primary-ai {
            border-radius: 12px !important;
            padding: 12px 22px !important;
            font-weight: 800 !important;
            font-size: 13px !important;
        }

        .btn-soft {
            background: #ffe9e6 !important;
            color: #b70011 !important;
            border: 1px solid #e6bdb8 !important;
        }

        .btn-primary-ai {
            background: #b70011 !important;
            color: #ffffff !important;
            border: 1px solid #b70011 !important;
        }

        .generated-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 22px;
        }

        .question-card {
            background: #ffffff;
            border: 1px solid #e6bdb8;
            border-radius: 18px;
            padding: 22px;
            box-shadow: 0 8px 22px rgba(40, 23, 21, 0.04);
        }

        .q-top {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 18px;
        }

        .q-meta {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .q-number {
            background: #b70011;
            color: #ffffff;
            border-radius: 999px;
            padding: 5px 10px;
            font-size: 12px;
            font-weight: 800;
        }

        .q-type {
            color: #b70011;
            font-size: 10px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.12em;
        }

        .q-module {
            color: #596373;
            font-size: 11px;
            font-weight: 700;
        }

        .q-tools {
            display: flex;
            gap: 4px;
            background: #fff0ee;
            border: 1px solid #e6bdb8;
            border-radius: 9px;
            padding: 4px;
        }

        .tool-btn {
            border: 0;
            background: transparent;
            color: #5c403c;
            border-radius: 7px;
            width: 30px;
            height: 30px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .tool-btn.keep {
            color: #15803d;
        }

        .tool-btn.delete {
            color: #dc2626;
        }

        .generated-question-input {
            width: 100%;
            border: 0 !important;
            background: transparent !important;
            color: #281715 !important;
            font-size: 17px !important;
            font-weight: 800 !important;
            line-height: 1.45 !important;
            min-height: 110px;
            resize: vertical;
            box-shadow: none !important;
            outline: none !important;
            margin-bottom: 18px;
        }

        .option-preview {
            border: 1px solid #e6bdb8;
            border-radius: 12px;
            padding: 12px;
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 9px;
            color: #5c403c;
            font-size: 13px;
            font-weight: 600;
        }

        .option-preview.correct {
            border: 2px solid #b70011;
            background: rgba(183, 0, 17, 0.05);
            color: #281715;
            font-weight: 800;
        }

        .letter {
            width: 28px;
            height: 28px;
            border-radius: 999px;
            background: #e6bdb8;
            color: #5c403c;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 800;
            flex-shrink: 0;
        }

        .option-preview.correct .letter {
            background: #b70011;
            color: #ffffff;
        }

        .done-card {
            max-width: 620px;
            margin: 0 auto;
            padding: 50px;
        }

        .done-icon {
            width: 82px;
            height: 82px;
            border-radius: 999px;
            background: #dcfce7;
            color: #15803d;
            margin: 0 auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .done-links {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 14px;
            margin-top: 24px;
        }

        .done-links a {
            color: #b70011;
            font-weight: 800;
            text-decoration: none;
            background: #fff0ee;
            border: 1px solid #e6bdb8;
            border-radius: 999px;
            padding: 9px 15px;
        }

        .ai-footer {
            border-top: 1px solid #e6bdb8;
            padding: 16px 32px;
            color: #596373;
            font-size: 12px;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 18px;
        }

        .footer-links {
            display: flex;
            gap: 22px;
        }

        .footer-links a {
            color: #596373;
            text-decoration: none;
        }

        .footer-links a:hover {
            color: #b70011;
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 500, 'GRAD' 0, 'opsz' 24;
        }

        @media (max-width: 1100px) {
            .wizard-grid {
                grid-template-columns: 1fr;
            }

            .wizard-left {
                border-right: 0;
                border-bottom: 1px solid #e6bdb8;
            }

            .generated-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 860px) {
            .ai-page {
                display: block;
            }

            .ai-sidebar {
                width: 100%;
                min-height: auto;
                height: auto;
                position: relative;
            }

            .ai-nav {
                flex-direction: row;
                overflow-x: auto;
            }

            .ai-nav a {
                white-space: nowrap;
            }

            .ai-topbar {
                padding: 0 16px;
            }

            .ai-active-pill {
                display: none;
            }

            .ai-content {
                padding: 22px 16px;
            }

            .hero-title {
                font-size: 36px;
            }

            .stepper {
                overflow-x: auto;
                gap: 16px;
            }

            .stepper::before {
                display: none;
            }

            .review-head {
                align-items: flex-start;
                flex-direction: column;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .ai-footer {
                align-items: flex-start;
                flex-direction: column;
            }
        }
    </style>

    <div class="ai-page">

        <aside class="ai-sidebar">
            <div class="brand">Aidify</div>

            <nav class="ai-nav">
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

                <a href="/Instructor/Quizzes/Edit.aspx">
                    <span class="material-symbols-outlined">quiz</span>
                    Quizzes
                </a>

                <a class="active" href="/Instructor/Quizzes/GenerateWithAI.aspx">
                    <span class="material-symbols-outlined">auto_awesome</span>
                    AI Generator
                </a>
            </nav>

            <div class="instructor-mini">
                <div class="avatar">M</div>
                <div>
                    <div class="mini-name"><%: Aidify_assigment.AuthHelper.GetName() %></div>
                    <div class="mini-role"><%: Aidify_assigment.AuthHelper.GetRole() %></div>
                </div>
            </div>
        </aside>

        <main class="ai-main">

            <header class="ai-topbar">
                <h1 class="portal-title">Instructor Portal</h1>

                <div class="topbar-actions">
                    <div class="ai-active-pill">
                        <span class="material-symbols-outlined" style="font-size:15px;font-variation-settings:'FILL' 1;">auto_awesome</span>
                        Aidify Intelligence Active
                    </div>

                    <span class="topbar-icon">
                        <span class="material-symbols-outlined" style="font-size:20px;">notifications</span>
                    </span>

                    <span class="topbar-icon">
                        <span class="material-symbols-outlined" style="font-size:20px;">search</span>
                    </span>
                </div>
            </header>

            <div class="ai-content">
                <div class="ai-container">

                    <section class="hero">
                        <h2 class="hero-title">AI Quiz Generator</h2>
                        <p class="hero-subtitle">
                            Transform medical manuals, lecture notes, and research papers into interactive clinical assessments in seconds.
                        </p>
                    </section>

                    <div class="stepper">
                        <div class="step-item active">
                            <div class="step-number">1</div>
                            <div class="step-label">Configure</div>
                        </div>

                        <div class="step-item">
                            <div class="step-number">2</div>
                            <div class="step-label">Generate</div>
                        </div>

                        <div class="step-item">
                            <div class="step-number">3</div>
                            <div class="step-label">Review</div>
                        </div>

                        <div class="step-item">
                            <div class="step-number">4</div>
                            <div class="step-label">Success</div>
                        </div>
                    </div>

                    <asp:MultiView ID="mvWizard" runat="server" ActiveViewIndex="0">

                        <asp:View ID="vwUpload" runat="server">
                            <div class="wizard-card">
                                <div class="wizard-grid">

                                    <div class="wizard-left">

                                        <div class="field-group">
                                            <asp:Label ID="lblKnowledge" runat="server"
                                                AssociatedControlID="fuKnowledge"
                                                CssClass="field-label">
                                                Knowledge Base Source
                                            </asp:Label>

                                            <div class="upload-zone">
                                                <asp:FileUpload ID="fuKnowledge" runat="server"
                                                    CssClass="file-cover"
                                                    onchange="showAIFileName(this)" />

                                                <div class="upload-icon">
                                                    <span class="material-symbols-outlined" style="font-size:38px;">upload_file</span>
                                                </div>

                                                <div class="upload-title">Click to upload or drag & drop</div>
                                                <p class="upload-help">Supported formats: .pdf, .docx, .txt, .md (Max 25MB)</p>

                                                <div id="aiFileReady" class="file-ready">File ready for generation</div>
                                            </div>
                                        </div>

                                        <div class="form-grid">
                                            <div class="field-group">
                                                <asp:Label ID="lblNumQuestions" runat="server"
                                                    AssociatedControlID="txtNumQuestions"
                                                    CssClass="field-label">
                                                    Questions Count
                                                </asp:Label>

                                                <asp:TextBox ID="txtNumQuestions" runat="server"
                                                    CssClass="ai-input"
                                                    TextMode="Number">
                                                </asp:TextBox>
                                            </div>

                                            <div class="field-group">
                                                <asp:Label ID="lblAIDifficulty" runat="server"
                                                    AssociatedControlID="ddlAIDifficulty"
                                                    CssClass="field-label">
                                                    Assessment Rigor
                                                </asp:Label>

                                                <asp:DropDownList ID="ddlAIDifficulty" runat="server"
                                                    CssClass="ai-select">
                                                    <asp:ListItem Value="Beginner">Standard Academic</asp:ListItem>
                                                    <asp:ListItem Value="Intermediate">Clinical Residency</asp:ListItem>
                                                    <asp:ListItem Value="Advanced">Board Exam Level</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="field-group">
                                            <asp:Label ID="lblTargetQuiz" runat="server"
                                                AssociatedControlID="ddlTargetQuiz"
                                                CssClass="field-label">
                                                Module Assignment / Target Quiz
                                            </asp:Label>

                                            <asp:DropDownList ID="ddlTargetQuiz" runat="server"
                                                CssClass="ai-select">
                                            </asp:DropDownList>
                                        </div>

                                        <asp:Button ID="btnGenerateAI" runat="server"
                                            Text="Initiate AI Generation"
                                            CssClass="btn btn-generate"
                                            OnClick="btnGenerateAI_Click" />
                                    </div>

                                    <aside class="wizard-right">
                                        <div class="tips-title">
                                            <span class="material-symbols-outlined" style="color:#b70011;">info</span>
                                            Pro Tips
                                        </div>

                                        <div class="tip-box">
                                            <div class="tip-kicker">Clinical Context</div>
                                            <p class="tip-text">
                                                Our AI specializes in creating high-fidelity clinical scenarios based on your specific protocols.
                                            </p>
                                        </div>

                                        <div class="tip-box">
                                            <div class="tip-kicker">AI Summary</div>
                                            <p class="tip-text">
                                                Knowledge file analysis + question drafting. Provide concise source material for clearer questions.
                                            </p>
                                        </div>

                                        <div>
                                            <div class="tip-kicker" style="margin-bottom:10px;">Recent Materials</div>

                                            <div class="recent-file">
                                                <span class="material-symbols-outlined" style="font-size:17px;color:#b70011;">description</span>
                                                ICU_Sedation_v2.pdf
                                                <span class="material-symbols-outlined ms-auto" style="font-size:17px;">add</span>
                                            </div>

                                            <div class="recent-file">
                                                <span class="material-symbols-outlined" style="font-size:17px;color:#b70011;">description</span>
                                                Pediatric_Triage.md
                                                <span class="material-symbols-outlined ms-auto" style="font-size:17px;">add</span>
                                            </div>
                                        </div>
                                    </aside>

                                </div>
                            </div>
                        </asp:View>

                        <asp:View ID="vwGenerating" runat="server">
                            <div class="generating-card">
                                <div class="spinner-shell">
                                    <div class="spinner-inner">
                                        <span class="material-symbols-outlined" style="font-size:70px;">clinical_notes</span>
                                    </div>
                                </div>

                                <asp:Label ID="lblGenerating" runat="server"
                                    CssClass="generating-title d-block">
                                    Synthesizing Protocol Assessments...
                                </asp:Label>

                                <p class="generating-text">
                                    The AI is cross-referencing clinical protocols and extracting distractors to ensure high validity.
                                    Estimated time: <strong style="color:#b70011;">8s</strong>
                                </p>

                                <div class="log-box">
                                    <div style="color:#15803d;">● PDF Metadata Parsed</div>
                                    <div style="color:#15803d;">● Knowledge Graph Initialized</div>
                                    <div style="color:#b70011;">● Generating Distractors...</div>
                                </div>
                            </div>
                        </asp:View>

                        <asp:View ID="vwPreview" runat="server">

                            <div class="review-head">
                                <div>
                                    <div class="review-badge">Drafting Complete</div>
                                    <h2 class="review-title">Review AI Drafts</h2>
                                    <p class="review-subtitle">
                                        Refine clinical scenarios and confirm distractors before publishing.
                                    </p>
                                </div>

                                <div class="review-actions">
                                    <asp:Button ID="btnDiscardAll" runat="server"
                                        Text="Regenerate / Discard All"
                                        CssClass="btn btn-soft"
                                        CausesValidation="false"
                                        OnClick="btnDiscardAll_Click" />

                                    <asp:Button ID="btnSaveKeptQuestions" runat="server"
                                        Text="Finalize Module"
                                        CssClass="btn btn-primary-ai"
                                        OnClick="btnSaveKeptQuestions_Click" />
                                </div>
                            </div>

                            <div class="generated-grid">
                                <asp:Repeater ID="rptGeneratedQuestions" runat="server">
                                    <ItemTemplate>
                                        <article class="question-card">
                                            <div class="q-top">
                                                <div class="q-meta">
                                                    <span class="q-number"><%# (Container.ItemIndex + 1).ToString("00") %></span>
                                                    <div>
                                                        <div class="q-type">Clinical Scenario</div>
                                                        <div class="q-module">Trauma Protocol I</div>
                                                    </div>
                                                </div>

                                                <div class="q-tools">
                                                    <button type="button" class="tool-btn keep">
                                                        <span class="material-symbols-outlined" style="font-size:18px;font-variation-settings:'FILL' 1;">check_circle</span>
                                                    </button>

                                                    <button type="button" class="tool-btn">
                                                        <span class="material-symbols-outlined" style="font-size:18px;">edit</span>
                                                    </button>

                                                    <button type="button" class="tool-btn delete">
                                                        <span class="material-symbols-outlined" style="font-size:18px;">delete</span>
                                                    </button>
                                                </div>
                                            </div>

                                            <asp:TextBox ID="txtGeneratedQuestion" runat="server"
                                                CssClass="generated-question-input"
                                                TextMode="MultiLine"
                                                Text='<%# Eval("QuestionText") %>'>
                                            </asp:TextBox>

                                            <div class="option-preview correct">
                                                <span class="letter">A</span>
                                                <span>Perform the priority clinical intervention according to protocol.</span>
                                            </div>

                                            <div class="option-preview">
                                                <span class="letter">B</span>
                                                <span>Administer supportive care first.</span>
                                            </div>

                                            <div class="option-preview">
                                                <span class="letter">C</span>
                                                <span>Delay intervention pending reassessment.</span>
                                            </div>
                                        </article>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </asp:View>

                        <asp:View ID="vwDone" runat="server">
                            <div class="done-card">
                                <div class="done-icon">
                                    <span class="material-symbols-outlined" style="font-size:44px;font-variation-settings:'FILL' 1;">check_circle</span>
                                </div>

                                <h2 class="done-title">Questions Saved</h2>

                                <asp:Label ID="lblSaveSuccess" runat="server"
                                    CssClass="d-block"
                                    Style="color:#15803d;font-weight:800;">
                                    Questions saved successfully.
                                </asp:Label>

                                <div class="done-links">
                                    <asp:HyperLink ID="lnkEditQuiz" runat="server">Edit Quiz</asp:HyperLink>
                                    <asp:HyperLink ID="lnkGenerateMore" runat="server">Generate More</asp:HyperLink>

                                    <asp:HyperLink ID="lnkDashboard" runat="server">
                                        Back to Dashboard
                                    </asp:HyperLink>

                                    <asp:HyperLink ID="lnkDashboardFooter" runat="server" Style="display:none;">
                                        Back to Dashboard
                                    </asp:HyperLink>
                                </div>
                            </div>
                        </asp:View>

                    </asp:MultiView>

                </div>
            </div>

            <footer class="ai-footer">
                <div>© 2024 Aidify Medical Education Platform. All Rights Reserved.</div>

                <div class="footer-links">
                    <a href="#">Support</a>
                    <a href="#">Privacy Policy</a>
                    <a href="#">Terms</a>
                </div>
            </footer>

        </main>
    </div>

    <script type="text/javascript">
        function showAIFileName(input) {
            var label = document.getElementById('aiFileReady');

            if (!label) {
                return;
            }

            if (input.files && input.files.length > 0) {
                label.style.display = 'block';
                label.innerText = input.files[0].name + ' is ready for generation';
            } else {
                label.style.display = 'none';
                label.innerText = 'File ready for generation';
            }
        }
    </script>

</asp:Content>