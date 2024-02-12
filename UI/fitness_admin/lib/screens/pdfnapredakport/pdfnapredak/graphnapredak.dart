// import 'dart:typed_data';

// import 'package:fitness_admin/models/napredakreport.dart';

// import 'package:flutter/material.dart' as ma;

// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';

// import 'package:flutter/services.dart' show rootBundle;

// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

// import 'dart:async';

// import 'dart:ui' as dart_ui;


// final ma.GlobalKey<_SparkBarChartState> chartKey = ma.GlobalKey();




// class SparkBarChart extends ma.StatefulWidget {
//   const SparkBarChart({ma.Key? key}) : super(key: key);

//   @override
//   _SparkBarChartState createState() => _SparkBarChartState();
// }

// class _SparkBarChartState extends ma.State<SparkBarChart> {
//   @override
//   ma.Widget build(ma.BuildContext context) {
//     return ma.RepaintBoundary(
//       child: SfSparkBarChart(
//         axisLineWidth: 0,
//         data: const <double>[
//           5,
//           6,
//           5,
//           7,
//           4,
//           3,
//           9,
//           5,
//           6,
//         ],
//         highPointColor: ma.Colors.red,
//         lowPointColor: ma.Colors.red,
//         firstPointColor: ma.Colors.orange,
//         lastPointColor: ma.Colors.orange,
//       ),
//     );
//   }
// }



import 'package:fitness_admin/models/napredakreport.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show Uint8List, rootBundle;

Future<Uint8List> makePdf(NapredakReport report) async {
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
                    PaddedText('Korisnicko ime'),
                    PaddedText(
                      "${report.tezine}",
                    )
                  ],
                ),
                  TableRow(
                   children: [
                    PaddedText('Lozinka'),
                    PaddedText(
                      "${report.datumiMjerenja}",
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