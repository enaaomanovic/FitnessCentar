import 'dart:math';

import 'package:fitness_mobile/models/raspored.dart';
import 'package:fitness_mobile/models/search_result.dart';
import 'package:fitness_mobile/models/trening.dart';
import 'package:fitness_mobile/providers/schedule_provider.dart';
import 'package:fitness_mobile/providers/workout_provider.dart';
import 'package:fitness_mobile/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({Key? key}) : super(key: key);

  @override
  _ScheduleListScreenState createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  late ScheduleProvider _scheduleProvider;
  late WorkoutProvider _workoutProvider;
  SearchResult<Raspored>? result;
  int? _selectedDay;

  @override
  void initState() {
    super.initState();
    _scheduleProvider = context.read<ScheduleProvider>();
    _workoutProvider = context.read<WorkoutProvider>();
    _loadData();
  }

  void _loadData() async {
    var data = await _scheduleProvider.get();

    setState(() {
      result = data;
    });
  }

  Future<Trening?> getTreningFromId(int? id) async {
    if (id == null) {
      return null;
    }
    final user = await _workoutProvider.getById(id);
    return user;
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
        return '  Ponedjeljak';
      case 2:
        return '      Utorak  ';
      case 3:
        return '     Srijeda  ';
      case 4:
        return '    Četvrtak  ';
      case 5:
        return '      Petak   ';
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
                // Dodajte kod za otvaranje detalja o treningu
              },
              child: Container(
                padding: EdgeInsets.all(16.0),
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
                    ElevatedButton(
                      onPressed: () {
                        // Dodajte kod za rezervaciju termina
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.white, // Postavite željenu boju ovdje
                      ),
                      child: Text(
                        'Rezerviši',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return SizedBox
              .shrink(); // Ne prikazujte ništa ako trening nije dostupan
        }
      },
    );
  }

  Widget _buildTreningCard(Raspored raspored) {
    final treningFuture = getTreningFromId(raspored.treningId);

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
                // Dodajte kod za otvaranje detalja o treningu
              },
              child: Container(
                alignment: Alignment.center,
                height: 34,
                width: 100,
                child: Text(
                  '${trening.naziv}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        } else {
          return SizedBox
              .shrink(); // Ne prikazujte ništa ako trening nije dostupan
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
}