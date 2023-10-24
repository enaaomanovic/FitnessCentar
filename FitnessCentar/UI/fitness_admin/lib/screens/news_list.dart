
import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/models/novosti.dart';
import 'package:fitness_admin/models/search_result.dart';
import 'package:fitness_admin/providers/news_provider.dart';
import 'package:fitness_admin/providers/user_provider.dart';
import 'package:fitness_admin/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/intl.dart';
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
 

  @override
 void initState() {
  super.initState();
  _newsProvider = context.read<NewsProvider>();
  _userProvider=context.read<UserProvider>();
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

@override
Widget build(BuildContext context) {
  return MasterScreanWidget(
    title_widget: Text("Prikaz novosti"),
    child: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [_buildDataListView(_novosti)],
        ),
      ),
    ),
  );
}


Widget _buildDataListView(List<Novosti> novosti) {
  return Padding(
    padding: EdgeInsets.only(top: 20.0),
    child: Align(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 900,
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: novosti.map((novost) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.purple, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
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
                            textAlign: TextAlign.left,
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
                                      textAlign: TextAlign.right,
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
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    ),
  );
}



 }
