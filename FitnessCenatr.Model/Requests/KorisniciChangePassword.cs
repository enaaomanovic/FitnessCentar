using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model.Requests
{
    public class KorisniciChangePassword
    {
        public int Id { get; set; }
        public string Password { get; set; } = null!;
        public string NewPassword { get; set; } = null!;
    }
}
