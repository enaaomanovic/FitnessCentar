import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/models/search_result.dart';
import 'package:fitness_admin/screens/user_details_screens.dart';
import 'package:fitness_admin/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../utils/util.dart';

class UserListScrean extends StatefulWidget {
  const UserListScrean({Key? key}) : super(key: key);

  @override
  State<UserListScrean> createState() => _UserListScrean();
}

class _UserListScrean extends State<UserListScrean> {
  late UserProvider _userProvider;
  SearchResult<Korisnici>? result;
  TextEditingController _ftsController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>(); 
    _loadData();
  }

  void _loadData() async {
    var data = await _userProvider.get(filter: {
      'fts': _ftsController.text,
    });

    setState(() {
      result = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      title_widget: Text("Prikaz korisnika"),
      child: Container(
        child: Column(children: [_buildSearch(), _buildDataListView()]),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 450,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Ime&Prezime",
                  border: OutlineInputBorder(),
                   focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple), // Postavljanje boje okvira kada je input fokusiran
      ),
                  hintText: 'Unesite ime ili prezime korisnika'),
              controller: _ftsController,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          ElevatedButton(
              onPressed: () async {
                _loadData();
              },
              child: Text("Pretraga")),
          SizedBox(
            width: 450,
          ),
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    return Container(
      child: Center(
          child: Card(
              child: Expanded(
                  child: SingleChildScrollView(
        child: DataTable(
            columnSpacing: 200,
            dataRowMinHeight: 80,
            dataRowMaxHeight: 80,
            columns: [
              const DataColumn(
                label: Expanded(
                  child: Text(
                    'Ime',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19),
                  ),
                ),
              ),
              const DataColumn(
                label: Expanded(
                  child: Text(
                    'Prezime',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19),
                  ),
                ),
              ),
              const DataColumn(
                label: Expanded(
                  child: Text(
                    'Korisničko ime',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19),
                  ),
                ),
              ),
              const DataColumn(
                label: Expanded(
                  child: Text(
                    'Slika',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 19),
                  ),
                ),
              )
            ],
            rows: result?.result
                    .map((Korisnici e) => DataRow(
                            onSelectChanged: (selected) => {
                                  if (selected == true)
                                    {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => UserDetalScreen(
                                            korisnik: e,
                                          ),
                                        ),
                                      )
                                    }
                                },
                            cells: [
                              DataCell(Text(
                                e.ime ?? "",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )),
                              DataCell(Text(e.prezime ?? "",
                                  style: TextStyle(fontSize: 20))),
                              DataCell(Text(e.korisnickoIme ?? "",
                                  style: TextStyle(fontSize: 20))),
                              DataCell(e.slika != ""
                                  ? Container(
                                      width: 100,
                                      height: 100,
                                      child: imageFromBase64String(e.slika!),
                                    )
                                  : Text(""))
                            ]))
                    .toList() ??
                []),
      )))),
    );
  }
}
