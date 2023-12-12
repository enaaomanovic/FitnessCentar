

import 'package:fitness_admin/models/report.dart';
import 'package:fitness_admin/screens/add_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class InvoicePage extends StatelessWidget {
  InvoicePage({Key? key}) : super(key: key);

  final invoices = <KorisniciReport>[
    KorisniciReport(
       ime:"Ena",
       prezime:"Omanovic",
       email:"enadkd",
       datumRegistracije:DateTime.now(),
       datumRodjenja :DateTime.now(),
korisnickoIme: "ena",
      lozinka: "me",
      pol: "md",
      slika: "kdl",
      telefon: "34",
      tezina: 23,
      visina: 2344,


    )
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoices'),
      ),
      body: ListView(
        children: [
          ...invoices.map(
            (e) => ListTile(
              title: Text(e.ime),
              subtitle: Text(e.prezime),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) => AddUser(report: e),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}