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
import 'package:form_builder_validators/form_builder_validators.dart';


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
    child: SingleChildScrollView(
      child: Column(
        children: [isLoading ? Container() : _addForm(), _submitbtn()],
      ),
    ),
    title: "Dodaj trenera",
  );
}
Widget _addForm() {
  return FormBuilder(
    key: _formKey,
       autovalidateMode: AutovalidateMode.always,

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
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: FormBuilderTextField(
                          decoration: InputDecoration(labelText: "Prezime"),
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
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: FormBuilderTextField(
                          decoration: InputDecoration(labelText: "E-mail"),
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
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: FormBuilderTextField(
                          decoration: InputDecoration(labelText: "Telefon"),
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
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  FormBuilderTextField(
                    decoration: InputDecoration(labelText: "Specijalizacija"),
                     validator: (value) {
                          if (_formKey.currentState?.fields['specijalnost']
                                  ?.isDirty ==
                              true) {
                            if (value == null || value.isEmpty) {
                              return 'Ovo polje je obavezno!';
                            } 
                          }
                          return null;
                        },
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

 bool _areAllFieldsFilled(FormBuilderState? formState) {
  if (formState == null) {
    return false;
  }

  // Liste imena obaveznih polja
  List<String> requiredFields = ['ime', 'prezime', 'korisnickoIme', 'email', 'lozinka', 'telefon', 'pol', 'datumRodjenja','specijalnost'];

    // Provera da li su sva obavezna polja popunjena
    for (String fieldName in requiredFields) {
      if (formState.fields[fieldName]?.value == null ||
          formState.fields[fieldName]!.value.toString().isEmpty) {
        return false;
      }
  }

  return true;
}



void _showAlertDialog(String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text("Upozorenje"),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("OK"),
        ),
      ],
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
    final currentFormState = _formKey.currentState;
                if (!_areAllFieldsFilled(currentFormState)) {
              // Nisu sva polja popunjena, prikažite poruku upozorenja
              _showAlertDialog("Popunite sva obavezna polja.");
              return;
            }
          if (currentFormState != null) {
              // Validirajte formu
              if (!currentFormState.validate()) {
                // Forma nije ispravna, prikažite poruku upozorenja
                _showAlertDialog("Molimo vas da ispravno popunite sva obavezna polja.");
                return;
              }
          }
                var request = Map<String, dynamic>.from(_formKey.currentState!.value);
                var pol = request['pol'];

                String formattedDate = request['datumRodjenja'].toIso8601String();
                request['datumRodjenja'] = formattedDate;

                // Kreirajte objekat Trener sa specijalizacijom
                var trener = Trener(0, request['specijalnost']);
                request['trener'] = trener;
                request['slika']=_base64Image;

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
              child: Text("Sačuvaj trenera",style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}





}



