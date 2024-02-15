import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/models/trener.dart';
import 'package:fitness_admin/providers/trainer_provider.dart';
import 'package:fitness_admin/providers/user_provider.dart';
import 'package:fitness_admin/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class EditUserScreen extends StatefulWidget {
  final int userId;
   final Function refreshDataCallback;
  const EditUserScreen({Key? key, required this.userId,required this.refreshDataCallback}) : super(key: key);

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  late UserProvider _userProvider;
  late TrainerProvider _trainerProvider;

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


  void _loadUserData(int userId) async {
    Korisnici? user = await getUserFromUserId(userId);

    if (user != null) {
      setState(() {
       
        _formKey.currentState?.patchValue({
          'ime': user.ime ?? '',
          'prezime': user.prezime ?? '',
          'telefon': user.telefon ?? '',
          
          'slika':user.slika,
          'email': user.email ?? '',
        });

        _imeController.text = user.ime ?? '';
        _prezimeController.text = user.prezime ?? '';

        _telefonController.text = user.telefon ?? '';
      
        _emailController.text = user.email ?? '';
      });
    }
  }

    File? _image;
  String? _base64Image;
    bool _removeImage = false;
  
  Future getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base64Image = base64Encode(_image!.readAsBytesSync());
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
                          // Prikazi trenutnu sliku korisnika ako postoji
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
                                    _image = null;
                                    _base64Image = null;
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



 void _updateUserData() async {

  _formKey.currentState?.save();

  try {
   
    if (_formKey.currentState!.validate()) {
     
      Map<String, dynamic> request = _formKey.currentState!.value;

     
      Map<String, dynamic> requestData = Map.from(request);

     
    if (_removeImage) {
    requestData['slika'] = null; 
  } else if (_base64Image != null) {
    
    requestData['slika'] = _base64Image;
  }

 
      var res = await _userProvider.update(widget.userId, requestData);
      print(res);

     
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Podaci su ažurirani!'),
        ),
      );

    
      Navigator.pop(context, true);


      widget.refreshDataCallback();
    }
  } catch (error) {
   
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Došlo je do greške prilikom ažuriranja podataka.'),
      ),
    );
  }
}

}
