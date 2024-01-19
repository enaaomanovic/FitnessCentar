using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FitnessCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class lastrezervacija : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 1,
                column: "Status",
                value: "Placena");

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 2,
                column: "Status",
                value: "Placena");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 1,
                column: "Status",
                value: "Aktivna");

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 2,
                column: "Status",
                value: "Aktivna");
        }
    }
}
