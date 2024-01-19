using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FitnessCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class seedplacanja : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 3);

            migrationBuilder.InsertData(
                table: "Placanja",
                columns: new[] { "ID", "DatumPlacanja", "Iznos", "KorisnikID", "TxnId" },
                values: new object[] { 1, new DateTime(2024, 1, 19, 0, 0, 0, 0, DateTimeKind.Unspecified), 15m, 8, "test010920001" });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 2,
                columns: new[] { "DatumRezervacija", "KorisnikID", "PlacanjeId", "RasporedID", "Status" },
                values: new object[] { new DateTime(2024, 1, 19, 10, 0, 0, 0, DateTimeKind.Unspecified), 8, 1, 20, "Aktivna" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Placanja",
                keyColumn: "ID",
                keyValue: 1);

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 2,
                columns: new[] { "DatumRezervacija", "KorisnikID", "PlacanjeId", "RasporedID", "Status" },
                values: new object[] { new DateTime(2023, 10, 27, 21, 0, 0, 0, DateTimeKind.Unspecified), 4, null, 4, "Neaktivna" });

            migrationBuilder.InsertData(
                table: "Rezervacije",
                columns: new[] { "ID", "DatumRezervacija", "KorisnikID", "PlacanjeId", "RasporedID", "Status" },
                values: new object[] { 3, new DateTime(2023, 10, 27, 21, 0, 0, 0, DateTimeKind.Unspecified), 4, null, 20, "Aktivna" });
        }
    }
}
