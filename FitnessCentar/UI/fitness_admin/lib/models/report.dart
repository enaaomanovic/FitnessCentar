class KorisniciReport {
  late String ime;
  late String prezime;
  late String korisnickoIme;
  late String email;
  late String telefon;
  late DateTime datumRegistracije;
  late DateTime datumRodjenja;
  late String pol;
  late double tezina;
  late double visina;
  late String slika;
  late String lozinka;

  KorisniciReport({
    required this.ime,
    required this.prezime,
    required this.korisnickoIme,
    required this.email,
    required this.telefon,
    required this.datumRegistracije,
    required this.datumRodjenja,
    required this.pol,
    required this.tezina,
    required this.visina,
    required this.slika,
    required this.lozinka,
  });
}
