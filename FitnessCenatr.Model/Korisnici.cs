using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model
{
    public partial class Korisnici
    {
        public int Id { get; set; }

        public string? Ime { get; set; }

        public string? Prezime { get; set; }

        public string? KorisnickoIme { get; set; }

        // public string? Lozinka { get; set; }

        public string? Email { get; set; }

        public string? Telefon { get; set; }

        public DateTime? DatumRegistracije { get; set; }

        public DateTime? DatumRodjenja { get; set; }

        public string? Pol { get; set; }

        public decimal? Tezina { get; set; }

        public decimal? Visina { get; set; }

        public virtual Treneri Trener { get; set; } = null!;
        public byte[]? Slika { get; set; }

        //   public virtual ICollection<Administracija> Administracijas { get; set; } = new List<Administracija>();

        //  public virtual ICollection<Komentari> Komentaris { get; set; } = new List<Komentari>();

        // public virtual ICollection<Napredak> Napredaks { get; set; } = new List<Napredak>();

        // public virtual ICollection<Placanja> Placanjas { get; set; } = new List<Placanja>();

        //public virtual ICollection<Rezervacije> Rezervacijes { get; set; } = new List<Rezervacije>();
    }
}
