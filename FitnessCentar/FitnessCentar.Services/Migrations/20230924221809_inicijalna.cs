using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FitnessCentar.Services.Migrations
{
    /// <inheritdoc />
    public partial class inicijalna : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Aktivnosti",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Aktivnos__3214EC27655B8984", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Korisnici",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    Prezime = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    KorisnickoIme = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    LozinkaHash = table.Column<byte[]>(type: "varbinary(255)", unicode: false, maxLength: 255, nullable: false),
                    LozinkaSalt = table.Column<byte[]>(type: "varbinary(255)", unicode: false, maxLength: 255, nullable: false),
                    Email = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    Telefon = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: true),
                    DatumRegistracije = table.Column<DateTime>(type: "date", nullable: true),
                    DatumRodjenja = table.Column<DateTime>(type: "date", nullable: true),
                    Pol = table.Column<string>(type: "varchar(10)", unicode: false, maxLength: 10, nullable: true),
                    Tezina = table.Column<decimal>(type: "decimal(5,2)", nullable: true),
                    Visina = table.Column<decimal>(type: "decimal(5,2)", nullable: true),
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Korisnic__3214EC2736DB7549", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Treningi",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    Opis = table.Column<string>(type: "text", nullable: true),
                    Trajanje = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Treningi__3214EC271B3ECC22", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Napredak",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikID = table.Column<int>(type: "int", nullable: true),
                    DatumMjerenja = table.Column<DateTime>(type: "date", nullable: true),
                    Tezina = table.Column<decimal>(type: "decimal(5,2)", nullable: true),
                    Visina = table.Column<decimal>(type: "decimal(5,2)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Napredak__3214EC2721435085", x => x.ID);
                    table.ForeignKey(
                        name: "FK__Napredak__Visina__6FE99F9F",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnici",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Placanja",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikID = table.Column<int>(type: "int", nullable: true),
                    DatumPlacanja = table.Column<DateTime>(type: "date", nullable: true),
                    Iznos = table.Column<decimal>(type: "decimal(10,2)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Placanja__3214EC27E0E744DB", x => x.ID);
                    table.ForeignKey(
                        name: "FK__Placanja__Korisn__6D0D32F4",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnici",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Treneri",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false),
                    Ime = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    Prezime = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    Specijalnost = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Treneri__3214EC272DC32C04", x => x.ID);
                    table.ForeignKey(
                        name: "FK__Treneri__Korisni__01142BA1",
                        column: x => x.ID,
                        principalTable: "Korisnici",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Novosti",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naslov = table.Column<string>(type: "varchar(255)", unicode: false, maxLength: 255, nullable: true),
                    Tekst = table.Column<string>(type: "text", nullable: true),
                    DatumObjave = table.Column<DateTime>(type: "datetime", nullable: true),
                    AutorID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Novosti__3214EC2703EB8099", x => x.ID);
                    table.ForeignKey(
                        name: "FK__Novosti__AutorID__72C60C4A",
                        column: x => x.AutorID,
                        principalTable: "Treneri",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Raspored",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DatumPocetka = table.Column<DateTime>(type: "datetime", nullable: true),
                    DatumZavrsetka = table.Column<DateTime>(type: "datetime", nullable: true),
                    TreningID = table.Column<int>(type: "int", nullable: true),
                    TrenerID = table.Column<int>(type: "int", nullable: true),
                    AktivnostID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Raspored__3214EC2788CB231D", x => x.ID);
                    table.ForeignKey(
                        name: "FK__Raspored__Aktivn__66603565",
                        column: x => x.AktivnostID,
                        principalTable: "Aktivnosti",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__Raspored__Trener__656C112C",
                        column: x => x.TrenerID,
                        principalTable: "Treneri",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__Raspored__Trenin__6477ECF3",
                        column: x => x.TreningID,
                        principalTable: "Treningi",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Komentari",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NovostID = table.Column<int>(type: "int", nullable: true),
                    KorisnikID = table.Column<int>(type: "int", nullable: true),
                    Tekst = table.Column<string>(type: "text", nullable: true),
                    DatumKomentara = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Komentar__3214EC274354741D", x => x.ID);
                    table.ForeignKey(
                        name: "FK__Komentari__Koris__7A672E12",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnici",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__Komentari__Novos__797309D9",
                        column: x => x.NovostID,
                        principalTable: "Novosti",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Rezervacije",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikID = table.Column<int>(type: "int", nullable: true),
                    RasporedID = table.Column<int>(type: "int", nullable: true),
                    Status = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: true),
                    DatumRezervacija = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Rezervac__3214EC2773F50FE4", x => x.ID);
                    table.ForeignKey(
                        name: "FK__Rezervaci__Koris__693CA210",
                        column: x => x.KorisnikID,
                        principalTable: "Korisnici",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__Rezervaci__Raspo__6A30C649",
                        column: x => x.RasporedID,
                        principalTable: "Raspored",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "OdgovoriNaKomentare",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KomentarID = table.Column<int>(type: "int", nullable: true),
                    TrenerID = table.Column<int>(type: "int", nullable: true),
                    Tekst = table.Column<string>(type: "text", nullable: true),
                    DatumOdgovora = table.Column<DateTime>(type: "datetime", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Odgovori__3214EC273D7F3F3D", x => x.ID);
                    table.ForeignKey(
                        name: "FK__OdgovoriN__Komen__7D439ABD",
                        column: x => x.KomentarID,
                        principalTable: "Komentari",
                        principalColumn: "ID");
                    table.ForeignKey(
                        name: "FK__OdgovoriN__Trene__7E37BEF6",
                        column: x => x.TrenerID,
                        principalTable: "Treneri",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Komentari_KorisnikID",
                table: "Komentari",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_Komentari_NovostID",
                table: "Komentari",
                column: "NovostID");

            migrationBuilder.CreateIndex(
                name: "IX_Napredak_KorisnikID",
                table: "Napredak",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_Novosti_AutorID",
                table: "Novosti",
                column: "AutorID");

            migrationBuilder.CreateIndex(
                name: "IX_OdgovoriNaKomentare_KomentarID",
                table: "OdgovoriNaKomentare",
                column: "KomentarID");

            migrationBuilder.CreateIndex(
                name: "IX_OdgovoriNaKomentare_TrenerID",
                table: "OdgovoriNaKomentare",
                column: "TrenerID");

            migrationBuilder.CreateIndex(
                name: "IX_Placanja_KorisnikID",
                table: "Placanja",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_Raspored_AktivnostID",
                table: "Raspored",
                column: "AktivnostID");

            migrationBuilder.CreateIndex(
                name: "IX_Raspored_TrenerID",
                table: "Raspored",
                column: "TrenerID");

            migrationBuilder.CreateIndex(
                name: "IX_Raspored_TreningID",
                table: "Raspored",
                column: "TreningID");

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacije_KorisnikID",
                table: "Rezervacije",
                column: "KorisnikID");

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacije_RasporedID",
                table: "Rezervacije",
                column: "RasporedID");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Napredak");

            migrationBuilder.DropTable(
                name: "OdgovoriNaKomentare");

            migrationBuilder.DropTable(
                name: "Placanja");

            migrationBuilder.DropTable(
                name: "Rezervacije");

            migrationBuilder.DropTable(
                name: "Komentari");

            migrationBuilder.DropTable(
                name: "Raspored");

            migrationBuilder.DropTable(
                name: "Novosti");

            migrationBuilder.DropTable(
                name: "Aktivnosti");

            migrationBuilder.DropTable(
                name: "Treningi");

            migrationBuilder.DropTable(
                name: "Treneri");

            migrationBuilder.DropTable(
                name: "Korisnici");
        }
    }
}
