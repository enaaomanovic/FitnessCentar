import 'package:fitness_admin/models/report.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InvoicePage extends StatelessWidget {
  InvoicePage({Key? key}) : super(key: key);

  final invoices = <KorisniciReport>[];

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
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
