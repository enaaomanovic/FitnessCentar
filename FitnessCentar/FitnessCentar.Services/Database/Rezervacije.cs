using System;
using System.Collections.Generic;

namespace FitnessCentar.Services.Database;

public partial class Rezervacije
{
    public int Id { get; set; }

    public int? KorisnikId { get; set; }

    public int? RasporedId { get; set; }

    public string? Status { get; set; }

    public DateTime? DatumRezervacija { get; set; }

    public virtual Korisnici? Korisnik { get; set; }

    public virtual Raspored? Raspored { get; set; }
}
