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
                              width:
                                  500, // Prilagodite širinu grafikona prema potrebi
                              height:
                                  100, // Prilagodite visinu grafikona prema potrebi
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

  Future<void> _addLogoAndProgressTable(PdfDocument document, PdfPage page,
      double containerWidth, double containerHeight) async {
    final double pageWidth = page.getClientSize().width;
    final double pageHeight = page.getClientSize().height;

    // Prilagodite položaj loga
    final double logoX = (pageWidth - 700) / 2;
    final double logoY = 150; // Prilagodite po potrebi

    // Prilagodite položaj teksta "Fitness Centar"
    final String fitnessCenterText = 'Fitness Centar';
    final PdfTextElement textElement = PdfTextElement(
      text: fitnessCenterText,
      font: PdfStandardFont(PdfFontFamily.timesRoman, 45,
          style: PdfFontStyle.bold),
    );
    final PdfLayoutResult? textLayoutResult = textElement.draw(
      page: page,
      bounds: Rect.fromLTWH(
        logoX + 250, // X koordinata (centrirano na širini stranice)
        logoY + 80, // Podešavanje visine teksta (ispod loga)
        300, // Širina teksta
        100, // Visina teksta
      ),
      format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate),
    );

    // Prilagodite položaj tabele
    final double tableX = 50;
    final double tableY = logoY + 150 + 20; // Postavite tablicu ispod loga

    // Prilagodite visinu potrebnu za prikazivanje loga, teksta, tabele i grafikona
    final double requiredHeight = tableY +
        containerHeight +
        20 +
        16; // Visina tablice + visina grafikona + margine

    // Provjerite je li stranica dovoljno visoka za prikaz svih elemenata
    if (requiredHeight > pageHeight) {
      // Ako nije dovoljno visoka, povećajte visinu stranice
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

    // Dobijanje referene na sliku iz AssetImage
    ByteData data = await rootBundle.load('assets/images/FitnessLogo.jpg');
    Uint8List uint8list = data.buffer.asUint8List();
    PdfBitmap pdfImage = PdfBitmap(uint8list);

    // Crtanje slike loga na PDF stranici
    page.graphics.drawImage(pdfImage, Rect.fromLTWH(logoX, logoY, 220, 220));

    // Prilagodite ovaj dio kako biste kreirali sadržaj tabele
    final PdfGrid grid = PdfGrid();
    // Populate grid with data from your DataTable
    // Prilagodite dimenzije i položaj tabele na stranici
    PdfLayoutResult? result = grid.draw(
      page: page,
      bounds: Rect.fromLTWH(
          tableX, tableY, pageWidth - 2 * tableX, pageHeight - tableY),
    );

    // Dodajte spark chart na istu stranicu
    final PdfBitmap bitmap = PdfBitmap(await _readImageData());
    final double chartX = 50; // Prilagodite po potrebi
    final double chartY = result!.bounds.bottom + 20; // Prilagodite po potrebi
    page.graphics.drawImage(
      bitmap,
      Rect.fromLTWH(chartX, chartY, containerWidth, containerHeight),
    );
  }

  Future<void> _addDataTable(PdfDocument document, PdfPage page,
      List<DateTime> datumiMjerenja, List<double> tezine) async {
    // Defining page dimensions
    final double pageWidth = page.getClientSize().width;
    final double pageHeight = page.getClientSize().height;

    // Defining table dimensions and position
    final double tableX = 300;
    final double tableY = 550; // You can adjust the table height as needed

    // Creating DataTable
    final PdfGrid dataTable = PdfGrid();

    // Adding columns to the table
    dataTable.columns.add(count: 2);
    dataTable.headers.add(1);
    dataTable.headers[0].cells[0].value = 'Datumi';
    dataTable.headers[0].cells[1].value = 'Tezine';

    // Setting font size and aligning text to center for table headers
    final PdfStandardFont headerFont = PdfStandardFont(
        PdfFontFamily.helvetica, 25,
        style: PdfFontStyle.bold); // Change the font size here
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
    // Define the border style for the header
    final PdfBorders headerBorderStyle = PdfBorders(
      left: PdfPens.transparent,
      top: PdfPens.transparent,
      right: PdfPens.transparent,
      bottom: PdfPens.white, // Set bottom border to white color
    );
    // Apply border style to header cells
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

    // Populating table rows with data
    for (int i = 0; i < datumiMjerenja.length; i++) {
      final DateTime datum = datumiMjerenja[i];
      final double tezina = tezine[i];

      // Adding a row to the table
      dataTable.rows.add();
      // Setting cell values
      dataTable.rows[i].cells[0].value = DateFormat('dd-MM-yyyy').format(datum);
      dataTable.rows[i].cells[1].value = '$tezina kg';

      // Setting font size and aligning text to center for table cells
      final PdfStandardFont cellFont = PdfStandardFont(
          PdfFontFamily.helvetica, 25); // Change the font size here
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

    // Adjusting table dimensions on the page
    PdfLayoutResult? result = dataTable.draw(
      page: page,
      bounds: Rect.fromLTWH(
          tableX, tableY, pageWidth - 1 * tableX, pageHeight - tableY),
    );

    // Checking if a new page is needed due to the table overflowing to the next page
    if (result!.bounds.bottom > pageHeight) {
      final PdfPage newPage = document.pages.add();
      await _addDataTable(document, newPage, datumiMjerenja, tezine);
    }
  }

  Future<void> _addText(PdfDocument document, PdfPage page) async {
    final double pageWidth = page.getClientSize().width;
    final double pageHeight = page.getClientSize().height;

    // Postavljamo položaj i stil teksta
    final String textContent = "Graficki prikaz rezultata";
    final PdfFont font =
        PdfStandardFont(PdfFontFamily.timesRoman, 25, style: PdfFontStyle.bold);

    // Izračunavamo dimenzije teksta
    final PdfStringFormat format = PdfStringFormat(
      alignment: PdfTextAlignment.center,
    );
    final Size textSize = font.measureString(textContent, format: format);

    // Izračunavamo položaj teksta da bude centriran
    final double textX = (pageWidth - textSize.width) / 2;
    final double textY = 800;

    // Crtamo tekst na stranici
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

    // Postavljamo položaj i stil teksta
    final String textContent =
        "Zelimo vam uspješno daljnje napredovanje u vašem fitnes putovanju!";
    final PdfFont font = PdfStandardFont(PdfFontFamily.timesRoman, 20);

    // Izračunavamo dimenzije teksta
    final PdfStringFormat format = PdfStringFormat(
      alignment: PdfTextAlignment.center,
    );
    final Size textSize = font.measureString(textContent, format: format);

    // Izračunavamo položaj teksta da bude centriran
    final double textX = (pageWidth - textSize.width) / 2;
    final double textY = 1500;

    // Crtamo tekst na stranici
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

    // Postavljamo položaj i stil teksta
    final String textContent =
        "Cestitamo, postigli ste rezultate u vasem fitness putovanju. Rezultati vaseg napretka su sljedeci:";
    final PdfFont font =
        PdfStandardFont(PdfFontFamily.timesRoman, 25, style: PdfFontStyle.bold);

    // Izračunavamo dimenzije teksta
    final PdfStringFormat format = PdfStringFormat(
      alignment: PdfTextAlignment.center,
    );
    final Size textSize = font.measureString(textContent, format: format);

    // Izračunavamo položaj teksta da bude centriran
    final double textX = (pageWidth - textSize.width) / 2;
    final double textY = 400;

    // Crtamo tekst na stranici
    page.graphics.drawString(
      textContent,
      font,
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      bounds: Rect.fromLTWH(textX, textY, textSize.width, textSize.height),
      format: format,
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
    double containerWidth = 0.2;
    double containerHeight = 0.2;

    await _addLogoAndProgressTable(
        document, page, containerWidth, containerHeight);
    await _addText3(document, page);

    await _addDataTable(
        document, page, widget.invoice.datumiMjerenja!, widget.invoice.tezine!);
    await _addText(document, page);
    await _addText2(document, page);

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
