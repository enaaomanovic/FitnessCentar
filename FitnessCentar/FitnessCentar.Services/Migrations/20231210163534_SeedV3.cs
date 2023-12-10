using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace FitnessCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class SeedV3 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Aktivnosti",
                columns: new[] { "ID", "Naziv" },
                values: new object[,]
                {
                    { 4, "Veoma intezivno" },
                    { 5, "Intezivno" },
                    { 6, "Umjereno" },
                    { 7, "Lagan tempo" }
                });

            migrationBuilder.InsertData(
                table: "Korisnici",
                columns: new[] { "ID", "DatumRegistracije", "DatumRodjenja", "Email", "Ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "Pol", "Prezime", "Slika", "Telefon", "Tezina", "Visina" },
                values: new object[,]
                {
                    { 3, new DateTime(2023, 12, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "husein.maric@gmail.com", "Husein", "Huso", new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 }, new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 }, "Muški", "Maric", null, "062545896", 90m, 190m },
                    { 4, new DateTime(2023, 12, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2000, 1, 2, 0, 0, 0, 0, DateTimeKind.Unspecified), "benjamin.omanovic@gmail.com", "Benjamin", "Benjo", new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 }, new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 }, "Muški", "Omanovic", null, "062545698", 88m, 192m },
                    { 5, new DateTime(2023, 12, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(1977, 12, 7, 0, 0, 0, 0, DateTimeKind.Unspecified), "sanela.omanovic@gmail.com", "Sanela", "Sanela", new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 }, new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 }, "Ženski", "Omanovic", null, "062548521", 70m, 175m },
                    { 6, new DateTime(2023, 12, 9, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2000, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "bakir.leto@gmail.com", "Bakir", "Bakir", new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 }, new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 }, "Muški", "Leto", null, "061254569", 88m, 190m },
                    { 7, new DateTime(2023, 12, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(1996, 2, 4, 0, 0, 0, 0, DateTimeKind.Unspecified), "faruk.tinjak@gmail.com", "Faruk", "Faruk", new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 }, new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 }, "Muški", "Tinjak", null, "062548865", 88m, 190m },
                    { 8, new DateTime(2023, 12, 9, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2000, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "ena.omanovic@gamil.com", "Ena", "Ena", new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 }, new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 }, "Ženski", "Omanovic", null, "062548895", 60m, 170m }
                });

            migrationBuilder.InsertData(
                table: "Treneri",
                columns: new[] { "ID", "Specijalnost" },
                values: new object[] { 2, "Magistrirani Personalni trener" });

            migrationBuilder.InsertData(
                table: "Treningi",
                columns: new[] { "ID", "Naziv", "Opis", "Trajanje" },
                values: new object[,]
                {
                    { 1, "Kružni", "Kružni trening je visoko intenzivan oblik vježbanja koji ukljucuje brze serije razlicitih vježbi s minimalnim odmorom izmedu njih. Cilj mu je poboljšati snagu, izdržljivost i kondiciju, poticuci sagorijevanje kalorija i oblikovanje tijela. Ovaj dinamican trening prilagodava se razlicitim razinama iskustva i fitnessa.", 60 },
                    { 2, "Back health", "Back Health trening je usmjeren na ocuvanje i jacanje zdravlja leda. Ova vrsta vježbanja ukljucuje niz vježbi koje su posebno dizajnirane za potporu kralježnici i mišicima leda. Cilj mu je smanjiti bol u ledima, poboljšati držanje i potaknuti mišice leda, što može dovesti do boljeg opceg zdravlja leda i smanjenja rizika od ozljeda. Back Health trening može biti prilagoden razlicitim razinama iskustva i potreba pojedinca.", 60 },
                    { 3, "Pilates", "Pilates je sistem vježbi koji se usredotocuje na jacanje mišica trupa, poboljšanje držanja i fleksibilnosti te poticanje svijesti o tijelu. Ovaj holisticki pristup vježbanju promovira centar tijela kao kljucnu tocku stabilnosti i ravnoteže. Cilj Pilates treninga je razviti snažne i gibljive mišice, smanjiti napetost i bol u ledima te unaprijediti ukupno tjelesno zdravlje. Pilates se može prilagoditi razlicitim razinama iskustva, cineci ga pristupacnim za sve, bez obzira na dob i kondiciju.", 60 },
                    { 4, "Barbell lift", "Trening dizanja tegova sa šipkom je izuzetno ucinkovita metoda za izgradnju snage i mišica. Ova vrsta vježbanja ukljucuje upotrebu šipke s tegovima i razlicitim tehnikama za dizanje, ukljucujuci cucnjeve, bench press, deadlifts i mnoge druge. Glavni cilj ovog treninga je povecati snagu i mišicnu masu, a takoder poboljšati tijelo i postici bolje sportske performanse. Dizanje utega s šipkom zahtijeva pravilnu tehniku i postupno povecavanje opterecenja. Ovaj trening se može prilagoditi razlicitim razinama iskustva i ciljevima vježbaca.", 60 },
                    { 5, "Booty workout", "Fokusira se na ciljanu izgradnju i toniranje mišica donjeg dijela tijela kako bi se postigao oblik i velicina koji vam odgovara. Ovaj trening ukljucuje vježbe poput cucnjeva, iskoraka, potisaka s nogama i razlicitih vježbi s težinama ili elasticnim trakama kako bi se postigao optimalan rezultat. Cilj mu je ne samo poboljšati izgled vec i poboljšati funkcionalnost  mišica, pomažuci u svakodnevnim aktivnostima. Booty workout može biti prilagoden razlicitim razinama iskustva i fitnessa, te može ukljucivati i kardio elemente kako bi se dodatno sagorijevale kalorije.", 60 },
                    { 6, "ABS & Core", "Trening za trbušne mišice i jezgru je usmjeren na jacanje mišica trbuha, donjeg dijela leda i struka kako bi se poboljšala snaga, stabilnost i ravnoteža tijela. Ovaj trening obicno ukljucuje vježbe poput trbušnjaka, plankova, leg-raise-ova i razlicitih vježbi s pilates loptom ili stabilnom površinom. Cilj mu je ne samo postici cvršce i izraženije trbušne mišice vec i poboljšati stabilnost tijela, smanjiti rizik od ozljeda i podržati držanje. Trening za trbušne mišice i jezgru se može prilagoditi razlicitim razinama iskustva i fitnessa, a takoder može ukljucivati vježbe za cijeli jezgru kako bi se postigao sveobuhvatan rezultat.", 60 }
                });

            migrationBuilder.InsertData(
                table: "Komentari",
                columns: new[] { "ID", "DatumKomentara", "KorisnikID", "NovostID", "Tekst" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 12, 12, 10, 55, 40, 0, DateTimeKind.Unspecified), 4, 1, "Nema problema, nadoknaditi cemo termine" },
                    { 2, new DateTime(2023, 12, 12, 13, 20, 10, 0, DateTimeKind.Unspecified), 5, 2, "Recept je odličan" }
                });

            migrationBuilder.InsertData(
                table: "Napredak",
                columns: new[] { "ID", "DatumMjerenja", "KorisnikID", "Tezina", "Visina" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 12, 12, 13, 20, 20, 0, DateTimeKind.Unspecified), 4, 90m, null },
                    { 2, new DateTime(2023, 12, 12, 13, 20, 30, 0, DateTimeKind.Unspecified), 4, 86m, null },
                    { 3, new DateTime(2023, 12, 12, 13, 20, 40, 0, DateTimeKind.Unspecified), 4, 76m, null }
                });

            migrationBuilder.InsertData(
                table: "Raspored",
                columns: new[] { "ID", "AktivnostID", "Dan", "DatumPocetka", "DatumZavrsetka", "TrenerID", "TreningID" },
                values: new object[,]
                {
                    { 1, 5, 1, new DateTime(2023, 10, 27, 8, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 9, 0, 0, 0, DateTimeKind.Unspecified), 1, 1 },
                    { 2, 5, 2, new DateTime(2023, 10, 27, 8, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 9, 0, 0, 0, DateTimeKind.Unspecified), 1, 1 },
                    { 3, 5, 3, new DateTime(2023, 10, 27, 8, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 9, 0, 0, 0, DateTimeKind.Unspecified), 2, 1 },
                    { 8, 5, 3, new DateTime(2023, 10, 27, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 10, 0, 0, 0, DateTimeKind.Unspecified), 2, 5 },
                    { 11, 5, 1, new DateTime(2023, 10, 27, 10, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 11, 0, 0, 0, DateTimeKind.Unspecified), 1, 1 },
                    { 12, 5, 2, new DateTime(2023, 10, 27, 10, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 11, 0, 0, 0, DateTimeKind.Unspecified), 1, 1 },
                    { 13, 5, 3, new DateTime(2023, 10, 27, 10, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 11, 0, 0, 0, DateTimeKind.Unspecified), 2, 1 },
                    { 15, 5, 5, new DateTime(2023, 10, 27, 10, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 11, 0, 0, 0, DateTimeKind.Unspecified), 2, 1 },
                    { 16, 7, 1, new DateTime(2023, 10, 27, 11, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 12, 0, 0, 0, DateTimeKind.Unspecified), 1, 6 },
                    { 17, 7, 2, new DateTime(2023, 10, 27, 11, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 12, 0, 0, 0, DateTimeKind.Unspecified), 1, 6 },
                    { 18, 6, 3, new DateTime(2023, 10, 27, 11, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 12, 0, 0, 0, DateTimeKind.Unspecified), 2, 4 },
                    { 21, 5, 1, new DateTime(2023, 10, 27, 12, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 13, 0, 0, 0, DateTimeKind.Unspecified), 1, 1 },
                    { 22, 5, 2, new DateTime(2023, 10, 27, 12, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 13, 0, 0, 0, DateTimeKind.Unspecified), 1, 1 },
                    { 23, 5, 3, new DateTime(2023, 10, 27, 12, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 13, 0, 0, 0, DateTimeKind.Unspecified), 2, 1 },
                    { 26, 4, 1, new DateTime(2023, 10, 27, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 16, 0, 0, 0, DateTimeKind.Unspecified), 1, 4 },
                    { 27, 4, 2, new DateTime(2023, 10, 27, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 16, 0, 0, 0, DateTimeKind.Unspecified), 1, 4 },
                    { 28, 5, 3, new DateTime(2023, 10, 27, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 16, 0, 0, 0, DateTimeKind.Unspecified), 2, 5 },
                    { 31, 7, 1, new DateTime(2023, 10, 27, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 17, 0, 0, 0, DateTimeKind.Unspecified), 1, 3 },
                    { 32, 7, 2, new DateTime(2023, 10, 27, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 17, 0, 0, 0, DateTimeKind.Unspecified), 1, 3 },
                    { 33, 7, 3, new DateTime(2023, 10, 27, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 17, 0, 0, 0, DateTimeKind.Unspecified), 2, 3 },
                    { 36, 5, 1, new DateTime(2023, 10, 27, 17, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, 1 },
                    { 37, 5, 2, new DateTime(2023, 10, 27, 17, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 18, 0, 0, 0, DateTimeKind.Unspecified), 1, 5 },
                    { 38, 7, 3, new DateTime(2023, 10, 27, 17, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 18, 0, 0, 0, DateTimeKind.Unspecified), 2, 6 },
                    { 41, 4, 1, new DateTime(2023, 10, 27, 18, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 19, 0, 0, 0, DateTimeKind.Unspecified), 1, 4 },
                    { 42, 4, 2, new DateTime(2023, 10, 27, 18, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 19, 0, 0, 0, DateTimeKind.Unspecified), 1, 4 },
                    { 43, 4, 3, new DateTime(2023, 10, 27, 18, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 19, 0, 0, 0, DateTimeKind.Unspecified), 2, 4 },
                    { 46, 7, 1, new DateTime(2023, 10, 27, 19, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 20, 0, 0, 0, DateTimeKind.Unspecified), 1, 6 },
                    { 47, 5, 2, new DateTime(2023, 10, 27, 19, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 20, 0, 0, 0, DateTimeKind.Unspecified), 1, 5 },
                    { 48, 6, 3, new DateTime(2023, 10, 27, 19, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 20, 0, 0, 0, DateTimeKind.Unspecified), 2, 2 },
                    { 51, 7, 1, new DateTime(2023, 10, 27, 20, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 21, 0, 0, 0, DateTimeKind.Unspecified), 1, 3 },
                    { 52, 7, 2, new DateTime(2023, 10, 27, 20, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 21, 0, 0, 0, DateTimeKind.Unspecified), 1, 3 },
                    { 53, 7, 3, new DateTime(2023, 10, 27, 20, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 21, 0, 0, 0, DateTimeKind.Unspecified), 2, 3 }
                });

            migrationBuilder.InsertData(
                table: "Treneri",
                columns: new[] { "ID", "Specijalnost" },
                values: new object[] { 3, "Stručni trener" });

            migrationBuilder.InsertData(
                table: "OdgovoriNaKomentare",
                columns: new[] { "ID", "DatumOdgovora", "KomentarID", "Tekst", "TrenerID" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 12, 12, 13, 20, 10, 0, DateTimeKind.Unspecified), 1, "Drago nam je to čuti", 1 },
                    { 2, new DateTime(2023, 12, 12, 13, 20, 20, 0, DateTimeKind.Unspecified), 2, "Drago nam je to čuti", 1 }
                });

            migrationBuilder.InsertData(
                table: "Raspored",
                columns: new[] { "ID", "AktivnostID", "Dan", "DatumPocetka", "DatumZavrsetka", "TrenerID", "TreningID" },
                values: new object[,]
                {
                    { 4, 5, 4, new DateTime(2023, 10, 27, 8, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 9, 0, 0, 0, DateTimeKind.Unspecified), 3, 1 },
                    { 5, 5, 5, new DateTime(2023, 10, 27, 8, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 9, 0, 0, 0, DateTimeKind.Unspecified), 3, 1 },
                    { 6, 6, 1, new DateTime(2023, 10, 27, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 10, 0, 0, 0, DateTimeKind.Unspecified), 3, 2 },
                    { 7, 6, 2, new DateTime(2023, 10, 27, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 10, 0, 0, 0, DateTimeKind.Unspecified), 3, 2 },
                    { 9, 6, 4, new DateTime(2023, 10, 27, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 10, 0, 0, 0, DateTimeKind.Unspecified), 3, 2 },
                    { 10, 6, 5, new DateTime(2023, 10, 27, 9, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 10, 0, 0, 0, DateTimeKind.Unspecified), 3, 2 },
                    { 14, 5, 4, new DateTime(2023, 10, 27, 10, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 11, 0, 0, 0, DateTimeKind.Unspecified), 3, 1 },
                    { 19, 7, 4, new DateTime(2023, 10, 27, 11, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 12, 0, 0, 0, DateTimeKind.Unspecified), 3, 6 },
                    { 20, 7, 5, new DateTime(2023, 10, 27, 11, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 12, 0, 0, 0, DateTimeKind.Unspecified), 3, 6 },
                    { 24, 5, 4, new DateTime(2023, 10, 27, 12, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 13, 0, 0, 0, DateTimeKind.Unspecified), 3, 1 },
                    { 25, 5, 5, new DateTime(2023, 10, 27, 12, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 13, 0, 0, 0, DateTimeKind.Unspecified), 3, 1 },
                    { 29, 4, 4, new DateTime(2023, 10, 27, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 16, 0, 0, 0, DateTimeKind.Unspecified), 3, 4 },
                    { 30, 4, 5, new DateTime(2023, 10, 27, 15, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 16, 0, 0, 0, DateTimeKind.Unspecified), 3, 4 },
                    { 34, 7, 4, new DateTime(2023, 10, 27, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 17, 0, 0, 0, DateTimeKind.Unspecified), 3, 3 },
                    { 35, 7, 5, new DateTime(2023, 10, 27, 16, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 17, 0, 0, 0, DateTimeKind.Unspecified), 3, 3 },
                    { 39, 5, 4, new DateTime(2023, 10, 27, 17, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 18, 0, 0, 0, DateTimeKind.Unspecified), 3, 5 },
                    { 40, 5, 5, new DateTime(2023, 10, 27, 17, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 18, 0, 0, 0, DateTimeKind.Unspecified), 3, 1 },
                    { 44, 4, 4, new DateTime(2023, 10, 27, 18, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 19, 0, 0, 0, DateTimeKind.Unspecified), 3, 4 },
                    { 45, 4, 5, new DateTime(2023, 10, 27, 18, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 19, 0, 0, 0, DateTimeKind.Unspecified), 3, 4 },
                    { 49, 5, 4, new DateTime(2023, 10, 27, 19, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 20, 0, 0, 0, DateTimeKind.Unspecified), 3, 5 },
                    { 50, 7, 5, new DateTime(2023, 10, 27, 19, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 20, 0, 0, 0, DateTimeKind.Unspecified), 3, 6 },
                    { 54, 7, 4, new DateTime(2023, 10, 27, 20, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 21, 0, 0, 0, DateTimeKind.Unspecified), 3, 3 },
                    { 55, 7, 5, new DateTime(2023, 10, 27, 20, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 10, 27, 21, 0, 0, 0, DateTimeKind.Unspecified), 3, 3 }
                });

            migrationBuilder.InsertData(
                table: "Rezervacije",
                columns: new[] { "ID", "DatumRezervacija", "KorisnikID", "RasporedID", "Status" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 10, 27, 21, 0, 0, 0, DateTimeKind.Unspecified), 4, 1, "Aktivna" },
                    { 2, new DateTime(2023, 10, 27, 21, 0, 0, 0, DateTimeKind.Unspecified), 4, 4, "Neaktivna" },
                    { 3, new DateTime(2023, 10, 27, 21, 0, 0, 0, DateTimeKind.Unspecified), 4, 20, "Aktivna" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "OdgovoriNaKomentare",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "OdgovoriNaKomentare",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 22);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 23);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 24);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 25);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 26);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 27);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 28);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 29);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 30);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 31);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 32);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 33);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 34);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 35);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 36);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 37);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 38);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 39);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 40);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 41);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 42);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 43);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 44);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 45);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 46);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 47);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 48);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 49);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 50);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 51);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 52);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 53);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 54);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 55);

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Aktivnosti",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Aktivnosti",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Komentari",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Komentari",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Raspored",
                keyColumn: "ID",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "Treneri",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Treningi",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Treningi",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Treningi",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Treningi",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Aktivnosti",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Aktivnosti",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Treneri",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Treningi",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Treningi",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 3);
        }
    }
}
