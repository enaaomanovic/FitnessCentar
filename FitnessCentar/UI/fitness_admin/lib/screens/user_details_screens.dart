import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/utils/util.dart';
import 'package:fitness_admin/widgets/master_screens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:convert';

class UserDetalScreen extends StatefulWidget {
  Korisnici? korisnik;
  UserDetalScreen({Key? key, this.korisnik}) : super(key: key);

  @override
  State<UserDetalScreen> createState() => _UserDetalScreenState();
}

class _UserDetalScreenState extends State<UserDetalScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  Image? userImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if ((widget.korisnik?.slika != null &&
        widget.korisnik!.slika!.isNotEmpty)) {
      userImage = imageFromBase64String(widget.korisnik!.slika!);
      _initialValue = {
        'ime': widget.korisnik?.ime,
        'prezime': widget.korisnik?.prezime,
        'korisnickoIme': widget.korisnik?.korisnickoIme,
        "datumRegistracije": widget.korisnik?.datumRegistracije.toString(),
        "datumRodjenja": widget.korisnik?.datumRodjenja.toString(),
        "pol": widget.korisnik?.pol,
        "telefon": widget.korisnik?.telefon,
        "tezina": widget.korisnik?.tezina.toString(),
        "visina": widget.korisnik?.visina.toString(),
        "email": widget.korisnik?.email,
        "slika": widget.korisnik?.slika
      };
    } else {
      // Ako korisnik nema sliku, postavite zamensku sliku

      userImage = Image.asset('assets/images/male_icon.jpg');
      _initialValue = {
        'ime': widget.korisnik?.ime,
        'prezime': widget.korisnik?.prezime,
        'korisnickoIme': widget.korisnik?.korisnickoIme,
        "datumRegistracije": widget.korisnik?.datumRegistracije.toString(),
        "datumRodjenja": widget.korisnik?.datumRodjenja.toString(),
        "pol": widget.korisnik?.pol,
        "telefon": widget.korisnik?.telefon,
        "tezina": widget.korisnik?.tezina.toString(),
        "visina": widget.korisnik?.visina.toString(),
        "email": widget.korisnik?.email,
        "slika": widget.korisnik?.slika
      };
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
       child: Container(
        child: Column(children: [_buildForm(),_buildButton()]),
      ),
     
     title: (this.widget.korisnik?.ime ?? "") + "  " + (this.widget.korisnik?.prezime ?? "Users Details"),

    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Row(
        children: [
Padding(
  padding: EdgeInsets.all(40.0),
  child: Container(
    decoration: BoxDecoration(
               
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 400.0, // Maksimalna širina
                      maxHeight: 500.0, // Maksimalna visina
                    ),
                    child: ClipRect(
                      child: userImage != null
                          ? Container(
                              width: 400.0,
                              height: 500.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.purple, // Boja bordera
                                  width: 4.0, // Debljina bordera
                                ),
                              ),
                              child: Image(
                                image: userImage!.image,
                                width: 400.0,
                                height: 400.0,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: 400.0,
                              height: 400.0,
                              decoration: BoxDecoration(
                                border: Border.all(
              color: Colors.purple, // Boja bordera
              width: 2.0, // Debljina bordera
            ),
          ),
          child: Image.asset('assets/images/male_icon.jpg'),
        ),
)

      ),
    ),
  ),
),
Card(
  elevation: 6,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  ),
  child: SizedBox(
    width: 900,
    height: 500,
    child: Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Prvi red: Ime i Prezime
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                  decoration: InputDecoration(
                    
                    labelText: "Ime",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                     fontSize: 25,
                    ),
                  ),
                  name: "ime",
                  enabled: false,
                ),
              ),
              SizedBox(width: 30),
              Expanded(
                child: FormBuilderTextField(
                  style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                  decoration: InputDecoration(
                    labelText: "Prezime",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  name: "prezime",
                  enabled: false,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),

          // Drugi red: Email i Telefon
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                     fontSize: 25,
                    ),
                  ),
                  name: "email",
                  enabled: false,
                ),
              ),
              SizedBox(width: 30),
              Expanded(
                child: FormBuilderTextField(
                  style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                  decoration: InputDecoration(
                    labelText: "Telefon",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  name: "telefon",
                  enabled: false,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),

          // Treći red: Datum rodjenja i Datum registracije
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                  decoration: InputDecoration(
                    labelText: "Datum rodjenja",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  name: "datumRodjenja",
                  enabled: false,
                ),
              ),
              SizedBox(width: 30),
              Expanded(
                child: FormBuilderTextField(
                  style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                  decoration: InputDecoration(
                    labelText: "Datum registracije",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                     fontSize: 25,
                    ),
                  ),
                  name: "datumRegistracije",
                  enabled: false,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),

          // Četvrti red: Korisnicko Ime, Pol, Visina i Tezina
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                  decoration: InputDecoration(
                    labelText: "Korisnicko ime",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  name: "korisnickoIme",
                  enabled: false,
                ),
              ),
              SizedBox(width: 30),
              Expanded(
                child: FormBuilderTextField(
                  style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                  decoration: InputDecoration(
                    labelText: "Pol",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  name: "pol",
                  enabled: false,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),

          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                  decoration: InputDecoration(
                    labelText: "Visina",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  name: "visina",
                  enabled: false,
                ),
              ),
              SizedBox(width: 30),
              Expanded(
                child: FormBuilderTextField(
                  style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                  decoration: InputDecoration(
                    labelText: "Tezina",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                    fontSize: 25,
                    ),
                  ),
                  name: "tezina",
                  enabled: false,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
)
        ],
      ),
    );
  }
Widget _buildButton() {
  return Column(
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.center, // Centrira dugmad u okviru reda
      children: [
        ElevatedButton(
          onPressed: () {
            // Ovde postavite šta želite da se dešava kada se pritisne dugme "Napredak korisnika"
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Prilagodite veličinu dugmeta
          ),
          child: Text(
            "Napredak korisnika",
            style: TextStyle(fontSize: 18), // Povećava veličinu teksta
          ),
        ),
        SizedBox(width: 20), // Dodaje razmak između dugmadi
        ElevatedButton(
          onPressed: () {
            // Ovde postavite šta želite da se dešava kada se pritisne dugme "Rezervacije korisnika"
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Prilagodite veličinu dugmeta
          ),
          child: Text(
            "Rezervacije korisnika",
            style: TextStyle(fontSize: 18), // Povećava veličinu teksta
          ),
        ),
      ],
    ),
  ],
);



}

}
