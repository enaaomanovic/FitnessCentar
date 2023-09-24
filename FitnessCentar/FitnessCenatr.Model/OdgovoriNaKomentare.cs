using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model
{
    public class OdgovoriNaKomentare
    {
        public int Id { get; set; }

        public int? KomentarId { get; set; }

        public int? TrenerId { get; set; }

        public string? Tekst { get; set; }

        public DateTime? DatumOdgovora { get; set; }

      

    }
}
