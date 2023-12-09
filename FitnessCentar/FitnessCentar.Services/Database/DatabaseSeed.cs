using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Services.Database
{
    public partial class Ib200005rs2Context
    {
        private readonly DateTime _dateTime = new(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local);


        private void SeedData(ModelBuilder modelBuilder)
        {
            SeedTreneri(modelBuilder);
            SeedKorisnici(modelBuilder);
            SeedNovosti(modelBuilder);
        }

        private void SeedTreneri(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Treneri>().HasData(
                 new Treneri()
                 {
                     Id = 1,
                     Specijalnost = "Personalni trener"
                 }
            );
        }

        private void SeedKorisnici(ModelBuilder modelBuilder)
        {
            //var salt = KorisniciService.GenerateSalt();
            //var password = KorisniciService.GenerateHash(salt, "test");

            var hash = new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 };
            var salt = new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 };

            modelBuilder.Entity<Korisnici>().HasData(
                 new Korisnici()
                 {
                     Id = 1,
                     Ime = "Selma",
                     Prezime = "Kovacevic",
                     KorisnickoIme = "Selma",
                     LozinkaHash = hash,
                     LozinkaSalt = salt,
                     DatumRegistracije = new DateTime(2023, 12, 9),
                     DatumRodjenja = new DateTime(2000, 1, 1),
                     Email = "selma.kovacevic@gmail.com",
                     Telefon = "061123123",
                     Pol = "Ženski",
                     Tezina = 60,
                     Visina = 165,
                 },
                 new Korisnici()
                 {
                     Id = 2,
                     Ime = "Vildana",
                     Prezime = "Šuta",
                     KorisnickoIme = "Vildana",
                     LozinkaHash = hash,
                     LozinkaSalt = salt,
                     DatumRegistracije = new DateTime(2023, 12, 9),
                     DatumRodjenja = new DateTime(2000, 1, 1),
                     Email = "vildana.suta@gmail.com",
                     Telefon = "061123123",
                     Pol = "Ženski",
                     Tezina = 60,
                     Visina = 165,
                 }
            );
        }

        private void SeedNovosti(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Novosti>().HasData(
                 new Novosti()
                 {
                     Id = 1,
                     Naslov = "Obavještenje za sve aktivne clanove centra!!!",
                     Tekst = "Obavještavaju se svi clanovi fitness centra da centar nece raditi 26.10.2023 godine. Buduci da renoviramo fitness centar neophodno je bilo da zatvorimo centar na jedan dan kako bi realizacija renoviranja bila moguca.Svi koji propuste svoje termine moci ce ih nadoknaditi u terminima narednih dana. Hvala na razumijevanju.",
                     DatumObjave = new DateTime(2023, 10, 25, 17, 55, 40),
                     AutorId = 1
                 },
                 new Novosti()
                 {
                     Id = 2,
                     Naslov = "Novi zdravi recept!",
                     Tekst = "Pozdrav svim clanovima našeg centra. Danas sam isprobala jedan zdravi i brzi recept te sam odlucila da ga podjelim i sa vama. Radi se o salati od tune, ja sam koristila dodatno zelenu salatu, krastavce, kukuruz i mrkvu. Obrok je bio proteinski obogacen niskokalorican ali ipak dovoljno zasitan. Javite mi vaše utiske.",
                     DatumObjave = new DateTime(2023, 10, 26, 18, 22, 34),
                     AutorId = 1
                 }
            );
        }

    }
}
