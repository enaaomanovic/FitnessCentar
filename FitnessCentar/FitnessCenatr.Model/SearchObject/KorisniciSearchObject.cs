using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model.SearchObject
{
    public class KorisniciSearchObject : BaseSearchObject
    {
        public string? Ime { get; set; }
        public bool IsTrener { get; set; } = false;
    }
}
