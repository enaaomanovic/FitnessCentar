
import 'package:fitness_admin/models/novosti.dart';
import 'package:fitness_admin/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:provider/provider.dart';
import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/providers/user_provider.dart';
import 'package:fitness_admin/widgets/master_screens.dart';

class AddNews extends StatefulWidget {
  const AddNews({Key? key}) : super(key: key);

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _naslovController = TextEditingController();
  final TextEditingController _tekstController = TextEditingController();
  final TextEditingController _datumObjaveController = TextEditingController();
  final TextEditingController _autorIdController = TextEditingController();



  late NewsProvider _newsProvider;
  
  @override
  void initState() {
    super.initState();
    _newsProvider = context.read<NewsProvider>();
  }


  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      title_widget: Text("Dodaj novost"),
      child: Container(
        child: Column(children: [_addForm(), _buildSubmitButton()]),
      ),
    );
  }

Widget _addForm() {
  return Container(
    child: Center(
       child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SizedBox(
          width: 700,
          height: 550,
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Dodavanje novosti", // Dodajte naslov
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                buildInputField(
                  "Naslov",
                  "Unesite naslov",
                  _naslovController,
                ),
                SizedBox(height: 20.0),
                buildLargeTextInput(
                  "Sadržaj",
                  "Unesite tekst novosti",
                  _tekstController,
                ),
              ],
            ),
          ),
        ),
      ),
       ),
    ),
  );
}

Widget buildLargeTextInput(String label, String hint, TextEditingController controller) {
  return TextField(
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(),
    ),
    controller: controller,
    maxLines: 10, // Postavite broj redova na željeni broj
  );
}


Widget buildInputField(String label, String hint, TextEditingController controller) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
     
     
      border: OutlineInputBorder(),
    ),
    controller: controller,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return hint;
      }
      return null;
    },
  );
}



Widget _buildSubmitButton() {
  return Container(
   
    height: 78, // Povećajte visinu containera
    child: Center(
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            // Forma je uspešno validirana
            final formData = {
              'naslov': _naslovController.text,
              'tekst': _tekstController.text,
              'autorId': "1",
              'datumObjave':DateTime.now(),
              
            };

            // Ovde biste mogli slati podatke na server ili ih obraditi kako vam odgovara

            // Primer: Snimanje korisnika na server
            try {
              await _newsProvider.insert(formData);
              // Korisnik je uspešno dodat
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Novost je uspješno dodana!')),
              );
            } catch (e) {
              // Greška pri dodavanju korisnika
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Greška prilikom dodavanja novosti: ')),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.purple,
          padding: EdgeInsets.all(20), // Povećajte veličinu gumba
        ),
        child: Text("Dodaj Novost"),
      ),
    ),
  );
}





} 



