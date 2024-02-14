import 'dart:async';
import 'dart:io';
import 'dart:ui' as dart_ui;

import 'package:collection/collection.dart';
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
        body: (widget.invoice.tezine != null &&
                widget.invoice.tezine!.isNotEmpty)
            ? Padding(
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
                                    height: 150,
                                    child: Image.asset(
                                        'assets/images/FitnessLogo.jpg'),
                                  ),
                                  SizedBox(width: 50),
                                  Text(
                                    'Fitness Centar',
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
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
                                rows: List.generate(
                                    widget.invoice.tezine!.length, (index) {
                                  return DataRow(cells: [
                                    DataCell(Text(DateFormat('dd-MM-yyyy')
                                        .format(widget
                                            .invoice.datumiMjerenja![index]))),
                                    DataCell(Text(
                                        '${widget.invoice.tezine![index]} kg')),
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
                                  border:
                                      Border.all(color: Colors.grey, width: 4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RepaintBoundary(
                                    child: SparkLineChart(
                                      key: chartKey,
                                      invoice: widget.invoice,
                                      width: 500,
                                      height: 100,
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(milliseconds: 2000),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              content: Text(
                                  'Spark Chart is being exported as PDF document'),
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
              )
            : Padding(
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
                                    height: 150,
                                    child: Image.asset(
                                        'assets/images/FitnessLogo.jpg'),
                                  ),
                                  SizedBox(width: 50),
                                  Text(
                                    'Fitness Centar',
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Jos uvijek niste postigli napredak, zelimo vam srecu u buducem napredovanju!',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }

  Future<void> _addLogoAndProgressTable(PdfDocument document, PdfPage page,
      double containerWidth, double containerHeight) async {
    final double pageWidth = page.getClientSize().width;
    final double pageHeight = page.getClientSize().height;

    final double logoX = (pageWidth - 700) / 2;
    final double logoY = 150;

    final String fitnessCenterText = 'Fitness Centar';
    final PdfTextElement textElement = PdfTextElement(
      text: fitnessCenterText,
      font: PdfStandardFont(PdfFontFamily.timesRoman, 45,
          style: PdfFontStyle.bold),
    );
    final PdfLayoutResult? textLayoutResult = textElement.draw(
      page: page,
      bounds: Rect.fromLTWH(
        logoX + 250,
        logoY + 80,
        300,
        100,
      ),
      format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate),
    );

    final double tableX = 50;
    final double tableY = logoY + 150 + 20;

    final double requiredHeight = tableY + containerHeight + 20 + 16;

    if (requiredHeight > pageHeight) {
      page.graphics.drawLine(
        PdfPen(PdfColor(0, 0, 0), width: 1),
        Offset(pageWidth - 20, 0),
        Offset(pageWidth - 20, pageHeight),
      );
      page.graphics.drawString(
        'Continued...',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: Rect.fromLTWH(pageWidth - 20, pageHeight - 50, 20, 50),
        format: PdfStringFormat(alignment: PdfTextAlignment.center),
      );

      final PdfPage newPage = document.pages.add();
      await _addLogoAndProgressTable(
          document, newPage, containerWidth, containerHeight);
      return;
    }

    ByteData data = await rootBundle.load('assets/images/FitnessLogo.jpg');
    Uint8List uint8list = data.buffer.asUint8List();
    PdfBitmap pdfImage = PdfBitmap(uint8list);

    page.graphics.drawImage(pdfImage, Rect.fromLTWH(logoX, logoY, 220, 220));

    final PdfGrid grid = PdfGrid();

    PdfLayoutResult? result = grid.draw(
      page: page,
      bounds: Rect.fromLTWH(
          tableX, tableY, pageWidth - 2 * tableX, pageHeight - tableY),
    );

    final PdfBitmap bitmap = PdfBitmap(await _readImageData());
    final double chartX = 50;
    final double chartY = result!.bounds.bottom + 20;
    page.graphics.drawImage(
      bitmap,
      Rect.fromLTWH(chartX, chartY, containerWidth, containerHeight),
    );
  }

  Future<void> _addDataTable(PdfDocument document, PdfPage page,
      List<DateTime> datumiMjerenja, List<double> tezine) async {
    final double pageWidth = page.getClientSize().width;
    final double pageHeight = page.getClientSize().height;

    final double tableX = 300;
    final double tableY = 550;

    final PdfGrid dataTable = PdfGrid();

    dataTable.columns.add(count: 2);
    dataTable.headers.add(1);
    dataTable.headers[0].cells[0].value = 'Datumi';
    dataTable.headers[0].cells[1].value = 'Tezine';

    final PdfStandardFont headerFont =
        PdfStandardFont(PdfFontFamily.helvetica, 25, style: PdfFontStyle.bold);
    final PdfStringFormat headerFormat = PdfStringFormat(
      alignment: PdfTextAlignment.center,
      lineAlignment: PdfVerticalAlignment.middle,
    );

    final PdfBorders dataBorderStyle = PdfBorders(
      left: PdfPens.white,
      top: PdfPens.white,
      right: PdfPens.white,
      bottom: PdfPens.black,
    );

    final PdfBorders headerBorderStyle = PdfBorders(
      left: PdfPens.transparent,
      top: PdfPens.transparent,
      right: PdfPens.transparent,
      bottom: PdfPens.white,
    );

    for (int j = 0; j < dataTable.columns.count; j++) {
      dataTable.headers[0].cells[j].style.borders = headerBorderStyle;
    }

    dataTable.headers[0].style = PdfGridCellStyle(
      font: headerFont,
      format: headerFormat,
    );
    dataTable.headers[0].cells[0].style = PdfGridCellStyle(
      font: headerFont,
      format: headerFormat,
      borders: dataBorderStyle,
    );
    dataTable.headers[0].cells[1].style = PdfGridCellStyle(
      font: headerFont,
      format: headerFormat,
      borders: dataBorderStyle,
    );

    for (int i = 0; i < datumiMjerenja.length; i++) {
      final DateTime datum = datumiMjerenja[i];
      final double tezina = tezine[i];

      dataTable.rows.add();

      dataTable.rows[i].cells[0].value = DateFormat('dd-MM-yyyy').format(datum);
      dataTable.rows[i].cells[1].value = '$tezina kg';

      final PdfStandardFont cellFont =
          PdfStandardFont(PdfFontFamily.helvetica, 25);
      final PdfStringFormat cellFormat = PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle,
      );

      dataTable.rows[i].cells[0].style = PdfGridCellStyle(
        font: cellFont,
        format: cellFormat,
        borders: dataBorderStyle,
      );
      dataTable.rows[i].cells[1].style = PdfGridCellStyle(
        font: cellFont,
        format: cellFormat,
        borders: dataBorderStyle,
      );
    }

    PdfLayoutResult? result = dataTable.draw(
      page: page,
      bounds: Rect.fromLTWH(
          tableX, tableY, pageWidth - 1 * tableX, pageHeight - tableY),
    );

    if (result!.bounds.bottom > pageHeight) {
      final PdfPage newPage = document.pages.add();
      await _addDataTable(document, newPage, datumiMjerenja, tezine);
    }
  }

  Future<void> _addText(PdfDocument document, PdfPage page) async {
    final double pageWidth = page.getClientSize().width;
    final double pageHeight = page.getClientSize().height;

    final String textContent = "Graficki prikaz rezultata";
    final PdfFont font =
        PdfStandardFont(PdfFontFamily.timesRoman, 25, style: PdfFontStyle.bold);

    final PdfStringFormat format = PdfStringFormat(
      alignment: PdfTextAlignment.center,
    );
    final Size textSize = font.measureString(textContent, format: format);

    final double textX = (pageWidth - textSize.width) / 2;
    final double textY = 800;

    page.graphics.drawString(
      textContent,
      font,
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      bounds: Rect.fromLTWH(textX, textY, textSize.width, textSize.height),
      format: format,
    );
  }

  Future<void> _addText2(PdfDocument document, PdfPage page) async {
    final double pageWidth = page.getClientSize().width;
    final double pageHeight = page.getClientSize().height;

    final String textContent =
        "Zelimo vam uspješno daljnje napredovanje u vašem fitnes putovanju!";
    final PdfFont font = PdfStandardFont(PdfFontFamily.timesRoman, 20);

    final PdfStringFormat format = PdfStringFormat(
      alignment: PdfTextAlignment.center,
    );
    final Size textSize = font.measureString(textContent, format: format);

    final double textX = (pageWidth - textSize.width) / 2;
    final double textY = 1500;

    page.graphics.drawString(
      textContent,
      font,
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      bounds: Rect.fromLTWH(textX, textY, textSize.width, textSize.height),
      format: format,
    );
  }

  Future<void> _addText3(PdfDocument document, PdfPage page) async {
    final double pageWidth = page.getClientSize().width;
    final double pageHeight = page.getClientSize().height;

    final String textContent =
        "Cestitamo, postigli ste rezultate u vasem fitness putovanju. Rezultati vaseg napretka su sljedeci:";
    final PdfFont font =
        PdfStandardFont(PdfFontFamily.timesRoman, 25, style: PdfFontStyle.bold);

    final PdfStringFormat format = PdfStringFormat(
      alignment: PdfTextAlignment.center,
    );
    final Size textSize = font.measureString(textContent, format: format);

    final double textX = (pageWidth - textSize.width) / 2;
    final double textY = 400;

    page.graphics.drawString(
      textContent,
      font,
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      bounds: Rect.fromLTWH(textX, textY, textSize.width, textSize.height),
      format: format,
    );
  }

  Future<void> _renderPdf() async {
    final PdfDocument document = PdfDocument();

    final PdfBitmap bitmap = PdfBitmap(await _readImageData());

    document.pageSettings.margins.all = 0;
    document.pageSettings.size =
        Size(bitmap.width.toDouble(), bitmap.height.toDouble());

    final PdfPage page = document.pages.add();
    double containerWidth = 0.2;
    double containerHeight = 0.2;

    await _addLogoAndProgressTable(
        document, page, containerWidth, containerHeight);
    await _addText3(document, page);

    await _addDataTable(
        document, page, widget.invoice.datumiMjerenja!, widget.invoice.tezine!);
    await _addText(document, page);
    await _addText2(document, page);

    final Size pageSize = page.getClientSize();

    page.graphics.drawImage(
        bitmap, Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      duration: Duration(milliseconds: 200),
      content: Text('Spark Chart has been exported as PDF document.'),
    ));

    final List<int> bytes = document.saveSync();
    document.dispose();

    Directory directory = (await getApplicationDocumentsDirectory());

    String path = directory.path;

    File file = File('$path/output.pdf');

    await file.writeAsBytes(bytes, flush: true);

    OpenFile.open('$path/output.pdf');
  }

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
  final double width;
  final double height;

  const SparkLineChart({
    Key? key,
    required this.invoice,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _SparkLineChartState createState() => _SparkLineChartState();
}

class _SparkLineChartState extends State<SparkLineChart> {
  @override
  Widget build(BuildContext context) {
    List<DateTime> datumiMjerenja = widget.invoice.datumiMjerenja!;
    List<double> tezine = widget.invoice.tezine!;

    return RepaintBoundary(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            color: Colors.white,
            height: widget.height,
            width: widget.width,
            child: SfSparkLineChart.custom(
              xValueMapper: (int index) => datumiMjerenja[index],
              yValueMapper: (int index) => tezine[index],
              dataCount: datumiMjerenja.length,
              labelDisplayMode: SparkChartLabelDisplayMode.all,
            ),
          ),
        ),
      ),
    );
  }

  Future<dart_ui.Image> convertToImage({double pixelRatio = 1.0}) async {
    final RenderRepaintBoundary boundary =
        context.findRenderObject() as RenderRepaintBoundary;

    final dart_ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);

    return image;
  }
}
