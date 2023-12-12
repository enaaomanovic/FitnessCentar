
// import 'package:fitness_admin/models/report.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:pdf/widgets.dart' as Pdf;

// final report = [
//   KorisniciReport(
//       ime: "Ema",
//       prezime: "Omanovic",
//       korisnickoIme: "Ena",
//       email: "ena.omanovic@edu.fit.ba",
//       telefon: "06182782",
//       datumRegistracije: 2020 - 23 - 12,
//       datumRodjenja: 2000 - 01 - 01,
//       pol: 'Ženski',
//       tezina: 23,
//       visina: 170,
//       slika: "",
//       lozinka: "test"),
// ];

// class DetailPage extends StatelessWidget {
//   final KorisniciReport report;
//   const DetailPage({
//     Key? key,
//     required this.report,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
          
//           // rootBundle.
//         },
//         child: Icon(Icons.picture_as_pdf),
//       ),
//       appBar: AppBar(
//         title: Text(report.ime),
//       ),
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Card(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       'Customer',
//                       style: Theme.of(context).textTheme.headline5,
//                     ),
//                   ),
//                   Expanded(
//                     child: Text(
//                       report.prezime,
//                       style: Theme.of(context).textTheme.headline4,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Card(
//               child: Column(
//                 children: [
//                   Text(
//                     'Invoice Items',
//                     style: Theme.of(context).textTheme.headline6,
//                   ),
                 
//                   DefaultTextStyle.merge(
//                     style: Theme.of(context).textTheme.headline4,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
                      
                       
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// Future<Uint8List> makePdf (KorisniciReport report) async {
//   final pdf = Pdf.Document();
//   pdf.addPage(
//     Pdf.Page(
//     build: (context) {
//    return Pdf.Column(
//         children: [
// Pdf.Text("Please forward the below slip to your accounts payable department."),
// // Create a divider that is 1 unit high and make the appearance of
// // the line dashed
// Pdf.Divider(
//   height: 1,
//   borderStyle: Pdf.BorderStyle.dashed,
// ),
// // Space out the invoice appropriately
// Pdf.Container(height: 50),
// // Create another table with the payment details
// Pdf.Table(
//   border: Pdf.TableBorder.all(color: PdfColors.black),
//   children: [
//     Pdf.TableRow(
//       children: [
//         Pdf.PaddedText('Account Number'),
//         Pdf.PaddedText(
//           '1234 1234',
//         )
//       ],
//     ),
//     Pdf.TableRow(
//       children: [
//         PaddedText(
//           'Account Name',
//         ),
//         PaddedText(
//           'ADAM FAMILY TRUST',
//         )
//       ],
//     ),
//     Pdf.TableRow(
//       children: [
//         PaddedText(
//           'Total Amount to be Paid',
//         ),
//         PaddedText('\$${(invoice.totalCost() * 1.1).toStringAsFixed(2)}')
//       ],
//     )
//   ],
// ),
// // Add a final instruction about how checks should be created
// // Center align and italicize this text to draw the reader's attention
// // to it.
// Pdf.Padding(
//   padding: Pdf.EdgeInsets.all(30),
//   child: Pdf.Text(
//     'Please ensure all checks are payable to the ADAM FAMILY TRUST.',
//     style: Theme.of(context).header3.copyWith(
//           fontStyle: FontStyle.italic,
//         ),
//     textAlign: Pdf.TextAlign.center,
//   ),
// )



//         ]
//    );
//    },
//     )
//   );
// }

// }

