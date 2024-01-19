using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model.Requests
{
    public class KorisniciChangeUsername
    {
        public int Id { get; set; }
        public string Username { get; set; } = null!;
        public string NewUsername { get; set; } = null!;
    }
}
