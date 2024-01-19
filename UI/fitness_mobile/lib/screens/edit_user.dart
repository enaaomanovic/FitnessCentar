

import 'dart:convert';
import 'dart:io';

import 'package:fitness_mobile/models/korisnici.dart';
import 'package:fitness_mobile/providers/progress_provider.dart';
import 'package:fitness_mobile/providers/trainer_provider.dart';
import 'package:fitness_mobile/providers/user_provider.dart';

import 'package:fitness_mobile/screens/home_authenticated.dart';
import 'package:fitness_mobile/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

class EditUserScreen extends StatefulWidget {
  final int userId;
  final Function refreshDataCallback;

  const EditUserScreen({Key? key, required this.userId, required this.refreshDataCallback}) : super(key: key);

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  late UserProvider _userProvider;
  late TrainerProvider _trainerProvider;



  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  TextEditingController _telefonController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  File? _image;
  String? _base64Image;
  bool _removeImage = false;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _trainerProvider = context.read<TrainerProvider>();

    _imeController = TextEditingController();
    _prezimeController = TextEditingController();
    _telefonController = TextEditingController();
    _emailController = TextEditingController();

    _loadUserData(widget.userId);
  }

  Future<Korisnici?> getUserFromUserId(int userId) async {
    final user = await _userProvider.getById(userId);
    return user;
  }

  void _loadUserData(int userId) async {
    Korisnici? user = await getUserFromUserId(userId);

    if (user != null) {
      setState(() {
        _formKey.currentState?.patchValue({
          'ime': user.ime ?? '',
          'prezime': user.prezime ?? '',
          'telefon': user.telefon ?? '',
          'slika': user.slika,
          'email': user.email ?? '',
        });

        _imeController.text = user.ime ?? '';
        _prezimeController.text = user.prezime ?? '';
        _telefonController.text = user.telefon ?? '';
        _emailController.text = user.email ?? '';
      });
    }
  }

final picker = ImagePicker();

Future getImage() async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    setState(() {
      _image = File(pickedFile.path);
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
      title: "Uredi profil",
    );
  }

Widget _editKredencijala() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       Expanded(
          child: Text(
            "Uređivanje korisnika",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21.0,
            
            ),
          ),
        ),
         
      ],
    ),
  );
}


  Widget _buildBody() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
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
                  'Slika',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FormBuilderField(
                  name: 'slika',
                  builder: (field) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        errorText: field.errorText,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Icon(Icons.photo),
                            title: Text("Select image"),
                            trailing: Icon(Icons.file_upload),
                            onTap: getImage,
                            subtitle: _image != null
                                ? Image.file(
                                    _image!,
                                    width: 80.0,
                                    height: 80.0,
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Checkbox(
                                value: _removeImage,
                                onChanged: (value) {
                                  setState(() {
                                    _removeImage = value ?? false;
                                    if (_removeImage) {
                                      // Ako je checkbox označen za uklanjanje slike, postavite _image na null
                                      _image = null;
                                    }
                                  });
                                },
                              ),
                              Text('Ukloni sliku'),
                            ],
                          ),

                        ],
                      ),
                    );
                  },
                ),
                Text(
                  'Ime',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FormBuilderTextField(
                  controller: _imeController,
                  name: 'ime',
                  validator: (value) {
                    if (_formKey.currentState?.fields['ime']?.isDirty == true) {
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
                    if (_formKey.currentState?.fields['prezime']?.isDirty == true) {
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
                    if (_formKey.currentState?.fields['telefon']?.isDirty == true) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Unesite ispravan broj telefona (samo brojevi).';
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
                    if (_formKey.currentState?.fields['email']?.isDirty == true) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                        return 'Unesite ispravan email.';
                      }
                    }
                    return null;
                  },
                ),
                Center(
                  child: ElevatedButton(
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

void _updateUserData() async {
  _formKey.currentState?.save();

  try {
    if (_formKey.currentState!.validate()) {
      // Kopiranje mape
      Map<String, dynamic> request = Map.from(_formKey.currentState!.value);

      // Ako je checkbox za uklanjanje slike označen, postavite slika na null
      if (_removeImage) {
        request['slika'] = null;
      } else if (_image != null) {
        // Ako nije označen checkbox za uklanjanje slike i odabrana je nova slika, kod za kodiranje slike ostaje nepromijenjen
        List<int> imageBytes = await _image!.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        request['slika'] = base64Image;
      }

      var res = await _userProvider.update(widget.userId, request);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Podaci su ažurirani!'),
        ),
      );
      Navigator.pop(context, true);
      widget.refreshDataCallback();
    }
  } catch (error) {
    print('Greška prilikom ažuriranja podataka: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Došlo je do greške prilikom ažuriranja podataka. Pogledajte konzolu za više informacija.'),
      ),
    );
  }
}




//   void _updateUserData() async {
//     _formKey.currentState?.save();

//     try {
//       if (_formKey.currentState!.validate()) {
//         Map<String, dynamic> request = _formKey.currentState!.value;

//        if (_image != null) {
//         List<int> imageBytes = await _image!.readAsBytes();
//         String base64Image = base64Encode(imageBytes);
//         request['slika'] = base64Image;
//       }


//         var res = await _userProvider.update(widget.userId, request);

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Podaci su ažurirani!'),
//           ),
//         );
//       Navigator.pop(context,true); 
//         widget.refreshDataCallback(); 

  


//       }
//     }
//     catch (error) {
//   print('Greška prilikom ažuriranja podataka: $error');
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text('Došlo je do greške prilikom ažuriranja podataka. Pogledajte konzolu za više informacija.'),
//     ),
//   );
// }

 // }
}
