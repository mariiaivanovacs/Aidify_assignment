using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnerDash.Learner
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Dummy data
                txtFullName.Text = "Manoj";
                txtEmail.Text = "manoj@learnerdash.com";
                lblDisplayName.Text = "Manoj";
                imgAvatar.ImageUrl = "https://ui-avatars.com/api/?name=Manoj&background=C0392B&color=fff&size=100";
            }
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            lblDisplayName.Text = txtFullName.Text;
            lblProfileStatus.Text = "✓ Profile updated successfully!";
            lblProfileStatus.Visible = true;
        }
    }
}