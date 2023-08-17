using System;
using System.Collections.Generic;

namespace FitnessCentar.Services.Database;

public partial class Placanja
{
    public int Id { get; set; }

    public int? KorisnikId { get; set; }

    public DateTime? DatumPlacanja { get; set; }

    public decimal? Iznos { get; set; }

    public virtual Korisnici? Korisnik { get; set; }
}
