using System;

namespace Aidify_assigment.Controls
{
    public partial class Navbar : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string role = "";

            if (Session["Role"] != null)
            {
                role = Session["Role"].ToString();
            }

            pnlVisitor.Visible = role == "";
            pnlLearner.Visible = role == "Learner";
            pnlInstructor.Visible = role == "Instructor";
            pnlAdmin.Visible = role == "Admin";
        }
    }
}