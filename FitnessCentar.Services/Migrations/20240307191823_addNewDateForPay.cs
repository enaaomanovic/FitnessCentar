using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FitnessCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class addNewDateForPay : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Placanja",
                keyColumn: "ID",
                keyValue: 1,
                column: "DatumPlacanja",
                value: new DateTime(2024, 3, 25, 0, 0, 0, 0, DateTimeKind.Unspecified));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Placanja",
                keyColumn: "ID",
                keyValue: 1,
                column: "DatumPlacanja",
                value: new DateTime(2024, 1, 19, 0, 0, 0, 0, DateTimeKind.Unspecified));
        }
    }
}
