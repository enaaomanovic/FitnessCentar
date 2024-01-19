using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FitnessCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class last : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Placanja",
                columns: new[] { "ID", "DatumPlacanja", "Iznos", "KorisnikID", "TxnId" },
                values: new object[] { 2, new DateTime(2023, 10, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), 15m, 4, "test010920002" });

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 1,
                column: "PlacanjeId",
                value: 2);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Placanja",
                keyColumn: "ID",
                keyValue: 2);

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 1,
                column: "PlacanjeId",
                value: null);
        }
    }
}
