import 'dart:typed_data';

import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/models/report.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

Future<Uint8List> makePdf(KorisniciReport report) async {
  final pdf = Document();
 final imageLogo = MemoryImage((await rootBundle.load('assets/images/FitnessLogo.jpg')).buffer.asUint8List());
  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("FITNES CENTAR"),
                     SizedBox(
                  height: 100,
                  width: 100,
                  child: Image(imageLogo)
                     ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
               
              ],
            ),
            Container(height: 20),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      child: Text(
                        'PODACI O KORISNIKU',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                  ],
                ),
              
              
               
              ],
            ),
            Padding(
              child: Text(
                "Zelimo Vam ugodno koristenje naseg Fitness centra",
                style: Theme.of(context).header2,
              ),
              padding: EdgeInsets.all(20),
            ),
            
            Divider(
              height: 1,
              borderStyle: BorderStyle.dashed,
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    PaddedText('Ime'),
                    PaddedText(
                      "${report.ime}",
                    )
                  ],
                ),
                TableRow(
                   children: [
                    PaddedText('Prezime'),
                    PaddedText(
                      "${report.prezime}",
                    )
                  ],
                ),
                 TableRow(
                   children: [
                    PaddedText('Korisnicko ime'),
                    PaddedText(
                      "${report.korisnickoIme}",
                    )
                  ],
                ),
                  TableRow(
                   children: [
                    PaddedText('Lozinka'),
                    PaddedText(
                      "${report.lozinka}",
                    )
                  ],
                ),
                  
                  TableRow(
                   children: [
                    PaddedText('E-mail'),
                    PaddedText(
                      "${report.email}",
                    )
                  ],
                ),
                  TableRow(
                   children: [
                    PaddedText('Telefon'),
                    PaddedText(
                      "${report.telefon}",
                    )
                  ],
                ),
                  
                  TableRow(
                   children: [
                    PaddedText('Tezina'),
                    PaddedText(
                      "${report.tezina}kg",
                    )
                  ],
                ),
                TableRow(
                   children: [
                    PaddedText('Visina'),
                    PaddedText(
                      "${report.visina}cm",
                    )
                  ],
                ),
              ],
            ),
            
          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );