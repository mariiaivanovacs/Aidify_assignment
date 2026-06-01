using System;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Caching;
using System.Web.Hosting;
using Newtonsoft.Json;

namespace Aidify_assigment
{
    public class AIInsightsService
    {
        private const string CacheKeyDaily = "AI_DailySummary";

        public async Task<string> GetDailySummaryAsync()
        {
            var cached = HttpRuntime.Cache[CacheKeyDaily] as string;
            if (cached != null)
                return cached;

            try
            {
                var stats = new AdminRepository().GetPlatformStats();
                var data = BuildStatsJson(stats);

                var prompt = BuildSummaryPrompt(data);

                var insight = await new GeminiClient()
                    .GenerateAsync(prompt, jsonMode: false);

                if (!string.IsNullOrWhiteSpace(insight))
                {
                    HttpRuntime.Cache.Insert(
                        CacheKeyDaily,
                        insight,
                        null,
                        DateTime.UtcNow.AddHours(24),
                        Cache.NoSlidingExpiration);
                }

                return string.IsNullOrWhiteSpace(insight)
                    ? "AI service returned no response."
                    : insight;
            }
            catch
            {
                return "AI service temporarily unavailable — please try again.";
            }
        }

        public async Task<string> AnswerQuestionAsync(string adminQuestion)
        {
            try
            {
                var stats = new AdminRepository().GetPlatformStats();
                var data = BuildStatsJson(stats);

                var promptPath = HostingEnvironment.MapPath(
                    "~/AI/Prompts/AdminInsights.txt");

                var template = File.ReadAllText(promptPath, Encoding.UTF8);

                var prompt = template
                    .Replace("{ADMIN_QUESTION}", adminQuestion)
                    .Replace("{AGGREGATED_JSON}", data);

                var answer = await new GeminiClient()
                    .GenerateAsync(prompt, jsonMode: false);

                return string.IsNullOrWhiteSpace(answer)
                    ? "AI service returned no response."
                    : answer;
            }
            catch
            {
                return "AI service temporarily unavailable — please try again.";
            }
        }

        private static string BuildStatsJson(PlatformStats stats)
        {
            return JsonConvert.SerializeObject(new
            {
                totalUsers = stats.TotalUsers,
                activeLearners = stats.ActiveLearners,
                totalInstructors = stats.TotalInstructors,

                totalModules = stats.TotalModules,
                publishedModules = stats.PublishedModules,
                draftModules = stats.DraftModules,
                pendingModules = stats.PendingModules,

                totalAttempts = stats.TotalAttempts,
                completedLessons = stats.CompletedLessons,
                expectedCompletions = stats.ExpectedCompletions,
                completionRate = stats.CompletionRate
            });
        }

        private static string BuildSummaryPrompt(string dataJson)
        {
            return
                "You are an analytics assistant for the Aidify first-aid learning platform. " +
                "Here is today's platform data: " + dataJson + ". " +
                "Write a concise 2-3 sentence daily summary highlighting the most important metric " +
                "and one actionable recommendation. Do not invent data.";
        }
    }
}