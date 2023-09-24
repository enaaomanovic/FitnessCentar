using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model
{
    public class Aktivnosti
    {
        public int Id { get; set; }

        public string? Naziv { get; set; }

        public virtual ICollection<Raspored> Rasporeds { get; set; } = new List<Raspored>();
    }
}
