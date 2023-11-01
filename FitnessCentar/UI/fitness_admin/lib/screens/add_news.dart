
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
       child: Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
         
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Centriranje sadržaja
              children: [
                Padding(
                  padding: const EdgeInsets.all( 10.0),
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
          ),
        ),
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
                height: 550,
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
                child: Text("Sačuvaj", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
