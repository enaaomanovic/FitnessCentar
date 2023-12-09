using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace FitnessCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class seedv2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Novosti",
                columns: new[] { "ID", "AutorID", "DatumObjave", "Naslov", "Tekst" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2023, 10, 25, 17, 55, 40, 0, DateTimeKind.Unspecified), "Obavještenje za sve aktivne clanove centra!!!", "Obavještavaju se svi clanovi fitness centra da centar nece raditi 26.10.2023 godine. Buduci da renoviramo fitness centar neophodno je bilo da zatvorimo centar na jedan dan kako bi realizacija renoviranja bila moguca.Svi koji propuste svoje termine moci ce ih nadoknaditi u terminima narednih dana. Hvala na razumijevanju." },
                    { 2, 1, new DateTime(2023, 10, 26, 18, 22, 34, 0, DateTimeKind.Unspecified), "Novi zdravi recept!", "Pozdrav svim clanovima našeg centra. Danas sam isprobala jedan zdravi i brzi recept te sam odlucila da ga podjelim i sa vama. Radi se o salati od tune, ja sam koristila dodatno zelenu salatu, krastavce, kukuruz i mrkvu. Obrok je bio proteinski obogacen niskokalorican ali ipak dovoljno zasitan. Javite mi vaše utiske." }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Novosti",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Novosti",
                keyColumn: "ID",
                keyValue: 2);
        }
    }
}
