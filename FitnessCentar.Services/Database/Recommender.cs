using Stripe;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Services.Database
{
    public class Recommender
    {
        public int Id { get; set; }
        public int NovostId { get; set; }
        public int CoNovostId1 { get; set; }
        public int CoNovostId2 { get; set; }
        public int CoNovostId3 { get; set; }


    }
}
