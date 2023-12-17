using System;
using System.Collections.Generic;

namespace FitnessCentar.Services.Database;

public partial class Raspored
{
    public int Id { get; set; }

    public DateTime? DatumPocetka { get; set; }

    public DateTime? DatumZavrsetka { get; set; }

    public int? TreningId { get; set; }

    public int? TrenerId { get; set; }

    public int? AktivnostId { get; set; }

    public virtual Aktivnosti? Aktivnost { get; set; }

    public virtual ICollection<Rezervacije> Rezervacijes { get; set; } = new List<Rezervacije>();

    public virtual Treneri? Trener { get; set; }

    public virtual Treningi? Trening { get; set; }

    public DayOfWeek Dan { get; set; }
}
