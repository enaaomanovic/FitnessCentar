using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FitnessCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class rezervacija : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "PlacanjeId",
                table: "Rezervacije",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TxnId",
                table: "Placanja",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 1,
                column: "PlacanjeId",
                value: null);

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 2,
                column: "PlacanjeId",
                value: null);

            migrationBuilder.UpdateData(
                table: "Rezervacije",
                keyColumn: "ID",
                keyValue: 3,
                column: "PlacanjeId",
                value: null);

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacije_PlacanjeId",
                table: "Rezervacije",
                column: "PlacanjeId");

            migrationBuilder.AddForeignKey(
                name: "FK_Rezervacije_Placanja_PlacanjeId",
                table: "Rezervacije",
                column: "PlacanjeId",
                principalTable: "Placanja",
                principalColumn: "ID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Rezervacije_Placanja_PlacanjeId",
                table: "Rezervacije");

            migrationBuilder.DropIndex(
                name: "IX_Rezervacije_PlacanjeId",
                table: "Rezervacije");

            migrationBuilder.DropColumn(
                name: "PlacanjeId",
                table: "Rezervacije");

            migrationBuilder.DropColumn(
                name: "TxnId",
                table: "Placanja");
        }
    }
}
