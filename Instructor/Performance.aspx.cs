using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Instructor
{
    public partial class Performance : Page
    {
        private const int InstructorUserId = 2;

        private string ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["AidifyDB"].ConnectionString;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadModuleFilter();
                LoadSummaryCards();
                LoadModulePerformance();
                LoadQuizAttempts();
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            ClearMessage();

            LoadModuleFilter();

            if (ddlModuleFilter.Items.FindByValue("All") != null)
            {
                ddlModuleFilter.SelectedValue = "All";
            }

            LoadSummaryCards();
            LoadModulePerformance();
            LoadQuizAttempts();

            ShowMessage("Performance data refreshed successfully.", true);
        }

        protected void btnApplyFilter_Click(object sender, EventArgs e)
        {
            ClearMessage();

            LoadSummaryCards();
            LoadModulePerformance();
            LoadQuizAttempts();
        }

        private void LoadModuleFilter()
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT ModuleId, Title
                    FROM dbo.Modules
                    WHERE CreatedBy = @CreatedBy AND IsDeleted = 0
                    ORDER BY Title;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        ddlModuleFilter.Items.Clear();
                        ddlModuleFilter.Items.Add(new ListItem("All Modules", "All"));

                        foreach (DataRow row in table.Rows)
                        {
                            ddlModuleFilter.Items.Add(new ListItem(
                                Convert.ToString(row["Title"]),
                                Convert.ToString(row["ModuleId"])
                            ));
                        }
                    }
                }
            }
        }

        private int GetSelectedModuleId()
        {
            if (ddlModuleFilter.Items.Count == 0 || string.IsNullOrWhiteSpace(ddlModuleFilter.SelectedValue))
            {
                return 0;
            }

            if (ddlModuleFilter.SelectedValue == "All")
            {
                return 0;
            }

            return Convert.ToInt32(ddlModuleFilter.SelectedValue);
        }

        private void LoadSummaryCards()
        {
            int moduleId = GetSelectedModuleId();

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        COUNT(DISTINCT e.UserId) AS TotalLearners,
                        COUNT(DISTINCT e.EnrolId) AS TotalEnrollments,
                        COUNT(DISTINCT p.ProgressId) AS CompletedLessons,
                        ISNULL(AVG(CAST(qa.Score AS decimal(10,2))), 0) AS AverageScore
                    FROM dbo.Modules m
                    LEFT JOIN dbo.Enrollments e ON m.ModuleId = e.ModuleId
                    LEFT JOIN dbo.Progress p ON e.EnrolId = p.EnrolId
                    LEFT JOIN dbo.Quizzes q ON m.ModuleId = q.ModuleId
                    LEFT JOIN dbo.QuizAttempts qa ON q.QuizId = qa.QuizId
                    WHERE
                        m.CreatedBy = @CreatedBy
                        AND m.IsDeleted = 0
                        AND (@ModuleId = 0 OR m.ModuleId = @ModuleId);";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);

                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblTotalLearners.Text = Convert.ToString(reader["TotalLearners"] == DBNull.Value ? 0 : reader["TotalLearners"]);
                            lblTotalEnrollments.Text = Convert.ToString(reader["TotalEnrollments"] == DBNull.Value ? 0 : reader["TotalEnrollments"]);
                            lblCompletedLessons.Text = Convert.ToString(reader["CompletedLessons"] == DBNull.Value ? 0 : reader["CompletedLessons"]);

                            decimal averageScore = reader["AverageScore"] == DBNull.Value ? 0 : Convert.ToDecimal(reader["AverageScore"]);
                            lblAverageScore.Text = Math.Round(averageScore, 1) + "%";
                        }
                    }
                }
            }
        }

        private void LoadModulePerformance()
        {
            int moduleId = GetSelectedModuleId();

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        m.ModuleId,
                        m.Title AS ModuleTitle,

                        COUNT(DISTINCT e.EnrolId) AS EnrollmentCount,

                        (
                            SELECT COUNT(*)
                            FROM dbo.Lessons l
                            WHERE l.ModuleId = m.ModuleId
                        ) AS LessonCount,

                        COUNT(DISTINCT p.ProgressId) AS CompletedLessons,

                        CASE
                            WHEN COUNT(DISTINCT e.EnrolId) = 0 OR
                                 (
                                    SELECT COUNT(*)
                                    FROM dbo.Lessons l
                                    WHERE l.ModuleId = m.ModuleId
                                 ) = 0
                            THEN 0
                            ELSE
                                CAST(
                                    COUNT(DISTINCT p.ProgressId) * 100.0 /
                                    (
                                        COUNT(DISTINCT e.EnrolId) *
                                        (
                                            SELECT COUNT(*)
                                            FROM dbo.Lessons l
                                            WHERE l.ModuleId = m.ModuleId
                                        )
                                    )
                                AS decimal(10,2))
                        END AS CompletionRate,

                        COUNT(DISTINCT qa.AttemptId) AS QuizAttemptCount,

                        ISNULL(CAST(AVG(CAST(qa.Score AS decimal(10,2))) AS decimal(10,2)), 0) AS AverageScore

                    FROM dbo.Modules m
                    LEFT JOIN dbo.Enrollments e ON m.ModuleId = e.ModuleId
                    LEFT JOIN dbo.Progress p ON e.EnrolId = p.EnrolId
                    LEFT JOIN dbo.Quizzes q ON m.ModuleId = q.ModuleId
                    LEFT JOIN dbo.QuizAttempts qa ON q.QuizId = qa.QuizId

                    WHERE
                        m.CreatedBy = @CreatedBy
                        AND m.IsDeleted = 0
                        AND (@ModuleId = 0 OR m.ModuleId = @ModuleId)

                    GROUP BY m.ModuleId, m.Title
                    ORDER BY m.Title;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        rptModulePerformance.DataSource = table;
                        rptModulePerformance.DataBind();

                        pnlModuleEmpty.Visible = table.Rows.Count == 0;
                    }
                }
            }
        }

        private void LoadQuizAttempts()
        {
            int moduleId = GetSelectedModuleId();

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT TOP 20
                        qa.AttemptId,
                        ISNULL(u.FullName, 'Learner') AS LearnerName,
                        q.Title AS QuizTitle,
                        m.Title AS ModuleTitle,
                        ISNULL(qa.Score, 0) AS Score,
                        ISNULL(qa.Passed, 0) AS Passed,
                        qa.SubmittedAt
                    FROM dbo.QuizAttempts qa
                    INNER JOIN dbo.Quizzes q ON qa.QuizId = q.QuizId
                    INNER JOIN dbo.Modules m ON q.ModuleId = m.ModuleId
                    LEFT JOIN dbo.Users u ON qa.UserId = u.UserId
                    WHERE
                        m.CreatedBy = @CreatedBy
                        AND m.IsDeleted = 0
                        AND (@ModuleId = 0 OR m.ModuleId = @ModuleId)
                    ORDER BY qa.SubmittedAt DESC, qa.AttemptId DESC;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);
                    cmd.Parameters.AddWithValue("@ModuleId", moduleId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        rptQuizAttempts.DataSource = table;
                        rptQuizAttempts.DataBind();

                        pnlAttemptsEmpty.Visible = table.Rows.Count == 0;
                    }
                }
            }
        }

        private void ShowMessage(string message, bool success)
        {
            lblPerformanceStatus.Visible = true;
            lblPerformanceStatus.Text = message;
            lblPerformanceStatus.CssClass = success
                ? "message-box message-success d-block"
                : "message-box message-error d-block";
        }

        private void ClearMessage()
        {
            lblPerformanceStatus.Visible = false;
            lblPerformanceStatus.Text = "";
            lblPerformanceStatus.CssClass = "";
        }

        protected string FormatDate(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return "-";
            }

            DateTime date = Convert.ToDateTime(value);
            return date.ToString("yyyy-MM-dd HH:mm");
        }
    }
}