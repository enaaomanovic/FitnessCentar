using Microsoft.ML.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model
{
    public class NovostiPreporuka
    {
        [KeyType(count: 27)]
        public uint NovostId { get; set; }

        [KeyType(count: 27)]
        public uint CoNovostID { get; set; }

        public float Label { get; set; }
    }
}
