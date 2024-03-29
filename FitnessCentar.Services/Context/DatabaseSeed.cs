﻿using Microsoft.EntityFrameworkCore;
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
            SeedAktivnosti(modelBuilder);
            SeedKomentari(modelBuilder);
            SeedOdgovoriNaKomentare(modelBuilder);
            SeedNapredak(modelBuilder);
            SeedTreninzi(modelBuilder);
            SeedRaspored(modelBuilder);
            SeedRezervacije(modelBuilder);
            SeedPlacanje(modelBuilder);
            SeedPregledanaNovost(modelBuilder);
        }

        private void SeedTreneri(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Treneri>().HasData(
                 new Treneri()
                 {
                     Id = 1,
                     Specijalnost = "Personalni trener"
                 },
            new Treneri()
            {
                Id = 2,
                Specijalnost = "Magistrirani Personalni trener"
            },
                             new Treneri()
                             {
                                 Id = 3,
                                 Specijalnost = "Stručni trener"
                             }
            );
        }
        private void SeedPlacanje(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Placanja>().HasData(
                 new Placanja()
                 {
                     Id = 1,

                     KorisnikId = 8,

                     DatumPlacanja = new DateTime(2024, 03, 25),

                     Iznos = 15,
                     TxnId = "test010920001"
                 },
                  new Placanja()
                  {
                      Id = 2,

                      KorisnikId = 4,

                      DatumPlacanja = new DateTime(2023, 10, 27),

                      Iznos = 15,
                      TxnId = "test010920002"
                  }
             

            );
        }

        private void SeedKorisnici(ModelBuilder modelBuilder)
        {
            //var salt = KorisniciService.GenerateSalt();
            //var password = KorisniciService.GenerateHash(salt, "test");

            var hash = new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 };
            var salt = new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 };
            var slika = File.ReadAllBytes("rs2.jpg");
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
                     Ime = "Admin",
                     Prezime = "Admin",
                     KorisnickoIme = "Admin",
                     LozinkaHash = hash,
                     LozinkaSalt = salt,
                     DatumRegistracije = new DateTime(2023, 12, 9),
                     DatumRodjenja = new DateTime(2000, 1, 1),
                     Email = "admin.admin@gmail.com",
                     Telefon = "061123123",
                     Pol = "Ženski",
                     Tezina = 60,
                     Visina = 165,
                 },
            new Korisnici()
            {
                Id = 3,
                Ime = "Husein",
                Prezime = "Maric",
                KorisnickoIme = "Huso",
                LozinkaHash = hash,
                LozinkaSalt = salt,
                DatumRegistracije = new DateTime(2023, 12, 10),
                DatumRodjenja = new DateTime(2000, 2, 1),
                Email = "husein.maric@gmail.com",
                Telefon = "062545896",
                Pol = "Muški",
                Tezina = 90,
                Visina = 190,
            },
                  new Korisnici()
                  {
                      Id = 4,
                      Ime = "Benjamin",
                      Prezime = "Omanovic",
                      KorisnickoIme = "Benjo",
                      LozinkaHash = hash,
                      LozinkaSalt = salt,
                      DatumRegistracije = new DateTime(2023, 12, 10),
                      DatumRodjenja = new DateTime(2000, 1, 2),
                      Email = "benjamin.omanovic@gmail.com",
                      Telefon = "062545698",
                      Pol = "Muški",
                      Tezina = 88,
                      Visina = 192,
                  },
                        new Korisnici()
                        {
                            Id = 5,
                            Ime = "Sanela",
                            Prezime = "Omanovic",
                            KorisnickoIme = "Sanela",
                            LozinkaHash = hash,
                            LozinkaSalt = salt,
                            DatumRegistracije = new DateTime(2023, 12, 10),
                            DatumRodjenja = new DateTime(1977, 12, 7),
                            Email = "sanela.omanovic@gmail.com",
                            Telefon = "062548521",
                            Pol = "Ženski",
                            Tezina = 70,
                            Visina = 175,
                        },
                              new Korisnici()
                              {
                                  Id = 6,
                                  Ime = "Bakir",
                                  Prezime = "Leto",
                                  KorisnickoIme = "Bakir",
                                  LozinkaHash = hash,
                                  LozinkaSalt = salt,
                                  DatumRegistracije = new DateTime(2023, 12, 9),
                                  DatumRodjenja = new DateTime(2000, 1, 1),
                                  Email = "bakir.leto@gmail.com",
                                  Telefon = "061254569",
                                  Pol = "Muški",
                                  Tezina = 88,
                                  Visina = 190,
                              },
                              new Korisnici()
                              {
                                  Id = 7,
                                  Ime = "Faruk",
                                  Prezime = "Tinjak",
                                  KorisnickoIme = "Faruk",
                                  LozinkaHash = hash,
                                  LozinkaSalt = salt,
                                  DatumRegistracije = new DateTime(2023, 12, 10),
                                  DatumRodjenja = new DateTime(1996, 2, 4),
                                  Email = "faruk.tinjak@gmail.com",
                                  Telefon = "062548865",
                                  Pol = "Muški",
                                  Tezina = 88,
                                  Visina = 190,
                              },
                              new Korisnici()
                              {
                                  Id = 8,
                                  Ime = "Ena",
                                  Prezime = "Omanovic",
                                  KorisnickoIme = "Ena",
                                  LozinkaHash = hash,
                                  LozinkaSalt = salt,
                                  DatumRegistracije = new DateTime(2023, 12, 9),
                                  DatumRodjenja = new DateTime(2000, 1, 1),
                                  Email = "ena.omanovic@gamil.com",
                                  Telefon = "062548895",
                                  Pol = "Ženski",
                                  Tezina = 60,
                                  Visina = 170,
                                  Slika = slika
                              },
                              new Korisnici()
                              {
                                  Id = 9,
                                  Ime = "User",
                                  Prezime = "User",
                                  KorisnickoIme = "User",
                                  LozinkaHash = hash,
                                  LozinkaSalt = salt,
                                  DatumRegistracije = new DateTime(2023, 12, 10),
                                  DatumRodjenja = new DateTime(2000, 2, 1),
                                  Email = "user.user@gmail.com",
                                  Telefon = "063456734",
                                  Pol = "Muški",
                                  Tezina = 90,
                                  Visina = 190,
                              },
                              new Korisnici()
                              {
                                  Id = 10,
                                  Ime = "Amna",
                                  Prezime = "Kazimic",
                                  KorisnickoIme = "Amina",
                                  LozinkaHash = hash,
                                  LozinkaSalt = salt,
                                  DatumRegistracije = new DateTime(2023, 12, 10),
                                  DatumRodjenja = new DateTime(2000, 2, 1),
                                  Email = "amna.kazicim@gmail.com",
                                  Telefon = "062545896",
                                  Pol = "Ženski",
                                  Tezina = 60,
                                  Visina = 170,
                              },
                              new Korisnici()
                              {
                                  Id = 11,
                                  Ime = "Enes",
                                  Prezime = "Omanovic",
                                  KorisnickoIme = "Enes",
                                  LozinkaHash = hash,
                                  LozinkaSalt = salt,
                                  DatumRegistracije = new DateTime(2023, 12, 10),
                                  DatumRodjenja = new DateTime(2000, 2, 1),
                                  Email = "enes.omanovic@gmail.com",
                                  Telefon = "063456734",
                                  Pol = "Muški",
                                  Tezina = 80,
                                  Visina = 180,
                              },
                              new Korisnici()
                              {
                                  Id = 12,
                                  Ime = "Sara",
                                  Prezime = "Maric",
                                  KorisnickoIme = "Sara",
                                  LozinkaHash = hash,
                                  LozinkaSalt = salt,
                                  DatumRegistracije = new DateTime(2023, 12, 10),
                                  DatumRodjenja = new DateTime(2000, 2, 1),
                                  Email = "sara.maric@gmail.com",
                                  Telefon = "062545896",
                                  Pol = "Ženski",
                                  Tezina = 50,
                                  Visina = 160,
                              },
                              new Korisnici()
                              {
                                  Id = 13,
                                  Ime = "Hana",
                                  Prezime = "Maric",
                                  KorisnickoIme = "Hana",
                                  LozinkaHash = hash,
                                  LozinkaSalt = salt,
                                  DatumRegistracije = new DateTime(2023, 12, 10),
                                  DatumRodjenja = new DateTime(2000, 2, 1),
                                  Email = "hana.maric@gmail.com",
                                  Telefon = "063456734",
                                  Pol = "Ženski",
                                  Tezina = 52,
                                  Visina = 170,
                              },
                              new Korisnici()
                              {
                                  Id = 14,
                                  Ime = "Nejra",
                                  Prezime = "Maric",
                                  KorisnickoIme = "Nejra",
                                  LozinkaHash = hash,
                                  LozinkaSalt = salt,
                                  DatumRegistracije = new DateTime(2023, 12, 10),
                                  DatumRodjenja = new DateTime(2000, 2, 1),
                                  Email = "nejra.maric@gmail.com",
                                  Telefon = "062545896",
                                  Pol = "Ženski",
                                  Tezina = 50,
                                  Visina = 160,
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
                 },
                 new Novosti()
                 {
                     Id = 3,
                     Naslov = "DaniSporta",
                     Tekst = "Obavještavamo vas da ce se 10.12.2023 u našem centru održati dani sporta. Centar ce tog dana moci posjetiti svi clanovi fitnes centra besplatno. Takoder bice pice dobrodošlice, vrijeme cemo provoditi vježbajuci. Radujemo se da vas vidimo u velikom broju.",
                     DatumObjave = new DateTime(2023, 10, 26, 18, 22, 34),
                     AutorId = 3
                 },
                 new Novosti()
                 {
                     Id = 4,
                     Naslov = "Slobodan dan ",
                     Tekst = "Obavještavamo sve korisnike centra da centar nece raditi 1.1.2024,2.1.2024 i 3.1.2024. Razlog zatvaranja centra su novogodišnji praznici.Zahvaljujemo se na razumjevanju",
                     DatumObjave = new DateTime(2023, 10, 26, 18, 22, 34),
                     AutorId = 3
                 },
                 new Novosti()
                 {
                     Id = 5,
                     Naslov = "Zadravi doručak:Ovsena kaša",
                     Tekst = "Oduševljavamo vas najnovijim receptom za zdravu ovsenu kasu- Nova Ovsena Kaša! Sada možete započeti svoj dan zdravim doručkom koji će vam pružiti potrebnu energiju za uspješan trening.Ovsena kaša obogaćena je nutritivnim sastojcima, voćem i orašastim plodovima.Isprobajte ovu ukusnu i hranjivu opciju za doručak!",
                     DatumObjave = new DateTime(2023, 10, 26, 18, 22, 34),
                     AutorId = 2
                 },
                 new Novosti()
                 {
                     Id = 6,
                     Naslov = "Dan žena",
                     Tekst = "Molimo sve članice našeg fitness centra da sa puta pokupe svoje poklone za dan žena ukoiko to već nisu uradile.",
                     DatumObjave = new DateTime(2023, 10, 26, 18, 22, 34),
                     AutorId = 1
                 },
                 new Novosti()
                 {
                     Id = 7,
                     Naslov = "Otkazan kružni trening",
                     Tekst = "Obavještavamo sve korisnike centra da se trener razbolio, te se kružni treninzi danas neće održati.Hvala na razumjevanju",
                     DatumObjave = new DateTime(2023, 10, 26, 18, 22, 34),
                     AutorId = 3
                 }
            );
        }
        private void SeedAktivnosti(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Aktivnosti>().HasData(
                 new Aktivnosti()
                 {
                     Id = 4,
                     Naziv = "Veoma intezivno"
                 },
                 new Aktivnosti()
                 {
                     Id = 5,
                     Naziv = "Intezivno"
                 },
                 new Aktivnosti()
                 {
                     Id = 6,
                     Naziv = "Umjereno"
                 },
                 new Aktivnosti()
                 {
                     Id = 7,
                     Naziv = "Lagan tempo"
                 }
            );
        }

        private void SeedKomentari(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Komentari>().HasData(
                 new Komentari()
                 {
                     Id = 1,
                     NovostId = 1,
                     KorisnikId = 4,
                     Tekst = "Nema problema, nadoknaditi cemo termine",
                     DatumKomentara = new DateTime(2023, 12, 12, 10, 55, 40),
                 },
                 new Komentari()
                 {
                     Id = 2,
                     NovostId = 2,
                     KorisnikId = 5,
                     Tekst = "Recept je odličan",
                     DatumKomentara = new DateTime(2023, 12, 12, 13, 20, 10),
                 }

            );
        }


        private void SeedOdgovoriNaKomentare(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<OdgovoriNaKomentare>().HasData(
                 new OdgovoriNaKomentare()
                 {
                     Id = 1,
                     KomentarId = 1,
                     TrenerId = 1,
                     Tekst = "Drago nam je to čuti",
                     DatumOdgovora = new DateTime(2023, 12, 12, 13, 20, 10),

                 },
                 new OdgovoriNaKomentare()
                 {
                     Id = 2,
                     KomentarId = 2,
                     TrenerId = 1,
                     Tekst = "Drago nam je to čuti",
                     DatumOdgovora = new DateTime(2023, 12, 12, 13, 20, 20),
                 }

            );
        }


        private void SeedNapredak(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Napredak>().HasData(
                 new Napredak()
                 {
                     Id = 1,
                     KorisnikId = 4,
                     DatumMjerenja = new DateTime(2023, 12, 14, 13, 20, 30),
                     Visina = null,
                     Tezina = 90


                 },
                 new Napredak()
                 {
                     Id = 2,
                     KorisnikId = 4,
                     DatumMjerenja = new DateTime(2024, 1, 14, 13, 20, 30),
                     Visina = null,
                     Tezina = 86


                 },
                   new Napredak()
                   {
                       Id = 3,
                       KorisnikId = 4,
                       DatumMjerenja = new DateTime(2024, 2, 14, 13, 20, 30),
                       Visina = null,
                       Tezina = 76


                   },
                   new Napredak()
                   {
                       Id = 4,
                       KorisnikId = 5,
                       DatumMjerenja = new DateTime(2024, 1, 14, 13, 20, 30),
                       Visina = null,
                       Tezina = 76
                   },
                   new Napredak()
                   {
                       Id = 5,
                       KorisnikId = 5,
                       DatumMjerenja = new DateTime(2024, 2, 14, 13, 20, 30),
                       Visina = null,
                       Tezina = 73
                   }
                   ,
                   new Napredak()
                   {
                       Id = 6,
                       KorisnikId = 6,
                       DatumMjerenja = new DateTime(2024, 1, 14, 13, 20, 30),
                       Visina = null,
                       Tezina = 85
                   }
                   ,
                   new Napredak()
                   {
                       Id = 7,
                       KorisnikId = 6,
                       DatumMjerenja = new DateTime(2024, 2, 14, 13, 20, 30),
                       Visina = null,
                       Tezina = 82
                   },
                   new Napredak()
                   {
                       Id = 8,
                       KorisnikId = 7,
                       DatumMjerenja = new DateTime(2024, 1, 14, 13, 20, 30),
                       Visina = null,
                       Tezina = 82
                   },
                   new Napredak()
                   {
                       Id = 9,
                       KorisnikId = 7,
                       DatumMjerenja = new DateTime(2024, 2, 14, 13, 20, 30),
                       Visina = null,
                       Tezina = 80
                   }
                   ,
                   new Napredak()
                   {
                       Id = 10,
                       KorisnikId = 8,
                       DatumMjerenja = new DateTime(2024, 1, 14, 13, 20, 30),
                       Visina = null,
                       Tezina = 62
                   },
                   new Napredak()
                   {
                       Id = 11,
                       KorisnikId = 8,
                       DatumMjerenja = new DateTime(2024, 2, 14, 13, 20, 30),
                       Visina = null,
                       Tezina = 64
                   },
                   new Napredak()
                   {
                       Id = 12,
                       KorisnikId = 9,
                       DatumMjerenja = new DateTime(2024, 1, 14, 13, 20, 30),
                       Visina = null,
                       Tezina = 85
                   },
                   new Napredak()
                   {
                       Id = 13,
                       KorisnikId = 9,
                       DatumMjerenja = new DateTime(2024, 2, 14, 13, 20, 30),
                       Visina = null,
                       Tezina = 87
                   }
                   ,
                   new Napredak()
                   {
                       Id = 14,
                       KorisnikId = 10,
                       DatumMjerenja = new DateTime(2024, 1, 14, 13, 20, 30),
                       Visina = null,
                       Tezina = 57
                   },
                   new Napredak()
                   {
                       Id = 15,
                       KorisnikId = 10,
                       DatumMjerenja = new DateTime(2024, 2, 14, 13, 20, 30),
                       Visina = null,
                       Tezina = 62
                   },
                   new Napredak()
                   {
                       Id = 16,
                       KorisnikId = 11,
                       DatumMjerenja = new DateTime(2024, 1, 14, 13, 20, 30),
                       Visina = null,
                       Tezina = 72
                   },
                   new Napredak()
                   {
                       Id = 17,
                       KorisnikId = 11,
                       DatumMjerenja = new DateTime(2024, 2, 14, 13, 20, 30),
                       Visina = null,
                       Tezina = 71
                   },
                   new Napredak()
                   {
                       Id = 18,
                       KorisnikId = 12,
                       DatumMjerenja = new DateTime(2024, 1, 14, 13, 20, 30),
                       Visina = null,
                       Tezina = 52
                   },
                    new Napredak()
                    {
                        Id = 19,
                        KorisnikId = 12,
                        DatumMjerenja = new DateTime(2024, 2, 14, 13, 20, 30),
                        Visina = null,
                        Tezina = 56
                    }
            );
        }


        private void SeedTreninzi(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Treningi>().HasData(
                 new Treningi()
                 {
                     Id = 1,
                     Naziv = "Kružni",
                     Opis = "Kružni trening je visoko intenzivan oblik vježbanja koji ukljucuje brze serije razlicitih vježbi s minimalnim odmorom izmedu njih. Cilj mu je poboljšati snagu, izdržljivost i kondiciju, poticuci sagorijevanje kalorija i oblikovanje tijela. Ovaj dinamican trening prilagodava se razlicitim razinama iskustva i fitnessa.",
                     Trajanje = 60


                 },
                 new Treningi()
                 {
                     Id = 2,
                     Naziv = "Back health",
                     Opis = "Back Health trening je usmjeren na ocuvanje i jacanje zdravlja leda. Ova vrsta vježbanja ukljucuje niz vježbi koje su posebno dizajnirane za potporu kralježnici i mišicima leda. Cilj mu je smanjiti bol u ledima, poboljšati držanje i potaknuti mišice leda, što može dovesti do boljeg opceg zdravlja leda i smanjenja rizika od ozljeda. Back Health trening može biti prilagoden razlicitim razinama iskustva i potreba pojedinca.",
                     Trajanje = 60



                 },
                   new Treningi()
                   {
                       Id = 3,
                       Naziv = "Pilates",
                       Opis = "Pilates je sistem vježbi koji se usredotocuje na jacanje mišica trupa, poboljšanje držanja i fleksibilnosti te poticanje svijesti o tijelu. Ovaj holisticki pristup vježbanju promovira centar tijela kao kljucnu tocku stabilnosti i ravnoteže. Cilj Pilates treninga je razviti snažne i gibljive mišice, smanjiti napetost i bol u ledima te unaprijediti ukupno tjelesno zdravlje. Pilates se može prilagoditi razlicitim razinama iskustva, cineci ga pristupacnim za sve, bez obzira na dob i kondiciju.",
                       Trajanje = 60


                   },
                    new Treningi()
                    {
                        Id = 4,
                        Naziv = "Barbell lift",
                        Opis = "Trening dizanja tegova sa šipkom je izuzetno ucinkovita metoda za izgradnju snage i mišica. Ova vrsta vježbanja ukljucuje upotrebu šipke s tegovima i razlicitim tehnikama za dizanje, ukljucujuci cucnjeve, bench press, deadlifts i mnoge druge. Glavni cilj ovog treninga je povecati snagu i mišicnu masu, a takoder poboljšati tijelo i postici bolje sportske performanse. Dizanje utega s šipkom zahtijeva pravilnu tehniku i postupno povecavanje opterecenja. Ovaj trening se može prilagoditi razlicitim razinama iskustva i ciljevima vježbaca.",
                        Trajanje = 60


                    },
                     new Treningi()
                     {
                         Id = 5,
                         Naziv = "Booty workout",
                         Opis = "Fokusira se na ciljanu izgradnju i toniranje mišica donjeg dijela tijela kako bi se postigao oblik i velicina koji vam odgovara. Ovaj trening ukljucuje vježbe poput cucnjeva, iskoraka, potisaka s nogama i razlicitih vježbi s težinama ili elasticnim trakama kako bi se postigao optimalan rezultat. Cilj mu je ne samo poboljšati izgled vec i poboljšati funkcionalnost  mišica, pomažuci u svakodnevnim aktivnostima. Booty workout može biti prilagoden razlicitim razinama iskustva i fitnessa, te može ukljucivati i kardio elemente kako bi se dodatno sagorijevale kalorije.",
                         Trajanje = 60


                     },
                      new Treningi()
                      {
                          Id = 6,
                          Naziv = "ABS & Core",
                          Opis = "Trening za trbušne mišice i jezgru je usmjeren na jacanje mišica trbuha, donjeg dijela leda i struka kako bi se poboljšala snaga, stabilnost i ravnoteža tijela. Ovaj trening obicno ukljucuje vježbe poput trbušnjaka, plankova, leg-raise-ova i razlicitih vježbi s pilates loptom ili stabilnom površinom. Cilj mu je ne samo postici cvršce i izraženije trbušne mišice vec i poboljšati stabilnost tijela, smanjiti rizik od ozljeda i podržati držanje. Trening za trbušne mišice i jezgru se može prilagoditi razlicitim razinama iskustva i fitnessa, a takoder može ukljucivati vježbe za cijeli jezgru kako bi se postigao sveobuhvatan rezultat.",
                          Trajanje = 60


                      }

            );
        }




        private void SeedRaspored(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Raspored>().HasData(
                 new Raspored()
                 {
                     Id = 1,
                     AktivnostId = 5,
                     Dan = DayOfWeek.Monday,
                     DatumPocetka = new DateTime(2023, 10, 27, 08, 00, 00),
                     DatumZavrsetka = new DateTime(2023, 10, 27, 09, 00, 00),
                     TreningId = 1,
                     TrenerId = 1

                 },
                 new Raspored()
                 {
                     Id = 2,
                     AktivnostId = 5,
                     Dan = DayOfWeek.Tuesday,
                     DatumPocetka = new DateTime(2023, 10, 27, 08, 00, 00),
                     DatumZavrsetka = new DateTime(2023, 10, 27, 09, 00, 00),
                     TreningId = 1,
                     TrenerId = 1

                 },
                  new Raspored()
                  {
                      Id = 3,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Wednesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 08, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 09, 00, 00),
                      TreningId = 1,
                      TrenerId = 2

                  },
                  new Raspored()
                  {
                      Id = 4,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Thursday,
                      DatumPocetka = new DateTime(2023, 10, 27, 08, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 09, 00, 00),
                      TreningId = 1,
                      TrenerId = 3

                  },
                  new Raspored()
                  {
                      Id = 5,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Friday,
                      DatumPocetka = new DateTime(2023, 10, 27, 08, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 09, 00, 00),
                      TreningId = 1,
                      TrenerId = 3

                  },
                  new Raspored()
                  {
                      Id = 6,
                      AktivnostId = 6,
                      Dan = DayOfWeek.Monday,
                      DatumPocetka = new DateTime(2023, 10, 27, 09, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 10, 00, 00),
                      TreningId = 2,
                      TrenerId = 3

                  },
                  new Raspored()
                  {
                      Id = 7,
                      AktivnostId = 6,
                      Dan = DayOfWeek.Tuesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 09, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 10, 00, 00),
                      TreningId = 2,
                      TrenerId = 3

                  },
                  new Raspored()
                  {
                      Id = 8,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Wednesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 09, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 10, 00, 00),
                      TreningId = 5,
                      TrenerId = 2

                  },
                  new Raspored()
                  {
                      Id = 9,
                      AktivnostId = 6,
                      Dan = DayOfWeek.Thursday,
                      DatumPocetka = new DateTime(2023, 10, 27, 09, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 10, 00, 00),
                      TreningId = 2,
                      TrenerId = 3

                  },
                  new Raspored()
                  {
                      Id = 10,
                      AktivnostId = 6,
                      Dan = DayOfWeek.Friday,
                      DatumPocetka = new DateTime(2023, 10, 27, 09, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 10, 00, 00),
                      TreningId = 2,
                      TrenerId = 3

                  },
                  new Raspored()
                  {
                      Id = 11,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Monday,
                      DatumPocetka = new DateTime(2023, 10, 27, 10, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 11, 00, 00),
                      TreningId = 1,
                      TrenerId = 1

                  },
                  new Raspored()
                  {
                      Id = 12,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Tuesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 10, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 11, 00, 00),
                      TreningId = 1,
                      TrenerId = 1

                  },
                  new Raspored()
                  {
                      Id = 13,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Wednesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 10, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 11, 00, 00),
                      TreningId = 1,
                      TrenerId = 2

                  },
                  new Raspored()
                  {
                      Id = 14,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Thursday,
                      DatumPocetka = new DateTime(2023, 10, 27, 10, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 11, 00, 00),
                      TreningId = 1,
                      TrenerId = 3

                  },
                  new Raspored()
                  {
                      Id = 15,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Friday,
                      DatumPocetka = new DateTime(2023, 10, 27, 10, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 11, 00, 00),
                      TreningId = 1,
                      TrenerId = 2

                  },
                  new Raspored()
                  {
                      Id = 16,
                      AktivnostId = 7,
                      Dan = DayOfWeek.Monday,
                      DatumPocetka = new DateTime(2023, 10, 27, 11, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 12, 00, 00),
                      TreningId = 6,
                      TrenerId = 1

                  },
                  new Raspored()
                  {
                      Id = 17,
                      AktivnostId = 7,
                      Dan = DayOfWeek.Tuesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 11, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 12, 00, 00),
                      TreningId = 6,
                      TrenerId = 1

                  },
                  new Raspored()
                  {
                      Id = 18,
                      AktivnostId = 6,
                      Dan = DayOfWeek.Wednesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 11, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 12, 00, 00),
                      TreningId = 4,
                      TrenerId = 2

                  },
                  new Raspored()
                  {
                      Id = 19,
                      AktivnostId = 7,
                      Dan = DayOfWeek.Thursday,
                      DatumPocetka = new DateTime(2023, 10, 27, 11, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 12, 00, 00),
                      TreningId = 6,
                      TrenerId = 3

                  },
                  new Raspored()
                  {
                      Id = 20,
                      AktivnostId = 7,
                      Dan = DayOfWeek.Friday,
                      DatumPocetka = new DateTime(2023, 10, 27, 11, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 12, 00, 00),
                      TreningId = 6,
                      TrenerId = 3

                  }
                                         ,
                  new Raspored()
                  {
                      Id = 21,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Monday,
                      DatumPocetka = new DateTime(2023, 10, 27, 12, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 13, 00, 00),
                      TreningId = 1,
                      TrenerId = 1

                  }
                                         ,
                  new Raspored()
                  {
                      Id = 22,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Tuesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 12, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 13, 00, 00),
                      TreningId = 1,
                      TrenerId = 1

                  }
                                         ,
                  new Raspored()
                  {
                      Id = 23,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Wednesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 12, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 13, 00, 00),
                      TreningId = 1,
                      TrenerId = 2

                  }
                                             ,
                  new Raspored()
                  {
                      Id = 24,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Thursday,
                      DatumPocetka = new DateTime(2023, 10, 27, 12, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 13, 00, 00),
                      TreningId = 1,
                      TrenerId = 3

                  }
                                              ,
                  new Raspored()
                  {
                      Id = 25,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Friday,
                      DatumPocetka = new DateTime(2023, 10, 27, 12, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 13, 00, 00),
                      TreningId = 1,
                      TrenerId = 3

                  }
                                                  ,
                  new Raspored()
                  {
                      Id = 26,
                      AktivnostId = 4,
                      Dan = DayOfWeek.Monday,
                      DatumPocetka = new DateTime(2023, 10, 27, 15, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 16, 00, 00),
                      TreningId = 4,
                      TrenerId = 1

                  }
                                                     ,
                  new Raspored()
                  {
                      Id = 27,
                      AktivnostId = 4,
                      Dan = DayOfWeek.Tuesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 15, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 16, 00, 00),
                      TreningId = 4,
                      TrenerId = 1

                  }
                                                     ,
                  new Raspored()
                  {
                      Id = 28,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Wednesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 15, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 16, 00, 00),
                      TreningId = 5,
                      TrenerId = 2

                  }
                                                     ,
                  new Raspored()
                  {
                      Id = 29,
                      AktivnostId = 4,
                      Dan = DayOfWeek.Thursday,
                      DatumPocetka = new DateTime(2023, 10, 27, 15, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 16, 00, 00),
                      TreningId = 4,
                      TrenerId = 3

                  }
                                                     ,
                  new Raspored()
                  {
                      Id = 30,
                      AktivnostId = 4,
                      Dan = DayOfWeek.Friday,
                      DatumPocetka = new DateTime(2023, 10, 27, 15, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 16, 00, 00),
                      TreningId = 4,
                      TrenerId = 3

                  },
                 new Raspored()
                 {
                     Id = 31,
                     AktivnostId = 7,
                     Dan = DayOfWeek.Monday,
                     DatumPocetka = new DateTime(2023, 10, 27, 16, 00, 00),
                     DatumZavrsetka = new DateTime(2023, 10, 27, 17, 00, 00),
                     TreningId = 3,
                     TrenerId = 1

                 },
                 new Raspored()
                 {
                     Id = 32,
                     AktivnostId = 7,
                     Dan = DayOfWeek.Tuesday,
                     DatumPocetka = new DateTime(2023, 10, 27, 16, 00, 00),
                     DatumZavrsetka = new DateTime(2023, 10, 27, 17, 00, 00),
                     TreningId = 3,
                     TrenerId = 1

                 },
                 new Raspored()
                 {
                     Id = 33,
                     AktivnostId = 7,
                     Dan = DayOfWeek.Wednesday,
                     DatumPocetka = new DateTime(2023, 10, 27, 16, 00, 00),
                     DatumZavrsetka = new DateTime(2023, 10, 27, 17, 00, 00),
                     TreningId = 3,
                     TrenerId = 2

                 },
                 new Raspored()
                 {
                     Id = 34,
                     AktivnostId = 7,
                     Dan = DayOfWeek.Thursday,
                     DatumPocetka = new DateTime(2023, 10, 27, 16, 00, 00),
                     DatumZavrsetka = new DateTime(2023, 10, 27, 17, 00, 00),
                     TreningId = 3,
                     TrenerId = 3

                 },
                 new Raspored()
                 {
                     Id = 35,
                     AktivnostId = 7,
                     Dan = DayOfWeek.Friday,
                     DatumPocetka = new DateTime(2023, 10, 27, 16, 00, 00),
                     DatumZavrsetka = new DateTime(2023, 10, 27, 17, 00, 00),
                     TreningId = 3,
                     TrenerId = 3

                 },
                 new Raspored()
                 {
                     Id = 36,
                     AktivnostId = 5,
                     Dan = DayOfWeek.Monday,
                     DatumPocetka = new DateTime(2023, 10, 27, 17, 00, 00),
                     DatumZavrsetka = new DateTime(2023, 10, 27, 18, 00, 00),
                     TreningId = 1,
                     TrenerId = 1

                 },
                  new Raspored()
                  {
                      Id = 37,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Tuesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 17, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 18, 00, 00),
                      TreningId = 5,
                      TrenerId = 1

                  },
                  new Raspored()
                  {
                      Id = 38,
                      AktivnostId = 7,
                      Dan = DayOfWeek.Wednesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 17, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 18, 00, 00),
                      TreningId = 6,
                      TrenerId = 2

                  },
                  new Raspored()
                  {
                      Id = 39,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Thursday,
                      DatumPocetka = new DateTime(2023, 10, 27, 17, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 18, 00, 00),
                      TreningId = 5,
                      TrenerId = 3

                  },
                  new Raspored()
                  {
                      Id = 40,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Friday,
                      DatumPocetka = new DateTime(2023, 10, 27, 17, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 18, 00, 00),
                      TreningId = 1,
                      TrenerId = 3

                  },
                  new Raspored()
                  {
                      Id = 41,
                      AktivnostId = 4,
                      Dan = DayOfWeek.Monday,
                      DatumPocetka = new DateTime(2023, 10, 27, 18, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 19, 00, 00),
                      TreningId = 4,
                      TrenerId = 1

                  },
                  new Raspored()
                  {
                      Id = 42,
                      AktivnostId = 4,
                      Dan = DayOfWeek.Tuesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 18, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 19, 00, 00),
                      TreningId = 4,
                      TrenerId = 1

                  },
                  new Raspored()
                  {
                      Id = 43,
                      AktivnostId = 4,
                      Dan = DayOfWeek.Wednesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 18, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 19, 00, 00),
                      TreningId = 4,
                      TrenerId = 2

                  },
                  new Raspored()
                  {
                      Id = 44,
                      AktivnostId = 4,
                      Dan = DayOfWeek.Thursday,
                      DatumPocetka = new DateTime(2023, 10, 27, 18, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 19, 00, 00),
                      TreningId = 4,
                      TrenerId = 3

                  },
                  new Raspored()
                  {
                      Id = 45,
                      AktivnostId = 4,
                      Dan = DayOfWeek.Friday,
                      DatumPocetka = new DateTime(2023, 10, 27, 18, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 19, 00, 00),
                      TreningId = 4,
                      TrenerId = 3

                  },
                  new Raspored()
                  {
                      Id = 46,
                      AktivnostId = 7,
                      Dan = DayOfWeek.Monday,
                      DatumPocetka = new DateTime(2023, 10, 27, 19, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 20, 00, 00),
                      TreningId = 6,
                      TrenerId = 1

                  },
                  new Raspored()
                  {
                      Id = 47,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Tuesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 19, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 20, 00, 00),
                      TreningId = 5,
                      TrenerId = 1

                  },
                  new Raspored()
                  {
                      Id = 48,
                      AktivnostId = 6,
                      Dan = DayOfWeek.Wednesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 19, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 20, 00, 00),
                      TreningId = 2,
                      TrenerId = 2

                  },
                  new Raspored()
                  {
                      Id = 49,
                      AktivnostId = 5,
                      Dan = DayOfWeek.Thursday,
                      DatumPocetka = new DateTime(2023, 10, 27, 19, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 20, 00, 00),
                      TreningId = 5,
                      TrenerId = 3

                  },
                  new Raspored()
                  {
                      Id = 50,
                      AktivnostId = 7,
                      Dan = DayOfWeek.Friday,
                      DatumPocetka = new DateTime(2023, 10, 27, 19, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 20, 00, 00),
                      TreningId = 6,
                      TrenerId = 3

                  },
                  new Raspored()
                  {
                      Id = 51,
                      AktivnostId = 7,
                      Dan = DayOfWeek.Monday,
                      DatumPocetka = new DateTime(2023, 10, 27, 20, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 21, 00, 00),
                      TreningId = 3,
                      TrenerId = 1

                  },
                  new Raspored()
                  {
                      Id = 52,
                      AktivnostId = 7,
                      Dan = DayOfWeek.Tuesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 20, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 21, 00, 00),
                      TreningId = 3,
                      TrenerId = 1

                  },
                  new Raspored()
                  {
                      Id = 53,
                      AktivnostId = 7,
                      Dan = DayOfWeek.Wednesday,
                      DatumPocetka = new DateTime(2023, 10, 27, 20, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 21, 00, 00),
                      TreningId = 3,
                      TrenerId = 2

                  },
                  new Raspored()
                  {
                      Id = 54,
                      AktivnostId = 7,
                      Dan = DayOfWeek.Thursday,
                      DatumPocetka = new DateTime(2023, 10, 27, 20, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 21, 00, 00),
                      TreningId = 3,
                      TrenerId = 3

                  },
                  new Raspored()
                  {
                      Id = 55,
                      AktivnostId = 7,
                      Dan = DayOfWeek.Friday,
                      DatumPocetka = new DateTime(2023, 10, 27, 20, 00, 00),
                      DatumZavrsetka = new DateTime(2023, 10, 27, 21, 00, 00),
                      TreningId = 3,
                      TrenerId = 3

                  }
            );
        }




        private void SeedRezervacije(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Rezervacije>().HasData(
                 new Rezervacije()
                 {
                     Id = 1,
                     KorisnikId = 4,
                     RasporedId = 1,
                     Status = "Placena",
                     DatumRezervacija = new DateTime(2023, 10, 27, 21, 00, 00),
                     PlacanjeId = 2,
                 },


                   new Rezervacije()
                   {
                       Id = 2,
                       KorisnikId = 8,
                       RasporedId = 20,
                       Status = "Placena",
                       DatumRezervacija = new DateTime(2024, 03, 25, 10, 00, 00),
                       PlacanjeId = 1,
                   },
                      new Rezervacije()
                      {
                          Id = 3,
                          KorisnikId = 8,
                          RasporedId = 25,
                          Status = "Aktivna",
                          DatumRezervacija = new DateTime(2024, 03, 25, 10, 00, 00),
                          PlacanjeId = null,
                      }

            );
        }
        private void SeedPregledanaNovost(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<PregledaneNovosti>().HasData(
                 new PregledaneNovosti()
                 {
                     Id = 1,
                     NovostId = 1,
                     KorisnikId = 8


                 },
                 new PregledaneNovosti()
                 {
                     Id = 2,
                     NovostId = 2,
                     KorisnikId = 4


                 }, new PregledaneNovosti()
                 {
                     Id = 3,
                     NovostId = 1,
                     KorisnikId = 4


                 }, new PregledaneNovosti()
                 {
                     Id = 4,
                     NovostId = 1,
                     KorisnikId = 5


                 },
                 new PregledaneNovosti()
                 {
                     Id = 5,
                     NovostId = 3,
                     KorisnikId = 5

                 },
                 new PregledaneNovosti()
                 {
                     Id = 6,
                     NovostId = 4,
                     KorisnikId = 5

                 },
                 new PregledaneNovosti()
                 {
                     Id = 7,
                     NovostId = 3,
                     KorisnikId = 8

                 },
                 new PregledaneNovosti()
                 {
                     Id = 8,
                     NovostId = 1,
                     KorisnikId = 7

                 },
                 new PregledaneNovosti()
                 {
                     Id = 9,
                     NovostId = 5,
                     KorisnikId = 6

                 },
                 new PregledaneNovosti()
                 {
                     Id = 10,
                     NovostId = 6,
                     KorisnikId = 6

                 },
                 new PregledaneNovosti()
                 {
                     Id = 11,
                     NovostId = 6,
                     KorisnikId = 8

                 },
                 new PregledaneNovosti()
                 {
                     Id = 12,
                     NovostId = 6,
                     KorisnikId = 7

                 }
            );
        }

   



    }

}
