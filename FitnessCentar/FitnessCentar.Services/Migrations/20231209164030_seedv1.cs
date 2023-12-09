using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace FitnessCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class seedv1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Korisnici",
                columns: new[] { "ID", "DatumRegistracije", "DatumRodjenja", "Email", "Ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "Pol", "Prezime", "Slika", "Telefon", "Tezina", "Visina" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 12, 9, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2000, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "selma.kovacevic@gmail.com", "Selma", "Selma", new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 }, new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 }, "Ženski", "Kovacevic", null, "061123123", 60m, 165m },
                    { 2, new DateTime(2023, 12, 9, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2000, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "vildana.suta@gmail.com", "Vildana", "Vildana", new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 }, new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 }, "Ženski", "Šuta", null, "061123123", 60m, 165m }
                });

            migrationBuilder.InsertData(
                table: "Treneri",
                columns: new[] { "ID", "Specijalnost" },
                values: new object[] { 1, "Personalni trener" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Treneri",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "ID",
                keyValue: 1);
        }
    }
}
