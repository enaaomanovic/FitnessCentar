using System;
using System.Collections.Generic;

namespace FitnessCentar.Services.Database;

public partial class Treningi
{
    public int Id { get; set; }

    public string? Naziv { get; set; }

    public string? Opis { get; set; }

    public int? Trajanje { get; set; }

    public virtual ICollection<Raspored> Rasporeds { get; set; } = new List<Raspored>();
}
