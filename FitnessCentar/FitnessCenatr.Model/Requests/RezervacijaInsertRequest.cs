using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model.Requests
{
    public class RezervacijaInsertRequest
    {
        public int? KorisnikId { get; set; }

        public int? RasporedId { get; set; }

        public string? Status { get; set; }
        public DateTime? DatumRezervacija { get; set; }
       
    }
}
