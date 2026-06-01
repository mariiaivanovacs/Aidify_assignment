using System;
using System.Web.UI;

namespace Aidify_assigment.Learner.Controls
{
    public partial class BadgeCard : System.Web.UI.UserControl
    {
        public string BadgeName { get; set; }
        public string IconPath { get; set; }
        public string AwardedDate { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            lblBadgeName.Text = Server.HtmlEncode(BadgeName);
            lblAwardedDate.Text = Server.HtmlEncode(AwardedDate);

            if (!string.IsNullOrEmpty(IconPath))
            {
                imgBadge.ImageUrl = ResolveUrl(IconPath);
                imgBadge.Visible = true;
                lblBadgeEmoji.Visible = false;
            }
            else
            {
                imgBadge.Visible = false;
                lblBadgeEmoji.Visible = true;
            }
        }
    }
}