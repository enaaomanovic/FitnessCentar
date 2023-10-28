import 'package:fitness_admin/models/raspored.dart';
import 'package:fitness_admin/models/search_result.dart';
import 'package:fitness_admin/models/trening.dart';
import 'package:fitness_admin/providers/schedule_provider.dart';
import 'package:fitness_admin/providers/workout_provider.dart';

import 'package:fitness_admin/widgets/master_screens.dart';
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


@override
  void initState() {
    super.initState();
    _scheduleProvider = context.read<ScheduleProvider>(); 
    _workoutProvider=context.read<WorkoutProvider>();
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



  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      title_widget: Text("Sedmični raspored"),
      child: _buildWeeklySchedule(), // Promijenite naslov
    );
  }


String _dayOfWeekToString(int dan) {
  switch (dan) {
    case 0:
      return 'Ned';
    case 1:
      return 'Pon';
    case 2:
      return 'Uto';
    case 3:
      return 'Sre';
    case 4:
      return 'Čet';
    case 5:
      return 'Pet';
    case 6:
      return 'Sub';
    default:
      return '';
  }
}



List<Raspored> getRasporediZaSatnicu(int dan, String satnica) {
  if (result == null) {
    return [];
  }

  return result!.result.where((r) {
    return r.dan== dan && r.datumPocetka?.hour == int.parse(satnica.split(":")[0]);
  }).toList();
}


Widget _buildWeeklySchedule() {
  if (result == null) {
    return CircularProgressIndicator(); // Prikažite loader dok se podaci učitavaju
  }

  final List<int> dani = [1, 2, 3, 4, 5, 6, 7];
  final List<String> satnice = [
    '08:00 - 09:00',
    '09:00 - 10:00',
    '10:00 - 11:00',
    '11:00 - 12:00',
    '12:00 - 13:00',
    '13:00-14:00',
    '14:00 - 15:00',
    '15:00 - 16:00',
    '16:00-17:00',
    '17:00 - 18:00',
    '18:00 - 19:00',
    '19:00-20:00',
    '20:00-21:00'
  ];

  return ListView(
    children: [
      DataTable(
        columns: [
          DataColumn(label: Text('Satnica')),
          for (var dan in dani)
            DataColumn(
              label: Text(_dayOfWeekToString(dan)), // Konvertujte dan u string
            ),
        ],
        rows: [
          for (var satnica in satnice)
            DataRow(
              cells: [
                DataCell(Text(satnica)),
                for (var dan in dani)
                  DataCell(_buildRasporedCell(dan, satnica)),
              ],
            ),
          if (satnice.length < dani.length)
            DataRow(
              cells: [
                DataCell(Text('')), // Prazna ćelija za dane bez termina
                for (var dan in dani.skip(satnice.length))
                  DataCell(Text('')), // Prazne ćelije za dane bez termina
              ],
            ),
        ],
      ),
    ],
  );
}





Widget _buildRasporedCell(int dan, String satnica) {
  final rasporedi = getRasporediZaSatnicu(dan, satnica);

  if (rasporedi.isEmpty) {
    return Text('Pauza');
  }

  final treningi = rasporedi.map((r) => getTreningFromId(r.treningId));

  return Column(
    children: treningi.map((snapshot) {
      return FutureBuilder<Trening?>(
        future: snapshot,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Text('${snapshot.data?.naziv}');
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


