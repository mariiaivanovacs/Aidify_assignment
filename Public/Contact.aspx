<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Aidify_assigment.Public.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="contact-page-section">
        <div class="container">

            <div class="contact-intro">
                <h1>Get in Touch</h1>
                <p>
                    Have questions about our first aid courses or need assistance with your training modules?
                    Our support team is here to help.
                </p>
            </div>

            <div class="row g-5">

                <div class="col-lg-7">
                    <div class="contact-form-card">

                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label>Full Name</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control form-control-lg" placeholder="John Doe"></asp:TextBox>
                            </div>

                            <div class="col-md-6">
                                <label>Email Address</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control form-control-lg" TextMode="Email" placeholder="john@example.com"></asp:TextBox>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label>Subject</label>
                            <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control form-control-lg" placeholder="Course inquiry, technical issue..."></asp:TextBox>
                        </div>

                        <div class="mb-4">
                            <label>Message</label>
                            <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="6" placeholder="How can we assist you today?"></asp:TextBox>
                        </div>

                        <asp:Button ID="btnSend" runat="server" Text="Send Message" CssClass="btn btn-aidify btn-lg px-5" />

                    </div>
                </div>

                <div class="col-lg-5">
                    <div class="contact-info-card">

                        <div class="contact-info-item">
                            <div class="contact-icon emergency-icon">
                                <i class="bi bi-telephone"></i>
                            </div>
                            <div>
                                <small>Emergency Line</small>
                                <h5>1-800-AIDIFY-911</h5>
                                <p>Available 24/7 for urgent course support.</p>
                            </div>
                        </div>

                        <div class="contact-info-item">
                            <div class="contact-icon email-icon">
                                <i class="bi bi-envelope"></i>
                            </div>
                            <div>
                                <small>Email Us</small>
                                <h5>support@aidify.edu</h5>
                                <p>Response within 24 business hours.</p>
                            </div>
                        </div>

                        <div class="contact-info-item">
                            <div class="contact-icon location-icon">
                                <i class="bi bi-geo-alt"></i>
                            </div>
                            <div>
                                <small>Main Campus</small>
                                <h5>Asia Pacific University</h5>
                                <p>Kuala Lumpur, Malaysia</p>
                            </div>
                        </div>

                    </div>

                    <div class="contact-map-box">
                        <img src="../Images/APU Outside Campus.jpg" alt="Aidify location" />
                        <a href="https://maps.google.com/?q=Asia+Pacific+University+Malaysia"
                           target="_blank"
                           class="contact-map-badge text-decoration-none">

                            <i class="bi bi-geo-alt-fill"></i>
                            View Location

                       </a>
                    </div>
                </div>

            </div>

        </div>
    </section>

</asp:Content>