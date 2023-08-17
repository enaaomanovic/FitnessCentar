using System;
using System.Collections.Generic;

namespace FitnessCentar.Services.Database;

public partial class Treneri
{
    public int Id { get; set; }

    public string? Ime { get; set; }

    public string? Prezime { get; set; }

    public string? Specijalnost { get; set; }

    public virtual ICollection<Administracija> Administracijas { get; set; } = new List<Administracija>();

    public virtual ICollection<Novosti> Novostis { get; set; } = new List<Novosti>();

    public virtual ICollection<OdgovoriNaKomentare> OdgovoriNaKomentares { get; set; } = new List<OdgovoriNaKomentare>();

    public virtual ICollection<Raspored> Rasporeds { get; set; } = new List<Raspored>();
}
