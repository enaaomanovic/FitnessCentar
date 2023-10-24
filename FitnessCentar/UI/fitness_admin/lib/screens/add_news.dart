// import 'package:collection/collection.dart';
// import 'package:fitness_admin/models/novosti.dart';
// import 'package:fitness_admin/providers/news_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:intl/date_time_patterns.dart';
// import 'package:provider/provider.dart';
// import 'package:fitness_admin/models/korisnici.dart';
// import 'package:fitness_admin/providers/user_provider.dart';
// import 'package:fitness_admin/widgets/master_screens.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';

// class AddNews extends StatefulWidget {
   
   
//   const AddNews({Key? key, this.novosti}) : super(key: key);

//   final Novosti? novosti;


//   @override
//   State<AddNews> createState() => _AddNewsState();
// }

// class _AddNewsState extends State<AddNews> {

//   final _formKey = GlobalKey<FormBuilderState>();

//   bool isLoading = true;
 
//   Novosti? novosti;

//   late NewsProvider _newsProvider;




//   @override
//   void initState() {
//     super.initState();
//     _newsProvider = context.read<NewsProvider>();
    
 
//     initForm();
//   }

//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//   }

//   Future initForm() async {
//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//      final userProvider = context.read<UserProvider>();
//     int? userId = userProvider.currentUserId;
//     return MasterScreanWidget(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 10.0),
//             child: Text(
//               "Dodaj novost", // Dodajte naslov
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           isLoading ? Container() : _addForm(userId),
//           _submitbtn(userId),
//         ],
//       ),
//       title: "Dodaj novost",
//     );
//   }

//   Widget _addForm(int? userId) {
//     return FormBuilder(
//       key: _formKey,
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Card(
//               elevation: 6,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               child: SizedBox(
//                 height: 500,
//                 width: 600,
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       SizedBox(height: 30),
//                       FormBuilderTextField(
//                         decoration: InputDecoration(
//                             labelText: "Naslov *",
//                             border: OutlineInputBorder()),
//                         validator: (value) {
//                           if (_formKey
//                                   .currentState?.fields['naslov']?.isDirty ==
//                               true) {
//                             if (value == null || value.isEmpty) {
//                               return 'Ovo polje je obavezno!';
//                             } else if (value[0] != value[0].toUpperCase()) {
//                               return 'Naslov mora početi velikim slovom.';
//                             }
//                           }
//                           return null;
//                         },
//                         name: "naslov",
//                       ),
//                       SizedBox(height: 50),
//                       FormBuilderTextField(
//                         decoration: InputDecoration(
//                             labelText: "Sadržaj *",
//                             border: OutlineInputBorder()),
//                         validator: (value) {
//                           if (_formKey.currentState?.fields['tekst']?.isDirty ==
//                               true) {
//                             if (value == null || value.isEmpty) {
//                               return 'Ovo polje je obavezno!';
//                             } else if (value[0] != value[0].toUpperCase()) {
//                               return 'Sadržaj mora početi velikim slovom.';
//                             }
//                           }
//                           return null;
//                         },
//                         maxLines: 10,
//                         name: "tekst",
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _submitbtn(int? userId) {
//     return Center(
//       child: Column(
//         children: [
//           Align(
//             alignment: Alignment.center,
//             child: SizedBox(
//                 width: 250,
//                 // Povećajte širinu dugmeta po potrebi
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     final currentFormState = _formKey.currentState;

//                     if (currentFormState != null &&
//                         currentFormState.saveAndValidate()) {
//                       // Svi podaci su ispravno uneseni, možete dodati ili ažurirati korisnika
//                       var request =
//                           Map<String, dynamic>.from(currentFormState.value);

//                       try {
                        
//                         request['autorId'] = userId;

//                         if (widget.novosti == null) {
//                           await _newsProvider.insert(request);

//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) => AlertDialog(
//                               title: Text("Novost uspješno dodana"),
//                               content: Text("Novost je uspješno dodana."),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                     //   // Resetirajte formu tek nakon što korisnik zatvori dijalog

//                                     _formKey.currentState?.reset();
//                                   },
//                                   child: Text("OK"),
//                                 ),
//                               ],
//                             ),
//                           );
//                         } else {
//                           await _newsProvider.update(
//                               widget.novosti!.id!, request);
//                         }
//                       } on Exception catch (e) {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) => AlertDialog(
//                             title: Text("Error"),
//                             content: Text(e.toString()),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 child: Text("OK"),
//                               ),
//                             ],
//                           ),
//                         );
//                       }
//                     }
//                   },
//                   child: Text("Sačuvaj"),
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.all(15),
//                   ),
//                 )),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:fitness_admin/models/novosti.dart';
import 'package:fitness_admin/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:fitness_admin/providers/user_provider.dart';
import 'package:fitness_admin/widgets/master_screens.dart';

class AddNews extends StatefulWidget {
  final Novosti? novosti;

  const AddNews({Key? key, this.novosti}) : super(key: key);

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  final _formKey = GlobalKey<FormBuilderState>();
  late NewsProvider _newsProvider;
  int? userId; 

 


  @override
void initState() {
  super.initState();
  _newsProvider = context.read<NewsProvider>();
  
  final userProvider = context.read<UserProvider>();

  userId = userProvider.currentUserId;


 
}

  @override
  Widget build(BuildContext context) {

    return MasterScreanWidget(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "Dodaj novost",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _addForm(userId),
          _submitButton(userId),
        ],
      ),
      title: "Dodaj novost",
    );
  }

  Widget _addForm(int? userId) {
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: SizedBox(
                height: 500,
                width: 600,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 30),
                      FormBuilderTextField(
                        decoration: InputDecoration(
                          labelText: "Naslov *",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (_formKey.currentState?.fields['naslov']?.isDirty ==
                              true) {
                            if (value == null || value.isEmpty) {
                              return 'Ovo polje je obavezno!';
                            } else if (value[0] != value[0].toUpperCase()) {
                              return 'Naslov mora početi velikim slovom.';
                            }
                          }
                          return null;
                        },
                        name: "naslov",
                      ),
                      SizedBox(height: 50),
                      FormBuilderTextField(
                        decoration: InputDecoration(
                          labelText: "Sadržaj *",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (_formKey.currentState?.fields['tekst']?.isDirty ==
                              true) {
                            if (value == null || value.isEmpty) {
                              return 'Ovo polje je obavezno!';
                            } else if (value[0] != value[0].toUpperCase()) {
                              return 'Sadržaj mora početi velikim slovom.';
                            }
                          }
                          return null;
                        },
                        maxLines: 10,
                        name: "tekst",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _submitButton(int? userId) {
    return Center(
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () async {
                  final currentFormState = _formKey.currentState;

                  if (currentFormState != null &&
                      currentFormState.saveAndValidate()) {
                    var request = Map<String, dynamic>.from(currentFormState.value);
               
                    request['autorId'] = userId; 

                    try {
                      if (widget.novosti == null) {
                        await _newsProvider.insert(request);

                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text("Novost uspješno dodana"),
                            content: Text("Novost je uspješno dodana."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _formKey.currentState?.reset();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          ),
                        );
                      } else {
                        await _newsProvider.update(widget.novosti!.id!, request);
                      }
                    } on Exception catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
                child: Text("Sačuvaj"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
