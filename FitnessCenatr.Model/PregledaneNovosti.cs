using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model
{
    public class PregledaneNovosti
    {
        public int Id { get; set; }
        public Novosti Novost { get; set; }
        public int NovostId { get; set; }
        public Korisnici Korisnik { get; set; }
        public int KorisnikId { get; set; }
    }
}
