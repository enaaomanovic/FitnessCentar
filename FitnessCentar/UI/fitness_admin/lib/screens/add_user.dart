
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fitness_admin/screens/add_treiner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/providers/user_provider.dart';
import 'package:fitness_admin/widgets/master_screens.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key, this.korisnik}) : super(key: key);

  final Korisnici? korisnik;

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormBuilderState>();

  late UserProvider _userProvider;
  bool isLoading = true;

  Korisnici? korisnik;

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

  Future getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base64Image = base64Encode(_image!.readAsBytesSync());
    }
  }

  //   @override
  // Widget build(BuildContext context) {
  //   return MasterScreanWidget(
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.only(top: 10.0),
  //             child: Text(
  //               "Dodaj novog korisnika",
  //               style: TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           isLoading ? Container() : _addForm(),
  //           _submitbtn(),
  //         ],
  //       ),
  //     ),
  //     title: "Dodaj korisnika",
  //   );
  // }

  
    @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      child:SingleChildScrollView(
          scrollDirection: Axis.vertical,

        child: 
      Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "Dodaj novog korisnika",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            isLoading ? Container() : _addForm(),
            _submitbtn(),
          ],
        ),
        ),
      ),
      ),
      title: "Dodaj korisnika",
    );
  }

//   @override
//   Widget build(BuildContext context) {
//     return MasterScreanWidget(
//       title_widget: Text("Detalji treninga"),
//    child: Center(
//   child: SingleChildScrollView(
//     scrollDirection: Axis.horizontal, // Omogućava horizontalno skroliranje
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center, // Centrira horizontalno
//       children: [
//         Center(
//           child: isLoading
//               ? Container()
//               : _buildWorkout(),
//         ),
//         SizedBox(width: 20), // Dodajte razmak između Card-ova ako je potrebno
//         Center(
//           child: isLoading
//               ? Container()
//               : _buildDataListView(),
//         ),
//       ],
//     ),
//   ),
// ),

  Widget _addForm() {
    return FormBuilder(
      key: _formKey,
       autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: SizedBox(
                height: 550,
                width: 600,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 15),
                      FormBuilderTextField(
                        decoration: InputDecoration(labelText: "Ime *"),
                        validator: (value) {
                          if (_formKey.currentState?.fields['ime']?.isDirty ==
                              true) {
                            if (value == null || value.isEmpty) {
                              return 'Ovo polje je obavezno!';
                            } else if (value[0] != value[0].toUpperCase()) {
                              return 'Ime mora početi velikim slovom.';
                            }
                          }
                          return null;
                        },
                      

                        name: "ime",
                      ),
                      SizedBox(height: 15),
                      FormBuilderTextField(
                        decoration: InputDecoration(labelText: "Prezime *"),
                        validator: (value) {
                          if (_formKey
                                  .currentState?.fields['prezime']?.isDirty ==
                              true) {
                            if (value == null || value.isEmpty) {
                              return 'Ovo polje je obavezno!';
                            } else if (value[0] != value[0].toUpperCase()) {
                              return 'Prezime mora početi velikim slovom.';
                            }
                          }
                          return null;
                        },
                        name: "prezime",
                      ),
                      SizedBox(height: 15),
                      FormBuilderTextField(
                        decoration:
                            InputDecoration(labelText: "Korisničko ime *"),
                        validator: (value) {
                          if (_formKey.currentState?.fields['korisnickoIme']
                                  ?.isDirty ==
                              true) {
                            if (value == null || value.isEmpty) {
                              return 'Ovo polje je obavezno!';
                            } else if (value[0] != value[0].toUpperCase()) {
                              return 'Korisničko ime mora početi velikim slovom.';
                            }
                          }
                          return null;
                        },
                        name: "korisnickoIme",
                      ),
                      SizedBox(height: 15),
                      FormBuilderTextField(
                        decoration: InputDecoration(labelText: "E-mail *"),
                        validator: (value) {
                          if (_formKey
                                  .currentState?.fields['email']?.isDirty ==
                              true) {
                            if (value == null || value.isEmpty) {
                              return 'Ovo polje je obavezno!';
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return 'Unesite ispravan email.';
                            }
                          }
                          return null;
                        },
                        name: "email",
                      ),
                      SizedBox(height: 15),
                      FormBuilderTextField(
                        decoration: InputDecoration(labelText: "Lozinka *"),
                        validator: (value) {
                          if (_formKey
                                  .currentState?.fields['lozinka']?.isDirty ==
                              true) {
                            if (value == null || value.isEmpty) {
                              return 'Ovo polje je obavezno!';
                            } else if (value.length < 8 ||
                                !value.contains(RegExp(r'[A-Z]')) ||
                                !value.contains(RegExp(r'[a-z]')) ||
                                !value.contains(RegExp(r'[0-9]'))) {
                              return '8 karaktera,uključujući najmanje jedno veliko slovo (A-Z), jedno malo slovo (a-z) i jednu cifru (0-9)';
                            }
                          }
                          return null;
                        },
                        name: "lozinka",
                      ),
                      SizedBox(height: 15),
                      FormBuilderTextField(
                        decoration: InputDecoration(labelText: "Telefon *"),
                        validator: (value) {
                          if (_formKey
                                  .currentState?.fields['telefon']?.isDirty ==
                              true) {
                            if (value == null || value.isEmpty) {
                              return 'Ovo polje je obavezno!';
                            } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Unesite ispravan broj telefona (samo brojevi).';
                            }
                          }
                          return null;
                        },
                        name: "telefon",
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: SizedBox(
                height: 550,
                width: 600,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 15),
                      FormBuilderDropdown(
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
                      SizedBox(height: 15),
                      FormBuilderTextField(
                        decoration: InputDecoration(labelText: "Tezina *"),

                        validator: (value) {
                          if (_formKey
                                  .currentState?.fields['tezina']?.isDirty ==
                              true) {
                            if (value == null || value.isEmpty) {
                              return 'Unesite težinu u kilogramima!';
                            } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Unesite ispravnu težinu (samo brojevi).';
                            }
                          }
                          return null;
                        },
                        name: "tezina",
                      ),
                      SizedBox(height: 15),
                      FormBuilderTextField(
                        decoration: InputDecoration(labelText: "Visina *"),
                        validator: (value) {
                          if (_formKey
                                  .currentState?.fields['visina']?.isDirty ==
                              true) {
                            if (value == null || value.isEmpty) {
                              return 'Unesite visinu u centimetrima!';
                            } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Unesite ispravnu težinu (samo brojevi).';
                            }
                          }
                          return null;
                        },
                        name: "visina",
                      ),
                      SizedBox(height: 15),
                      FormBuilderDateTimePicker(
                        name: 'datumRodjenja',
                        inputType: InputType.date,
                        decoration: InputDecoration(labelText: 'Datum rođenja'),
                        validator: (value) {
                          if (_formKey.currentState?.fields['datumRodjenja']
                                  ?.isDirty ==
                              true) {
                            if (value == null) {
                              return 'Unesite datum rođenja';
                            }
                          }
                          return null;
                        },
                        initialDate: DateTime.now(),
                        onChanged: (DateTime? newDate) {},
                      ),
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
          ],
        ),
      ),
    );
  }



Widget _submitbtn() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 250,
        child: ElevatedButton(
           onPressed: () async {
    final currentFormState = _formKey.currentState;
    
    if (currentFormState != null && currentFormState.saveAndValidate()) {
      // Svi podaci su ispravno uneseni, možete dodati ili ažurirati korisnika
      var request = Map<String, dynamic>.from(currentFormState.value);
      var pol = request['pol'];

      String formattedDate = request['datumRodjenja'].toIso8601String();
      request['datumRodjenja'] = formattedDate;

      request['slika'] = _base64Image;

      request['datumRegistracije']= DateTime.now().toIso8601String();

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
                //   // Resetirajte formu tek nakon što korisnik zatvori dijalog
               
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
    }
  },
          child: Text("Sačuvaj korisnika",style: TextStyle(fontSize: 18)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20),
            
          ),
        ),
      ),
      SizedBox(width: 50), 
      Column(children: [SizedBox(
        width: 250,
        child: ElevatedButton(
          onPressed: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddTreiner(),
              ),
            );
          },
          child: Text("Dodaj novog trenera"),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(10),
          ),
        ),
      ),
      SizedBox(height: 10), // Dodajte razmak između dugmadi ako je potrebno
      SizedBox(
        width: 250,
        child: ElevatedButton(
          onPressed: () async {
            // Obrada za "Isprintaj korisnika"
          },
          child: Text("Isprintaj korisnika"),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(10),
          ),
        ),
         ),
        ],)// Dodajte razmak između dugmadi ako je potrebno   
    ],
  );
}



}

