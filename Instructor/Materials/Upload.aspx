<%@ Page Title="Upload Learning Material" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="Aidify_assigment.Instructor.Materials.Upload" %>

<asp:Content ID="MaterialsUploadContent" ContentPlaceHolderID="MainContent" runat="server">

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

        .materials-page {
            min-height: 100vh;
            background: #fff8f7;
            color: #281715;
        }

        .materials-topbar {
            height: 64px;
            background: #fff8f7;
            border-bottom: 1px solid #e6bdb8;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 28px;
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .topbar-left {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .menu-btn {
            border: 0;
            background: transparent;
            color: #b70011;
            width: 34px;
            height: 34px;
            border-radius: 999px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .menu-btn:hover {
            background: #fbdbd7;
        }

        .portal-title {
            font-size: 18px;
            font-weight: 800;
            color: #b70011;
            margin: 0;
        }

        .topbar-right {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .topbar-icon {
            color: #5c403c;
            width: 32px;
            height: 32px;
            border-radius: 999px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .topbar-icon:hover {
            background: #fbdbd7;
            color: #b70011;
        }

        .avatar {
            width: 32px;
            height: 32px;
            border-radius: 999px;
            background: #ffdad6;
            border: 2px solid #e6bdb8;
            color: #b70011;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 12px;
        }

        .materials-layout {
            display: flex;
            min-height: calc(100vh - 64px);
        }

        .materials-sidebar {
            width: 280px;
            background: #fff0ee;
            border-right: 1px solid #e6bdb8;
            padding: 26px 14px;
            flex-shrink: 0;
            position: sticky;
            top: 64px;
            height: calc(100vh - 64px);
            overflow-y: auto;
        }

        .instructor-block {
            padding: 0 16px 26px;
        }

        .instructor-name {
            font-size: 22px;
            line-height: 1.15;
            font-weight: 800;
            color: #b70011;
            margin-bottom: 4px;
        }

        .instructor-role {
            color: #5c403c;
            font-size: 13px;
            margin-bottom: 6px;
        }

        .verified-text {
            color: #916f6b;
            font-size: 11px;
            font-weight: 700;
        }

        .materials-nav {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .materials-nav a {
            display: flex;
            align-items: center;
            gap: 13px;
            padding: 13px 15px;
            border-radius: 11px;
            color: #5c403c;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: 0.2s ease;
        }

        .materials-nav a:hover {
            background: #fbdbd7;
            color: #281715;
        }

        .materials-nav a.active {
            background: #b70011;
            color: #ffffff;
            box-shadow: 0 8px 18px rgba(183, 0, 17, 0.14);
        }

        .materials-nav .material-symbols-outlined {
            font-size: 19px;
        }

        .materials-main {
            flex: 1;
            min-width: 0;
            background: #fff8f7;
            padding: 32px;
            display: flex;
            flex-direction: column;
        }

        .materials-container {
            max-width: 1280px;
            width: 100%;
            margin: 0 auto;
            flex: 1;
        }

        .page-heading {
            margin-bottom: 24px;
        }

        .page-title {
            font-size: 32px;
            line-height: 1.15;
            font-weight: 800;
            letter-spacing: -0.03em;
            color: #281715;
            margin: 0 0 6px;
        }

        .page-subtitle {
            color: #596373;
            font-size: 15px;
            margin: 0;
        }

        .status-label {
            color: #596373;
            font-size: 13px;
            margin-top: 6px;
            display: block;
        }

        .upload-grid {
            display: grid;
            grid-template-columns: minmax(320px, 5fr) minmax(420px, 7fr);
            gap: 24px;
            align-items: start;
        }

        .left-stack {
            display: flex;
            flex-direction: column;
            gap: 22px;
        }

        .panel {
            background: #ffffff;
            border: 1px solid #e6bdb8;
            border-radius: 16px;
            box-shadow: 0 8px 22px rgba(40, 23, 21, 0.04);
            overflow: hidden;
        }

        .details-panel {
            padding: 24px;
        }

        .panel-title {
            font-size: 22px;
            font-weight: 800;
            color: #281715;
            margin: 0 0 18px;
        }

        .field-group {
            margin-bottom: 17px;
        }

        .field-group:last-child {
            margin-bottom: 0;
        }

        .field-label {
            display: block;
            color: #5c403c;
            font-size: 12px;
            font-weight: 800;
            letter-spacing: 0.02em;
            margin-bottom: 7px;
        }

        .required-star {
            color: #ba1a1a;
        }

        .material-select,
        .material-input {
            width: 100%;
            background: #fff8f7 !important;
            border: 1px solid #916f6b !important;
            border-radius: 9px !important;
            color: #281715 !important;
            padding: 12px 14px !important;
            font-size: 14px !important;
            box-shadow: none !important;
            outline: none !important;
        }

        .material-select:focus,
        .material-input:focus {
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

        .upload-drop {
            background: #ffffff;
            border: 2px dashed #e6bdb8;
            border-radius: 16px;
            min-height: 300px;
            padding: 36px 28px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            position: relative;
            transition: 0.2s ease;
        }

        .upload-drop:hover {
            border-color: #b70011;
            background: #fff8f7;
        }

        .file-input-cover {
            position: absolute;
            inset: 0;
            opacity: 0;
            cursor: pointer;
            z-index: 5;
            width: 100%;
            height: 100%;
        }

        .upload-icon-circle {
            width: 64px;
            height: 64px;
            border-radius: 999px;
            background: #ffe9e6;
            color: #b70011;
            margin: 0 auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: 0.2s ease;
        }

        .upload-drop:hover .upload-icon-circle {
            background: #ffdad6;
            transform: translateY(-2px);
        }

        .upload-title {
            font-size: 23px;
            font-weight: 800;
            color: #281715;
            margin: 0 0 8px;
        }

        .upload-help {
            color: #596373;
            font-size: 14px;
            line-height: 1.5;
            margin: 0 0 14px;
        }

        .upload-button-wrap {
            position: relative;
            z-index: 10;
            margin-top: 20px;
        }

        .btn-upload-custom {
            background: #b70011 !important;
            border-color: #b70011 !important;
            color: #ffffff !important;
            border-radius: 9px !important;
            padding: 13px 34px !important;
            font-size: 13px !important;
            font-weight: 800 !important;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            box-shadow: 0 10px 22px rgba(183, 0, 17, 0.16);
        }

        .btn-upload-custom:hover {
            filter: brightness(1.06);
        }

        .recent-panel {
            min-height: 100%;
        }

        .recent-header {
            background: #fff0ee;
            border-bottom: 1px solid #e6bdb8;
            padding: 20px 22px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
        }

        .recent-title {
            font-size: 22px;
            font-weight: 800;
            color: #281715;
            margin: 0;
        }

        .items-pill {
            background: #d6e0f3;
            color: #404754;
            border-radius: 999px;
            padding: 5px 11px;
            font-size: 11px;
            font-weight: 800;
            white-space: nowrap;
        }

        .recent-list {
            display: flex;
            flex-direction: column;
        }

        .material-item {
            padding: 21px 22px;
            border-bottom: 1px solid #e6bdb8;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 18px;
            transition: 0.2s ease;
        }

        .material-item:hover {
            background: #fff8f7;
        }

        .material-left {
            display: flex;
            align-items: flex-start;
            gap: 15px;
            min-width: 0;
        }

        .file-icon {
            width: 44px;
            height: 44px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .file-icon.pdf {
            background: #fee2e2;
            color: #b70011;
        }

        .file-icon.video {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .file-icon.image {
            background: #ffedd5;
            color: #c2410c;
        }

        .file-name {
            font-size: 16px;
            font-weight: 800;
            color: #281715;
            margin-bottom: 5px;
            word-break: break-word;
        }

        .file-meta {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
        }

        .file-type {
            color: white;
            border-radius: 4px;
            padding: 2px 6px;
            font-size: 9px;
            font-weight: 800;
            text-transform: uppercase;
        }

        .file-type.pdf {
            background: #b70011;
        }

        .file-type.video {
            background: #1d4ed8;
        }

        .file-type.image {
            background: #c2410c;
        }

        .file-detail {
            color: #596373;
            font-size: 12px;
            font-weight: 600;
        }

        .material-actions {
            display: flex;
            align-items: center;
            gap: 6px;
            flex-shrink: 0;
        }

        .icon-btn {
            border: 0;
            background: transparent;
            color: #5c403c;
            width: 34px;
            height: 34px;
            border-radius: 9px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: 0.2s ease;
        }

        .icon-btn:hover {
            background: #ffe9e6;
            color: #b70011;
        }

        .recent-footer {
            background: #fff0ee;
            border-top: 1px solid #e6bdb8;
            padding: 18px 22px;
            text-align: center;
        }

        .load-more {
            color: #b70011;
            font-size: 13px;
            font-weight: 800;
            text-decoration: none;
        }

        .materials-footer {
            max-width: 1280px;
            width: 100%;
            margin: 34px auto 0;
            padding-top: 18px;
            border-top: 1px solid #e6bdb8;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 18px;
            color: #596373;
            font-size: 11px;
            font-weight: 600;
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
            .upload-grid {
                grid-template-columns: 1fr;
            }

            .materials-sidebar {
                width: 240px;
            }
        }

        @media (max-width: 850px) {
            .materials-layout {
                display: block;
            }

            .materials-sidebar {
                width: 100%;
                height: auto;
                position: relative;
                top: 0;
            }

            .materials-nav {
                flex-direction: row;
                overflow-x: auto;
            }

            .materials-nav a {
                white-space: nowrap;
            }

            .materials-main {
                padding: 22px 16px;
            }

            .materials-footer {
                flex-direction: column;
                align-items: flex-start;
            }

            .material-item {
                align-items: flex-start;
                flex-direction: column;
            }

            .material-actions {
                align-self: flex-end;
            }
        }
    </style>

    <div class="materials-page">

        <!-- Top Bar -->
        <header class="materials-topbar">
            <div class="topbar-left">
                <button type="button" class="menu-btn">
                    <span class="material-symbols-outlined">menu</span>
                </button>

                <h1 class="portal-title">Instructor Portal</h1>
            </div>

            <div class="topbar-right">
                <span class="topbar-icon">
                    <span class="material-symbols-outlined" style="font-size:19px;">notifications</span>
                </span>

                <div class="avatar">M</div>
            </div>
        </header>

        <div class="materials-layout">

            <!-- Sidebar -->
            <aside class="materials-sidebar">
                <div class="instructor-block">
                    <div class="instructor-name"><%: Aidify_assigment.AuthHelper.GetName() %></div>
                    <div class="instructor-role"><%: Aidify_assigment.AuthHelper.GetRole() %></div>
                    <div class="verified-text">Verified Educator</div>
                </div>

                <nav class="materials-nav">
                    <a href="/Instructor/Dashboard.aspx">
                        <span class="material-symbols-outlined">dashboard</span>
                        Dashboard
                    </a>

                    <a href="/Instructor/Modules/Edit.aspx">
                        <span class="material-symbols-outlined">school</span>
                        My Modules
                    </a>

                    <a class="active" href="/Instructor/Materials/Upload.aspx">
                        <span class="material-symbols-outlined">description</span>
                        Materials
                    </a>

                    <a href="/Instructor/Quizzes/Edit.aspx">
                        <span class="material-symbols-outlined">quiz</span>
                        Quizzes
                    </a>

                    <a href="/Instructor/Quizzes/GenerateWithAI.aspx">
                        <span class="material-symbols-outlined">auto_awesome</span>
                        AI Generator
                    </a>
                </nav>
            </aside>

            <!-- Main -->
            <main class="materials-main">
                <div class="materials-container">

                    <div class="page-heading">
                        <h2 class="page-title">Upload Learning Material</h2>
                        <p class="page-subtitle">Add new educational resources to your active curriculum modules.</p>
                        <asp:Label ID="lblUploadStatus" runat="server" CssClass="status-label"></asp:Label>
                    </div>

                    <div class="upload-grid">

                        <!-- Left Column -->
                        <div class="left-stack">

                            <section class="panel details-panel">
                                <h3 class="panel-title">Material Details</h3>

                                <div class="field-group">
                                    <asp:Label ID="lblTargetModule" runat="server"
                                        AssociatedControlID="ddlTargetModule"
                                        CssClass="field-label">
                                        Select Module <span class="required-star">*</span>
                                    </asp:Label>

                                    <asp:DropDownList ID="ddlTargetModule" runat="server"
                                        CssClass="material-select">
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="rfvModule" runat="server"
                                        ControlToValidate="ddlTargetModule"
                                        CssClass="validator-custom"
                                        Display="Dynamic"
                                        ErrorMessage="Please select a target module"
                                        InitialValue="">
                                    </asp:RequiredFieldValidator>
                                </div>

                                <div class="field-group">
                                    <asp:Label ID="lblTargetLesson" runat="server"
                                        AssociatedControlID="ddlTargetLesson"
                                        CssClass="field-label">
                                        Select Lesson
                                    </asp:Label>

                                    <asp:DropDownList ID="ddlTargetLesson" runat="server"
                                        CssClass="material-select">
                                    </asp:DropDownList>
                                </div>

                                <div class="field-group">
                                    <asp:Label ID="lblCaption" runat="server"
                                        AssociatedControlID="txtCaption"
                                        CssClass="field-label">
                                        Resource Title (Caption)
                                    </asp:Label>

                                    <asp:TextBox ID="txtCaption" runat="server"
                                        CssClass="material-input"
                                        placeholder="e.g., Quick Reference Guide - Ventricular Fibrillation">
                                    </asp:TextBox>
                                </div>
                            </section>

                            <section class="upload-drop">
                                <asp:Label ID="lblMaterial" runat="server"
                                    AssociatedControlID="fuMaterial"
                                    CssClass="d-none">
                                    Upload File
                                </asp:Label>

                                <asp:FileUpload ID="fuMaterial" runat="server"
                                    CssClass="file-input-cover"
                                    onchange="showSelectedMaterialName(this)" />

                                <div>
                                    <div class="upload-icon-circle">
                                        <span class="material-symbols-outlined" style="font-size:36px;">cloud_upload</span>
                                    </div>

                                    <h3 class="upload-title">Drag and drop file here</h3>

                                    <p class="upload-help">
                                        Support for PDF, MP4, or JPG files up to 50MB
                                    </p>

                                    <asp:RequiredFieldValidator ID="rfvMaterial" runat="server"
                                        ControlToValidate="fuMaterial"
                                        CssClass="validator-custom"
                                        Display="Dynamic"
                                        ErrorMessage="File selection is required">
                                    </asp:RequiredFieldValidator>

                                    <div id="selectedFileName" class="validator-custom" style="display:none;color:#b70011;margin-top:8px;">
                                        File ready for upload
                                    </div>

                                    <div class="upload-button-wrap">
                                        <asp:Button ID="btnUpload" runat="server"
                                            Text="Upload Material"
                                            CssClass="btn btn-upload-custom"
                                            OnClick="btnUpload_Click" />
                                    </div>
                                </div>
                            </section>

                        </div>

                        <!-- Right Column -->
                        <section class="panel recent-panel">
                            <div class="recent-header">
                                <h3 class="recent-title">Recently Uploaded</h3>
                                <span class="items-pill">4 Items Total</span>
                            </div>

                            <div class="recent-list">
                                <asp:Repeater ID="rptUploadedMaterials" runat="server">
                                    <ItemTemplate>
                                        <div class="material-item">
                                            <div class="material-left">
                                                <div class="file-icon pdf">
                                                    <span class="material-symbols-outlined">picture_as_pdf</span>
                                                </div>

                                                <div>
                                                    <div class="file-name"><%# Eval("Title") %></div>

                                                    <div class="file-meta">
                                                        <span class="file-type pdf"><%# Eval("Status") %></span>
                                                        <span class="file-detail"><%# Eval("Detail") %></span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="material-actions">
                                                <button type="button" class="icon-btn" title="View Material">
                                                    <span class="material-symbols-outlined" style="font-size:19px;">visibility</span>
                                                </button>

                                                <button type="button" class="icon-btn" title="Delete Material">
                                                    <span class="material-symbols-outlined" style="font-size:19px;">delete</span>
                                                </button>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>

                            <div class="recent-footer">
                                <a class="load-more" href="#">Load More Materials</a>
                            </div>
                        </section>

                    </div>

                    <footer class="materials-footer">
                        <div>© 2024 Medical Education Platform. All Rights Reserved.</div>

                        <div class="footer-links">
                            <a href="#">Support</a>
                            <a href="#">Privacy Policy</a>
                            <a href="#">Terms of Service</a>
                        </div>
                    </footer>

                </div>
            </main>
        </div>
    </div>

    <script type="text/javascript">
        function showSelectedMaterialName(input) {
            var label = document.getElementById('selectedFileName');

            if (!label) {
                return;
            }

            if (input.files && input.files.length > 0) {
                label.style.display = 'block';
                label.innerText = input.files[0].name + ' is ready for upload';
            } else {
                label.style.display = 'none';
                label.innerText = 'File ready for upload';
            }
        }
    </script>

</asp:Content>