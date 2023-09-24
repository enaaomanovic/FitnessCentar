using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model
{
    public class Raspored
    {
        public int Id { get; set; }

        public DateTime? DatumPocetka { get; set; }

        public DateTime? DatumZavrsetka { get; set; }

        public int? TreningId { get; set; }

        public int? TrenerId { get; set; }

        public int? AktivnostId { get; set; }

       // public virtual Aktivnosti? Aktivnost { get; set; }

        public virtual ICollection<Rezervacije> Rezervacijes { get; set; } = new List<Rezervacije>();

        public virtual Treneri? Trener { get; set; }

       // public virtual Treningi? Trening { get; set; }
    }
}
