import 'dart:convert';
import 'dart:typed_data';

import 'package:fitness_mobile/models/korisnici.dart';
import 'package:fitness_mobile/models/search_result.dart';
import 'package:fitness_mobile/models/trener.dart';
import 'package:fitness_mobile/providers/progress_provider.dart';
import 'package:fitness_mobile/providers/trainer_provider.dart';
import 'package:fitness_mobile/providers/user_provider.dart';
import 'package:fitness_mobile/screens/home_authenticated.dart';
import 'package:fitness_mobile/screens/news_list.dart';
import 'package:fitness_mobile/screens/reservation.dart';
import 'package:fitness_mobile/screens/user_details.dart';
import 'package:fitness_mobile/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TreneriScreen extends StatefulWidget {
  const TreneriScreen({Key? key}) : super(key: key);

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

  
    void onUserEdit() {
        int? trenutniKorisnikId = _userProvider.currentUserId;
 
    _userProvider.updateUser();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeAuthenticated(
                    userId: trenutniKorisnikId,
                    userProvider: _userProvider,
                    progressProvider: _progressProvider,
                  ),
      ),
    );
  }

  void _loadData() async {
    var data = await _trainerProvider.get(filter: {});

    setState(() {
      result = data;
    });
  }

  Future<Korisnici?> getKorisnikFromId(int userId) async {
    final korisnik = await _userProvider.getById(userId);
    return korisnik;
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
                width: MediaQuery.of(context).size.width * 0.9,
                child: isLoading ? Container() : _buildTrenerCard(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ScheduleListScreen(),
                ),
              );
            },
            child: Text(
              'Rezerviši termin kod naših trenera',
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.purple,
              onPrimary: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          SizedBox(height: 10),
          _buildBottomNavigationBar(context),
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
            'Trenirajte sa našim trenerima',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: result!.result!.length,
            itemBuilder: (context, index) {
              Trener trener = result!.result![index];
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
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.purple, width: 3.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(10.0),
        title: FutureBuilder<Korisnici?>(
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

              return Row(
                children: [
                  ClipOval(
                    child: Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(),
                      child: userImageBytes != null && userImageBytes.isNotEmpty
                          ? Image.memory(
                              userImageBytes,
                              width: 70.0,
                              height: 70.0,
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
                        style: TextStyle(fontSize: 18),
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Specijalnosti: ${trener.specijalnost ?? ''}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
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

  Widget _buildBottomNavigationBar(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    int? trenutniKorisnikId = _userProvider.currentUserId;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.purpleAccent,
            width: 2.0,
          ),
        ),
      ),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.purple, size: 35),
            label: 'Početna',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule, color: Colors.purple, size: 35),
            label: 'Pretraga',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_sharp, color: Colors.purple, size: 35),
            label: 'Favoriti',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.purple, size: 35),
            label: 'Profil',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomeAuthenticated(
                    userId: trenutniKorisnikId,
                    userProvider: _userProvider,
                    progressProvider: _progressProvider,
                  ),
                ),
              );

              break;
            case 1:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TreneriScreen(),
                ),
              );
              break;
            case 2:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewsListScreen(),
                ),
              );

              break;
            case 3:
             Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MobileUserDetailScreen(
                    userId: trenutniKorisnikId,
                     onUserEdit: onUserEdit,
                  ),
                ),
              );

              break;
          }
        },
      ),
    );
  }
}
