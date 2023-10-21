import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fitness_admin/models/trener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/providers/user_provider.dart';
import 'package:fitness_admin/widgets/master_screens.dart';

class AddTreiner extends StatefulWidget {
  const AddTreiner({Key? key, this.korisnik}) : super(key: key);

  final Korisnici? korisnik;

  @override
  State<AddTreiner> createState() => _AddTreinerState();
}

class _AddTreinerState extends State<AddTreiner> {
  final _formKey = GlobalKey<FormBuilderState>();
  late UserProvider _userProvider;
  bool isLoading = true;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _userProvider = context.read<UserProvider>();
    initForm();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Future initForm() async {
    setState(() {
      isLoading = false;
    });
  }

   File? _image;
  String? _base64Image;

  Future getImage()  async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if(result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base64Image = base64Encode(_image!.readAsBytesSync());
    }

  }

  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      // ignore: sort_child_properties_last
     
      child: Column(
        children: [isLoading ? Container() : _addForm(), _submitbtn()],
      ),
      title: "Dodaj korisnika",
       
    );
  }
Widget _addForm() {
  return FormBuilder(
    key: _formKey,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            width: 1000,
            height: 620,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Dodavanje novog trenera",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FormBuilderTextField(
                          decoration: InputDecoration(labelText: "Ime"),
                          name: "ime",
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: FormBuilderTextField(
                          decoration: InputDecoration(labelText: "Prezime"),
                          name: "prezime",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FormBuilderTextField(
                          decoration: InputDecoration(labelText: "Korisničko ime"),
                          name: "korisnickoIme",
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: FormBuilderTextField(
                          decoration: InputDecoration(labelText: "E-mail"),
                          name: "email",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FormBuilderTextField(
                          decoration: InputDecoration(labelText: "Lozinka"),
                          name: "lozinka",
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: FormBuilderTextField(
                          decoration: InputDecoration(labelText: "Telefon"),
                          name: "telefon",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FormBuilderDropdown(
                          name: 'pol',
                          decoration: InputDecoration(labelText: 'Pol'),
                          initialValue: 'Muški',
                          items: ['Muški', 'Ženski'].map((pol) {
                            return DropdownMenuItem(
                              value: pol,
                              child: Text(pol),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: FormBuilderDateTimePicker(
                          name: 'datumRodjenja',
                          inputType: InputType.date,
                          decoration: InputDecoration(labelText: 'Datum rođenja'),
                          initialDate: DateTime.now(),
                          onChanged: (DateTime? newDate) {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  FormBuilderTextField(
                    decoration: InputDecoration(labelText: "Specijalizacija"),
                    name: "specijalnost",
                  ),
                  SizedBox(height: 20),
                  FormBuilderField(
                    name: 'slika',
                    builder: (field) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Odaberite sliku',
                          errorText: field.errorText,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.photo),
                          title: Text("Select image"),
                          trailing: Icon(Icons.file_upload),
                          onTap: getImage,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}


Widget _submitbtn() {
  return Center(
    child: Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 250,
            child: ElevatedButton(
              onPressed: () async {
                _formKey.currentState?.saveAndValidate();
                var request = Map<String, dynamic>.from(_formKey.currentState!.value);
                var pol = request['pol'];

                String formattedDate = request['datumRodjenja'].toIso8601String();
                request['datumRodjenja'] = formattedDate;

                // Kreirajte objekat Trener sa specijalizacijom
                var trener = Trener(0, request['specijalnost']);
                request['trener'] = trener;

                try {
                  if (widget.korisnik == null) {
                    request['pol'] = pol;
                    
                    await _userProvider.insert(request);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text("Uspešno dodat korisnik"),
                        content: Text("Korisnik je uspešno dodat."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _formKey.currentState?.reset();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    await _userProvider.update(widget.korisnik!.id!, request);
                  }
                } on Exception catch (e) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text("Error"),
                      content: Text(e.toString()),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text("Sačuvaj trenera"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}





}



