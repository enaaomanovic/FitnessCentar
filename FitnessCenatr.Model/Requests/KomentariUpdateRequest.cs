using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model.Requests
{
    public class KomentariUpdateRequest
    {
 
        public int? NovostId { get; set; }

        public int? KorisnikId { get; set; }

        public string? Tekst { get; set; }

        public DateTime? DatumKomentara { get; set; }

        
    }
}
