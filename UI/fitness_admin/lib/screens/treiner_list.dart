import 'dart:convert';
import 'dart:typed_data';

import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/models/search_result.dart';
import 'package:fitness_admin/models/trener.dart';
import 'package:fitness_admin/providers/progress_provider.dart';
import 'package:fitness_admin/providers/trainer_provider.dart';
import 'package:fitness_admin/providers/user_provider.dart';
import 'package:fitness_admin/screens/edit_trainer.dart';
import 'package:fitness_admin/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TreneriScreen extends StatefulWidget {

  const TreneriScreen({Key? key,required this.onTrainerEdit}) : super(key: key);
   final VoidCallback onTrainerEdit;
  @override
  _TreneriScreen createState() => _TreneriScreen();
}


class _TreneriScreen extends State<TreneriScreen> {
  late TrainerProvider _trainerProvider;
  late UserProvider _userProvider;
  late ProgressProvider _progressProvider;
  bool isLoading = true;
  SearchResult<Trener>? result;

  @override
  void initState() {
    super.initState();
    _trainerProvider = context.read<TrainerProvider>();
    _userProvider = context.read<UserProvider>();
    _progressProvider = context.read<ProgressProvider>();
    initForm();
    _loadData();
  }

  Future initForm() async {
    setState(() {
      isLoading = false;
    });
  }

  void _loadData() async {
    var data = await _trainerProvider.get(filter: {});

    setState(() {
      result = data;
    });
  }

  void _refreshData() {
    _loadData();
  }

  Future<Korisnici?> getKorisnikFromId(int userId) async {
    final korisnik = await _userProvider.getById(userId);
    return korisnik;
  }

  Widget _buildCurrentUserHeader() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    int? trenutniKorisnikId = userProvider.currentUserId;
    return FutureBuilder<Korisnici?>(
      future: getKorisnikFromId(trenutniKorisnikId ?? 0),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Greška: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          return Text("id ${user.id} ");
        } else {
          return Text('Nema dostupnih podataka');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      title_widget: Text("Trenerski tim fitness centra"),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: isLoading ? Container() : _buildTrenerCard()),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildTrenerCard() {
    if (result == null || result!.result == null || result!.result!.isEmpty) {
      return Center(child: Text('Nema dostupnih trenera.'));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Treneri centra',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: result!.result.length,
            itemBuilder: (context, index) {
              Trener trener = result!.result[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildTrenerListItem(trener),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrenerListItem(Trener trener) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    int? trenutniKorisnikId = userProvider.currentUserId;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.purple, width: 3.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(10.0),
        title: 
        FutureBuilder<Korisnici?>(
          future: getKorisnikFromId(trener.id ?? 0),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Greška: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              final userImageBytes = user.slika != null
                  ? Uint8List.fromList(base64Decode(user.slika!))
                  : null;

              return Column(
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(),
                          child: userImageBytes != null &&
                                  userImageBytes.isNotEmpty
                              ? Image.memory(
                                  userImageBytes,
                                  width: 150.0,
                                  height: 150.0,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset('assets/images/male_icon.jpg'),
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.ime} ${user.prezime}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Godine: ${_calculateAge(user.datumRodjenja)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Specijalnosti: ${trener.specijalnost ?? ''}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Korisničko ime: ${user.korisnickoIme ?? ""}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'E-mail: ${user.email ?? ""}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Težina: ${user.tezina ?? ""} kg',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Visina: ${user.visina ?? ""} cm',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Broj telefona: ${user.telefon ?? ""}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Datum registracije: ${_formatDate(user.datumRegistracije)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (user.id == trenutniKorisnikId)
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () async {
                                var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditTrainerScreen(
                                            userId: user.id ?? 0,
                                            refreshDataCallback: _refreshData,
                                          )),
                                );

                                if (result == true) {
                                  
                                  _refreshData();
                                  widget.onTrainerEdit();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(20.0),
                              ),
                              child: Text('Uredi svoj profil',
                                  style: TextStyle(fontSize: 18)),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              );
            } else {
              return Text('Nema dostupnih podataka');
            }
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd.MM.yyyy').format(date);
    } else {
      return 'N/A';
    }
  }

  String _calculateAge(DateTime? birthDate) {
    if (birthDate == null) {
      return 'N/A';
    }
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    return age.toString();
  }
}
