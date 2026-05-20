using System;
using System.Drawing;

namespace Aidify_assigment.Auth
{
    public partial class ConfirmEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtCode.Text))
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Please enter the verification code.";
                return;
            }

            lblMessage.ForeColor = Color.Green;
            lblMessage.Text = "Email verified successfully.";
        }
    }
}