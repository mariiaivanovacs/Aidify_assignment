<%@ Page Title="Emergency Awareness" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmergencyAwareness.aspx.cs" Inherits="Aidify_assigment.Public.EmergencyAwareness" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="emergency-hero">
        <div class="container">
            <h1>Immediate Emergency Awareness & Response</h1>
            <p>
                In an emergency, every second counts. Learn simple awareness steps that can help you stay calm
                and respond safely while waiting for professional help.
            </p>
            <a href="PreviewModules.aspx" class="btn btn-light">Explore First Aid Modules</a>
        </div>
    </section>

    <section class="emergency-steps">
        <div class="container">
            <div class="section-title">
                <h2>Initial Response Guidelines</h2>
                <p>Follow these basic awareness steps during an emergency situation.</p>
            </div>

            <div class="row">
                <div class="col-md-3">
                    <div class="step-card">
                        <h3>01</h3>
                        <h4>Assess the Scene</h4>
                        <p>Check if the area is safe before approaching the person who needs help.</p>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="step-card">
                        <h3>02</h3>
                        <h4>Check Response</h4>
                        <p>Try to get a response and observe breathing or visible signs of distress.</p>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="step-card">
                        <h3>03</h3>
                        <h4>Call for Help</h4>
                        <p>Contact emergency services or ask someone nearby to call immediately.</p>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="step-card">
                        <h3>04</h3>
                        <h4>Provide Basic Aid</h4>
                        <p>Use only basic first aid steps you understand until trained help arrives.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="safety-tips-section">
        <div class="container">
            <div class="section-title">
                <h2>Essential Safety Tips</h2>
            </div>

            <div class="row">
                <div class="col-md-4">
                    <div class="safety-card">
                        <h4>Stay Calm</h4>
                        <p>A calm response helps you think clearly and provide better assistance.</p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="safety-card">
                        <h4>Protect Yourself</h4>
                        <p>Avoid unsafe areas and use protective barriers if available.</p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="safety-card">
                        <h4>Share Clear Details</h4>
                        <p>When calling for help, explain the location, situation, and number of people involved.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="emergency-reminder">
        <div class="container">
            <div class="reminder-box">
                <h2>Create Your Emergency Plan</h2>
                <p>
                    Keep important phone numbers, emergency contacts, and basic first aid information easy to access.
                    Being prepared can reduce panic during real emergencies.
                </p>
                <a href="../Auth/Register.aspx" class="btn btn-aidify">Register to Learn More</a>
            </div>
        </div>
    </section>

    <section class="medical-disclaimer">
        <div class="container">
            <div class="disclaimer-box">
                <h3>Professional Medical Disclaimer</h3>
                <p>
                    Aidify provides educational and awareness-based information only. It does not replace professional
                    medical training, diagnosis, treatment, or emergency services. In a real emergency, call emergency
                    services immediately.
                </p>
            </div>
        </div>
    </section>

</asp:Content>