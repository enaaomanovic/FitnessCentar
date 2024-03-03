using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace FitnessCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class mig23 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Napredak",
                columns: new[] { "ID", "DatumMjerenja", "KorisnikID", "Tezina", "Visina" },
                values: new object[,]
                {
                    { 4, new DateTime(2024, 1, 14, 13, 20, 30, 0, DateTimeKind.Unspecified), 5, 76m, null },
                    { 5, new DateTime(2024, 2, 14, 13, 20, 30, 0, DateTimeKind.Unspecified), 5, 73m, null },
                    { 6, new DateTime(2024, 1, 14, 13, 20, 30, 0, DateTimeKind.Unspecified), 6, 85m, null },
                    { 7, new DateTime(2024, 2, 14, 13, 20, 30, 0, DateTimeKind.Unspecified), 6, 82m, null },
                    { 8, new DateTime(2024, 1, 14, 13, 20, 30, 0, DateTimeKind.Unspecified), 7, 82m, null },
                    { 9, new DateTime(2024, 2, 14, 13, 20, 30, 0, DateTimeKind.Unspecified), 7, 80m, null },
                    { 10, new DateTime(2024, 1, 14, 13, 20, 30, 0, DateTimeKind.Unspecified), 8, 62m, null },
                    { 11, new DateTime(2024, 2, 14, 13, 20, 30, 0, DateTimeKind.Unspecified), 8, 64m, null },
                    { 12, new DateTime(2024, 1, 14, 13, 20, 30, 0, DateTimeKind.Unspecified), 9, 85m, null },
                    { 13, new DateTime(2024, 2, 14, 13, 20, 30, 0, DateTimeKind.Unspecified), 9, 87m, null },
                    { 14, new DateTime(2024, 1, 14, 13, 20, 30, 0, DateTimeKind.Unspecified), 10, 57m, null },
                    { 15, new DateTime(2024, 2, 14, 13, 20, 30, 0, DateTimeKind.Unspecified), 10, 62m, null },
                    { 16, new DateTime(2024, 1, 14, 13, 20, 30, 0, DateTimeKind.Unspecified), 11, 72m, null },
                    { 17, new DateTime(2024, 2, 14, 13, 20, 30, 0, DateTimeKind.Unspecified), 11, 71m, null },
                    { 18, new DateTime(2024, 1, 14, 13, 20, 30, 0, DateTimeKind.Unspecified), 12, 52m, null },
                    { 19, new DateTime(2024, 2, 14, 13, 20, 30, 0, DateTimeKind.Unspecified), 12, 56m, null }
                });

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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Napredak",
                keyColumn: "ID",
                keyValue: 19);

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 2,
                column: "DatumRezervacija",
                value: new DateTime(2024, 2, 14, 10, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 3,
                column: "DatumRezervacija",
                value: new DateTime(2024, 2, 14, 10, 0, 0, 0, DateTimeKind.Unspecified));
        }
    }
}
