using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace FitnessCentar.Services.Database;

public partial class Treneri
{
    [ForeignKey(nameof(Korisnik))]
    public int Id { get; set; }

    public string? Specijalnost { get; set; }

    public virtual Korisnici Korisnik { get; set; } = null!;

    public virtual ICollection<Novosti> Novostis { get; set; } = new List<Novosti>();

    public virtual ICollection<OdgovoriNaKomentare> OdgovoriNaKomentares { get; set; } = new List<OdgovoriNaKomentare>();

    public virtual ICollection<Raspored> Rasporeds { get; set; } = new List<Raspored>();
}
