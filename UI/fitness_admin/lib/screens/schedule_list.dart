import 'package:fitness_admin/models/raspored.dart';
import 'package:fitness_admin/models/search_result.dart';
import 'package:fitness_admin/models/trening.dart';
import 'package:fitness_admin/providers/schedule_provider.dart';
import 'package:fitness_admin/providers/workout_provider.dart';
import 'package:fitness_admin/screens/workout_details.dart';

import 'package:fitness_admin/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleListScreen extends StatefulWidget {
  const ScheduleListScreen({Key? key}) : super(key: key);

  @override
  _ScheduleListScreenState createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  late ScheduleProvider _scheduleProvider;
  late WorkoutProvider _workoutProvider;
  SearchResult<Raspored>? result;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _scheduleProvider = context.read<ScheduleProvider>();
    _workoutProvider = context.read<WorkoutProvider>();
    initForm();
    _loadData();
  }

  Future initForm() async {
    setState(() {
      isLoading = false;
    });
  }

  void _loadData() async {
    var data = await _scheduleProvider.get();

    setState(() {
      result = data;
    });
  }

  void openTreningDetailsPage(Trening? trening, Raspored? raspored) {
    if (trening != null && raspored != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return WorkoutDetails(trening: trening, raspored: raspored);
          },
        ),
      );
    }
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
      child: isLoading ? Container() : _buildWeeklySchedule(),
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
        return '    Červrtak  ';
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
    final List<String> satnice = [
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
      '20:00 - 21:00'
    ];

    return ListView(
      children: [
        Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: EdgeInsets.all(16.0),
            child: DataTable(
              dataRowMinHeight: 50.0,
              dataRowMaxHeight: 50.0,
              columnSpacing: 110,
              headingRowHeight: 50.0,
              columns: [
                DataColumn(
                  label: SizedBox(
                    width: 150,
                    child: Text(
                      'Raspored',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                ),
                for (var dan in dani)
                  DataColumn(
                    label: Container(
                      alignment: Alignment.center,
                      child: Text(
                        _dayOfWeekToString(dan).toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
              rows: [
                for (var satnica in satnice)
                  DataRow(
                    cells: [
                      DataCell(
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            satnica,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      for (var dan in dani)
                        DataCell(
                          _buildRasporedCell(dan, satnica),
                        ),
                    ],
                  ),
                if (satnice.length < dani.length)
                  DataRow(
                    cells: [
                      DataCell(Text('')),
                      for (var dan in dani.skip(satnice.length))
                        DataCell(Text('')),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRasporedCell(int dan, String satnica) {
    final rasporedi = getRasporediZaSatnicu(dan, satnica);
    final cellHeight = 100.0;

    if (rasporedi.isEmpty) {
      return Card(
        elevation: 2,
        margin: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.grey,
        child: Container(
          alignment: Alignment.center,
          height: cellHeight,
          child: Text(
            'Pauza',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    final treningi = rasporedi.map((r) => getTreningFromId(r.treningId));

    return Column(
      children: treningi.map((snapshot) {
        return FutureBuilder<Trening?>(
          future: snapshot,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                Color bojaTreninga =
                    bojeTreninga[snapshot.data?.naziv] ?? Colors.blue;

                return Card(
                  elevation: 2,
                  margin: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: bojaTreninga,
                  child: InkWell(
                    onTap: () {
                      openTreningDetailsPage(
                          snapshot.data,
                          rasporedi.firstWhere(
                              (r) => r.treningId == snapshot.data?.id));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 34,
                      width: 100,
                      child: Text(
                        '${snapshot.data?.naziv}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }
            }
            return CircularProgressIndicator();
          },
        );
      }).toList(),
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
