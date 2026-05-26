using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Newtonsoft.Json;

namespace Aidify_assigment
{
    public class AIContentService
    {
        public async Task<List<GeneratedQuestion>> GenerateQuestionsAsync(
            string knowledgeChunk, int count, string difficulty)
        {
            try
            {
                var promptPath = HttpContext.Current.Server.MapPath(
                    "~/AI/Prompts/QuizGenerator.txt");
                var template = File.ReadAllText(promptPath, Encoding.UTF8);

                var prompt = template
                    .Replace("{N}",               count.ToString())
                    .Replace("{DIFFICULTY}",       difficulty)
                    .Replace("{KNOWLEDGE_CHUNK}",  knowledgeChunk);

                var client = new GeminiClient();
                var json   = await client.GenerateAsync(prompt, jsonMode: true);

                if (string.IsNullOrEmpty(json))
                    return new List<GeneratedQuestion>();

                return JsonConvert.DeserializeObject<List<GeneratedQuestion>>(json)
                       ?? new List<GeneratedQuestion>();
            }
            catch
            {
                return new List<GeneratedQuestion>();
            }
        }
    }
}
