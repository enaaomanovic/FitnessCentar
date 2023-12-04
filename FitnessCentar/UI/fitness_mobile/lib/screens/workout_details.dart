import 'dart:convert';
import 'dart:typed_data';

import 'package:fitness_mobile/models/korisnici.dart';
import 'package:fitness_mobile/models/raspored.dart';
import 'package:fitness_mobile/models/search_result.dart';
import 'package:fitness_mobile/models/trener.dart';
import 'package:fitness_mobile/models/trening.dart';
import 'package:fitness_mobile/providers/schedule_provider.dart';
import 'package:fitness_mobile/providers/trainer_provider.dart';
import 'package:fitness_mobile/providers/user_provider.dart';
import 'package:fitness_mobile/providers/workout_provider.dart';
import 'package:fitness_mobile/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:fitness_mobile/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class WorkoutDetailScreen extends StatefulWidget {
  int? treningid;
  int? rasporedId;
  WorkoutDetailScreen({Key? key, this.treningid,this.rasporedId}) : super(key: key);
  @override
  _WorkoutDetailScreen createState() => _WorkoutDetailScreen();
}

class _WorkoutDetailScreen extends State<WorkoutDetailScreen> {
  late WorkoutProvider _workoutProvider;
  late ScheduleProvider _scheduleProvider;
  late UserProvider _userProvider;
  bool isLoading = true;

  Future<Trening?> getWorkoutFromUserId(int treningId) async {
    final trening = await _workoutProvider.getById(treningId);
    return trening;
  }

  
  Future<Raspored?> getRaporedFromUserId(int rasporedId) async {
    final raspored = await _scheduleProvider.getById(rasporedId);
    return raspored;
  }

    Future<Korisnici?> getTrenerFromUserId(int trenerId) async {
    final trener = await _userProvider.getById(trenerId);
    return trener;
  }


  @override
  void initState() {
    super.initState();
    _workoutProvider = context.read<WorkoutProvider>();
    _scheduleProvider = context.read<ScheduleProvider>();
    _userProvider=context.read<UserProvider>();

  }

  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      child: Stack(
        children: [
          _workoutDetails(),
        ],
      ),
      title: "Detalji treninga",
    );
  }

Widget _workoutDetails() {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Center(
      child: Container(
        width: 350,
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(width: 3.0, color: Colors.purple),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<Trening?>(
              future: getWorkoutFromUserId(widget.treningid!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Greška pri dohvaćanju treninga: ${snapshot.error}',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: Text(
                      'Trening nije pronađen.',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  );
                } else {
                  Trening trening = snapshot.data!;
                  return FutureBuilder<Raspored?>(
                    future: getRaporedFromUserId(widget.rasporedId ?? 0),
                    builder: (context, rasporedSnapshot) {
                      if (rasporedSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (rasporedSnapshot.hasError) {
                        return Center(
                          child: Text(
                            'Greška pri dohvaćanju rasporeda: ${rasporedSnapshot.error}',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        );
                      } else {
                        Raspored? raspored = rasporedSnapshot.data;
                        final dateFormat = DateFormat.Hm();
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow('Naziv treninga', trening.naziv ?? ""),
                            _buildInfoRow('Trajanje treninga', '${trening.trajanje} minuta'),
                            _buildInfoRow('Opis treninga', trening.opis ?? ""),
                            SizedBox(height: 16),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Informacije o terminu',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Container(
                                    height: 1,
                                    width: 50,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            _buildInfoRow(
                              'Trening počinje',
                              'u ${dateFormat.format(raspored?.datumPocetka ?? DateTime.now())} h',
                            ),
                            _buildInfoRow(
                              'Trening završava',
                              'u ${dateFormat.format(raspored?.datumZavrsetka ?? DateTime.now())} h',
                            ),
                    FutureBuilder<Korisnici?>(
  future: getTrenerFromUserId(raspored?.trenerId ?? 0),
  builder: (context, trenerSnapshot) {
    if (trenerSnapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (trenerSnapshot.hasError) {
      return Text(
        'Greška pri dohvaćanju trenera: ${trenerSnapshot.error}',
        style: TextStyle(
          fontSize: 14,
          color: Colors.red,
        ),
      );
    } else if (trenerSnapshot.hasData) {
      final trener = trenerSnapshot.data!;
      final trenerImage = trener.slika != null
          ? imageFromBase64String(trener.slika!)
          : null;
      final trenerImageBytes = trener.slika != null
          ? Uint8List.fromList(base64Decode(trener.slika!))
          : null;

      return Row(
        children: [
          _buildInfoRow(
            'Trener',
            '${trener.ime} ${trener.prezime}',
          ),
          SizedBox(width: 8),
          CircleAvatar(
            backgroundImage: trenerImage != null
                ? Image.memory(Uint8List.fromList(trenerImageBytes!)).image
                : null,
            radius: 30,
          ),
        ],
      );
    } else {
      return Text(
        'Trener nije pronađen',
        style: TextStyle(
          fontSize: 14,
          color: Colors.red,
        ),
      );
    }
  },
),

                            
                          ],
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    ),
  );
}


Widget _buildInfoRow(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}


}
