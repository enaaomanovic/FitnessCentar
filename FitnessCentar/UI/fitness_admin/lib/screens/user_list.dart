import 'package:fitness_admin/models/search_result.dart';
import 'package:fitness_admin/screens/user_details_screens.dart';
import 'package:fitness_admin/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness_admin/models/korisnici.dart';
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      title_widget: Text("Product list"),
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
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Ime&Prezime"),
              controller: _ftsController,
            ),
          ),
          SizedBox(
            width: 8,
          ),
        
          ElevatedButton(
              onPressed: () async {
                print("login proceed");
                // Navigator.of(context).pop();

                var data = await _userProvider.get(filter: {
                  'fts': _ftsController.text,
                
                });

                setState(() {
                  result = data;
                });

               
              },
              child: Text("Pretraga")),
          SizedBox(
            width: 8,
          ),
        
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    return Expanded(
        child: SingleChildScrollView(
      child: DataTable(
          columns: [
           
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Ime',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Prezime',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'KorisničkoIme',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Slika',
                  style: TextStyle(fontStyle: FontStyle.italic),
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
                                        builder: (context) =>
                                            UserDetalScreen(
                                       
                                        ),
                                      ),
                                    )
                                  }
                              },
                          cells: [
                            DataCell(Text(e.ime?.toString() ?? "")),
                            DataCell(Text(e.prezime ?? "")),
                            DataCell(Text(e.korisnickoIme ?? "")),
                          
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
    ));
  }
}

