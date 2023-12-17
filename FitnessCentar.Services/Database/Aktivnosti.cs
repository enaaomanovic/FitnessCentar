using System;
using System.Collections.Generic;

namespace FitnessCentar.Services.Database;

public partial class Aktivnosti
{
    public int Id { get; set; }

    public string? Naziv { get; set; }

    public virtual ICollection<Raspored> Rasporeds { get; set; } = new List<Raspored>();
}
