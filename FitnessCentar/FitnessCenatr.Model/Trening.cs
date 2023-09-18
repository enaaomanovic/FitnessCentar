using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model
{
    public class Trening
    {
        public int Id { get; set; }

        public string? Naziv { get; set; }

        public string? Opis { get; set; }

        public int? Trajanje { get; set; }
    }
}
