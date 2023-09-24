using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model.Requests
{
    public class KorisniciUpdateRequest
    {
        public int id { get; set; }
        public string? Ime { get; set; }

        public string? Prezime { get; set; }

        public string? Telefon { get; set; }

        

    }
}
