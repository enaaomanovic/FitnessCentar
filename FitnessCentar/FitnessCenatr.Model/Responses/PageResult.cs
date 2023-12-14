using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model.Responses
{
    public class PageResult<TDb> where TDb : class
    {

        public List<TDb> Result { get; set; }

        public int Count { get; set; }




    }
}
