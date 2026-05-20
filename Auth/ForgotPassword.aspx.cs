using System;
using System.Drawing;

namespace Aidify_assigment.Auth
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.Text = "If this email exists in our system, a reset link will be sent.";
        }
    }
}