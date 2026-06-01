using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aidify_assigment.Instructor.Quizzes
{
    public partial class GenerateWithAI : InstructorBasePage
    {

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
                LoadQuizzes();
                pnlPreview.Visible = false;
            }
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            ClearMessage();

            if (string.IsNullOrWhiteSpace(ddlQuiz.SelectedValue))
            {
                ShowMessage("Please select a target quiz.", false);
                return;
            }

            if (!int.TryParse(txtQuestionCount.Text.Trim(), out int questionCount) || questionCount < 1 || questionCount > 20)
            {
                ShowMessage("Please enter a question count between 1 and 20.", false);
                return;
            }

            if (!fuKnowledgeFile.HasFile)
            {
                ShowMessage("Please upload a .txt or .md knowledge file.", false);
                return;
            }

            string extension = Path.GetExtension(fuKnowledgeFile.FileName).ToLower();

            if (extension != ".txt" && extension != ".md")
            {
                ShowMessage("Only .txt and .md files are allowed.", false);
                return;
            }

            int quizId = Convert.ToInt32(ddlQuiz.SelectedValue);

            if (!InstructorOwnsQuiz(quizId))
            {
                ShowMessage("Invalid quiz selected.", false);
                return;
            }

            try
            {
                string fileContent = ReadUploadedFileContent();

                if (string.IsNullOrWhiteSpace(fileContent))
                {
                    ShowMessage("The uploaded file is empty.", false);
                    return;
                }

                if (fileContent.Length > 30000)
                {
                    fileContent = fileContent.Substring(0, 30000);
                }

                string difficulty = ddlDifficulty.SelectedValue;
                string prompt = BuildPrompt(questionCount, difficulty, fileContent);

                string rawJson = GenerateQuestionsJson(prompt, questionCount, difficulty);
                List<GeneratedQuestion> generatedQuestions = ParseGeneratedQuestions(rawJson);

                if (generatedQuestions.Count == 0)
                {
                    rawJson = BuildDemoJson(questionCount, difficulty);
                    generatedQuestions = ParseGeneratedQuestions(rawJson);
                }

                for (int i = 0; i < generatedQuestions.Count; i++)
                {
                    generatedQuestions[i].Index = i + 1;

                    if (string.IsNullOrWhiteSpace(generatedQuestions[i].QuestionType))
                    {
                        generatedQuestions[i].QuestionType = "MCQ";
                    }

                    if (generatedQuestions[i].Points <= 0)
                    {
                        generatedQuestions[i].Points = 1;
                    }
                }

                int taskId = InsertAITask(
                    quizId,
                    fuKnowledgeFile.FileName,
                    prompt,
                    rawJson,
                    InstructorUserId
                );
                AuditService.Log(InstructorUserId, "GenerateAIQuestions", "AIGeneratedTasks", taskId);

                hfTaskId.Value = taskId.ToString();

                Session["AIGeneratedQuestions"] = generatedQuestions;
                Session["AIRawJson"] = rawJson;
                Session["AIPromptUsed"] = prompt;
                Session["AIQuizId"] = quizId;

                rptGeneratedQuestions.DataSource = generatedQuestions;
                rptGeneratedQuestions.DataBind();

                pnlPreview.Visible = true;

                string apiKey = ConfigurationManager.AppSettings["GeminiApiKey"];
                bool demoMode = string.IsNullOrWhiteSpace(apiKey) || apiKey == "PUT_YOUR_API_KEY_HERE";

                if (demoMode)
                {
                    ShowMessage("Demo AI questions generated because GeminiApiKey is not set yet. Replace the API key for real AI generation.", true);
                }
                else
                {
                    ShowMessage("AI questions generated. If Gemini returned no candidates, demo fallback questions were used and logged in AIInsights.", true);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error while generating AI questions: " + ex.Message, false);
            }
        }

        protected void btnSaveGenerated_Click(object sender, EventArgs e)
        {
            ClearMessage();

            List<GeneratedQuestion> generatedQuestions = Session["AIGeneratedQuestions"] as List<GeneratedQuestion>;

            if (generatedQuestions == null || generatedQuestions.Count == 0)
            {
                ShowMessage("No generated questions found. Please generate questions first.", false);
                return;
            }

            if (Session["AIQuizId"] == null)
            {
                ShowMessage("Target quiz not found. Please generate again.", false);
                return;
            }

            int quizId = Convert.ToInt32(Session["AIQuizId"]);

            if (!InstructorOwnsQuiz(quizId))
            {
                ShowMessage("Invalid quiz selected.", false);
                return;
            }

            try
            {
                SaveGeneratedQuestions(quizId, generatedQuestions);
                AuditService.Log(InstructorUserId, "SaveAIQuestions", "Quizzes", quizId);

                string promptUsed = Convert.ToString(Session["AIPromptUsed"]);
                string responseText = "Saved " + generatedQuestions.Count + " AI-generated questions into dbo.Questions and dbo.Options.";

                InsertAIInsight(
                    "QuizGeneration",
                    promptUsed,
                    responseText,
                    DateTime.Now.AddDays(7)
                );

                Session.Remove("AIGeneratedQuestions");
                Session.Remove("AIRawJson");
                Session.Remove("AIPromptUsed");
                Session.Remove("AIQuizId");

                pnlPreview.Visible = false;
                hfTaskId.Value = "";

                ShowMessage("Generated questions saved successfully.", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Error while saving generated questions: " + ex.Message, false);
            }
        }

        protected void btnDiscard_Click(object sender, EventArgs e)
        {
            Session.Remove("AIGeneratedQuestions");
            Session.Remove("AIRawJson");
            Session.Remove("AIPromptUsed");
            Session.Remove("AIQuizId");

            pnlPreview.Visible = false;
            hfTaskId.Value = "";

            ShowMessage("Generated questions discarded.", true);
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtQuestionCount.Text = "5";
            ddlDifficulty.SelectedValue = "Intermediate";

            if (ddlQuiz.Items.Count > 0)
            {
                ddlQuiz.SelectedIndex = 0;
            }

            pnlPreview.Visible = false;
            ClearMessage();
            ShowMessage("Form cleared.", true);
        }

        private void LoadQuizzes()
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT
                        q.QuizId,
                        q.Title,
                        m.Title AS ModuleTitle
                    FROM dbo.Quizzes q
                    INNER JOIN dbo.Modules m ON q.ModuleId = m.ModuleId
                    WHERE
                        m.CreatedBy = @CreatedBy
                        AND m.IsDeleted = 0
                    ORDER BY q.QuizId DESC;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable table = new DataTable();
                        adapter.Fill(table);

                        ddlQuiz.Items.Clear();
                        ddlQuiz.Items.Add(new ListItem("Select Quiz", ""));

                        foreach (DataRow row in table.Rows)
                        {
                            string text = Convert.ToString(row["Title"]) + " — " + Convert.ToString(row["ModuleTitle"]);
                            string value = Convert.ToString(row["QuizId"]);

                            ddlQuiz.Items.Add(new ListItem(text, value));
                        }
                    }
                }
            }
        }

        private string ReadUploadedFileContent()
        {
            using (Stream stream = fuKnowledgeFile.PostedFile.InputStream)
            using (StreamReader reader = new StreamReader(stream, Encoding.UTF8))
            {
                return reader.ReadToEnd();
            }
        }

        private string BuildPrompt(int questionCount, string difficulty, string fileContent)
        {
            return
@"You are generating educational multiple-choice quiz questions for a first aid learning platform.
The content is for safe training and classroom assessment only.
Do not include graphic details.
Do not provide harmful instructions.
Focus on general first aid awareness, safety checks, emergency calling, CPR basics, and AED awareness.

Create exactly " + questionCount + @" multiple-choice questions.
Difficulty level: " + difficulty + @".
Question type must be MCQ.
Each question must have 4 options.
Exactly one option must be correct.
Do not include explanations.
Return JSON only. No markdown. No code fences.

Required JSON format:
[
  {
    ""QuestionText"": ""question text here"",
    ""QuestionType"": ""MCQ"",
    ""Points"": 1,
    ""Options"": [
      { ""OptionText"": ""option A"", ""IsCorrect"": true },
      { ""OptionText"": ""option B"", ""IsCorrect"": false },
      { ""OptionText"": ""option C"", ""IsCorrect"": false },
      { ""OptionText"": ""option D"", ""IsCorrect"": false }
    ]
  }
]

Knowledge file content:
" + fileContent;
        }

        private string GenerateQuestionsJson(string prompt, int questionCount, string difficulty)
        {
            string apiKey = ConfigurationManager.AppSettings["GeminiApiKey"];

            if (string.IsNullOrWhiteSpace(apiKey) || apiKey == "PUT_YOUR_API_KEY_HERE")
            {
                return BuildDemoJson(questionCount, difficulty);
            }

            string url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=" + apiKey;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            serializer.MaxJsonLength = int.MaxValue;

            var requestBody = new
            {
                contents = new object[]
                {
                    new
                    {
                        role = "user",
                        parts = new object[]
                        {
                            new
                            {
                                text = prompt
                            }
                        }
                    }
                },
                generationConfig = new
                {
                    temperature = 0.2,
                    maxOutputTokens = 4096
                }
            };

            string requestJson = serializer.Serialize(requestBody);

            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = "POST";
            request.ContentType = "application/json";
            request.Timeout = 60000;

            byte[] requestBytes = Encoding.UTF8.GetBytes(requestJson);
            request.ContentLength = requestBytes.Length;

            using (Stream requestStream = request.GetRequestStream())
            {
                requestStream.Write(requestBytes, 0, requestBytes.Length);
            }

            try
            {
                using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
                using (StreamReader reader = new StreamReader(response.GetResponseStream()))
                {
                    string responseJson = reader.ReadToEnd();

                    try
                    {
                        string text = ExtractGeminiText(responseJson);
                        string jsonArray = ExtractJsonArray(text);

                        if (string.IsNullOrWhiteSpace(jsonArray) || jsonArray.Trim() == "[]")
                        {
                            InsertAIInsight(
                                "GeminiFallback",
                                prompt,
                                "Gemini returned empty JSON. Demo questions were generated instead. Raw response: " + responseJson,
                                DateTime.Now.AddDays(7)
                            );

                            return BuildDemoJson(questionCount, difficulty);
                        }

                        return jsonArray;
                    }
                    catch (Exception parseEx)
                    {
                        InsertAIInsight(
                            "GeminiFallback",
                            prompt,
                            "Gemini returned no usable candidates. Demo questions were generated instead. Parse error: " + parseEx.Message + " Raw response: " + responseJson,
                            DateTime.Now.AddDays(7)
                        );

                        return BuildDemoJson(questionCount, difficulty);
                    }
                }
            }
            catch (WebException ex)
            {
                string errorBody = "";

                if (ex.Response != null)
                {
                    using (StreamReader reader = new StreamReader(ex.Response.GetResponseStream()))
                    {
                        errorBody = reader.ReadToEnd();
                    }
                }

                InsertAIInsight(
                    "GeminiError",
                    prompt,
                    "Gemini API failed. Demo questions were generated instead. Error: " + errorBody,
                    DateTime.Now.AddDays(7)
                );

                return BuildDemoJson(questionCount, difficulty);
            }
            catch (Exception ex)
            {
                InsertAIInsight(
                    "GeminiError",
                    prompt,
                    "Gemini unexpected error. Demo questions were generated instead. Error: " + ex.Message,
                    DateTime.Now.AddDays(7)
                );

                return BuildDemoJson(questionCount, difficulty);
            }
        }

        private string ExtractGeminiText(string responseJson)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            serializer.MaxJsonLength = int.MaxValue;

            Dictionary<string, object> root = serializer.Deserialize<Dictionary<string, object>>(responseJson);

            if (root == null)
            {
                throw new Exception("Gemini response could not be parsed.");
            }

            if (!root.ContainsKey("candidates"))
            {
                throw new Exception("Gemini returned no candidates.");
            }

            object[] candidates = root["candidates"] as object[];

            if (candidates == null || candidates.Length == 0)
            {
                throw new Exception("Gemini returned empty candidates.");
            }

            Dictionary<string, object> firstCandidate = candidates[0] as Dictionary<string, object>;

            if (firstCandidate == null)
            {
                throw new Exception("Invalid Gemini candidate format.");
            }

            if (!firstCandidate.ContainsKey("content"))
            {
                throw new Exception("Gemini candidate has no content.");
            }

            Dictionary<string, object> content = firstCandidate["content"] as Dictionary<string, object>;

            if (content == null || !content.ContainsKey("parts"))
            {
                throw new Exception("Gemini content has no parts.");
            }

            object[] parts = content["parts"] as object[];

            if (parts == null || parts.Length == 0)
            {
                throw new Exception("Gemini parts are empty.");
            }

            Dictionary<string, object> firstPart = parts[0] as Dictionary<string, object>;

            if (firstPart == null || !firstPart.ContainsKey("text"))
            {
                throw new Exception("Gemini part has no text.");
            }

            return Convert.ToString(firstPart["text"]);
        }

        private string ExtractJsonArray(string text)
        {
            if (string.IsNullOrWhiteSpace(text))
            {
                return "[]";
            }

            text = text.Trim();

            text = Regex.Replace(text, "^```json", "", RegexOptions.IgnoreCase).Trim();
            text = Regex.Replace(text, "^```", "", RegexOptions.IgnoreCase).Trim();
            text = Regex.Replace(text, "```$", "", RegexOptions.IgnoreCase).Trim();

            int start = text.IndexOf("[");
            int end = text.LastIndexOf("]");

            if (start >= 0 && end > start)
            {
                return text.Substring(start, end - start + 1);
            }

            return text;
        }

        private List<GeneratedQuestion> ParseGeneratedQuestions(string rawJson)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            serializer.MaxJsonLength = int.MaxValue;

            List<GeneratedQuestion> questions = null;

            try
            {
                questions = serializer.Deserialize<List<GeneratedQuestion>>(rawJson);
            }
            catch
            {
                questions = new List<GeneratedQuestion>();
            }

            if (questions == null)
            {
                questions = new List<GeneratedQuestion>();
            }

            List<GeneratedQuestion> validQuestions = new List<GeneratedQuestion>();

            foreach (GeneratedQuestion question in questions)
            {
                if (question == null)
                {
                    continue;
                }

                if (string.IsNullOrWhiteSpace(question.QuestionText))
                {
                    continue;
                }

                if (question.Options == null || question.Options.Count < 2)
                {
                    continue;
                }

                bool hasCorrect = false;

                foreach (GeneratedOption option in question.Options)
                {
                    if (option != null && option.IsCorrect)
                    {
                        hasCorrect = true;
                        break;
                    }
                }

                if (!hasCorrect)
                {
                    question.Options[0].IsCorrect = true;
                }

                List<GeneratedOption> cleanedOptions = new List<GeneratedOption>();

                foreach (GeneratedOption option in question.Options)
                {
                    if (option == null)
                    {
                        continue;
                    }

                    if (!string.IsNullOrWhiteSpace(option.OptionText))
                    {
                        cleanedOptions.Add(option);
                    }
                }

                question.Options = cleanedOptions;

                if (question.Options.Count >= 2)
                {
                    validQuestions.Add(question);
                }
            }

            return validQuestions;
        }

        private string BuildDemoJson(int questionCount, string difficulty)
        {
            List<GeneratedQuestion> demo = new List<GeneratedQuestion>();

            for (int i = 1; i <= questionCount; i++)
            {
                demo.Add(new GeneratedQuestion
                {
                    QuestionText = "Demo " + difficulty + " first aid question " + i + ": What should a responder do first in an emergency?",
                    QuestionType = "MCQ",
                    Points = 1,
                    Options = new List<GeneratedOption>
                    {
                        new GeneratedOption { OptionText = "Check scene safety and call for help if needed", IsCorrect = true },
                        new GeneratedOption { OptionText = "Move the patient immediately without assessment", IsCorrect = false },
                        new GeneratedOption { OptionText = "Give food or drink immediately", IsCorrect = false },
                        new GeneratedOption { OptionText = "Ignore the situation and wait", IsCorrect = false }
                    }
                });
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            serializer.MaxJsonLength = int.MaxValue;
            return serializer.Serialize(demo);
        }

        private int InsertAITask(int quizId, string sourceFileName, string promptUsed, string rawJson, int createdBy)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    INSERT INTO dbo.AIGeneratedTasks
                        (QuizId, SourceFileName, PromptUsed, RawJson, CreatedBy, CreatedAt)
                    VALUES
                        (@QuizId, @SourceFileName, @PromptUsed, @RawJson, @CreatedBy, GETDATE());

                    SELECT CAST(SCOPE_IDENTITY() AS int);";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@QuizId", quizId);
                    cmd.Parameters.AddWithValue("@SourceFileName", sourceFileName);
                    cmd.Parameters.AddWithValue("@PromptUsed", promptUsed);
                    cmd.Parameters.AddWithValue("@RawJson", rawJson);
                    cmd.Parameters.AddWithValue("@CreatedBy", createdBy);

                    con.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }

        private void InsertAIInsight(string category, string promptUsed, string responseText, DateTime cachedUntil)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    INSERT INTO dbo.AIInsights
                        (Category, PromptUsed, ResponseText, GeneratedAt, CachedUntil)
                    VALUES
                        (@Category, @PromptUsed, @ResponseText, GETDATE(), @CachedUntil);";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Category", category);
                    cmd.Parameters.AddWithValue("@PromptUsed", string.IsNullOrWhiteSpace(promptUsed) ? (object)DBNull.Value : promptUsed);
                    cmd.Parameters.AddWithValue("@ResponseText", string.IsNullOrWhiteSpace(responseText) ? (object)DBNull.Value : responseText);
                    cmd.Parameters.AddWithValue("@CachedUntil", cachedUntil);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void SaveGeneratedQuestions(int quizId, List<GeneratedQuestion> generatedQuestions)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                con.Open();

                using (SqlTransaction transaction = con.BeginTransaction())
                {
                    try
                    {
                        foreach (GeneratedQuestion question in generatedQuestions)
                        {
                            int questionId = InsertQuestion(con, transaction, quizId, question);

                            foreach (GeneratedOption option in question.Options)
                            {
                                if (!string.IsNullOrWhiteSpace(option.OptionText))
                                {
                                    InsertOption(con, transaction, questionId, option);
                                }
                            }
                        }

                        transaction.Commit();
                    }
                    catch
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            }
        }

        private int InsertQuestion(SqlConnection con, SqlTransaction transaction, int quizId, GeneratedQuestion question)
        {
            string query = @"
                INSERT INTO dbo.Questions
                    (QuizId, QuestionText, QuestionType, Points)
                VALUES
                    (@QuizId, @QuestionText, @QuestionType, @Points);

                SELECT CAST(SCOPE_IDENTITY() AS int);";

            using (SqlCommand cmd = new SqlCommand(query, con, transaction))
            {
                cmd.Parameters.AddWithValue("@QuizId", quizId);
                cmd.Parameters.AddWithValue("@QuestionText", question.QuestionText);
                cmd.Parameters.AddWithValue("@QuestionType", string.IsNullOrWhiteSpace(question.QuestionType) ? "MCQ" : question.QuestionType);
                cmd.Parameters.AddWithValue("@Points", question.Points <= 0 ? 1 : question.Points);

                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        private void InsertOption(SqlConnection con, SqlTransaction transaction, int questionId, GeneratedOption option)
        {
            string query = @"
                INSERT INTO dbo.Options
                    (QuestionId, OptionText, IsCorrect)
                VALUES
                    (@QuestionId, @OptionText, @IsCorrect);";

            using (SqlCommand cmd = new SqlCommand(query, con, transaction))
            {
                cmd.Parameters.AddWithValue("@QuestionId", questionId);
                cmd.Parameters.AddWithValue("@OptionText", option.OptionText);
                cmd.Parameters.AddWithValue("@IsCorrect", option.IsCorrect);

                cmd.ExecuteNonQuery();
            }
        }

        private bool InstructorOwnsQuiz(int quizId)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT COUNT(*)
                    FROM dbo.Quizzes q
                    INNER JOIN dbo.Modules m ON q.ModuleId = m.ModuleId
                    WHERE
                        q.QuizId = @QuizId
                        AND m.CreatedBy = @CreatedBy
                        AND m.IsDeleted = 0;";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@QuizId", quizId);
                    cmd.Parameters.AddWithValue("@CreatedBy", InstructorUserId);

                    con.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
                }
            }
        }

        protected List<GeneratedOption> GetPreviewOptions(object indexValue)
        {
            List<GeneratedQuestion> generatedQuestions = Session["AIGeneratedQuestions"] as List<GeneratedQuestion>;

            if (generatedQuestions == null)
            {
                return new List<GeneratedOption>();
            }

            int index = Convert.ToInt32(indexValue);

            foreach (GeneratedQuestion question in generatedQuestions)
            {
                if (question.Index == index)
                {
                    return question.Options ?? new List<GeneratedOption>();
                }
            }

            return new List<GeneratedOption>();
        }

        private void ShowMessage(string message, bool success)
        {
            lblAIStatus.Visible = true;
            lblAIStatus.Text = message;
            lblAIStatus.CssClass = success
                ? "message-box message-success d-block"
                : "message-box message-error d-block";
        }

        private void ClearMessage()
        {
            lblAIStatus.Visible = false;
            lblAIStatus.Text = "";
            lblAIStatus.CssClass = "";
        }

        [Serializable]
        public class GeneratedQuestion
        {
            public int Index { get; set; }
            public string QuestionText { get; set; }
            public string QuestionType { get; set; }
            public int Points { get; set; }
            public List<GeneratedOption> Options { get; set; }
        }

        [Serializable]
        public class GeneratedOption
        {
            public string OptionText { get; set; }
            public bool IsCorrect { get; set; }
        }
    }
}