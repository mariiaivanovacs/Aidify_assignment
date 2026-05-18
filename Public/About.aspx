<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Aidify_assigment.Public.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="about-page-hero">
        <div class="container">
            <div class="row align-items-center g-5">
                <div class="col-md-6">
                    <span class="about-badge">MISSION FIRST</span>

                    <h1>Empowering immediate readiness through clinical precision.</h1>

                    <p>
                        Aidify is dedicated to bridging the gap between medical knowledge and life-saving action.
                        We believe that in moments of crisis, clarity and confidence are powerful tools one can possess.
                    </p>

                    <div class="d-flex gap-4 flex-wrap mt-5 mb-4">
                        <a href="PreviewModules.aspx" class="btn btn-aidify">
                            Our Methodology
                        </a>

                        <a href="EmergencyAwareness.aspx" class="btn btn-outline-aidify">
                            Watch Overview
                        </a>
                   </div>
                </div>

                <div class="col-md-6">
                    <div class="about-hero-image">
                       
                        <img src="../Images/medical-about.jpg" alt="Medical learning" />
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="about-purpose-section">
        <div class="container">
            <div class="row g-5">
                <div class="col-md-6">
                    <h2 class="about-red-title">Our Core Purpose</h2>

                    <p>
                        In the face of a medical emergency, every second counts. Aidify was built to transform 
                        complex medical protocols into actionable, step-by-step guidance that anyone can follow 
                        when it matters most.
                    </p>

                    <div class="about-info-box">
                        <div class="about-icon-box"><i class="bi bi-hospital"></i></div>
                        <div>
                            <h4>Verified Content</h4>
                            <p>
                               All our modules are strictly vetted by board-certified emergency physicians 
                               and medical educators.
                            </p>
                        </div>
                    </div>

                    <div class="about-info-box">
                        <div class="about-icon-box"><i class="bi bi-speedometer2"></i></div>
                        <div>
                            <h4>Instant Accessibility</h4>
                            <p>Designed for rapid recall and zero-friction navigation during high-stress situations.</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <h2 class="about-blue-title">Why It Matters</h2>

                    <div class="about-impact-card">
                        <div class="d-flex justify-content-between align-items-end">
                            <h3>70%</h3>
                            <span>Survival rate impact</span>
                        </div>

                        <div class="about-progress">
                            <div></div>
                        </div>

                        <p>
                            Statistics show that immediate bystander intervention can increase survival rates significantly. 
                            Aidify provides the training necessary to move from bystander to responder.
                        </p>

                        <blockquote>
                            “True preparation is the foundation of a calm response. By putting the vital
                            knowledge of a first responder into the hands of everyone, Aidify ensures that
                            when an emergency strikes, panic is replaced by capability.”
                        </blockquote>

                        <p class="about-quote-author">
                            — Dr. Sarah Jenkins, Emergency Medicine
                        </p>

                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="about-feature-section">
        <div class="container">
            <div class="text-center mb-5">
                <h2>Educational Ecosystem</h2>
                <p>Structured for retention and optimized for emergency awareness.</p>
            </div>

            <div class="row g-4">
                <div class="col-md-4">
                    <div class="about-feature-card">
                        <div class="about-feature-icon"><i class="bi bi-book"></i></div>
                        <h4>Structured Modules</h4>
                        <p>Learn first aid topics through organized and easy-to-follow sections.</p>
                        <img src="../Images/Modules.jpg" alt="Structured modules" />
                        <a href="PreviewModules.aspx">Explore Modules <i class="bi bi-arrow-right"></i></a>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="about-feature-card">
                        <div class="about-feature-icon"><i class="bi bi-patch-question"></i></div>
                        <h4>Interactive Quizzes</h4>
                        <p>Test your understanding using short quizzes and scenario-based questions.</p>
                        <img src="../Images/Quiz.jpg" alt="Interactive quizzes" />
                        <a href="PreviewQuiz.aspx">Test Knowledge <i class="bi bi-arrow-right"></i></a>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="about-feature-card">
                        <div class="about-feature-icon"><i class="bi bi-exclamation-triangle"></i></div>
                        <h4>Emergency Tips</h4>
                        <p>Access basic awareness tips for choking, burns, fractures, and injuries.</p>
                        <img src="../Images/tips.jpg" alt="Emergency tips" />
                        <a href="EmergencyAwareness.aspx">View Tips <i class="bi bi-arrow-right"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>