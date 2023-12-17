import 'package:fitness_admin/models/aktivnosti.dart';
import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/models/placanja.dart';
import 'package:fitness_admin/models/raspored.dart';
import 'package:fitness_admin/models/rezervacija.dart';
import 'package:fitness_admin/models/trening.dart';
import 'package:fitness_admin/providers/active_provider.dart';
import 'package:fitness_admin/providers/pay_provider.dart';
import 'package:fitness_admin/providers/reservation_provider.dart';
import 'package:fitness_admin/providers/user_provider.dart';
import 'package:fitness_admin/screens/user_details_screens.dart';

import 'package:fitness_admin/widgets/master_screens.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class WorkoutDetails extends StatefulWidget {
  final Trening trening;
  final Raspored raspored;

  WorkoutDetails({Key? key, required this.trening, required this.raspored})
      : super(key: key);

  @override
  State<WorkoutDetails> createState() => _WorkoutDetails();
}

class _WorkoutDetails extends State<WorkoutDetails> {
  late ActiveProvider _activeProvider;
  late UserProvider _userProvider;
  late ReservationProvider _reservationProvider;
  late PayProvider _payProvider;
  List<Rezervacija> validneRezervacije = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _activeProvider = context.read<ActiveProvider>();
    _userProvider = context.read<UserProvider>();
    _reservationProvider = context.read<ReservationProvider>();
    _payProvider = context.read<PayProvider>();

    initForm();

    RealRezervacije();
  }

  Future initForm() async {
    setState(() {
      isLoading = false;
    });
  }

  Future<Aktivnosti?> getAktivnostFromUserId(int aktivnostId) async {
    final aktivnost = await _activeProvider.getById(aktivnostId);

    return aktivnost;
  }

  Future<Korisnici?> getKorisnikFromUserId(int userid) async {
    final user = await _userProvider.getById(userid);

    return user;
  }

  Future<List<Placanja?>> GetPlacanja() async {
    var searchResult = await _payProvider.get();

    if (searchResult != null && searchResult.result.isNotEmpty) {
      List<Placanja> data = searchResult.result;

      return data;
    }
    return [];
  }

  Future<List<Rezervacija?>> GetRezervacije() async {
    final rasporedId = widget.raspored.id;
    var searchResult = await _reservationProvider.get(filter: {
      "status": "Plaćena",
      'rasporedId': rasporedId.toString(),
    });
    if (searchResult != null && searchResult.result.isNotEmpty) {
      List<Rezervacija> data = searchResult.result;
      return data;
    }
    return [];
  }

  Future<List<Rezervacija>> RealRezervacije() async {
    var placanja = await GetPlacanja();
    var rezervacije = await GetRezervacije();
    if (placanja != null && rezervacije != null) {
      for (var placanje in placanja) {
        for (var rezervacija in rezervacije) {
          if (rezervacija?.placanjeId == placanje?.id) {
            DateTime? datumPlacanja = placanje?.datumPlacanja;
            DateTime trenutniDatum = DateTime.now();
            Duration razlika = trenutniDatum.difference(datumPlacanja!);

            if (razlika.inDays <= 30) {
              setState(() {
                validneRezervacije.add(rezervacija!);
              });
            }
          }
        }
      }
    }

    return validneRezervacije;
  }

  Rezervacija? selectedReservation;

  void onReservationChanged(Rezervacija? newValue) {
    setState(() {
      selectedReservation = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      title_widget: Text("Detalji treninga"),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: isLoading ? Container() : _buildWorkout(),
              ),
              SizedBox(width: 20),
              Center(
                child: isLoading
                    ? Container()
                    : _buildDataListView(validneRezervacije),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkout() {
    final trening = widget.trening;
    final raspored = widget.raspored;

    return Center(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          width: 700,
          height: 650,
          padding: const EdgeInsets.all(40.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                "Detalji odabranog treninga",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "Ime treninga:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                trening.naziv ?? "Nema informacija",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                "Opis treninga:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                trening.opis ?? "Nema informacija",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                "Satnica treninga:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Trening traje od ${raspored.datumPocetka != null ? DateFormat('HH:mm').format(raspored.datumPocetka!) : 'Nema informacija'} do ${raspored.datumZavrsetka != null ? DateFormat('HH:mm').format(raspored.datumZavrsetka!) : 'Nema informacija'} sati",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                "Aktivnost treninga:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FutureBuilder<Aktivnosti?>(
                future: getAktivnostFromUserId(raspored.aktivnostId ?? 0),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Greška: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final aktivnost = snapshot.data!;
                    return Text(
                      aktivnost.naziv ?? "Nema informacija",
                      style: TextStyle(fontSize: 20),
                    );
                  } else {
                    return Text('Nema dostupnih podataka');
                  }
                },
              ),
              SizedBox(height: 10),
              Text(
                "Na ovom treningu se družite sa:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FutureBuilder<Korisnici?>(
                future: getKorisnikFromUserId(raspored.trenerId ?? 0),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Greška: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final user = snapshot.data!;
                    return Text(
                      "${user.ime} ${user.prezime}",
                      style: TextStyle(fontSize: 20),
                    );
                  } else {
                    return Text('Nema dostupnih podataka');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataListView(List<Rezervacija> validneRezervacije) {
    return Center(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          width: 700,
          height: 650,
          padding: const EdgeInsets.all(40.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                "Korisnici koji su rezervirali ovaj termin",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              if (validneRezervacije == null || validneRezervacije.isEmpty)
                Text(
                  "Ovaj termin nije rezervisao nijedan korisnik",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                )
              else
                Center(
                  child: Card(
                    child: DataTable(
                      columnSpacing: 200,
                      dataRowMinHeight: 80,
                      dataRowMaxHeight: 80,
                      columns: [
                        DataColumn(
                          label: Text(
                            '',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ],
                      rows: validneRezervacije
                              .map((Rezervacija e) => DataRow(
                                    onSelectChanged: (selected) async {
                                      if (selected == true) {
                                        if (e.korisnikId != null &&
                                            e.korisnikId != 0) {
                                          final korisnik =
                                              await getKorisnikFromUserId(
                                                  e.korisnikId ?? 0);
                                          if (korisnik != null) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UserDetalScreen(
                                                  korisnik: korisnik,
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    },
                                    cells: [
                                      DataCell(
                                        FutureBuilder<Korisnici?>(
                                          future: getKorisnikFromUserId(
                                              e.korisnikId ?? 0),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Greška: ${snapshot.error}');
                                            } else if (snapshot.hasData) {
                                              final korisnik = snapshot.data!;
                                              final imageWidget = korisnik
                                                              .slika !=
                                                          null &&
                                                      korisnik.slika!.isNotEmpty
                                                  ? Container(
                                                      width: 70,
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40),
                                                        child: Image.memory(
                                                          base64Decode(
                                                              korisnik.slika!),
                                                          width: 70,
                                                          height: 70,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      width: 70,
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(40),
                                                        child: Image.asset(
                                                          'assets/images/male_icon.jpg',
                                                          width: 80,
                                                          height: 80,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    );

                                              return Row(
                                                children: [
                                                  imageWidget,
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "${korisnik.ime} ${korisnik.prezime}",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return Text(
                                                  'Nema dostupnih podataka');
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ))
                              .toList() ??
                          [],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
