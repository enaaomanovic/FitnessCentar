﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model
{
    public class Napredak
    {
        public int Id { get; set; }

        public int? KorisnikId { get; set; }


        public DateTime? DatumMjerenja { get; set; }
        public decimal? Tezina { get; set; }

    }
}
