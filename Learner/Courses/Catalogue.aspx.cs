using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnerDash.Learner.Courses
{
    public partial class Catalogue : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCourses();
            }
        }

        private void BindCourses()
        {
            var courses = new[]
            {
                new { ModuleId = 1, ModuleTitle = "Intro to C#", Difficulty = "Beginner",
                    Description = "Learn the fundamentals of C# programming from scratch.",
                    CoverImageUrl = "" },
                new { ModuleId = 2, ModuleTitle = "ASP.NET Web Forms", Difficulty = "Intermediate",
                    Description = "Build dynamic web apps using ASP.NET Web Forms and C#.",
                    CoverImageUrl = "" },
                new { ModuleId = 3, ModuleTitle = "SQL Basics", Difficulty = "Beginner",
                    Description = "Understand relational databases and write SQL queries.",
                    CoverImageUrl = "" },
                new { ModuleId = 4, ModuleTitle = "Advanced C#", Difficulty = "Advanced",
                    Description = "Deep dive into LINQ, async/await, and design patterns.",
                    CoverImageUrl = "" },
            };

            rptModules.DataSource = courses;
            rptModules.DataBind();
            lblNoCourses.Visible = courses.Length == 0;
        }

        protected void btnCatalogueSearch_Click(object sender, EventArgs e)
        {
            // Will be based on the database.
            // A dummy code to show that it works
            string searchText = txtCatalogueSearch.Text.Trim().ToLower();
            string difficulty = ddlDifficultyFilter.SelectedValue;

            //This is the dummy data (replace with Data Base later"
            var courses = new[]
            {
                new { ModuleId = 1, ModuleTitle = "Intro to C#", Difficulty = "Beginner",
                    Description = "Learn the fundamentals of C# programming from scratch.",
                    CoverImageUrl = "" },
                new { ModuleId = 2, ModuleTitle = "ASP.NET Web Forms", Difficulty = "Intermediate",
                    Description = "Build dynamic web apps using ASP.NET Web Forms and C#.",
                    CoverImageUrl = "" },
                new { ModuleId = 3, ModuleTitle = "SQL Basics", Difficulty = "Beginner",
                    Description = "Understand relational databases and write SQL queries.",
                    CoverImageUrl = "" },
                new { ModuleId = 4, ModuleTitle = "Advanced C#", Difficulty = "Advanced",
                    Description = "Deep dive into LINQ, async/await, and design patterns.",
                    CoverImageUrl = "" },
            };

            var filtered = courses
                .Where(c => (string.IsNullOrEmpty(searchText) || c.ModuleTitle.ToLower().Contains(searchText))
                         && (string.IsNullOrEmpty(difficulty) || c.Difficulty == difficulty))
                .ToArray();

            rptModules.DataSource = filtered;
            rptModules.DataBind();
            lblNoCourses.Visible = filtered.Length == 0;
        }

        protected void rptModules_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Enrol")
            {
                // Save enrolment to database here
                int moduleId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("~/Learner/Courses/Details.aspx?moduleId=" + moduleId);
            }
        }

        public string GetDifficultyBadge(string difficulty)
        {
            switch (difficulty)
            {
                case "Beginner":
                    return "bg-success";
                case "Intermediate":
                    return "bg-warning text-dark";
                case "Advanced":
                    return "bg-danger";
                default:
                    return "bg-secondary";
            }
        }
    }
}