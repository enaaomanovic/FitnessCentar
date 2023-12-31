﻿// <auto-generated />
using System;
using FitnessCentar.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace FitnessCentar.Services.Migrations
{
    [DbContext(typeof(Ib200005rs2Context))]
    [Migration("20231209164152_seedv2")]
    partial class seedv2
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "7.0.10")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("FitnessCentar.Services.Database.Aktivnosti", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Naziv")
                        .HasMaxLength(255)
                        .IsUnicode(false)
                        .HasColumnType("varchar(255)");

                    b.HasKey("Id")
                        .HasName("PK__Aktivnos__3214EC27655B8984");

                    b.ToTable("Aktivnosti", (string)null);
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Komentari", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime?>("DatumKomentara")
                        .HasColumnType("datetime");

                    b.Property<int?>("KorisnikId")
                        .HasColumnType("int")
                        .HasColumnName("KorisnikID");

                    b.Property<int?>("NovostId")
                        .HasColumnType("int")
                        .HasColumnName("NovostID");

                    b.Property<string>("Tekst")
                        .HasColumnType("text");

                    b.HasKey("Id")
                        .HasName("PK__Komentar__3214EC274354741D");

                    b.HasIndex("KorisnikId");

                    b.HasIndex("NovostId");

                    b.ToTable("Komentari", (string)null);
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Korisnici", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime?>("DatumRegistracije")
                        .HasColumnType("date");

                    b.Property<DateTime?>("DatumRodjenja")
                        .HasColumnType("date");

                    b.Property<string>("Email")
                        .HasMaxLength(255)
                        .IsUnicode(false)
                        .HasColumnType("varchar(255)");

                    b.Property<string>("Ime")
                        .HasMaxLength(255)
                        .IsUnicode(false)
                        .HasColumnType("varchar(255)");

                    b.Property<string>("KorisnickoIme")
                        .HasMaxLength(255)
                        .IsUnicode(false)
                        .HasColumnType("varchar(255)");

                    b.Property<byte[]>("LozinkaHash")
                        .IsRequired()
                        .HasMaxLength(255)
                        .IsUnicode(false)
                        .HasColumnType("varbinary(255)");

                    b.Property<byte[]>("LozinkaSalt")
                        .IsRequired()
                        .HasMaxLength(255)
                        .IsUnicode(false)
                        .HasColumnType("varbinary(255)");

                    b.Property<string>("Pol")
                        .HasMaxLength(10)
                        .IsUnicode(false)
                        .HasColumnType("varchar(10)");

                    b.Property<string>("Prezime")
                        .HasMaxLength(255)
                        .IsUnicode(false)
                        .HasColumnType("varchar(255)");

                    b.Property<byte[]>("Slika")
                        .HasColumnType("varbinary(max)");

                    b.Property<string>("Telefon")
                        .HasMaxLength(20)
                        .IsUnicode(false)
                        .HasColumnType("varchar(20)");

                    b.Property<decimal?>("Tezina")
                        .HasColumnType("decimal(5, 2)");

                    b.Property<decimal?>("Visina")
                        .HasColumnType("decimal(5, 2)");

                    b.HasKey("Id")
                        .HasName("PK__Korisnic__3214EC2736DB7549");

                    b.ToTable("Korisnici", (string)null);

                    b.HasData(
                        new
                        {
                            Id = 1,
                            DatumRegistracije = new DateTime(2023, 12, 9, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            DatumRodjenja = new DateTime(2000, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Email = "selma.kovacevic@gmail.com",
                            Ime = "Selma",
                            KorisnickoIme = "Selma",
                            LozinkaHash = new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 },
                            LozinkaSalt = new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 },
                            Pol = "Ženski",
                            Prezime = "Kovacevic",
                            Telefon = "061123123",
                            Tezina = 60m,
                            Visina = 165m
                        },
                        new
                        {
                            Id = 2,
                            DatumRegistracije = new DateTime(2023, 12, 9, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            DatumRodjenja = new DateTime(2000, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                            Email = "vildana.suta@gmail.com",
                            Ime = "Vildana",
                            KorisnickoIme = "Vildana",
                            LozinkaHash = new byte[] { 205, 173, 238, 240, 123, 28, 44, 53, 56, 164, 63, 104, 173, 124, 252, 68, 180, 14, 228, 115 },
                            LozinkaSalt = new byte[] { 0, 15, 217, 112, 57, 244, 61, 193, 39, 247, 215, 237, 250, 28, 45, 120 },
                            Pol = "Ženski",
                            Prezime = "Šuta",
                            Telefon = "061123123",
                            Tezina = 60m,
                            Visina = 165m
                        });
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Napredak", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime?>("DatumMjerenja")
                        .HasColumnType("date");

                    b.Property<int?>("KorisnikId")
                        .HasColumnType("int")
                        .HasColumnName("KorisnikID");

                    b.Property<decimal?>("Tezina")
                        .HasColumnType("decimal(5, 2)");

                    b.Property<decimal?>("Visina")
                        .HasColumnType("decimal(5, 2)");

                    b.HasKey("Id")
                        .HasName("PK__Napredak__3214EC2721435085");

                    b.HasIndex("KorisnikId");

                    b.ToTable("Napredak", (string)null);
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Novosti", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int?>("AutorId")
                        .HasColumnType("int")
                        .HasColumnName("AutorID");

                    b.Property<DateTime?>("DatumObjave")
                        .HasColumnType("datetime");

                    b.Property<string>("Naslov")
                        .HasMaxLength(255)
                        .IsUnicode(false)
                        .HasColumnType("varchar(255)");

                    b.Property<string>("Tekst")
                        .HasColumnType("text");

                    b.HasKey("Id")
                        .HasName("PK__Novosti__3214EC2703EB8099");

                    b.HasIndex("AutorId");

                    b.ToTable("Novosti", (string)null);

                    b.HasData(
                        new
                        {
                            Id = 1,
                            AutorId = 1,
                            DatumObjave = new DateTime(2023, 10, 25, 17, 55, 40, 0, DateTimeKind.Unspecified),
                            Naslov = "Obavještenje za sve aktivne clanove centra!!!",
                            Tekst = "Obavještavaju se svi clanovi fitness centra da centar nece raditi 26.10.2023 godine. Buduci da renoviramo fitness centar neophodno je bilo da zatvorimo centar na jedan dan kako bi realizacija renoviranja bila moguca.Svi koji propuste svoje termine moci ce ih nadoknaditi u terminima narednih dana. Hvala na razumijevanju."
                        },
                        new
                        {
                            Id = 2,
                            AutorId = 1,
                            DatumObjave = new DateTime(2023, 10, 26, 18, 22, 34, 0, DateTimeKind.Unspecified),
                            Naslov = "Novi zdravi recept!",
                            Tekst = "Pozdrav svim clanovima našeg centra. Danas sam isprobala jedan zdravi i brzi recept te sam odlucila da ga podjelim i sa vama. Radi se o salati od tune, ja sam koristila dodatno zelenu salatu, krastavce, kukuruz i mrkvu. Obrok je bio proteinski obogacen niskokalorican ali ipak dovoljno zasitan. Javite mi vaše utiske."
                        });
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.OdgovoriNaKomentare", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime?>("DatumOdgovora")
                        .HasColumnType("datetime");

                    b.Property<int?>("KomentarId")
                        .HasColumnType("int")
                        .HasColumnName("KomentarID");

                    b.Property<string>("Tekst")
                        .HasColumnType("text");

                    b.Property<int?>("TrenerId")
                        .HasColumnType("int")
                        .HasColumnName("TrenerID");

                    b.HasKey("Id")
                        .HasName("PK__Odgovori__3214EC273D7F3F3D");

                    b.HasIndex("KomentarId");

                    b.HasIndex("TrenerId");

                    b.ToTable("OdgovoriNaKomentare", (string)null);
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Placanja", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime?>("DatumPlacanja")
                        .HasColumnType("date");

                    b.Property<decimal?>("Iznos")
                        .HasColumnType("decimal(10, 2)");

                    b.Property<int?>("KorisnikId")
                        .HasColumnType("int")
                        .HasColumnName("KorisnikID");

                    b.HasKey("Id")
                        .HasName("PK__Placanja__3214EC27E0E744DB");

                    b.HasIndex("KorisnikId");

                    b.ToTable("Placanja", (string)null);
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Raspored", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int?>("AktivnostId")
                        .HasColumnType("int")
                        .HasColumnName("AktivnostID");

                    b.Property<int>("Dan")
                        .HasColumnType("int");

                    b.Property<DateTime?>("DatumPocetka")
                        .HasColumnType("datetime");

                    b.Property<DateTime?>("DatumZavrsetka")
                        .HasColumnType("datetime");

                    b.Property<int?>("TrenerId")
                        .HasColumnType("int")
                        .HasColumnName("TrenerID");

                    b.Property<int?>("TreningId")
                        .HasColumnType("int")
                        .HasColumnName("TreningID");

                    b.HasKey("Id")
                        .HasName("PK__Raspored__3214EC2788CB231D");

                    b.HasIndex("AktivnostId");

                    b.HasIndex("TrenerId");

                    b.HasIndex("TreningId");

                    b.ToTable("Raspored", (string)null);
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Rezervacije", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime?>("DatumRezervacija")
                        .HasColumnType("datetime");

                    b.Property<int?>("KorisnikId")
                        .HasColumnType("int")
                        .HasColumnName("KorisnikID");

                    b.Property<int?>("RasporedId")
                        .HasColumnType("int")
                        .HasColumnName("RasporedID");

                    b.Property<string>("Status")
                        .HasMaxLength(20)
                        .IsUnicode(false)
                        .HasColumnType("varchar(20)");

                    b.HasKey("Id")
                        .HasName("PK__Rezervac__3214EC2773F50FE4");

                    b.HasIndex("KorisnikId");

                    b.HasIndex("RasporedId");

                    b.ToTable("Rezervacije", (string)null);
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Treneri", b =>
                {
                    b.Property<int>("Id")
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    b.Property<string>("Specijalnost")
                        .HasMaxLength(255)
                        .IsUnicode(false)
                        .HasColumnType("varchar(255)");

                    b.HasKey("Id")
                        .HasName("PK__Treneri__3214EC272DC32C04");

                    b.ToTable("Treneri", (string)null);

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Specijalnost = "Personalni trener"
                        });
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Treningi", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Naziv")
                        .HasMaxLength(255)
                        .IsUnicode(false)
                        .HasColumnType("varchar(255)");

                    b.Property<string>("Opis")
                        .HasColumnType("text");

                    b.Property<int?>("Trajanje")
                        .HasColumnType("int");

                    b.HasKey("Id")
                        .HasName("PK__Treningi__3214EC271B3ECC22");

                    b.ToTable("Treningi", (string)null);
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Komentari", b =>
                {
                    b.HasOne("FitnessCentar.Services.Database.Korisnici", "Korisnik")
                        .WithMany("Komentaris")
                        .HasForeignKey("KorisnikId")
                        .HasConstraintName("FK__Komentari__Koris__7A672E12");

                    b.HasOne("FitnessCentar.Services.Database.Novosti", "Novost")
                        .WithMany("Komentaris")
                        .HasForeignKey("NovostId")
                        .HasConstraintName("FK__Komentari__Novos__797309D9");

                    b.Navigation("Korisnik");

                    b.Navigation("Novost");
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Napredak", b =>
                {
                    b.HasOne("FitnessCentar.Services.Database.Korisnici", "Korisnik")
                        .WithMany("Napredaks")
                        .HasForeignKey("KorisnikId")
                        .HasConstraintName("FK__Napredak__Visina__6FE99F9F");

                    b.Navigation("Korisnik");
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Novosti", b =>
                {
                    b.HasOne("FitnessCentar.Services.Database.Treneri", "Autor")
                        .WithMany("Novostis")
                        .HasForeignKey("AutorId")
                        .HasConstraintName("FK__Novosti__AutorID__72C60C4A");

                    b.Navigation("Autor");
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.OdgovoriNaKomentare", b =>
                {
                    b.HasOne("FitnessCentar.Services.Database.Komentari", "Komentar")
                        .WithMany("OdgovoriNaKomentares")
                        .HasForeignKey("KomentarId")
                        .HasConstraintName("FK__OdgovoriN__Komen__7D439ABD");

                    b.HasOne("FitnessCentar.Services.Database.Treneri", "Trener")
                        .WithMany("OdgovoriNaKomentares")
                        .HasForeignKey("TrenerId")
                        .HasConstraintName("FK__OdgovoriN__Trene__7E37BEF6");

                    b.Navigation("Komentar");

                    b.Navigation("Trener");
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Placanja", b =>
                {
                    b.HasOne("FitnessCentar.Services.Database.Korisnici", "Korisnik")
                        .WithMany("Placanjas")
                        .HasForeignKey("KorisnikId")
                        .HasConstraintName("FK__Placanja__Korisn__6D0D32F4");

                    b.Navigation("Korisnik");
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Raspored", b =>
                {
                    b.HasOne("FitnessCentar.Services.Database.Aktivnosti", "Aktivnost")
                        .WithMany("Rasporeds")
                        .HasForeignKey("AktivnostId")
                        .HasConstraintName("FK__Raspored__Aktivn__66603565");

                    b.HasOne("FitnessCentar.Services.Database.Treneri", "Trener")
                        .WithMany("Rasporeds")
                        .HasForeignKey("TrenerId")
                        .HasConstraintName("FK__Raspored__Trener__656C112C");

                    b.HasOne("FitnessCentar.Services.Database.Treningi", "Trening")
                        .WithMany("Rasporeds")
                        .HasForeignKey("TreningId")
                        .HasConstraintName("FK__Raspored__Trenin__6477ECF3");

                    b.Navigation("Aktivnost");

                    b.Navigation("Trener");

                    b.Navigation("Trening");
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Rezervacije", b =>
                {
                    b.HasOne("FitnessCentar.Services.Database.Korisnici", "Korisnik")
                        .WithMany("Rezervacijes")
                        .HasForeignKey("KorisnikId")
                        .HasConstraintName("FK__Rezervaci__Koris__693CA210");

                    b.HasOne("FitnessCentar.Services.Database.Raspored", "Raspored")
                        .WithMany("Rezervacijes")
                        .HasForeignKey("RasporedId")
                        .HasConstraintName("FK__Rezervaci__Raspo__6A30C649");

                    b.Navigation("Korisnik");

                    b.Navigation("Raspored");
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Treneri", b =>
                {
                    b.HasOne("FitnessCentar.Services.Database.Korisnici", "Korisnik")
                        .WithOne("Trener")
                        .HasForeignKey("FitnessCentar.Services.Database.Treneri", "Id")
                        .IsRequired()
                        .HasConstraintName("FK__Treneri__Korisni__01142BA1");

                    b.Navigation("Korisnik");
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Aktivnosti", b =>
                {
                    b.Navigation("Rasporeds");
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Komentari", b =>
                {
                    b.Navigation("OdgovoriNaKomentares");
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Korisnici", b =>
                {
                    b.Navigation("Komentaris");

                    b.Navigation("Napredaks");

                    b.Navigation("Placanjas");

                    b.Navigation("Rezervacijes");

                    b.Navigation("Trener")
                        .IsRequired();
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Novosti", b =>
                {
                    b.Navigation("Komentaris");
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Raspored", b =>
                {
                    b.Navigation("Rezervacijes");
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Treneri", b =>
                {
                    b.Navigation("Novostis");

                    b.Navigation("OdgovoriNaKomentares");

                    b.Navigation("Rasporeds");
                });

            modelBuilder.Entity("FitnessCentar.Services.Database.Treningi", b =>
                {
                    b.Navigation("Rasporeds");
                });
#pragma warning restore 612, 618
        }
    }
}
