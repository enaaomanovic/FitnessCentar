import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/models/report.dart';
import 'package:fitness_admin/screens/pdfexport/pdf/pdfexport.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:printing/printing.dart';


class PdfPreviewPage extends StatelessWidget {
  final KorisniciReport invoice;

  const PdfPreviewPage({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(invoice),
      ),
    );
  }
}