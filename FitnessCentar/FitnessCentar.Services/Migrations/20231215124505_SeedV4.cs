using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace FitnessCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class SeedV4 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Korisnici",
                columns: new[] { "ID", "DatumRegistracije", "DatumRodjenja", "Email", "Ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "Pol", "Prezime", "Slika", "Telefon", "Tezina", "Visina" },
                values: new object[,]
                {
                    { 9, new DateTime(2023, 12, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "user.user@gmail.com", "User", "User", new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 }, new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 }, "Muški", "User", null, "063456734", 90m, 190m },
                    { 10, new DateTime(2023, 12, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "amna.kazicim@gmail.com", "Amna", "Amina", new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 }, new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 }, "Ženski", "Kazimic", null, "062545896", 60m, 170m },
                    { 11, new DateTime(2023, 12, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "enes.omanovic@gmail.com", "Enes", "Enes", new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 }, new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 }, "Muški", "Omanovic", null, "063456734", 80m, 180m },
                    { 12, new DateTime(2023, 12, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "sara.maric@gmail.com", "Sara", "Sara", new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 }, new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 }, "Ženski", "Maric", null, "062545896", 50m, 160m },
                    { 13, new DateTime(2023, 12, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "hana.maric@gmail.com", "Hana", "Hana", new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 }, new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 }, "Ženski", "Maric", null, "063456734", 52m, 170m },
                    { 14, new DateTime(2023, 12, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2000, 2, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "nejra.maric@gmail.com", "Nejra", "Nejra", new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 }, new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 }, "Ženski", "Maric", null, "062545896", 50m, 160m }
                });

            migrationBuilder.InsertData(
                table: "Novosti",
                columns: new[] { "ID", "AutorID", "DatumObjave", "Naslov", "Tekst" },
                values: new object[,]
                {
                    { 3, 3, new DateTime(2023, 10, 26, 18, 22, 34, 0, DateTimeKind.Unspecified), "DaniSporta", "Obavještavamo vas da ce se 10.12.2023 u našem centru održati dani sporta. Centar ce tog dana moci posjetiti svi clanovi fitnes centra besplatno. Takoder bice pice dobrodošlice, vrijeme cemo provoditi vježbajuci. Radujemo se da vas vidimo u velikom broju." },
                    { 4, 3, new DateTime(2023, 10, 26, 18, 22, 34, 0, DateTimeKind.Unspecified), "Slobodan dan ", "Obavještavamo sve korisnike centra da centar nece raditi 1.1.2024,2.1.2024 i 3.1.2024. Razlog zatvaranja centra su novogodišnji praznici.Zahvaljujemo se na razumjevanju" },
                    { 5, 2, new DateTime(2023, 10, 26, 18, 22, 34, 0, DateTimeKind.Unspecified), "Zadravi doručak:Ovsena kaša", "Oduševljavamo vas najnovijim receptom za zdravu ovsenu kasu- Nova Ovsena Kaša! Sada možete započeti svoj dan zdravim doručkom koji će vam pružiti potrebnu energiju za uspješan trening.Ovsena kaša obogaćena je nutritivnim sastojcima, voćem i orašastim plodovima.Isprobajte ovu ukusnu i hranjivu opciju za doručak!" },
                    { 6, 1, new DateTime(2023, 10, 26, 18, 22, 34, 0, DateTimeKind.Unspecified), "Dan žena", "Molimo sve članice našeg fitness centra da sa puta pokupe svoje poklone za dan žena ukoiko to već nisu uradile." },
                    { 7, 3, new DateTime(2023, 10, 26, 18, 22, 34, 0, DateTimeKind.Unspecified), "Otkazan kružni trening", "Obavještavamo sve korisnike centra da se trener razbolio, te se kružni treninzi danas neće održati.Hvala na razumjevanju" }
                });

            migrationBuilder.InsertData(
                table: "PregledaneNovostis",
                columns: new[] { "Id", "KorisnikId", "NovostId" },
                values: new object[,]
                {
                    { 1, 8, 1 },
                    { 2, 4, 2 },
                    { 3, 4, 1 },
                    { 4, 5, 1 },
                    { 8, 7, 1 },
                    { 5, 5, 3 },
                    { 6, 5, 4 },
                    { 7, 8, 3 },
                    { 9, 6, 5 },
                    { 10, 6, 6 },
                    { 11, 8, 6 },
                    { 12, 7, 6 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Novosti",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "PregledaneNovostis",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "PregledaneNovostis",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "PregledaneNovostis",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "PregledaneNovostis",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "PregledaneNovostis",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "PregledaneNovostis",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "PregledaneNovostis",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "PregledaneNovostis",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "PregledaneNovostis",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "PregledaneNovostis",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "PregledaneNovostis",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "PregledaneNovostis",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Novosti",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Novosti",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Novosti",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Novosti",
                keyColumn: "ID",
                keyValue: 6);
        }
    }
}
