using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model.Requests
{
    public class OdgovoriNaKomentareInsertRequest
    {
       
        public int KomentarId { get; set; }

        public int TrenerId { get; set; }

        public string Tekst { get; set; }

        public DateTime? DatumOdgovora { get; set; }

    }
}
