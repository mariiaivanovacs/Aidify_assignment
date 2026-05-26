using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Aidify_assigment
{
    public class QuizDto
    {
        public int    QuizId { get; set; }
        public string Title  { get; set; }
    }

    public class QuizRepository
    {
        // Gets all quizzes that belong to modules created by this instructor.
        public List<QuizDto> GetByInstructor(int userId)
        {
            var list = new List<QuizDto>();
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    SELECT q.QuizId, q.Title
                    FROM   Quizzes q
                    JOIN   Modules m ON m.ModuleId = q.ModuleId
                    WHERE  m.CreatedBy = @UserId AND m.IsDeleted = 0
                    ORDER BY q.Title", conn);
                cmd.Parameters.AddWithValue("@UserId", userId);

                using (var r = cmd.ExecuteReader())
                    while (r.Read())
                        list.Add(new QuizDto
                        {
                            QuizId = (int)r["QuizId"],
                            Title  = r["Title"].ToString()
                        });
            }
            return list;
        }

        // Inserts an MCQ question into the specified quiz. Returns the new QuestionId.
        public int AddQuestion(int quizId, string text,
                               SqlConnection conn, SqlTransaction tx)
        {
            var cmd = new SqlCommand(@"
                INSERT INTO Questions (QuizId, QuestionText, QuestionType, Points)
                OUTPUT INSERTED.QuestionId
                VALUES (@QuizId, @Text, 'MCQ', 1)", conn, tx);
            cmd.Parameters.AddWithValue("@QuizId", quizId);
            cmd.Parameters.AddWithValue("@Text",   text);
            return (int)cmd.ExecuteScalar();
        }

        // Inserts one answer option for a question.
        public void AddOption(int questionId, string text, bool isCorrect,
                              SqlConnection conn, SqlTransaction tx)
        {
            var cmd = new SqlCommand(@"
                INSERT INTO Options (QuestionId, OptionText, IsCorrect)
                VALUES (@Qid, @Text, @Correct)", conn, tx);
            cmd.Parameters.AddWithValue("@Qid",    questionId);
            cmd.Parameters.AddWithValue("@Text",    text ?? "");
            cmd.Parameters.AddWithValue("@Correct", isCorrect);
            cmd.ExecuteNonQuery();
        }

        // Records an AI generation event for the audit trail.
        public void SaveAITask(int quizId, string fileName,
                               string prompt, string rawJson, int createdBy)
        {
            using (var conn = DbHelper.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    INSERT INTO AIGeneratedTasks
                        (QuizId, SourceFileName, PromptUsed, RawJson, CreatedBy)
                    VALUES (@QuizId, @File, @Prompt, @Json, @By)", conn);
                cmd.Parameters.AddWithValue("@QuizId", quizId > 0 ? (object)quizId : DBNull.Value);
                cmd.Parameters.AddWithValue("@File",   fileName ?? "");
                cmd.Parameters.AddWithValue("@Prompt", prompt   ?? "");
                cmd.Parameters.AddWithValue("@Json",   rawJson  ?? "");
                cmd.Parameters.AddWithValue("@By",     createdBy);
                cmd.ExecuteNonQuery();
            }
        }
    }
}
