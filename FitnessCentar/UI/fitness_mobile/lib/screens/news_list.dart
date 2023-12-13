import 'dart:convert';

import 'package:fitness_mobile/models/komentari.dart';
import 'package:fitness_mobile/models/korisnici.dart';
import 'package:fitness_mobile/models/novosti.dart';
import 'package:fitness_mobile/models/odgovoriNaKomentare.dart';
import 'package:fitness_mobile/models/search_result.dart';
import 'package:fitness_mobile/providers/comment_provider.dart';
import 'package:fitness_mobile/providers/news_provider.dart';
import 'package:fitness_mobile/providers/progress_provider.dart';
import 'package:fitness_mobile/providers/replyToComment.dart';
import 'package:fitness_mobile/providers/user_provider.dart';
import 'package:fitness_mobile/screens/home_authenticated.dart';
import 'package:fitness_mobile/screens/trainer_list.dart';
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
  late ProgressProvider _progressProvider;
  late ReplyToCommentProvider _replyToCommentProvider;
  
   Map<int?, bool> _isExpandedMap = {};

var page = 1;
  var totalcount = 0;
  var numberOfnews=3;

  List<Novosti> _novosti = [];

  @override
  void initState() {
    super.initState();
    _newsProvider = context.read<NewsProvider>();
    _userProvider = context.read<UserProvider>();
    _commentProvider = context.read<CommentProvider>();
    _progressProvider=context.read<ProgressProvider>();
    _replyToCommentProvider=context.read<ReplyToCommentProvider>();

    _loadData();

   
  }

  void _loadData() async {
    var data = await _newsProvider.getPaged(filter: {
       'page':page,
    'pageSize':numberOfnews
    });
    if (data != null) {
      setState(() {
         totalcount=data.count!;
        _novosti = data.result ?? [];
        _isExpandedMap = Map.fromIterable(
          _novosti.map((novost) => novost.id),
          key: (novostId) => novostId as int?,
          value: (_) => false,
        );
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

Future<SearchResult<OdgovoriNaKomentare>?> getOdgovoriFromNovostiId(
    int komentarId) async {
  var data = await _replyToCommentProvider.get(filter: {
    "komentarId": komentarId,
  });

  // Dodajte proveru da li je data različita od null pre nego što vratite rezultat
  if (data != null) {
    if (data.result.isNotEmpty) {
      print(data.result.first.tekst);
    }
    return data;
  } else {
    // Ako je data null, možete odlučiti šta da radite (npr. baciti izuzetak, vratiti neki podrazumevani rezultat itd.)
    return null;
  }
}



 @override
Widget build(BuildContext context) {
  return MasterScreanWidget(
    title_widget: Text("Prikaz novosti"),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Novosti fitness centra",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _novosti.length,
            itemBuilder: (context, index) {
              return _buildNewsCard(_novosti[index]);
            },
          ),
        ),
        _buildPageNumbers(),
        _buildBottomNavigationBar(context),
      ],
    ),
  );
}


Widget _buildNewsCard(Novosti novost) {
           

  return Padding(
    padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
    child: Card(
    
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
          border: Border.all(
            color: Colors.purple, // Boja granice
            width: 1.0, // Širina granice
          ),
          borderRadius: BorderRadius.circular(10.0), // Radijus granice
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              novost.naslov ?? "",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10), // Dodaj razmak između naslova i informacija o autoru i datumu

            Row(
              children: <Widget>[
                Text(
                  "Objavio: ",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FutureBuilder<Korisnici?>(
                  future: getUserFromUserId(novost.autorId ?? 0),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final author = snapshot.data;
                      if (author != null) {
                        return Text(
                          "${author.ime} ${author.prezime}",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        );
                      } else {
                        return Text("Nepoznat autor");
                      }
                    } else {
                      return Text("Učitavanje...");
                    }
                  },
                ),
              ],
            ),

            Row(
              children: <Widget>[
                Text(
                  "Datum objave: ",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat('dd.MM.yyyy').format(novost.datumObjave ?? DateTime.now()),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10), // Dodaj razmak između informacija o autoru i datumu i ostatka sadržaja

            FutureBuilder<Korisnici?>(
              future: getUserFromUserId(novost.autorId ?? 0),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final author = snapshot.data;
                  return ListTile(
                    title: _isExpandedMap[novost.id] != null
                        ? (_isExpandedMap[novost.id]!
                            ? Text(
                                "Sadržaj novosti: ${novost.tekst ?? ''}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              )
                            : Text(
                                "Sadržaj novosti: ${novost.tekst?.substring(0, 100) ?? ''}...", // Prikazi samo prvih 100 karaktera
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ))
                        : Text("Sadržaj novosti nije dostupan"),
                    onTap: () {
                      setState(() {
                        if (novost.id != null) {
                          _isExpandedMap[novost.id!] =
                              _isExpandedMap[novost.id!] != null
                                  ? !_isExpandedMap[novost.id!]!
                                  : false;
                        }
                      });
                    },
                  );
                } else {
                  return Text("Učitavanje...");
                }
              },
            ),

            Divider(),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (novost.id != null) {
                    _isExpandedMap[novost.id!] =
                        _isExpandedMap[novost.id!] != null
                            ? !_isExpandedMap[novost.id!]!
                            : false;
                  }
                });
              },
              child: Text(
                _isExpandedMap[novost.id] != null
                    ? (_isExpandedMap[novost.id]! ? "Smanji" : "Pročitaj više")
                    : "Pročitaj više",
              ),
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
        final base64Image = autor?.slika;

        Widget userAvatar;
        if (base64Image != null && base64Image.isNotEmpty) {
          userAvatar = ClipOval(
            child: Image.memory(
              base64Decode(base64Image),
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          );
        } else {
          userAvatar = ClipOval(
            child: Image.asset(
              "assets/images/male_icon.jpg",
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          );
        }

        return Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userAvatar,
                  SizedBox(width: 8),
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
                              color: Colors.purple,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
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
              SizedBox(height: 8),
              TextButton(
                        onPressed: () async {
  var odgovori = await getOdgovoriFromNovostiId(komentar.id ?? 0);

  if (odgovori!.result.isNotEmpty) {
    print("Odgovori su ${odgovori!.result.first.tekst}");

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildOdgovoriDialog(odgovori.result);
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Nema odgovora"),
          content: Text("Ovaj komentar nema odgovora."),
          actions: [
            TextButton(
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
},


                          child: Text('Pogledaj odgovore'),
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
Widget _buildOdgovoriDialog(List<OdgovoriNaKomentare>? odgovori) {
  return Dialog(
    child: Container(
      width: 100,
      height: 350, // Postavite željenu širinu dijaloga
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Odgovori na komentar',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          if (odgovori != null && odgovori.isNotEmpty)
            ...odgovori.map((odgovor) {
              return FutureBuilder<Korisnici?>(
                future: getUserFromUserId(odgovor.trenerId ?? 0),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.done) {
                    final trener = userSnapshot.data;
                    final base64Image = trener?.slika;

                    Widget userAvatar;
                    if (base64Image != null && base64Image.isNotEmpty) {
                      userAvatar = ClipOval(
                        child: Image.memory(
                          base64Decode(base64Image),
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      userAvatar = ClipOval(
                        child: Image.asset(
                          "assets/images/male_icon.jpg",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      );
                    }

                    return ListTile(
                      leading: userAvatar,
                      title: Text(
                        '${trener?.ime ?? 'Nepoznat'} ${trener?.prezime ?? 'Nepoznat'}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(odgovor.tekst ?? ''),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              );
            }),
          if (odgovori == null || odgovori.isEmpty) // Dodajte proveru ovde
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Nema dostupnih odgovora.'),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Zatvori'),
            ),
          ),
        ],
      ),
    ),
  );
}


 Widget _buildPageNumbers() {
  int totalPages = (totalcount / numberOfnews).ceil();
  List<Widget> pageButtons = [];

  for (int i = 1; i <= totalPages; i++) {
    pageButtons.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          onPressed: () {
            // Update the page variable and load data for the selected page
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

  Widget _buildBottomNavigationBar(BuildContext context) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
    int? trenutniKorisnikId = _userProvider.currentUserId;
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
            Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomeAuthenticated(
                    userId: trenutniKorisnikId,
                    userProvider: _userProvider,
                    progressProvider: _progressProvider,
                  ),
                ),
              );
             
              // Navigacija na Početnu stranicu
              break;
            case 1:
              Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TreneriScreen(),
            ),
          );
              // Navigacija na Pretraga stranicu
              break;
            case 2:
   Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewsListScreen(),
            ),
          );
              // Navigacija na Favoriti stranicu
              break;
            case 3:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MobileUserDetailScreen(
                    userId: trenutniKorisnikId,
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

