using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FitnessCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class lastlast : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 1,
                column: "DatumMjerenja",
                value: new DateTime(2023, 12, 14, 13, 20, 30, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 2,
                column: "DatumMjerenja",
                value: new DateTime(2024, 1, 14, 13, 20, 30, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 3,
                column: "DatumMjerenja",
                value: new DateTime(2024, 2, 14, 13, 20, 30, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 2,
                column: "DatumRezervacija",
                value: new DateTime(2024, 2, 14, 10, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.InsertData(
                table: "Rezervacije",
                columns: new[] { "ID", "DatumRezervacija", "KorisnikID", "PlacanjeId", "RasporedID", "Status" },
                values: new object[] { 3, new DateTime(2024, 2, 14, 10, 0, 0, 0, DateTimeKind.Unspecified), 8, null, 25, "Aktivna" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.UpdateData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 1,
                column: "DatumMjerenja",
                value: new DateTime(2023, 12, 12, 13, 20, 20, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 2,
                column: "DatumMjerenja",
                value: new DateTime(2023, 12, 12, 13, 20, 30, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 3,
                column: "DatumMjerenja",
                value: new DateTime(2023, 12, 12, 13, 20, 40, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 2,
                column: "DatumRezervacija",
                value: new DateTime(2024, 1, 19, 10, 0, 0, 0, DateTimeKind.Unspecified));
        }
    }
}
