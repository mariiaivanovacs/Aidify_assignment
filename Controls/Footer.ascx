<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Footer.ascx.cs" Inherits="Aidify_assigment.Controls.Footer" %>

<footer class="aidify-footer">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h5>Aidify</h5>
                <p>First Aid & Emergency Response Learning Platform</p>
                <p class="footer-warning">
                    Aidify is for educational purposes only. Always call emergency services in a real emergency.
                </p>
            </div>

            <div class="col-md-6 text-md-end">
                <a href="<%= ResolveUrl("~/Default.aspx") %>">Home</a>
                <a href="<%= ResolveUrl("~/Public/About.aspx") %>">About</a>
                <a href="<%= ResolveUrl("~/Public/FAQ.aspx") %>">FAQ</a>
                <a href="<%= ResolveUrl("~/Public/Contact.aspx") %>">Contact</a>
                <p class="mt-3">&copy; <%: DateTime.Now.Year %> Aidify. All rights reserved.</p>
            </div>
        </div>
    </div>
</footer>