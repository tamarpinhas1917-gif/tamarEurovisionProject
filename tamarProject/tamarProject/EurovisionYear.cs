using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace tamarProject
{
    /// <summary>
    /// Represents a single year of Israel's Eurovision participation
    /// </summary>
    public class EurovisionYear
    {
        public int Year { get; set; }
        public string Artist { get; set; }
        public string ArtistEnglish { get; set; }
        public string Song { get; set; }
        public string SongEnglish { get; set; }
        public string SongHebrew { get; set; }
        public int? Rank { get; set; } // Nullable for years Israel didn't qualify
        public string Sound { get; set; }
        public string Fashion { get; set; }
        public string Language { get; set; }
        public string Choreography { get; set; }
        public List<string> Tags { get; set; }
        public string ImageUrl { get; set; }

        // Helper property to display rank nicely
        public string RankDisplay
        {
            get
            {
                if (!Rank.HasValue)
                    return "Did Not Qualify";
                
                if (Rank == 1)
                    return "🏆 1st Place - WINNER!";
                
                return $"{Rank}{GetOrdinalSuffix(Rank.Value)} Place";
            }
        }

        private string GetOrdinalSuffix(int number)
        {
            if (number <= 0) return "";
            
            switch (number % 100)
            {
                case 11:
                case 12:
                case 13:
                    return "th";
            }

            switch (number % 10)
            {
                case 1: return "st";
                case 2: return "nd";
                case 3: return "rd";
                default: return "th";
            }
        }
    }
}
