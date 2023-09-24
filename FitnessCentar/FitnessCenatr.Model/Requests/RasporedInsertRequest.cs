using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model.Requests
{
    public class RasporedInsertRequest
    {
      
        public DateTime? DatumPocetka { get; set; }

        public DateTime? DatumZavrsetka { get; set; }

        public int? TreningId { get; set; }

        public int? TrenerId { get; set; }

        public int? AktivnostId { get; set; }



    }
}
