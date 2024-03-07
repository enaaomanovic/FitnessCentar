using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FitnessCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class newDateReservation : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 2,
                column: "DatumRezervacija",
                value: new DateTime(2024, 3, 25, 10, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 3,
                column: "DatumRezervacija",
                value: new DateTime(2024, 3, 25, 10, 0, 0, 0, DateTimeKind.Unspecified));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 2,
                column: "DatumRezervacija",
                value: new DateTime(2024, 3, 14, 10, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 3,
                column: "DatumRezervacija",
                value: new DateTime(2024, 3, 14, 10, 0, 0, 0, DateTimeKind.Unspecified));
        }
    }
}
