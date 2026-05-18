<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Aidify_assigment.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <span class="hero-badge">Immediate Action Saves Lives</span>

                    <h1>Learn First Aid <span>Before It Matters</span></h1>

                    <p>
                        Aidify helps learners understand first aid and emergency response through
                        structured lessons, preview modules, quizzes, and awareness tips.
                    </p>

                     <div class="d-flex gap-3 flex-wrap mt-4">
                        <a href="Auth/Register.aspx" class="btn btn-aidify">
                            Get Started for Free
                        </a>

                        <a href="Public/PreviewModules.aspx" class="btn btn-outline-aidify">
                            Browse Modules
                        </a>
                   </div>
                </div>

                <div class="col-md-6 text-center">
                    <div class="hero-image-box">
                        <img src="Images/firstaid-hero.jpg" alt="First aid learning" class="img-fluid rounded" />
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row text-center">
                <div class="col-md-4">
                    <div class="stat-card">
                        <h2>4+</h2>
                        <p>Preview Modules</p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="stat-card">
                        <h2>10+</h2>
                        <p>Practice Questions</p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="stat-card">
                        <h2>24/7</h2>
                        <p>Accessible Learning</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Preview Modules -->
    <section class="module-section">
        <div class="container">
            <div class="section-title">
                <h2>Preview Our Modules</h2>
                <p>Explore selected first aid topics before registering for full access.</p>
            </div>

            <div class="row">
                <div class="col-md-3">
                    <div class="module-card">
                        <h4>CPR Awareness</h4>
                        <p>Learn basic CPR awareness and emergency response steps.</p>
                        <span>Beginner • 30 mins</span>
                        <a href="Public/PreviewModules.aspx" class="btn btn-sm btn-aidify mt-3">Preview</a>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="module-card">
                        <h4>Burns</h4>
                        <p>Understand basic burn response and safety precautions.</p>
                        <span>Beginner • 20 mins</span>
                        <a href="Public/PreviewModules.aspx" class="btn btn-sm btn-aidify mt-3">Preview</a>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="module-card">
                        <h4>Choking</h4>
                        <p>Learn how to identify choking emergencies and respond safely.</p>
                        <span>Beginner • 25 mins</span>
                        <a href="Public/PreviewModules.aspx" class="btn btn-sm btn-aidify mt-3">Preview</a>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="module-card locked-card">
                        <h4>Fractures</h4>
                        <p>Learn basic fracture care and when to seek professional help.</p>
                        <span>Locked • Register to unlock</span>
                        <a href="Auth/Register.aspx" class="btn btn-sm btn-outline-aidify mt-3">Register</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Emergency Awareness -->
    <section class="awareness-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-7">
                    <h2>In an Emergency, Every Second Counts</h2>

                    <div class="awareness-step">
                        <strong>1. Assess the Scene</strong>
                        <p>Check that the area is safe before helping others.</p>
                    </div>

                    <div class="awareness-step">
                        <strong>2. Call for Help</strong>
                        <p>Contact emergency services immediately when needed.</p>
                    </div>

                    <div class="awareness-step">
                        <strong>3. Provide Basic Aid</strong>
                        <p>Follow simple first aid steps while waiting for professionals.</p>
                    </div>
                </div>

                <div class="col-md-5">
                    <div class="warning-box">
                        <h4>Important Reminder</h4>
                        <p>
                            Aidify provides educational awareness only. It does not replace
                            professional medical training or advice.
                        </p>
                        <a href="Public/EmergencyAwareness.aspx" class="btn btn-aidify">Learn More</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>