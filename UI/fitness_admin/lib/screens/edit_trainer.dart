import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/models/trener.dart';
import 'package:fitness_admin/providers/trainer_provider.dart';
import 'package:fitness_admin/providers/user_provider.dart';
import 'package:fitness_admin/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class EditTrainerScreen extends StatefulWidget {
  final int userId;
   final Function refreshDataCallback;
  const EditTrainerScreen({Key? key, required this.userId,required this.refreshDataCallback}) : super(key: key);

  @override
  _EditTrainerScreenState createState() => _EditTrainerScreenState();
}

class _EditTrainerScreenState extends State<EditTrainerScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  late UserProvider _userProvider;
  late TrainerProvider _trainerProvider;

  // Dodajte kontrolere ovdje
  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  TextEditingController _specijalnostController = TextEditingController();
  TextEditingController _telefonController = TextEditingController();
  TextEditingController _korisnickoImeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _trainerProvider = context.read<TrainerProvider>();

    // Inicijalizacija kontrolera
    _imeController = TextEditingController();
    _prezimeController = TextEditingController();
    _specijalnostController = TextEditingController();
    _telefonController = TextEditingController();
    _korisnickoImeController = TextEditingController();
    _emailController = TextEditingController();

    _loadUserData(widget.userId);
  }

  Future<Korisnici?> getUserFromUserId(int userId) async {
    final user = await _userProvider.getById(userId);
    return user;
  }

  Future<Trener?> getTrainerFromUserId(int userId) async {
    final user = await _trainerProvider.getById(userId);
    return user;
  }

  void _loadUserData(int userId) async {
    Korisnici? user = await getUserFromUserId(userId);
    Trener? trener = await getTrainerFromUserId(userId);

    if (user != null) {
      setState(() {
        // Koristimo `FormBuilderState` za postavljanje vrednosti polja
        _formKey.currentState?.patchValue({
          'ime': user.ime ?? '',
          'prezime': user.prezime ?? '',
          'specijalnost': trener?.specijalnost ?? '',
          'telefon': user.telefon ?? '',
          'korisnickoIme': user.korisnickoIme ?? '',
          'email': user.email ?? '',
        });

        // Postavljamo vrednosti u kontrolere
        _imeController.text = user.ime ?? '';
        _prezimeController.text = user.prezime ?? '';
        _specijalnostController.text = trener?.specijalnost ?? '';
        _telefonController.text = user.telefon ?? '';
        _korisnickoImeController.text = user.korisnickoIme ?? '';
        _emailController.text = user.email ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      child: Center(
        child: SingleChildScrollView(
          child: _buildBody(),
        ),
      ),
      title: "Uredi trenera",
    );
  }

  Widget _buildBody() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.purple, width: 3.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                Text(
                  'Ime',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FormBuilderTextField(
                  controller: _imeController,
                  name: 'ime',
                validator: (value) {
                              if (_formKey
                                      .currentState?.fields['ime']?.isDirty ==
                                  true) {
                                if (value == null || value.isEmpty) {
                                  return 'Ovo polje je obavezno!';
                                } else if (value[0] != value[0].toUpperCase()) {
                                  return 'Ime mora početi velikim slovom.';
                                }
                              }
                              return null;
                            },
                ),
                SizedBox(height: 10),
                Text(
                  'Prezime',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FormBuilderTextField(
                  controller: _prezimeController,
                  name: 'prezime',
                   validator: (value) {
                              if (_formKey.currentState?.fields['prezime']
                                      ?.isDirty ==
                                  true) {
                                if (value == null || value.isEmpty) {
                                  return 'Ovo polje je obavezno!';
                                } else if (value[0] != value[0].toUpperCase()) {
                                  return 'Prezime mora početi velikim slovom.';
                                }
                              }
                              return null;
                            },
                ),

                SizedBox(height: 10),
                Text(
                  'Telefon',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FormBuilderTextField(
                  controller: _telefonController,
                  name: 'telefon',
                   validator: (value) {
                              if (_formKey.currentState?.fields['telefon']
                                      ?.isDirty ==
                                  true) {
                                if (value == null || value.isEmpty) {
                                  return 'Ovo polje je obavezno!';
                                } else if (!RegExp(r'^[0-9]+$')
                                    .hasMatch(value)) {
                                  return 'Unesite ispravan broj telefona (samo brojevi).';
                                }
                              }
                              return null;
                            },
                ),
                SizedBox(height: 10),
                Text(
                  'Korisničko ime',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FormBuilderTextField(
                  controller: _korisnickoImeController,
                  name: 'korisnickoIme',
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
                ),
                SizedBox(height: 10),
                Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FormBuilderTextField(
                  controller: _emailController,
                  name: 'email',
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
                ),
                SizedBox(height: 20),
                 ElevatedButton(
                    onPressed: () => _updateSpecijalnost(context),
                    child: Text('Edituj specijalnost trenera'),
                  ),
                SizedBox(height: 20),
                Center(
                  child:
                   ElevatedButton(
                    onPressed: _updateUserData,
                    child: Text('Sačuvaj promene'),
                  ),
                  
                ),
               
         
              ],
            ),
          ),
        ),
      ),
    );
  }




Future<void> _updateSpecijalnost(BuildContext context) async {

  final GlobalKey<FormBuilderState> _formKeySpecijalnost = GlobalKey<FormBuilderState>();

  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Edituj specijalnost trenera'),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        content: FormBuilder(
          key: _formKeySpecijalnost,
          autovalidateMode: AutovalidateMode.always,
          child: FormBuilderTextField(
            controller: _specijalnostController,
            decoration: InputDecoration(labelText: 'Nova specijalnost'),
            validator: (value) {
              if (_formKeySpecijalnost.currentState?.fields['nova_specijalnost']?.isDirty == true) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno!';
                }
              }
              return null;
            },
            name: 'nova_specijalnost',
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (_formKeySpecijalnost.currentState!.validate()) {
                String newSpecijalnost = _specijalnostController.text;
                

                Map<String, dynamic> request = {
                  'specijalnost': newSpecijalnost,
                };
                var res = await _trainerProvider.update(widget.userId, request);

                if (res is Trener) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Specijalnost uspešno ažurirana!'),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  FocusScope.of(context).unfocus();
                 // Navigator.of(context).pop();
                   Navigator.pop(context, true);

    // Dodajte sledeću liniju kako biste obavestili prethodni ekran da treba osvežiti podatke
    widget.refreshDataCallback();
  
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Greška pri ažuriranju specijalnosti'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              }
            },
            child: Text('Spasi'),
          ),
        ],
      );
    },
  );
}


  void _updateUserData() async {
    // Spremi trenutno stanje forme
    _formKey.currentState?.save();

    try {
      // Validacija forme
      if (_formKey.currentState!.validate()) {
        // Napravi mapu sa podacima iz forme
        Map<String, dynamic> request = _formKey.currentState!.value;

        // Dodaj dodatne parametre za ažuriranje (npr. id, questionId itd.)
        // Ako su potrebni za vašu implementaciju

        // Pozovi metodu za ažuriranje korisnika
        var res = await _userProvider.update(widget.userId, request);
    print(res);

    // Prikaz poruke o uspešnom ažuriranju
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Podaci su ažurirani!'),
      ),
    );

    // Zatvori trenutni ekran i obavesti prethodni ekran da treba osvežiti podatke
    Navigator.pop(context, true);

    // Dodajte sledeću liniju kako biste obavestili prethodni ekran da treba osvežiti podatke
    widget.refreshDataCallback();
  
      }
    } catch (error) {
      // Prikaz poruke o grešci ako dođe do problema
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Došlo je do greške prilikom ažuriranja podataka.'),
        ),
      );
    }
  }
}
