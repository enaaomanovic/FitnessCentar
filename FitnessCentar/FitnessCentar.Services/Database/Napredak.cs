using System;
using System.Collections.Generic;

namespace FitnessCentar.Services.Database;

public partial class Napredak
{
    public int Id { get; set; }

    public int? KorisnikId { get; set; }

    public DateTime? DatumMjerenja { get; set; }

    public decimal? Tezina { get; set; }

    public decimal? Visina { get; set; }

    public virtual Korisnici? Korisnik { get; set; }
}
