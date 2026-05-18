<%@ Page Title="FAQ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FAQ.aspx.cs" Inherits="Aidify_assigment.Public.FAQ" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="faqx-hero">
        <div class="container text-center">
            <h1>How can we help you?</h1>
            <p>Search our comprehensive database for immediate answers to your first aid learning and platform questions.</p>

            <div class="faqx-search">
                <i class="bi bi-search"></i>
                <input type="text" class="form-control" placeholder="Search for questions (e.g. CPR certification, Quiz reset...)" />
            </div>
        </div>
    </section>

    <section class="faqx-content">
        <div class="container">
            <div class="row">

                <div class="col-lg-3">
                    <div class="faqx-sidebar">
                        <h6>CATEGORIES</h6>
                        <a href="#platform" class="active"><i class="bi bi-grid"></i> Platform</a>
                        <a href="#registration"><i class="bi bi-person-plus"></i> Registration</a>
                        <a href="#learning"><i class="bi bi-mortarboard"></i> First Aid Learning</a>
                        <a href="#quizzes"><i class="bi bi-patch-question"></i> Quizzes</a>
                    </div>
                </div>

                <div class="col-lg-9">

                    <div id="platform" class="faqx-category">
                        <h2><i class="bi bi-grid"></i> Platform</h2>

                        <div class="accordion" id="accordionPlatform">
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
                                        Is the Aidify platform accessible on mobile devices?
                                    </button>
                                </h2>
                                <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#accordionPlatform">
                                    <div class="accordion-body">
                                        Yes, Aidify is fully responsive and designed to work seamlessly across desktops, tablets, and smartphones.
                                    </div>
                                </div>
                            </div>

                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2">
                                        What technical requirements do I need to run the modules?
                                    </button>
                                </h2>
                                <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#accordionPlatform">
                                    <div class="accordion-body">
                                        You only need a modern web browser and a stable internet connection.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="registration" class="faqx-category">
                        <h2><i class="bi bi-person-plus"></i> Registration</h2>

                        <div class="accordion" id="accordionRegistration">
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq3">
                                        How do I create a new learner account?
                                    </button>
                                </h2>
                                <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#accordionRegistration">
                                    <div class="accordion-body">
                                        Click the Register button and complete the registration form using your email address.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="learning" class="faqx-category">
                        <h2><i class="bi bi-mortarboard"></i> First Aid Learning</h2>

                        <div class="accordion" id="accordionLearning">
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq4">
                                        Are Aidify's modules officially certified?
                                    </button>
                                </h2>
                                <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#accordionLearning">
                                    <div class="accordion-body">
                                        Aidify is for educational awareness only and does not replace professional medical certification.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="quizzes" class="faqx-category">
                        <h2><i class="bi bi-patch-question"></i> Quizzes</h2>

                        <div class="accordion" id="accordionQuizzes">
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq5">
                                        Can visitors attempt preview quizzes?
                                    </button>
                                </h2>
                                <div id="faq5" class="accordion-collapse collapse" data-bs-parent="#accordionQuizzes">
                                    <div class="accordion-body">
                                        Yes, visitors can attempt selected preview quizzes. Full quizzes require registration.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

            <div class="faqx-support">
                <div>
                    <h2>Still have questions?</h2>
                    <p>Our medical education support team is available 24/7 to assist with technical issues or specific protocol clarifications.</p>
                    <span><i class="bi bi-envelope"></i> support@aidify.com</span>
                    <span><i class="bi bi-telephone"></i> +1 (800) AID-HELP</span>
                </div>

                <div class="faqx-support-buttons">
                    <a href="Contact.aspx" class="btn btn-aidify">Contact Support</a>
                    <a href="FAQ.aspx" class="btn btn-outline-aidify">Knowledge Base</a>
                </div>
            </div>

        </div>
    </section>

</asp:Content>