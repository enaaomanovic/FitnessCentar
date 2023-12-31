﻿using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace FitnessCentar.Services.Database;

public partial class Ib200005rs2Context : DbContext
{
    public Ib200005rs2Context(DbContextOptions<Ib200005rs2Context> options)
        : base(options)
    {
    }

    public virtual DbSet<Aktivnosti> Aktivnostis { get; set; }

    public virtual DbSet<Komentari> Komentaris { get; set; }

    public virtual DbSet<Korisnici> Korisnicis { get; set; }

    public virtual DbSet<Napredak> Napredaks { get; set; }

    public virtual DbSet<Novosti> Novostis { get; set; }

    public virtual DbSet<OdgovoriNaKomentare> OdgovoriNaKomentares { get; set; }

    public virtual DbSet<Placanja> Placanjas { get; set; }

    public virtual DbSet<Raspored> Rasporeds { get; set; }

    public virtual DbSet<Rezervacije> Rezervacijes { get; set; }

    public virtual DbSet<Treneri> Treneris { get; set; }

    public virtual DbSet<Treningi> Treningis { get; set; }
    public virtual DbSet<PregledaneNovosti> PregledaneNovostis { get; set; }
    public virtual DbSet<Recommender> Recommender { get; set; }


    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        SeedData(modelBuilder);

        modelBuilder.Entity<Aktivnosti>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Aktivnos__3214EC27655B8984");

            entity.ToTable("Aktivnosti");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Naziv)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Komentari>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Komentar__3214EC274354741D");

            entity.ToTable("Komentari");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.DatumKomentara).HasColumnType("datetime");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.NovostId).HasColumnName("NovostID");
            entity.Property(e => e.Tekst).HasColumnType("text");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Komentaris)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK__Komentari__Koris__7A672E12");

            entity.HasOne(d => d.Novost).WithMany(p => p.Komentaris)
                .HasForeignKey(d => d.NovostId)
                .HasConstraintName("FK__Komentari__Novos__797309D9");
        });

        modelBuilder.Entity<Korisnici>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Korisnic__3214EC2736DB7549");

            entity.ToTable("Korisnici");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.DatumRegistracije).HasColumnType("date");
            entity.Property(e => e.DatumRodjenja).HasColumnType("date");
            entity.Property(e => e.Email)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Ime)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.KorisnickoIme)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.LozinkaHash)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.LozinkaSalt)
              .HasMaxLength(255)
              .IsUnicode(false);
            entity.Property(e => e.Pol)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.Prezime)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Telefon)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Tezina).HasColumnType("decimal(5, 2)");
            entity.Property(e => e.Visina).HasColumnType("decimal(5, 2)");
        });

        modelBuilder.Entity<Napredak>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Napredak__3214EC2721435085");

            entity.ToTable("Napredak");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.DatumMjerenja).HasColumnType("date");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.Tezina).HasColumnType("decimal(5, 2)");
            entity.Property(e => e.Visina).HasColumnType("decimal(5, 2)");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Napredaks)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK__Napredak__Visina__6FE99F9F");
        });

        modelBuilder.Entity<Novosti>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Novosti__3214EC2703EB8099");

            entity.ToTable("Novosti");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.AutorId).HasColumnName("AutorID");
            entity.Property(e => e.DatumObjave).HasColumnType("datetime");
            entity.Property(e => e.Naslov)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Tekst).HasColumnType("text");

            entity.HasOne(d => d.Autor).WithMany(p => p.Novostis)
                .HasForeignKey(d => d.AutorId)
                .HasConstraintName("FK__Novosti__AutorID__72C60C4A");
        });

        modelBuilder.Entity<OdgovoriNaKomentare>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Odgovori__3214EC273D7F3F3D");

            entity.ToTable("OdgovoriNaKomentare");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.DatumOdgovora).HasColumnType("datetime");
            entity.Property(e => e.KomentarId).HasColumnName("KomentarID");
            entity.Property(e => e.Tekst).HasColumnType("text");
            entity.Property(e => e.TrenerId).HasColumnName("TrenerID");

            entity.HasOne(d => d.Komentar).WithMany(p => p.OdgovoriNaKomentares)
                .HasForeignKey(d => d.KomentarId)
                .HasConstraintName("FK__OdgovoriN__Komen__7D439ABD");

            entity.HasOne(d => d.Trener).WithMany(p => p.OdgovoriNaKomentares)
                .HasForeignKey(d => d.TrenerId)
                .HasConstraintName("FK__OdgovoriN__Trene__7E37BEF6");
        });

        modelBuilder.Entity<Placanja>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Placanja__3214EC27E0E744DB");

            entity.ToTable("Placanja");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.DatumPlacanja).HasColumnType("date");
            entity.Property(e => e.Iznos).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Placanjas)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK__Placanja__Korisn__6D0D32F4");
        });

        modelBuilder.Entity<Raspored>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Raspored__3214EC2788CB231D");

            entity.ToTable("Raspored");
            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.AktivnostId).HasColumnName("AktivnostID");
            entity.Property(e => e.DatumPocetka).HasColumnType("datetime");
            entity.Property(e => e.DatumZavrsetka).HasColumnType("datetime");
            entity.Property(e => e.TrenerId).HasColumnName("TrenerID");
            entity.Property(e => e.TreningId).HasColumnName("TreningID");

            entity.HasOne(d => d.Aktivnost).WithMany(p => p.Rasporeds)
                .HasForeignKey(d => d.AktivnostId)
                .HasConstraintName("FK__Raspored__Aktivn__66603565");

            entity.HasOne(d => d.Trener).WithMany(p => p.Rasporeds)
                .HasForeignKey(d => d.TrenerId)
                .HasConstraintName("FK__Raspored__Trener__656C112C");

            entity.HasOne(d => d.Trening).WithMany(p => p.Rasporeds)
                .HasForeignKey(d => d.TreningId)
                .HasConstraintName("FK__Raspored__Trenin__6477ECF3");
        });

        modelBuilder.Entity<Rezervacije>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Rezervac__3214EC2773F50FE4");

            entity.ToTable("Rezervacije");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.DatumRezervacija).HasColumnType("datetime");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.RasporedId).HasColumnName("RasporedID");
            entity.Property(e => e.Status)
                .HasMaxLength(20)
                .IsUnicode(false);

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Rezervacijes)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK__Rezervaci__Koris__693CA210");

            entity.HasOne(d => d.Raspored).WithMany(p => p.Rezervacijes)
                .HasForeignKey(d => d.RasporedId)
                .HasConstraintName("FK__Rezervaci__Raspo__6A30C649");
        });

        modelBuilder.Entity<Treneri>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Treneri__3214EC272DC32C04");

            entity.ToTable("Treneri");

            entity.Property(e => e.Id).HasColumnName("ID");
           
            
            entity.HasOne(d => d.Korisnik)
                    .WithOne(p => p.Trener)
                    .HasForeignKey<Treneri>(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Treneri__Korisni__01142BA1"); ;
            
            entity.Property(e => e.Specijalnost)
                .HasMaxLength(255)
                .IsUnicode(false);

          
               
               
        });

        modelBuilder.Entity<Treningi>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Treningi__3214EC271B3ECC22");

            entity.ToTable("Treningi");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Naziv)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Opis).HasColumnType("text");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
