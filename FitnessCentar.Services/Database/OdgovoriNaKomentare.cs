using System;
using System.Collections.Generic;

namespace FitnessCentar.Services.Database;

public partial class OdgovoriNaKomentare
{
    public int Id { get; set; }

    public int? KomentarId { get; set; }

    public int? TrenerId { get; set; }

    public string? Tekst { get; set; }

    public DateTime? DatumOdgovora { get; set; }

    public virtual Komentari? Komentar { get; set; }

    public virtual Treneri? Trener { get; set; }
}
