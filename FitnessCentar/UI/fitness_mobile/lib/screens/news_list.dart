import 'dart:convert';

import 'package:fitness_mobile/models/komentari.dart';
import 'package:fitness_mobile/models/korisnici.dart';
import 'package:fitness_mobile/models/novosti.dart';
import 'package:fitness_mobile/models/search_result.dart';
import 'package:fitness_mobile/providers/comment_provider.dart';
import 'package:fitness_mobile/providers/news_provider.dart';
import 'package:fitness_mobile/providers/user_provider.dart';
import 'package:fitness_mobile/screens/user_details.dart';
import 'package:fitness_mobile/utils/utils.dart';
import 'package:fitness_mobile/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({Key? key}) : super(key: key);

  @override
  State<NewsListScreen> createState() => _NewsListScreen();
}

class _NewsListScreen extends State<NewsListScreen> {
  late NewsProvider _newsProvider;
  late UserProvider _userProvider;
  late CommentProvider _commentProvider;

  List<Novosti> _novosti = [];

  @override
  void initState() {
    super.initState();
    _newsProvider = context.read<NewsProvider>();
    _userProvider = context.read<UserProvider>();
    _commentProvider = context.read<CommentProvider>();

    _loadData();
  }

  void _loadData() async {
    var data = await _newsProvider.get(filter: {});
    if (data != null) {
      setState(() {
        _novosti = data.result ?? [];
      });
    }
  }

  Future<Korisnici?> getUserFromUserId(int userId) async {
    final user = await _userProvider.getById(userId);
    return user;
  }

  Future<SearchResult<Komentari>> getKomentariFromNovostiId(
      int novostId) async {
    final kom = await _commentProvider.get(filter: {
      'novostId': novostId,
    });

    return kom;
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      title_widget: Text("Prikaz novosti"),
      child: Stack(
        children: [
          ListView.builder(
            itemCount: _novosti.length,
            itemBuilder: (context, index) {
              return _buildNewsCard(_novosti[index]);
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomNavigationBar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard(Novosti novost) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 50),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text(
                novost.naslov ?? "",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: Text(
                  "Datum objave: ${DateFormat('dd.MM.yyyy').format(novost.datumObjave ?? DateTime.now())}",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: FutureBuilder<Korisnici?>(
                  future: getUserFromUserId(novost.autorId ?? 0),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final author = snapshot.data;
                      if (author != null) {
                        return ListTile(
                          title: Text(
                            "Objavio: ${author.ime} ${author.prezime}",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "Sadržaj novosti: ${novost.tekst ?? ''}",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        );
                      } else {
                        return Text("Objavio: Nepoznat autor");
                      }
                    } else {
                      return Text("Objavio: Učitavanje...");
                    }
                  },
                ),
                onTap: () {
                  // Dodajte funkcionalnost za prikaz celokupne vesti
                },
              ),
              Divider(),
              _buildCommentsButton(novost),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommentsButton(Novosti novost) {
    return TextButton(
      onPressed: () {
        // Prikaz dijaloga sa komentarima
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _buildCommentsDialog(novost);
          },
        );
      },
      child: Text('Komentari'),
    );
  }

Widget _buildCommentsDialog(Novosti novost) {
  TextEditingController commentController = TextEditingController();

  return AlertDialog(
    title: Text('Komentari'),
    content: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: _buildCommentsSection(novost),
          ),
        ),
        // Polje za unos novog komentara
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
              controller: commentController,
                  decoration: InputDecoration(
                    hintText: 'Unesite komentar...',
                    border: OutlineInputBorder(),
                  ),
                  // Obrada unesenog komentara
                  onSubmitted: (comment) {
                    // Dodajte logiku za dodavanje novog komentara
                    // Ovde možete pozvati funkciju za dodavanje komentara
                    // Pobrinite se da ažurirate listu komentara i ponovo izgradite dijalog ako je potrebno
                    },
                  ),
                ),
                SizedBox(width: 8.0), // Razmak između polja za unos i ikone
                // Ikona za postavljanje komentara
              IconButton(
  onPressed: () async {
    // Dohvati trenutnog korisnika
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    int? trenutniKorisnikId = userProvider.currentUserId;

    // Provjeri da li je uneseni komentar prazan
    if (commentController.text.trim().isEmpty) {
      // Ispisi poruku da korisnik nije unio komentar
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Greška'),
            content: Text('Niste uneli komentar. Molimo vas da unesete komentar pre nego što pošaljete.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Proveri da li imamo trenutnog korisnika
      if (trenutniKorisnikId != null) {
        var request = <String, dynamic>{
          'korisnikId': trenutniKorisnikId,
          'novostId': novost.id,
          'datumKomentara': DateTime.now().toIso8601String(),
          'tekst': commentController.text,
        };

        await _commentProvider.insert(request);

        // Zatvori dijalog
        Navigator.of(context).pop();

        // Otvori dijalog ponovo
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _buildCommentsDialog(novost);
          },
        );
      } else {
        // Korisnik nije prijavljen, možete rukovati ovim slučajem prema vašim potrebama
        print('Korisnik nije prijavljen.');
      }
    }
  },
  icon: Icon(Icons.send),
),




            ],
          ),
        ),
      ],
    ),
    actions: [
      // Opcioni dugmici u dijalogu
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Zatvori'),
      ),
    ],
  );
}


Widget _buildCommentsSection(Novosti novost) {
  return FutureBuilder<SearchResult<Komentari>>(
    future: getKomentariFromNovostiId(novost.id ?? 0),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Greška pri učitavanju komentara.');
      } else if (!snapshot.hasData ||
          snapshot.data == null ||
          snapshot.data!.result == null) {
        return Text('Nema dostupnih komentara.');
      } else {
        List<Komentari> komentari = snapshot.data!.result!;
        return Column(
          children: [
            // Prikazi postojeće komentare
            ..._buildCommentsList(komentari),
          ],
        );
      }
    },
  );
}


List<Widget> _buildCommentsList(List<Komentari> komentari) {
  return komentari.map((komentar) => FutureBuilder<Korisnici?>(
    future: getUserFromUserId(komentar.korisnikId ?? 0),
    builder: (context, userSnapshot) {
      if (userSnapshot.connectionState == ConnectionState.done) {
        final autor = userSnapshot.data;
        final base64Image = autor?.slika; // Zamijenite ovo sa stvarnim base64 podacima slike korisnika
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8), // Razmak između komentara
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: MemoryImage(base64Decode(base64Image ?? '')),
                  ),
                  SizedBox(width: 8), // Razmak između slike i teksta
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${autor?.ime ?? 'Nepoznat'} ${autor?.prezime ?? 'Nepoznat'}:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.purple, // Boja granice
                              width: 2.0, // Debljina granice
                            ),
                            borderRadius: BorderRadius.circular(5.0), // Zaobljeni uglovi
                          ),
                          margin: EdgeInsets.only(top: 4),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            komentar.tekst ?? '',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8), // Dodajte razmak između komentara i gumba za odgovore

              // Gumb za prikaz odgovora
              TextButton(
                onPressed: () {
                  // Implementirajte logiku za prikaz odgovora na ovaj komentar
                  // Ovdje možete otvoriti novi dijalog, preći na novi ekran ili nešto drugo
                },
                child: Text('Pogledaj odgovor'),
              ),
            ],
          ),
        );
      } else {
        return CircularProgressIndicator();
      }
    },
  )).toList();
}



  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.purpleAccent, // Boja gornje granice
            width: 2.0, // Debljina gornje granice
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
          // Ovde postavite šta želite da se dešava kada se pritisne dugme na donjoj navigaciji
          switch (index) {
            case 0:
              Navigator.of(context).pop();
              // Navigacija na Početnu stranicu
              break;
            case 1:
              // Navigacija na Pretraga stranicu
              break;
            case 2:

              // Navigacija na Favoriti stranicu
              break;
            case 3:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MobileUserDetailScreen(
                    userId: 106,
                  ),
                ),
              );
              // Navigacija na Profil stranicu

              break;
          }
        },
      ),
    );
  }
}
