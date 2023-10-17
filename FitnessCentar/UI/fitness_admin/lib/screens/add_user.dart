
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:provider/provider.dart';
import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/providers/user_provider.dart';
import 'package:fitness_admin/widgets/master_screens.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormState>();
  late UserProvider _userProvider;
  List<String> spolovi = ['Muški', 'Ženski'];

  final TextEditingController _imeController = TextEditingController();
  final TextEditingController _prezimeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _polController = TextEditingController();
  final TextEditingController _korisnickoImeController = TextEditingController();
  final TextEditingController _lozinkaController = TextEditingController();
  final TextEditingController _brojTelefonaController = TextEditingController();
  final TextEditingController _datumRodjenjaController = TextEditingController();
  final TextEditingController _potvrdiLozinkuController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
  }

  @override
  void dispose() {
    _imeController.dispose();
    _prezimeController.dispose();
    _emailController.dispose();
    _polController.dispose();
    _korisnickoImeController.dispose();
    _lozinkaController.dispose();
    _brojTelefonaController.dispose();
    _datumRodjenjaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      title_widget: Text("Dodaj korisnika"),
      child: Container(
        child: Column(children: [_addForm(), _buildSubmitButton()]),
      ),
    );
  }


Widget _addForm() {
  return Container(
    child: Center(
      
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
          child: SizedBox(
            width: 800,
            height: 650,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                  "Dodavanje novog korisnika", // Dodajte naslov
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
               buildInputField(
                  "Ime",
                  "Unesite ime",
                  Icons.person, // Dodajte ikonu za ime
                  _imeController,
                ),
               
                 SizedBox(height: 5.0),
           buildInputField(
                  "Prezime",
                  "Unesite prezime",
                  Icons.person, // Dodajte ikonu za ime
                  _prezimeController,
                ),
            SizedBox(height: 5.0),
         buildInputField(
                  "Email",
                  "Unesite E-mail",
                    Icons.mail, // Dodajte ikonu za ime
                    _emailController,
                  ),
                  SizedBox(height: 5.0),
                  FormBuilderDropdown(
                    name: 'pol',
                    decoration: InputDecoration(
                      labelText: 'Pol',
                      border: OutlineInputBorder(),
                     
                    ),
                    initialValue: 'Muški',
                    items: spolovi.map((spol) {
                      return DropdownMenuItem(
                        value: spol,
                        child: Text(spol),
                      );
                    }).toList(),
),
          SizedBox(height: 5.0),
         buildInputField(
                  "Korisničko ime",
                  "Unesite korisničko ime",
                  Icons.person, // Dodajte ikonu za ime
                  _korisnickoImeController,
                ),
          SizedBox(height: 5.0),
          TextFormField(
            decoration: InputDecoration(labelText: "Lozinka",border: OutlineInputBorder()),
            controller: _lozinkaController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Unesite lozinku';
              }
              // Opciono, možete dodati proveru za minimalnu dužinu lozinke.
              return null;
            },
              
            obscureText: true,
          ),
          SizedBox(height: 5.0),
          TextFormField(
            decoration: InputDecoration(labelText: "Potvrdite lozinku",border: OutlineInputBorder()),
            controller: _potvrdiLozinkuController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Potvrdite lozinku';
              }
              if (value != _lozinkaController.text) {
                return 'Lozinke se ne podudaraju';
              }
              return null;
            },
            obscureText: true,
          ),
          SizedBox(height: 5.0),
          buildInputField(
                  "Telefon",
                  "Unesite telefon",
                  Icons.phone, // Dodajte ikonu za ime
                  _brojTelefonaController,
                ),
          SizedBox(height: 5.0),
           FormBuilderDateTimePicker(
           keyboardType: TextInputType.datetime,
            name: 'datumRodjenja',
            inputType: InputType.date,
        
            decoration: InputDecoration(labelText: 'Datum rođenja',border: OutlineInputBorder(),prefixIcon: Icon(Icons.date_range)),
            initialDate: DateTime.now(),
           controller: _datumRodjenjaController,
          ),
              ],
            ),
          ),
        ),
        
      ),
    ),
    
  );
}




Widget buildInputField(String label, String hint, IconData icon, TextEditingController controller) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
     
      prefixIcon: Icon(icon), 
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
              'ime': _imeController.text,
              'prezime': _prezimeController.text,
              'email': _emailController.text,
              'pol': _polController.text,
              'korisnicko_ime': _korisnickoImeController.text,
              'lozinka': _lozinkaController.text,
              'broj_telefona': _brojTelefonaController.text,
              'datum_rodjenja': _datumRodjenjaController.text,
            };

            // Ovde biste mogli slati podatke na server ili ih obraditi kako vam odgovara

            // Primer: Snimanje korisnika na server
            try {
              await _userProvider.insert(formData);
              // Korisnik je uspešno dodat
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Korisnik je uspešno dodat.')),
              );
            } catch (e) {
              // Greška pri dodavanju korisnika
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Greška prilikom dodavanja korisnika: $e')),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.purple,
          padding: EdgeInsets.all(20), // Povećajte veličinu gumba
        ),
        child: Text("Dodaj korisnika"),
      ),
    ),
  );
}

} 



