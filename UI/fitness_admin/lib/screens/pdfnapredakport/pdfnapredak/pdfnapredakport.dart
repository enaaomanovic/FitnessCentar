import 'dart:async';
import 'dart:io';
import 'dart:ui' as dart_ui;

import 'package:fitness_admin/models/napredakreport.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height:
                                150, // Postavi visinu slike na 100 piksela, širina će se automatski prilagoditi
                            child: Image.asset('assets/images/FitnessLogo.jpg'),
                          ),
                          SizedBox(width: 50),
                          Text(
                            'Fitness Centar',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Čestitamo, postigli ste rezultate u vašem fitness putovanju. Rezultati vašeg napretka su sljedeći:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      DataTable(
                        // Dodajte DataTable prikaz podataka
                        columns: [
                          DataColumn(label: Text('Datumi')),
                          DataColumn(label: Text('Težine')),
                        ],
                        rows: List.generate(widget.invoice.tezine!.length,
                            (index) {
                          return DataRow(cells: [
                            DataCell(Text(DateFormat('dd-MM-yyyy').format(
                                widget.invoice.datumiMjerenja![index]))),
                            DataCell(
                                Text('${widget.invoice.tezine![index]} kg')),
                          ]);
                        }),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Grafički prikaz rezultata',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 450,
                        width: 800,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RepaintBoundary(
                            child: SparkLineChart(
                              key: chartKey,
                              invoice: widget.invoice,
                            ),
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
                width: 150,
                color: Colors.green,
                child: IconButton(
                  onPressed: () {
                    /// Snackbar messanger to indicate that the spark chart is being exported as PDF
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(milliseconds: 2000),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      content:
                          Text('Spark Chart is being exported as PDF document'),
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

  Future<void> _renderPdf() async {
    // Create a new PDF document.
    final PdfDocument document = PdfDocument();
    // Create a pdf bitmap for the rendered spark chart image.
    final PdfBitmap bitmap = PdfBitmap(await _readImageData());
    // set the necessary page settings for the pdf document such as margin, size etc..
    document.pageSettings.margins.all = 0;
    document.pageSettings.size =
        Size(bitmap.width.toDouble(), bitmap.height.toDouble());
    // Create a PdfPage page object and assign the pdf document's pages to it.
    final PdfPage page = document.pages.add();
    // Retrieve the pdf page client size
    final Size pageSize = page.getClientSize();
    // Draw an image into graphics using the bitmap.
    page.graphics.drawImage(
        bitmap, Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));

    // Snackbar indication for chart export operation
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      duration: Duration(milliseconds: 200),
      content: Text('Spark Chart has been exported as PDF document.'),
    ));
    //Save and dispose the document.
    final List<int> bytes = document.saveSync();
    document.dispose();

    //Get the external storage directory.
    Directory directory = (await getApplicationDocumentsDirectory());
    //Get the directory path.
    String path = directory.path;
    //Create an empty file to write the PDF data.
    File file = File('$path/output.pdf');
    //Write the PDF data.
    await file.writeAsBytes(bytes, flush: true);
    //Open the PDF document on mobile.
    OpenFile.open('$path/output.pdf');
  }




  /// Method to read the rendered spark bar chart image and return the image data for processing.
  Future<List<int>> _readImageData() async {
    final dart_ui.Image data =
        await chartKey.currentState!.convertToImage(pixelRatio: 3.0);

    final ByteData? bytes =
        await data.toByteData(format: dart_ui.ImageByteFormat.png);
    return bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  }
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

    return RepaintBoundary(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            color: Colors.white,
            height: 500,
            width: 320,
            child: SfSparkLineChart.custom(
              xValueMapper: (int index) => datumiMjerenja[index],
              // Povežite yValueMapper sa težinama
              yValueMapper: (int index) => tezine[index],
              // Postavite broj podataka
              dataCount: datumiMjerenja.length,
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
