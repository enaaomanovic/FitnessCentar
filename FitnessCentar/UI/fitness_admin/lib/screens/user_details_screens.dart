// import 'package:fitness_admin/models/korisnici.dart';
// import 'package:fitness_admin/utils/util.dart';
// import 'package:fitness_admin/widgets/master_screens.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'dart:convert';

// class UserDetalScreen extends StatefulWidget {
//   Korisnici? korisnik;
//   UserDetalScreen({Key? key, this.korisnik}) : super(key: key);

//   @override
//   State<UserDetalScreen> createState() => _UserDetalScreenState();
// }

// class _UserDetalScreenState extends State<UserDetalScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   Map<String, dynamic> _initialValue = {};
//   Image? userImage;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     if (widget.korisnik?.slika != null) {
//       userImage = imageFromBase64String(widget.korisnik!.slika!);
//       _initialValue = {
//         'ime': widget.korisnik?.ime,
//         'prezime': widget.korisnik?.prezime,
//         'korisnickoIme': widget.korisnik?.korisnickoIme,
//         "datumRegistracije": widget.korisnik?.datumRegistracije.toString(),
//         "datumRodjenja": widget.korisnik?.datumRodjenja.toString(),
//         "pol": widget.korisnik?.pol,
//         "telefon": widget.korisnik?.telefon,
//         "tezina": widget.korisnik?.tezina.toString(),
//         "visina": widget.korisnik?.visina.toString(),
//         "email": widget.korisnik?.email,
//         "slika": widget.korisnik?.slika
//       };
//     }
//   }

//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MasterScreanWidget(
//       child: _buildForm(),
//       title: (this.widget.korisnik?.ime ?? "") +
//           (this.widget.korisnik?.prezime ?? "Users Details"),
//     );
//   }

//   FormBuilder _buildForm() {
//     return FormBuilder(
//       key: _formKey,
//       initialValue: _initialValue,
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Align(
//                 alignment:
//                     Alignment.topLeft, // Postavlja sliku u lijevi gornji kut
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(
//                     maxWidth: 400.0,
//                     maxHeight: 400.0,
//                   ),
//                   child: FittedBox(
//                     fit: BoxFit.contain,
//                     child: userImage,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: FormBuilderTextField(
//                   decoration: InputDecoration(labelText: "Ime"),
//                   name: "ime",
//                 ),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Expanded(
//                 child: FormBuilderTextField(
//                   decoration: InputDecoration(labelText: "Prezime"),
//                   name: "prezime",
//                 ),
//               ),
//               Expanded(
//                 child: FormBuilderTextField(
//                   decoration: InputDecoration(labelText: "Telefon"),
//                   name: "telefon",
//                 ),
//               ),
//               Expanded(
//                 child: FormBuilderTextField(
//                   decoration: InputDecoration(labelText: "Email"),
//                   name: "email",
//                 ),
//               ),
//               Expanded(
//                 child: FormBuilderTextField(
//                   decoration: InputDecoration(labelText: "Datum registracije"),
//                   name: "datumRegistracije",
//                 ),
//               ),
//               Expanded(
//                 child: FormBuilderTextField(
//                   decoration: InputDecoration(labelText: "Datum rodjenja"),
//                   name: "datumRodjenja",
//                 ),
//               ),
//               Expanded(
//                 child: FormBuilderTextField(
//                   decoration: InputDecoration(labelText: "Pol"),
//                   name: "pol",
//                 ),
//               ),
//               Expanded(
//                 child: FormBuilderTextField(
//                   decoration: InputDecoration(labelText: "Visina"),
//                   name: "visina",
//                 ),
//               ),
//               Expanded(
//                 child: FormBuilderTextField(
//                   decoration: InputDecoration(labelText: "Tezina"),
//                   name: "tezina",
//                 ),
//               ),
//               Expanded(
//                 child: FormBuilderTextField(
//                   decoration: InputDecoration(labelText: "Tezina"),
//                   name: "tezina",
//                 ),
//               ),
//             ],
//           ),
          
//         ],
//       ),
//     );
//   }
// }



//import 'dart:html';

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
    if (widget.korisnik?.slika != null) {
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
      child: _buildForm(),
     title: (this.widget.korisnik?.ime ?? "") +
          (this.widget.korisnik?.prezime ?? "Users Details"),
    );
  }

FormBuilder _buildForm() {
  return FormBuilder(
    key: _formKey,
    initialValue: _initialValue,
    child: Row(
      children: [
        // Slika korisnika
       Padding(
  padding: EdgeInsets.all(40.0), // Dodajte odgovarajući razmak
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.purple, // Boja ivice
        width: 4.0, // Širina ivice
      ),
    ),
    child: Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 650.0, // Smanjio sam veličinu slike
          maxHeight: 650.0,
        ),
        child: FittedBox(
         fit: BoxFit.cover,
          child: userImage,
        ),
      ),
    ),
  ),
),


        // Informacije o korisniku
        Expanded(
          child: Column(
            children: [
              FormBuilderTextField(
                decoration: InputDecoration(labelText: "Ime"),
                name: "ime",
              ),
              FormBuilderTextField(
                decoration: InputDecoration(labelText: "Prezime"),
                name: "prezime",
              ),
              FormBuilderTextField(
                decoration: InputDecoration(labelText: "Telefon"),
                name: "telefon",
              ),
              FormBuilderTextField(
                decoration: InputDecoration(labelText: "Email"),
                name: "email",
              ),
              FormBuilderTextField(
                decoration: InputDecoration(labelText: "Datum registracije"),
                name: "datumRegistracije",
              ),
              FormBuilderTextField(
                decoration: InputDecoration(labelText: "Datum rodjenja"),
                name: "datumRodjenja",
              ),
              FormBuilderTextField(
                decoration: InputDecoration(labelText: "Pol"),
                name: "pol",
              ),
              FormBuilderTextField(
                decoration: InputDecoration(labelText: "Visina"),
                name: "visina",
              ),
              FormBuilderTextField(
                decoration: InputDecoration(labelText: "Tezina"),
                name: "tezina",
              ),
              // Dodajte ostale FormBuilderTextField widgets po potrebi
            ],
          ),
        ),
      ],
    ),
  );
}


}


  
