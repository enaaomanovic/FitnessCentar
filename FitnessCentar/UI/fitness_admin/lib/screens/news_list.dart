
import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/models/novosti.dart';
import 'package:fitness_admin/models/search_result.dart';
import 'package:fitness_admin/providers/news_provider.dart';
import 'package:fitness_admin/providers/user_provider.dart';
import 'package:fitness_admin/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbols.dart';
import 'package:provider/provider.dart';

import '../utils/util.dart';

class NewsListScrean extends StatefulWidget {
  const NewsListScrean({Key? key}) : super(key: key);

  @override
  State<NewsListScrean> createState() => _NewsListScrean();
}

class _NewsListScrean extends State<NewsListScrean> {
  late NewsProvider _newsProvider;
  late UserProvider _userProvider;

  List<Novosti> _novosti = [];
  List<Korisnici> _treneri = [];



  @override
 void initState() {
  super.initState();
  _newsProvider = context.read<NewsProvider>();
  _loadData();
  _loadTreneri();
}

void _loadData() async {
  var data = await _newsProvider.get(filter: {});
  if (data != null) {
    setState(() {
      _novosti = data.result ?? [];
    });
  }
}

void _loadTreneri() async {
  var data = await _userProvider.get(filter: {
    'IsTrener': "true",
  });
  if (data != null) {
    setState(() {
      _treneri = data.result ?? [];
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      title_widget: Text("Prikaz novosti"),
      child: Container(
        child: Column(children: [_buildDataListView(_novosti,_treneri)]),
      ),
    );
  }
Widget _buildDataListView(List<Novosti> novosti, List<Korisnici> treneri) {
  return Padding(
    padding: EdgeInsets.only(top: 20.0),
    child: Align(
      alignment: Alignment.center,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 900,
          padding: EdgeInsets.all(20.0),
          child: Column(
              children: novosti.map((novost) {
               final trener = treneri.firstWhere(
  (t) => t.id == novost.autorId,
  orElse: () {
    final defaultUser = Korisnici(
      novost.autorId, // Postavite odgovarajući ID
      "nepoznat", // Ime
      'Trener', // Prezime
      'username', // Korisničko ime
      'email', // Email
      'telefon', // Telefon
      DateTime.now(), // Datum registracije
      DateTime.now(), // Datum rođenja
      'pol', // Pol
      0.0, // Težina
      0.0, // Visina
      'slika', // Slika
      'lozinka', // Lozinka
    );
    return defaultUser;
  },
);

              return Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.purple, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          novost.naslov ?? "",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(novost.tekst ?? ""),
                        onTap: () {
                          // Dodajte funkcionalnost za prikaz celokupne vesti
                        },
                      ),
                      Divider(),
                      
                      // Oznaka "Komentari" ispod svake novosti
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Komentari "),
                      ),

                      // Ime trenera
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Objavio: ${trener.ime}, id ${trener.id}"),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    ),
  );
}


}
