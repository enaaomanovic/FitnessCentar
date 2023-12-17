using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model.Requests
{
    public class TrenerUpdateRequest
    {
        public int Id { get; set; }

        public string? Ime { get; set; }

        public string? Prezime { get; set; }

        public string? Specijalnost { get; set; }

        
    }
}
