

import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/models/napredakreport.dart';
import 'package:fitness_admin/models/report.dart';
import 'package:fitness_admin/screens/pdfexport/pdf/pdfexport.dart';
import 'package:fitness_admin/screens/pdfnapredakport/pdfnapredak/pdfnapredakport.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:printing/printing.dart';


class PdfNapredakPreviewPage extends StatelessWidget {
  final NapredakReport invoice;

  const PdfNapredakPreviewPage({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      // body: PdfPreview(
      //   build: (context) => makeNapredakPdf(invoice),
      // ),
    );
  }
}


