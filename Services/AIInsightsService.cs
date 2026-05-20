using System;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Caching;
using Newtonsoft.Json;

namespace Aidify_assigment
{
    public class AIInsightsService
    {
        private const string CacheKeyDaily = "AI_DailySummary";

        // Returns a cached (24 h) plain-text summary based on platform stats.
        public async Task<string> GetDailySummaryAsync()
        {
            var cached = HttpRuntime.Cache[CacheKeyDaily] as string;
            if (cached != null) return cached;

            try
            {
                var stats = new AdminRepository().GetPlatformStats();
                var data  = JsonConvert.SerializeObject(new
                {
                    totalUsers     = stats.TotalUsers,
                    activeLearners = stats.ActiveLearners,
                    pendingModules = stats.PendingModules,
                    totalAttempts  = stats.TotalAttempts
                });

                var prompt  = BuildSummaryPrompt(data);
                var insight = await new GeminiClient().GenerateAsync(prompt, jsonMode: false);

                if (!string.IsNullOrWhiteSpace(insight))
                    HttpRuntime.Cache.Insert(CacheKeyDaily, insight, null,
                        DateTime.UtcNow.AddHours(24), Cache.NoSlidingExpiration);

                return insight ?? "AI service temporarily unavailable.";
            }
            catch
            {
                return "AI service temporarily unavailable.";
            }
        }

        // Answers a specific admin question using current aggregate data.
        public async Task<string> AnswerQuestionAsync(string adminQuestion)
        {
            try
            {
                var stats = new AdminRepository().GetPlatformStats();
                var data  = JsonConvert.SerializeObject(new
                {
                    totalUsers     = stats.TotalUsers,
                    activeLearners = stats.ActiveLearners,
                    pendingModules = stats.PendingModules,
                    totalAttempts  = stats.TotalAttempts
                });

                var promptPath = HttpContext.Current.Server.MapPath(
                    "~/AI/Prompts/AdminInsights.txt");
                var template = File.ReadAllText(promptPath, Encoding.UTF8);

                var prompt = template
                    .Replace("{ADMIN_QUESTION}",   adminQuestion)
                    .Replace("{AGGREGATED_JSON}",  data);

                var answer = await new GeminiClient().GenerateAsync(prompt, jsonMode: false);
                return answer ?? "AI service temporarily unavailable.";
            }
            catch
            {
                return "AI service temporarily unavailable.";
            }
        }

        private static string BuildSummaryPrompt(string dataJson) =>
            "You are an analytics assistant for the Aidify first-aid learning platform. " +
            "Here is today's platform data: " + dataJson + ". " +
            "Write a concise 2-3 sentence daily summary highlighting the most important " +
            "metric and one actionable recommendation. Do not invent data.";
    }
}
