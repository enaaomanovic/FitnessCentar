import 'package:collection/collection.dart';
import 'package:fitness_mobile/models/korisnici.dart';
import 'package:fitness_mobile/models/placanja.dart';
import 'package:fitness_mobile/models/raspored.dart';
import 'package:fitness_mobile/models/rezervacija.dart';

import 'package:fitness_mobile/models/search_result.dart';

import 'package:fitness_mobile/models/trening.dart';
import 'package:fitness_mobile/providers/reservation_provider.dart';
import 'package:fitness_mobile/providers/schedule_provider.dart';
import 'package:fitness_mobile/providers/pay_provider.dart';

import 'package:fitness_mobile/providers/user_provider.dart';
import 'package:fitness_mobile/providers/workout_provider.dart';
import 'package:fitness_mobile/screens/pay.dart';
import 'package:fitness_mobile/screens/workout_details.dart';
import 'package:fitness_mobile/widgets/master_screens.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({Key? key}) : super(key: key);

  @override
  _ScheduleListScreenState createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  late ScheduleProvider _scheduleProvider;
  late WorkoutProvider _workoutProvider;
  late ReservationProvider _reservationProvider;
  late UserProvider _userProvider;
  late PayProvider _payProvider;

  bool isReserved = false;
  Map<int, bool> reservedMap = {};
  SearchResult<Raspored>? result;
  int? _selectedDay;

  @override
  void initState() {
    super.initState();

    _scheduleProvider = context.read<ScheduleProvider>();
    _workoutProvider = context.read<WorkoutProvider>();
    _reservationProvider = context.read<ReservationProvider>();
    _userProvider = context.read<UserProvider>();
    _payProvider = context.read<PayProvider>();
    _loadData();
  }

  Future<Placanja?> GetPlacanje(int korisnikId) async {
    var searchResult =
        await _payProvider.get(filter: {"korisnikId": korisnikId});

    if (searchResult != null && searchResult.result.isNotEmpty) {
      List<Placanja> data = searchResult.result;

      data.sort((a, b) => b.datumPlacanja!.compareTo(a.datumPlacanja!));

      var zadnjePlacanje = data[0];

      return zadnjePlacanje;
    }
    return null;
  }

  Future<bool> PlacanjeUZadnjih30Dana(int korisnikId) async {
    var zadnjePlacanje = await GetPlacanje(korisnikId);

    if (zadnjePlacanje != null) {
      var trenutnoVrijeme = DateTime.now();

      var datumPlacanja = zadnjePlacanje.datumPlacanja;

      var razlika = trenutnoVrijeme.difference(datumPlacanja!);
      return razlika.inDays <= 30;
    }

    return false;
  }

  void _loadData() async {
    var data = await _scheduleProvider.get();

    setState(() {
      result = data;
    });
    setState(() {});
  }

  Future<bool> _isReservationPlacena(
      int trenutniKorisnikId, int rasporedId) async {
    var searchResult = await _reservationProvider.get(filter: {
      "korisnikId": trenutniKorisnikId,
      "rasporedId": rasporedId,
      "status": "Plaćena",
    });

    return searchResult.result != null && searchResult.result.isNotEmpty;
  }

  Future<bool> _isReservationActive(
      int trenutniKorisnikId, int rasporedId) async {
    var searchResult = await _reservationProvider.get(filter: {
      "korisnikId": trenutniKorisnikId,
      "rasporedId": rasporedId,
      "status": "Aktivna",
    });

    return searchResult.result != null && searchResult.result.isNotEmpty;
  }

  Future<void> updateStatus(
      int trenutniKorisnikId, int rasporedId, String status) async {
    try {
      // Dobavite sve rezervacije sa određenim korisnikom, rasporedom i statusom "Aktivna"
      var searchResult = await _reservationProvider.get(
        filter: {
          "korisnikId": trenutniKorisnikId,
          "rasporedId": rasporedId,
          "status": "Aktivna",
        },
      );

      if (searchResult.result != null && searchResult.result.isNotEmpty) {
        // Sortirajte rezultate po datumu rezervacije silazno
        searchResult.result
            .sort((a, b) => b.datumRezervacija!.compareTo(a.datumRezervacija!));

        // Dohvatite prvi rezultat (poslednju rezervaciju)
        var poslednjaRezervacija = searchResult.result.first;

        // Postoji rezervacija, dohvatite njen ID
        int rezervacijaId = poslednjaRezervacija.id ?? 0;

        var request = {
          'korisnikId': trenutniKorisnikId,
          'rasporedId': rasporedId,
          'datumRezervacija': DateTime.now().toIso8601String(),
          "status": status,
        };

        // Koristite dohvaćeni ID rezervacije za ažuriranje statusa
        await _reservationProvider.update(rezervacijaId, request);

        print('Successfully updated reservation status.');
      } else {
        // Rezervacija nije pronađena
        print(
            'No active reservation found for user $trenutniKorisnikId and schedule $rasporedId');
      }
    } catch (error) {
      print('Error updating reservation status: $error');
      rethrow;
    }
  }

  List<Raspored> getReservedRasporedi(int dan, String satnica) {
    if (result == null) {
      return [];
    }

    return result!.result.where((r) {
      return r.dan == dan &&
          r.datumPocetka?.hour == int.parse(satnica.split(":")[0]) &&
          reservedMap[r.id] == true;
    }).toList();
  }

  Future<int> calculateReservedCount() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    int? trenutniKorisnikId = userProvider.currentUserId;
    if (result == null) {
      return 0;
    }

    int reservedCount = 0;

    for (var raspored in result!.result) {
      bool isReservationActive = await _isReservationActive(
        trenutniKorisnikId!,
        raspored.id!,
      );

      if (isReservationActive) {
        // Povećajte broj rezervisanih termina
        reservedCount++;
      }
    }

    return reservedCount;
  }

  Future<double> calculateReservedPrice() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    int? trenutniKorisnikId = userProvider.currentUserId;
    if (result == null) {
      return 0.0;
    }

    double totalPrice = 0.0;

    for (var raspored in result!.result) {
      bool isReservationActive = await _isReservationActive(
        trenutniKorisnikId!, // Postavite trenutni korisnički ID
        raspored.id!,
      );

      if (isReservationActive) {
        // Dodajte cenu termina na ukupnu cenu
        totalPrice += 15.0;
      }
    }

    return totalPrice;
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat.Hm().format(dateTime); // Formatiranje u "hh:mm"
  }

  Future<void> _showReservationDialog() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    int? trenutniKorisnikId = userProvider.currentUserId;

    List<Raspored> activeReservations = [];

    for (var raspored in result!.result) {
      bool isReservationPlacena = await _isReservationPlacena(
        trenutniKorisnikId!,
        raspored.id!,
      );
      if (isReservationPlacena) {
        activeReservations.add(raspored);
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aktivne rezervacije'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                for (var raspored in activeReservations)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dan: ${_dayOfWeekToString(raspored.dan!)}'),
                      Text(
                          'Trajanje: ${_formatTime(raspored.datumPocetka!)} - ${_formatTime(raspored.datumZavrsetka!)}'),
                      SizedBox(height: 8),
                      // Dodajte malu prazninu između rezervacija

                      FutureBuilder<Korisnici?>(
                        future: getTrenerFromId(raspored.trenerId),
                        builder: (context, trenerSnapshot) {
                          if (trenerSnapshot.connectionState ==
                                  ConnectionState.done &&
                              trenerSnapshot.hasData) {
                            Korisnici? trener = trenerSnapshot.data;
                            return Text(
                                'Trener: ${trener?.ime ?? 'N/A'} ${trener?.prezime ?? 'N/A'}');
                          } else {
                            return Text('Trener: N/A');
                          }
                        },
                      ),
                      FutureBuilder<Trening?>(
                        future: getTreningFromId(raspored.treningId),
                        builder: (context, treningSnapshot) {
                          if (treningSnapshot.connectionState ==
                                  ConnectionState.done &&
                              treningSnapshot.hasData) {
                            Trening? trening = treningSnapshot.data;
                            return Text('Trening: ${trening?.naziv ?? 'N/A'}');
                          } else {
                            return Text('Trening: N/A');
                          }
                        },
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                      // Dodajte Divider između rezervacija
                    ],
                  ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Zatvori dijalog
              },
              child: Text('Zatvori'),
            ),
          ],
        );
      },
    );
  }

  Future<Trening?> getTreningFromId(int? id) async {
    if (id == null) {
      return null;
    }
    final user = await _workoutProvider.getById(id);
    return user;
  }

  Future<Korisnici?> getTrenerFromId(int? id) async {
    if (id == null) {
      return null;
    }
    final trener = await _userProvider.getById(id);
    return trener;
  }

  final Map<String, Color> bojeTreninga = {
    'Kružni': Colors.red,
    'Pilates': Colors.green,
    'Back health': Colors.yellow,
    'Barbell lift': Colors.purple,
    'Booty workout': Colors.blue,
    'ABS & Core': Colors.orange,
  };

  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      title_widget: Text("Sedmični raspored"),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            Text(
              'Odaberite dan treninga',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black, // Boja naslova
              ),
            ),
            _buildWeeklySchedule(),
            _buildReservationInfo(),
          ],
        ),
      ),
    );
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
        return 'Četvrtak';
      case 5:
        return 'Petak';
      default:
        return '';
    }
  }

  List<Raspored> getRasporediZaSatnicu(int dan, String satnica) {
    if (result == null) {
      return [];
    }

    return result!.result.where((r) {
      return r.dan == dan &&
          r.datumPocetka?.hour == int.parse(satnica.split(":")[0]);
    }).toList();
  }

  Widget _buildWeeklySchedule() {
    if (result == null) {
      return CircularProgressIndicator();
    }

    final List<int> dani = [1, 2, 3, 4, 5];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.purple, // Boja granice
              width: 3.0, // Debljina granice
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 16),
              for (var dan in dani) _buildDayPanel(dan),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayPanel(int dan) {
    final isOpen = _selectedDay == dan;

    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            if (_selectedDay == dan) {
              _selectedDay = null;
            } else {
              _selectedDay = dan;
            }
          });
        },
        child: Container(
          width: double
              .infinity, // Povećava širinu carda na širinu dostupnu u roditeljskom widgetu
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: isOpen ? Colors.grey[300] : Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.grey[400]!, // Boja bordera
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              Text(
                _dayOfWeekToString(dan),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black, // Boja dana
                ),
              ),
              if (isOpen) ...[
                SizedBox(height: 8),
                for (var satnica in _getDailySchedule(dan))
                  _buildRasporedCell(dan, satnica),
              ],
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getDailySchedule(int dan) {
    return [
      '08:00 - 09:00',
      '09:00 - 10:00',
      '10:00 - 11:00',
      '11:00 - 12:00',
      '12:00 - 13:00',
      '13:00 - 14:00',
      '14:00 - 15:00',
      '15:00 - 16:00',
      '16:00 - 17:00',
      '17:00 - 18:00',
      '18:00 - 19:00',
      '19:00 - 20:00',
      '20:00 - 21:00',
    ];
  }

  Widget _buildRasporedCell(int dan, String satnica) {
    final rasporedi = getRasporediZaSatnicu(dan, satnica);

    if (rasporedi.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          satnica,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        for (var raspored in rasporedi) _buildCustomTreningCard(raspored),
      ],
    );
  }

  Widget _buildCustomTreningCard(Raspored raspored) {
    final treningFuture = getTreningFromId(raspored.treningId);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    int? trenutniKorisnikId = userProvider.currentUserId;

    return FutureBuilder<Trening?>(
      future: treningFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final trening = snapshot.data!;
          Color bojaTreninga = bojeTreninga[trening.naziv] ?? Colors.blue;

          return Card(
            elevation: 2,
            margin: EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: bojaTreninga,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WorkoutDetailScreen(
                      treningid: raspored.treningId,
                      rasporedId: raspored.id,
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${trening.naziv}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Detalji o treningu',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      color: Colors.white,
                      thickness: 1.0,
                    ),
                    FutureBuilder<bool>(
                      future: _isReservationActive(
                          trenutniKorisnikId!, raspored.id!),
                      builder: (context, reservationSnapshot) {
                        bool isReservationActive =
                            reservationSnapshot.data ?? false;
                        Color buttonColor =
                            isReservationActive ? Colors.red : Colors.white;
                        String buttonText =
                            isReservationActive ? 'Rezervisano' : 'Rezerviši';

                        return ElevatedButton(
                          onPressed: () async {
                            if (trenutniKorisnikId != null) {
                              try {
                                var isReserved = await _isReservationActive(
                                  trenutniKorisnikId,
                                  raspored.id!,
                                );

                                if (isReserved) {
                                  var shouldCancel = await showDialog<bool>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text(
                                          'Već ste rezervirali ovaj termin. Želite li otkazati rezervaciju?',
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop(true);

                                              await updateStatus(
                                                trenutniKorisnikId,
                                                raspored.id!,
                                                "Neaktivna",
                                              );

                                              _loadData();

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Rezervacija je otkazana.'),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red,
                                            ),
                                            child: Text(
                                              'Da',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                            ),
                                            child: Text(
                                              'Ne',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (shouldCancel == true) {
                                    return;
                                  }
                                }

                                var request = <String, dynamic>{
                                  'korisnikId': trenutniKorisnikId,
                                  'rasporedId': raspored.id,
                                  'status': "Aktivna",
                                  'datumRezervacija':
                                      DateTime.now().toIso8601String(),
                                };

                                await _reservationProvider.insert(request);

                                _loadData();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Termin je uspešno rezerviran.'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                setState(() {
                                  buttonColor =
                                      isReserved ? Colors.red : Colors.white;
                                  buttonText = 'Rezervisano';
                                });
                              } catch (e) {
                                print('Error during reservation: $e');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Došlo je do pogreške prilikom obrade rezervacije. $e',
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Korisnik nije prijavljen.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              print('Korisnik nije prijavljen.');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: buttonColor,
                            side: BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          child: Text(
                            buttonText,
                            style: TextStyle(
                              fontSize: 14,
                              color: isReserved ? Colors.white : Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
          // Ne prikazujte ništa ako trening nije dostupan
        }
      },
    );
  }

  Widget _buildRasporedZaDan(int dan, List<String> satnice) {
    return Column(
      children: [
        Text(_dayOfWeekToString(dan)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Satnica')),
              DataColumn(label: Text('Termin')),
            ],
            rows: [
              for (var satnica in satnice)
                DataRow(
                  cells: [
                    DataCell(Text(satnica)),
                    DataCell(_buildRasporedCell(dan, satnica)),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _showPriceListDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Center(
            child: Text(
              'Cjenovnik',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPriceListItem('1X sedmično', '15KM'),
                _buildPriceListItem('2X sedmično', '30KM'),
                _buildPriceListItem('3X sedmično', '45KM'),
                _buildPriceListItem('4X sedmično', '60KM'),
                _buildPriceListItem('5X sedmično', '75KM'),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Zatvori'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPriceListItem(String description, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            description,
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationInfo() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    int? trenutniKorisnikId = userProvider.currentUserId;
    Future<int> reservedCountFuture = calculateReservedCount();
    Future<double> reservedPriceFuture = calculateReservedPrice();
    Future<bool> isPaymentInLast30DaysFuture =
        PlacanjeUZadnjih30Dana(trenutniKorisnikId!);

    return FutureBuilder<bool>(
      future: isPaymentInLast30DaysFuture,
      builder: (context, isPaymentSnapshot) {
        bool isPaymentInLast30Days = isPaymentSnapshot.data ?? false;

        return FutureBuilder<int>(
          future: reservedCountFuture,
          builder: (context, countSnapshot) {
            int reservedCount = countSnapshot.data ?? 0;

            return FutureBuilder<double>(
              future: reservedPriceFuture,
              builder: (context, priceSnapshot) {
                double reservedPrice = priceSnapshot.data ?? 0.0;

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _showPriceListDialog();
                            },
                            child: Text('Cjenovnik'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                150,
                                50,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _showReservationDialog();
                            },
                            child: Text('Pregled rezervacija'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                150,
                                50,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (!isPaymentInLast30Days && reservedCount == 0) ...[
                      SizedBox(height: 16),
                      Text(
                        'Niste rezervisali nijedan termin za ovaj mjesec.',
                        style: TextStyle(
                          fontSize: 17.5,
                        ),
                      ),
                    ] else if (isPaymentInLast30Days) ...[
                      SizedBox(height: 16),
                      Text(
                        'Već ste izvršili uplatu za ovaj mjesec.',
                        style: TextStyle(
                          fontSize: 17.5,
                        ),
                      ),
                    ] else if (reservedCount > 0) ...[
                      SizedBox(height: 16),
                      Text(
                        'Uspješno ste rezervisali $reservedCount termina.',
                        style: TextStyle(
                          fontSize: 17.5,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Članarina za trenutno rezervisane termine iznosi',
                        style: TextStyle(
                          fontSize: 17.5,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '$reservedPrice KM',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0, top: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PayScreen(amountToPay: reservedPrice),
                              ),
                            );
                          },
                          child: Text('Plati članarinu'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                              150,
                              50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  List<Widget> _buildReservedRasporedCell(int dan, String satnica) {
    final reservedRasporedi = getReservedRasporedi(dan, satnica);

    if (reservedRasporedi.isEmpty) {
      return [];
    }

    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Text(
            _dayOfWeekToString(dan),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            satnica,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          for (var raspored in reservedRasporedi)
            _buildCustomTreningCard(raspored),
        ],
      ),
    ];
  }
}
