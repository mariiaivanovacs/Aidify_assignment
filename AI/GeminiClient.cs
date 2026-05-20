using System;
using System.Configuration;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json.Linq;

namespace Aidify_assigment
{
    // Shared Gemini 1.5 Flash client — server-side only, never expose API key to browser.
    public class GeminiClient
    {
        private static readonly HttpClient _http = new HttpClient();
        private readonly string _apiKey = ConfigurationManager.AppSettings["GeminiApiKey"];

        public async Task<string> GenerateAsync(string prompt, bool jsonMode = true)
        {
            var url = "https://generativelanguage.googleapis.com/v1beta/models/" +
                      "gemini-1.5-flash:generateContent?key=" + _apiKey;

            var body = Newtonsoft.Json.JsonConvert.SerializeObject(new
            {
                contents = new[] { new { parts = new[] { new { text = prompt } } } },
                generationConfig = new
                {
                    response_mime_type = jsonMode ? "application/json" : "text/plain",
                    temperature = 0.4
                }
            });

            var content = new StringContent(body, Encoding.UTF8, "application/json");
            var resp = await _http.PostAsync(url, content);
            resp.EnsureSuccessStatusCode();

            var raw    = await resp.Content.ReadAsStringAsync();
            var parsed = JObject.Parse(raw);
            return parsed["candidates"][0]["content"]["parts"][0]["text"].ToString();
        }
    }
}
