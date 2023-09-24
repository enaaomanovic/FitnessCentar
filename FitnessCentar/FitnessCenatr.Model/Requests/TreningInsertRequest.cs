using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model.Requests
{
    public class TreningInsertRequest
    {

        public string Naziv { get; set; }

        public string Opis { get; set; }

        public int Trajanje { get; set; }

       
    }
}
