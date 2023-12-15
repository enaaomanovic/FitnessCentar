using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FitnessCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class Table_preporuka : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "PregledaneNovostis",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NovostId = table.Column<int>(type: "int", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PregledaneNovostis", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PregledaneNovostis_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_PregledaneNovostis_Novosti_NovostId",
                        column: x => x.NovostId,
                        principalTable: "Novosti",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Recommender",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NovostId = table.Column<int>(type: "int", nullable: false),
                    CoNovostId1 = table.Column<int>(type: "int", nullable: false),
                    CoNovostId2 = table.Column<int>(type: "int", nullable: false),
                    CoNovostId3 = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Recommender", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_PregledaneNovostis_KorisnikId",
                table: "PregledaneNovostis",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_PregledaneNovostis_NovostId",
                table: "PregledaneNovostis",
                column: "NovostId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "PregledaneNovostis");

            migrationBuilder.DropTable(
                name: "Recommender");
        }
    }
}
