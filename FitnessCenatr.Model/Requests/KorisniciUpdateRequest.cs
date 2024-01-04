using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model.Requests
{
    public class KorisniciUpdateRequest
    {
       
        public string? Ime { get; set; }

        public string? Prezime { get; set; }

        public string? Telefon { get; set; }
       
        public string? KorisnickoIme { get; set; }
        public string? Email { get; set; }

        public byte[]? Slika { get; set; }



    }
}
