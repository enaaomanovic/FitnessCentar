import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fitness_admin/screens/add_treiner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: Text(
            "Dodaj novog korisnika", // Dodajte naslov
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
    title: "Dodaj korisnika",
  );
}


Widget _addForm() {
  return FormBuilder(
    key: _formKey, // Postavljanje ključa forme
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
                      decoration: InputDecoration(labelText: "Ime"),
                      name: "ime",
                    ),
                    SizedBox(height: 15),
                    FormBuilderTextField(
                      decoration: InputDecoration(labelText: "Prezime"),
                      name: "prezime",
                    ),
                    SizedBox(height: 15),
                    FormBuilderTextField(
                      decoration: InputDecoration(labelText: "Korisničko ime"),
                      name: "korisnickoIme",
                    ),
                    SizedBox(height: 15),
                    FormBuilderTextField(
                      decoration: InputDecoration(labelText: "E-mail"),
                      name: "email",
                    ),
                    SizedBox(height: 15),
                    FormBuilderTextField(
                      decoration: InputDecoration(labelText: "Lozinka"),
                      name: "lozinka",
                    ),
                    SizedBox(height: 15),
                    FormBuilderTextField(
                      decoration: InputDecoration(labelText: "Telefon"),
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
                      decoration: InputDecoration(labelText: "Težina"),
                      name: "tezina",
                    ),
                    SizedBox(height: 15),
                    FormBuilderTextField(
                      decoration: InputDecoration(labelText: "Visina"),
                      name: "visina",
                    ),
                    SizedBox(height: 15),
                    FormBuilderDateTimePicker(
                      name: 'datumRodjenja',
                      inputType: InputType.date,
                      decoration: InputDecoration(labelText: 'Datum rođenja'),
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
  return Center(
    child:
        Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 250, 
               // Povećajte širinu dugmeta po potrebi
                child: ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState?.saveAndValidate();
                    var request = Map<String, dynamic>.from(_formKey.currentState!.value);
                    var pol = request['pol'];

                    String formattedDate = request['datumRodjenja'].toIso8601String();
                    request['datumRodjenja'] = formattedDate;


                  request['slika'] = _base64Image;
                 


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
                  child: Text("Sačuvaj"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                  ),
                ),
              ),
            ),
             Align(
  alignment: Alignment.topRight,
  child: SizedBox(
    width: 250, // Povećajte širinu dugmeta po potrebi
    child: Padding(
      padding: const EdgeInsets.only(right: 10),
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
  ),
), 
         Align(
  alignment: Alignment.topRight,
  child: SizedBox(
    width: 250, // Povećajte širinu dugmeta po potrebi
    child: Padding(
      padding: const EdgeInsets.only(top: 10,right: 10),


      child: ElevatedButton(
        onPressed: () async {
         
        },
        child: Text("Isprintaj korisnika"),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(10),
        ),
      ),
    ),
  ),
), 
          ],
        ),
         
       
    
  );
}





}



