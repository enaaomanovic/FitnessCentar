
import 'dart:async';
import 'dart:io';
import 'dart:ui' as dart_ui;

import 'package:fitness_admin/models/napredakreport.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';

final GlobalKey<_SparkLineChartState> chartKey = GlobalKey();

class ExportSparkChart extends StatefulWidget {
  final NapredakReport invoice;

  const ExportSparkChart({Key? key, required this.invoice}) : super(key: key);

  @override
  _ExportSparkChartState createState() => _ExportSparkChartState();
}

class _ExportSparkChartState extends State<ExportSparkChart> {
  _ExportSparkChartState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Napredak korisnika'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: 
        Center(
          child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    
                     Text(
                      'Fitness Centar',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                      Text(
                      'Čestitamo, postigli ste rezultate u vašem fitness putovanju. Rezultati vašeg napretka su sljedeći:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    DataTable(
                      // Dodajte DataTable prikaz podataka
                      columns: [
                        DataColumn(label: Text('Datum')),
                        DataColumn(label: Text('Težina')),
                      ],
                      rows: List.generate(widget.invoice.tezine!.length, (index) {
                        return DataRow(cells: [
                          DataCell(Text('${widget.invoice.datumiMjerenja![index].toString()}')),
                          DataCell(Text('${widget.invoice.tezine![index]}')),
                        ]);
                      }),
                    ),
                    SizedBox(height: 20),
                  
                    Container(
                      height: 450,
                      width: 650,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RepaintBoundary(
                          child: SparkLineChart(invoice: widget.invoice),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Želimo vam uspješno daljnje napredovanje u vašem fitnes putovanju!',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: 200,
              color: Colors.green,
              child: IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(milliseconds: 2000),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                    content: Text('Spark Chart is being exported as PDF document'),
                  ));
                  _renderPdf();
                },
                icon: Row(
                  children: const <Widget>[
                    Icon(Icons.picture_as_pdf, color: Colors.black),
                    Text('Export to pdf'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }

Future<List<int>> _readImageData() async {
  if (!mounted) return []; // Provjerava je li widget još uvijek ugrađen u widget tree
  final dart_ui.Image? data = await chartKey.currentState?.convertToImage(pixelRatio: 3.0);
  if (data == null) {
    print('Image data is null');
    return [];
  }
  final ByteData? bytes = await data.toByteData(format: dart_ui.ImageByteFormat.png);
  if (bytes == null) {
    print('ByteData is null');
    return [];
  }
  return bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
}


Future<void> _renderPdf() async {
  try {
    // Kreirajte novi PDF dokument.
    final PdfDocument document = PdfDocument();
    // Kreirajte pdf bitmapu za renderiranu sliku grafikona.
    final PdfBitmap bitmap = PdfBitmap(await _readImageData());
    if (bitmap.width == 0 || bitmap.height == 0) {
      throw Exception("Image conversion error");
    }
    // Postavite potrebne postavke stranice za PDF dokument kao što su margine, veličina itd.
    document.pageSettings.margins.all = 0;
    document.pageSettings.size =
        Size(bitmap.width.toDouble(), bitmap.height.toDouble());
    // Kreirajte objekt stranice PdfPage i dodijelite stranice PDF dokumenta.
    final PdfPage page = document.pages.add();
    // Dohvatite veličinu klijentske stranice PDF-a
    final Size pageSize = page.getClientSize();
    // Nacrtajte sliku u grafiku koristeći bitmapu.
    page.graphics.drawImage(
        bitmap, Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));

    // Snackbar obavijest za izvoz grafa u PDF
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      duration: Duration(milliseconds: 200),
      content: Text('Spark Chart has been exported as PDF document.'),
    ));
    // Spremi i oslobodi dokument.
    final List<int> bytes = document.saveSync();
    document.dispose();

    // Dohvati direktorij aplikacije.
    Directory directory = (await getApplicationDocumentsDirectory());
    // Dohvati putanju direktorija.
    String path = directory.path;
    // Kreiraj praznu datoteku za pohranu podataka PDF-a.
    File file = File('$path/output.pdf');
    // Spremi podatke PDF-a.
    await file.writeAsBytes(bytes, flush: true);
    // Otvori PDF dokument na mobilnom uređaju.
    OpenFile.open('$path/output.pdf');
  } catch (e) {
    print("Error exporting to PDF: $e");
    // Prikaži poruku o grešci ako dođe do problema pri izvozu u PDF formatu.
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: 2000),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      content: Text('Error exporting Spark Chart to PDF document'),
    ));
  }
}


//    Future<void> _renderPdf() async {
//     // Create a new PDF document.
//     final PdfDocument document = PdfDocument();
//     // Create a pdf bitmap for the rendered spark chart image.
//     final PdfBitmap bitmap = PdfBitmap(await _readImageData());
//     // set the necessary page settings for the pdf document such as margin, size etc..
//     document.pageSettings.margins.all = 0;
//     document.pageSettings.size =
//         Size(bitmap.width.toDouble(), bitmap.height.toDouble());
//     // Create a PdfPage page object and assign the pdf document's pages to it.
//     final PdfPage page = document.pages.add();
//     // Retrieve the pdf page client size
//     final Size pageSize = page.getClientSize();
//     // Draw an image into graphics using the bitmap.
//     page.graphics.drawImage(
//         bitmap, Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));

//     // Snackbar indication for chart export operation
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       behavior: SnackBarBehavior.floating,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(5))),
//       duration: Duration(milliseconds: 200),
//       content: Text('Spark Chart has been exported as PDF document.'),
//     ));
//     //Save and dispose the document.
//     final List<int> bytes = document.saveSync();
//     document.dispose();

//     //Get the external storage directory.
//     Directory directory = (await getApplicationDocumentsDirectory());
//     //Get the directory path.
//     String path = directory.path;
//     //Create an empty file to write the PDF data.
//     File file = File('$path/output.pdf');
//     //Write the PDF data.
//     await file.writeAsBytes(bytes, flush: true);
//     //Open the PDF document on mobile.
//     OpenFile.open('$path/output.pdf');
//   }

// Future<List<int>> _readImageData() async {
//   if (!mounted) return []; // Provjerava je li widget još uvijek ugrađen u widget tree
//   final dart_ui.Image data =
//       await chartKey.currentState!.convertToImage(pixelRatio: 3.0);
//   final ByteData? bytes =
//       await data.toByteData(format: dart_ui.ImageByteFormat.png);
//   return bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
// }

}

class SparkLineChart extends StatefulWidget {
  final NapredakReport invoice;

  const SparkLineChart({Key? key, required this.invoice}) : super(key: key);

  @override
  _SparkLineChartState createState() => _SparkLineChartState();
}

class _SparkLineChartState extends State<SparkLineChart> {
  @override
  Widget build(BuildContext context) {
    // Koristite vaše podatke datuma i težina iz objekta NapredakReport
    List<DateTime> datumiMjerenja = widget.invoice.datumiMjerenja!;
    List<double> tezine = widget.invoice.tezine!;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            color: Colors.white,
            height: 500,
            width: 320,
            child: SfSparkLineChart.custom(
              // Povežite xValueMapper sa datumima mjerenja
              xValueMapper: (int index) => datumiMjerenja[index],
              // Povežite yValueMapper sa težinama
              yValueMapper: (int index) => tezine[index],
              // Postavite broj podataka
              dataCount: datumiMjerenja.length,
              // Dodajte svojstvo za prikazivanje svih oznaka
              labelDisplayMode: SparkChartLabelDisplayMode.all,
            ),
          ),
        ),
      ),
    );
  }
  Future<dart_ui.Image> convertToImage({double pixelRatio = 1.0}) async {
    // Get the render object from context and store in the RenderRepaintBoundary onject.
    final RenderRepaintBoundary boundary =
        context.findRenderObject() as RenderRepaintBoundary;

    // Convert the repaint boundary as image
    final dart_ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);

    return image;
  }
}
