import 'dart:convert';

import 'package:fitness_admin/models/aktivnosti.dart';
import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/models/placanja.dart';
import 'package:fitness_admin/models/raspored.dart';
import 'package:fitness_admin/models/rezervacija.dart';
import 'package:fitness_admin/models/trening.dart';
import 'package:fitness_admin/providers/active_provider.dart';
import 'package:fitness_admin/providers/pay_provider.dart';
import 'package:fitness_admin/providers/reservation_provider.dart';
import 'package:fitness_admin/providers/schedule_provider.dart';
import 'package:fitness_admin/providers/workout_provider.dart';
import 'package:fitness_admin/screens/user_details_screens.dart';
import 'package:fitness_admin/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../utils/util.dart';

class UnpaidReservationListScrean extends StatefulWidget {
  const UnpaidReservationListScrean({Key? key}) : super(key: key);

  @override
  State<UnpaidReservationListScrean> createState() => _UnpaidReservationListScrean();
}

class _UnpaidReservationListScrean extends State<UnpaidReservationListScrean> {
  late UserProvider _userProvider;
  late ReservationProvider _reservationProvider;
  late ScheduleProvider _scheduleProvider;
  late ActiveProvider _activeProvider;
  late WorkoutProvider _workoutProvider;
  late PayProvider _payProvider;

  List<Rezervacija>? pageresult;

  var page = 1;
  var totalcount = 0;
  var numberOfPpl = 3;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _reservationProvider = context.read<ReservationProvider>();
    _scheduleProvider = context.read<ScheduleProvider>();
    _activeProvider = context.read<ActiveProvider>();
    _workoutProvider = context.read<WorkoutProvider>();
    _payProvider = context.read<PayProvider>();
    initForm();
    _loadData();
  }

  Future initForm() async {
    setState(() {
      isLoading = false;
    });
  }

  void _loadData() async {
    var placanja = await GetPlacanja();
    var data = await _reservationProvider.getPaged(
      filter: {'page': page, 'pageSize': numberOfPpl, 'status': 'Aktivna'},
    );

    setState(() {
      totalcount = data.count!;
      pageresult = data.result;

    });
  }



  Future<Korisnici?> getUserFromUserId(int userId) async {
    final user = await _userProvider.getById(userId);
    return user;
  }

  Future<Aktivnosti?> getAktivnostFromAktivnostId(int aktId) async {
    final akt = await _activeProvider.getById(aktId);
    return akt;
  }

  Future<Trening?> getTreningFromTreningId(int trenId) async {
    final tren = await _workoutProvider.getById(trenId);
    return tren;
  }

  Future<Raspored?> getRasporedFromRasporedId(int raspId) async {
    try {
      final raspored = await _scheduleProvider.getById(raspId);
      return raspored;
    } catch (e) {
      print('Error fetching Raspored: $e');
      return null;
    }
  }

  Future<List<Placanja?>> GetPlacanja() async {
    var searchResult = await _payProvider.get(filter: {});

    if (searchResult != null && searchResult.result.isNotEmpty) {
      List<Placanja> data = searchResult.result;

      return data;
    }
    return [];
  }

  String _dayOfWeekToString(int dan) {
    switch (dan) {
      case 0:
        return 'Ned';
      case 1:
        return 'Ponedjeljak';
      case 2:
        return 'Utorak';
      case 3:
        return 'Srijeda';
      case 4:
        return 'Červrtak';
      case 5:
        return 'Petak';

      default:
        return '';
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      title_widget: Text("Neplacene rezervacije"),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: isLoading
                    ? Container()
                    : Column(
                        children: [
                       
                          _buildReservation(),
                          _buildPageNumbers(),
                        ],
                      ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }



  Widget _buildReservation() {
    return Expanded(
      child: pageresult != null && pageresult!.isNotEmpty
          ? ListView.builder(
              itemCount: pageresult!.length,
              itemBuilder: (context, index) {
                

                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(
                      color: Colors.yellow,
                      width: 3.0,
                    ),
                  ),
                  margin: EdgeInsets.all(16.0),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 32,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 80.0,
                        right: 80.0,
                        bottom: 20.0,
                        top: 20.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<Korisnici?>(
                            future: getUserFromUserId(
                                pageresult![index].korisnikId!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                Korisnici? user = snapshot.data;

                                Widget getUserImage() {
                                  final base64Image = user?.slika;
                                  if (base64Image != null &&
                                      base64Image.isNotEmpty) {
                                    try {
                                      final decodedImage =
                                          base64.decode(base64Image);
                                      return CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            MemoryImage(decodedImage),
                                      );
                                    } catch (e) {}
                                  }

                                  return CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(
                                        'assets/images/male_icon.jpg'),
                                  );
                                }

                                return FutureBuilder<Raspored?>(
                                  future: getRasporedFromRasporedId(
                                      pageresult![index].rasporedId!),
                                  builder: (context, rasporedSnapshot) {
                                    if (rasporedSnapshot.connectionState ==
                                        ConnectionState.done) {
                                      Raspored? raspored =
                                          rasporedSnapshot.data;

                                      final boldTextStyle = TextStyle(
                                          fontWeight: FontWeight.bold);

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            title: Text(
                                                'Rezervacija REZ00${pageresult![index].id}'),
                                            leading: getUserImage(),
                                          ),
                                          Divider(),
                                          SizedBox(height: 16.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  _buildInfoRow(
                                                    'Korisnik: ',
                                                    '${user?.ime ?? 'Nepoznat'} ${user?.prezime ?? 'Nepoznat'}',
                                                  ),
                                                  _buildInfoRow(
                                                      'Status rezervacije: ',
                                                      '${pageresult![index].status}'),
                                                  _buildInfoRow(
                                                      'Datum rezervacije: ',
                                                      '${DateFormat('yyyy-MM-dd').format(pageresult![index].datumRezervacija!)}'),
                                                  FutureBuilder<Trening?>(
                                                    future:
                                                        getTreningFromTreningId(
                                                            raspored?.treningId ??
                                                                0),
                                                    builder: (context,
                                                        treningSnapshot) {
                                                      if (treningSnapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .done) {
                                                        Trening? trening =
                                                            treningSnapshot
                                                                .data;
                                                        return _buildInfoRow(
                                                            'Trening: ',
                                                            '${trening?.naziv ?? 'Nepoznat'} ');
                                                      } else {
                                                        return _buildInfoRow(
                                                            'Trening: ',
                                                            'Loading...');
                                                      }
                                                    },
                                                  ),
                                                  FutureBuilder<Aktivnosti?>(
                                                    future: getAktivnostFromAktivnostId(
                                                        raspored?.aktivnostId ??
                                                            0),
                                                    builder: (context,
                                                        aktivnostSnapshot) {
                                                      if (aktivnostSnapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .done) {
                                                        Aktivnosti? aktivnost =
                                                            aktivnostSnapshot
                                                                .data;
                                                        return _buildInfoRow(
                                                            'Aktivnost: ',
                                                            '${aktivnost?.naziv ?? 'Nepoznat'}');
                                                      } else {
                                                        return _buildInfoRow(
                                                            'Aktivnost: ',
                                                            'Loading...');
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  FutureBuilder<Korisnici?>(
                                                    future: getUserFromUserId(
                                                        raspored?.trenerId ??
                                                            0),
                                                    builder: (context,
                                                        trenerSnapshot) {
                                                      if (trenerSnapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .done) {
                                                        Korisnici? trener =
                                                            trenerSnapshot.data;
                                                        return _buildInfoRow(
                                                            'Trener: ',
                                                            '${trener?.ime ?? 'Nepoznat'} ${trener?.prezime ?? 'Nepoznat'}');
                                                      } else {
                                                        return _buildInfoRow(
                                                            'Trener: ',
                                                            'Loading...');
                                                      }
                                                    },
                                                  ),
                                                  _buildInfoRow(
                                                      'Datum Pocetka: ',
                                                      '${DateFormat('HH:mm').format(raspored?.datumPocetka ?? DateTime.now())} h'),
                                                  _buildInfoRow(
                                                      'Datum Zavrsetka: ',
                                                      '${DateFormat('HH:mm').format(raspored?.datumZavrsetka ?? DateTime.now())} h'),
                                                  _buildInfoRow(
                                                    'Dan: ',
                                                    _dayOfWeekToString(
                                                        raspored?.dan ?? -1),
                                                  ),
                                                 
                                                    _buildInfoRow(
                                                      'Status:  ',
                                                      'Neplacena',
                                                      TextStyle(
                                                        color: Colors.yellow,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 30.0,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16.0),
                                        ],
                                      );
                                    } else {
                                      // Loading Raspored...
                                      return ListTile(
                                        title: Text(
                                            'Rezervacija #${pageresult![index].id}'),
                                        leading: getUserImage(),
                                        subtitle: Text('Loading Raspored...'),
                                      );
                                    }
                                  },
                                );
                              } else {
                                // Loading User...
                                return ListTile(
                                  title: Text(
                                      'Rezervacija #${pageresult![index].id}'),
                                  subtitle: Text('Loading User...'),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text('Nema dostupnih rezervacija'),
            ),
    );
  }

  Widget _buildInfoRow(String label, String value, [TextStyle? style]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 20.0, // Prilagodi veličinu fonta
                    // Dodaj bold
                  ).merge(style), // Merge sa proslijeđenim stilom
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 21.0, // Prilagodi veličinu fonta
                    fontWeight: FontWeight.bold, // Dodaj bold
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageNumbers() {
    int totalPages = (totalcount / numberOfPpl).ceil();
    List<Widget> pageButtons = [];

    for (int i = 1; i <= totalPages; i++) {
      pageButtons.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                page = i;
                _loadData();
              });
            },
            child: Text('$i'),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: pageButtons,
    );
  }
}
