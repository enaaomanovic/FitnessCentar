using System;
using System.Collections.Generic;

namespace FitnessCentar.Services.Database;

public partial class Administracija
{
    public int Id { get; set; }

    public int? KorisnikId { get; set; }

    public int? TrenerId { get; set; }

    public string? Uloga { get; set; }

    public virtual Korisnici? Korisnik { get; set; }

    public virtual Treneri? Trener { get; set; }
}
