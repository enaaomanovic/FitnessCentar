using System;
using System.Collections.Generic;

namespace FitnessCentar.Services.Database;

public partial class Novosti
{
    public int Id { get; set; }

    public string? Naslov { get; set; }

    public string? Tekst { get; set; }

    public DateTime? DatumObjave { get; set; }

    public int? AutorId { get; set; }

    public virtual Treneri? Autor { get; set; }

    public virtual ICollection<Komentari> Komentaris { get; set; } = new List<Komentari>();
}
