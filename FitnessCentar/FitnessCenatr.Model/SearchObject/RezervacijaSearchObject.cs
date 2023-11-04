using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model.SearchObject
{
    public class RezervacijaSearchObject:BaseSearchObject
    {
        public int? rasporedId { get; set; }

        public int? korisnikId { get; set; }

    }
}
