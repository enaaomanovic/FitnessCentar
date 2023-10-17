

import 'package:fitness_admin/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbols.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../utils/util.dart';

class ScheduleListScrean extends StatefulWidget {
  const ScheduleListScrean({Key? key}) : super(key: key);
  @override
  State<ScheduleListScrean> createState() => _ScheduleListScrean();
}
class _ScheduleListScrean extends State<ScheduleListScrean> {
  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      title_widget: Text("Prikaz rasporeda"),
      child: Container(
        child: Column(children: [_buildDataListView()]),
      ),
    );
  }
Widget _buildDataListView() {
  return Padding(
    padding: EdgeInsets.only(top: 50.0),
    child: Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 900,
          padding: EdgeInsets.all(20.0),
          child: TableCalendar(
            calendarFormat: CalendarFormat.month,
            focusedDay: DateTime.now(),
            firstDay: DateTime(DateTime.now().year, 1, 1),
            lastDay: DateTime(DateTime.now().year, 12, 31),
            onDaySelected: (selectedDay, focusedDay) {
              // Ovdje možete obraditi odabir dana (mjeseca)
            },
          ),
        ),
      ),
    ),
  );
}
}
