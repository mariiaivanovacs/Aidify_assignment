using System;

namespace Aidify_assigment.Public
{
    public partial class PreviewQuiz : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            btnSubmitPreviewQuiz.Click += btnSubmitPreviewQuiz_Click;
        }

        protected void Page_Load(object sender, EventArgs e) { }

        private void btnSubmitPreviewQuiz_Click(object sender, EventArgs e)
        {
            // Quiz questions are hardcoded HTML radio inputs — not server controls.
            // No DB write. Show a register CTA injected via JS.
            const string js = "document.addEventListener('DOMContentLoaded',function(){" +
                "var d=document.createElement('div');" +
                "d.className='container py-3';" +
                "d.innerHTML='<div class=\"alert alert-success\">" +
                "<strong>Thanks for trying the preview quiz!</strong> " +
                "<a href=\"../Auth/Register.aspx\">Register for free</a> " +
                "to access full quizzes with instant scoring, progress tracking, and certificates." +
                "</div>';" +
                "document.body.insertBefore(d,document.body.firstChild);});";
            ClientScript.RegisterStartupScript(GetType(), "quizDone", js, true);
        }
    }
}
