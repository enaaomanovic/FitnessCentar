using System;
using System.Collections.Generic;

namespace FitnessCentar.Services.Database;

public partial class Komentari
{
    public int Id { get; set; }

    public int? NovostId { get; set; }

    public int? KorisnikId { get; set; }

    public string? Tekst { get; set; }

    public DateTime? DatumKomentara { get; set; }

    public virtual Korisnici? Korisnik { get; set; }

    public virtual Novosti? Novost { get; set; }

    public virtual ICollection<OdgovoriNaKomentare> OdgovoriNaKomentares { get; set; } = new List<OdgovoriNaKomentare>();
}
