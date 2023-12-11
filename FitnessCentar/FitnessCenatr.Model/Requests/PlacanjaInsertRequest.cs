using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model.Requests
{
    public class PlacanjaInsertRequest
    {
        
        public int? KorisnikId { get; set; }

        public DateTime? DatumPlacanja { get; set; }

        public decimal? Iznos { get; set; }
    
        public string? PaymentIntentId { get; set; }

        public List<int> RezervacijeId { get; set; } = new();



    }
}
