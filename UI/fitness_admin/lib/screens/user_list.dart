import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/screens/edit_user.dart';
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

  List<Korisnici>? pageresult;
  TextEditingController _ftsController = new TextEditingController();
  var page = 1;
  var totalcount = 0;
  var numberOfPpl = 4;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    initForm();
    _loadData();

    _ftsController.addListener(() {
      _loadData();
    });
  }

  Future initForm() async {
    setState(() {
      isLoading = false;
    });
  }

  void _loadData() async {
    var data = await _userProvider.getPaged(filter: {
      'fts': _ftsController.text,
      'page': page,
      'pageSize': numberOfPpl
    });

    setState(() {
      totalcount = data.count!;
      pageresult = data.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      title_widget: Text("Prikaz korisnika"),
      child: Container(
        child: Column(
          children: [
            _buildSearch(),
            isLoading
                ? Container(
                   
                  )
                : _buildDataListView(),
          ],
        ),
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
                labelText: "Ime i prezime",
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                hintText: 'Unesite ime ili prezime korisnika',
              ),
              controller: _ftsController,
              onChanged: (value) => {page = 1},
            ),
          ),
          SizedBox(
            width: 8,
          ),
          SizedBox(
            width: 450,
          ),
        ],
      ),
    );
  }

  Widget _buildPageNumbers() {
    int totalPages = (totalcount / numberOfPpl).ceil();
    List<Widget> pageButtons = [];

    for (int i = 1; i <= totalPages; i++) {
      pageButtons.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
            onPressed: () {
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

   void _refreshData() {
    _loadData();
  }


  Widget _buildDataListView() {
    return Expanded(
      child: ListView(
        children: [
          Center(
            child: Card(
              child: DataTable(
                columnSpacing: 200,
                dataRowMinHeight: 80,
                dataRowMaxHeight: 80,
                columns: [
                  DataColumn(
                    label: Text(
                      'Ime',
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 19),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Prezime',
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 19),
                    ),
                  ),
                 
                  DataColumn(
                    label: Text(
                      'Slika',
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 19),
                    ),
                  ),
                       DataColumn(
                    label: Text(
                      'Uređivanja',
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 19),
                    ),
                  ),
                   
                ],
                rows: pageresult
                        ?.map((Korisnici e) => DataRow(
                              onSelectChanged: (selected) {
                                if (selected == true) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => UserDetalScreen(
                                        korisnik: e,
                                      ),
                                    ),
                                  );
                                }
                              },
                              cells: [
                                DataCell(
                                  Text(
                                    e.ime ?? "",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(e.prezime ?? "",
                                      style: TextStyle(fontSize: 20)),
                                ),
                               
                                DataCell(
                                  e.slika != ""
                                      ? Container(
                                          width: 100,
                                          height: 100,
                                          child:
                                              imageFromBase64String(e.slika!),
                                        )
                                      : Image.asset(
                                          'assets/images/male_icon.jpg'),

                                ),
                                    DataCell(
                                  ElevatedButton(
                                    onPressed: ()async {
                                      var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditUserScreen(
                                            userId: e.id ?? 0,
                                            refreshDataCallback: _refreshData,
                                          )
                                          ),
                                );

                                if (result == true) {
                                  // Osvežavanje podataka na prethodnoj stranici
                                  _refreshData();
                                }
                        
                                    },
                                    child: Text('Uredi korisnikov profil'),
                                  ),
                                ),
                              ],
                            ))
                        .toList() ??
                    [],
              ),
            ),
          ),
          SizedBox(height: 16),
          _buildPageNumbers(),
        ],
      ),
    );
  }
}