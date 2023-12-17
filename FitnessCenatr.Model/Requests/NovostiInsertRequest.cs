using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model.Requests
{
    public class NovostiInsertRequest
    {
        public string Naslov { get; set; }

        public string Tekst { get; set; }
        public DateTime? DatumObjave { get; set; }

        public int? AutorId { get; set; }

    }
}
