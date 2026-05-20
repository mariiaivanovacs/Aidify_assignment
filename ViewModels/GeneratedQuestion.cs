using System.Collections.Generic;
using Newtonsoft.Json;

namespace Aidify_assigment
{
    public class GeneratedQuestion
    {
        [JsonProperty("question")]    public string Question    { get; set; }
        [JsonProperty("options")]     public List<GeneratedOption> Options { get; set; }
        [JsonProperty("explanation")] public string Explanation { get; set; }

        // Alias used by the repeater's Eval("QuestionText") binding
        public string QuestionText => Question;
    }

    public class GeneratedOption
    {
        [JsonProperty("text")]       public string Text      { get; set; }
        [JsonProperty("is_correct")] public bool   IsCorrect { get; set; }
    }
}
