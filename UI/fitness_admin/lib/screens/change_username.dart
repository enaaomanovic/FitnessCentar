import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:fitness_admin/screens/homepage.dart';
import 'package:fitness_admin/utils/util.dart';

import 'package:file_picker/file_picker.dart';
import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/models/trener.dart';
import 'package:fitness_admin/providers/trainer_provider.dart';
import 'package:fitness_admin/providers/user_provider.dart';
import 'package:fitness_admin/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class ChangeUsernameScreen extends StatefulWidget {
  final int userId;

  const ChangeUsernameScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ChangeUsernameScreenState createState() => _ChangeUsernameScreenState();
}

class _ChangeUsernameScreenState extends State<ChangeUsernameScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late UserProvider _userProvider;

  TextEditingController _newUsernameController = TextEditingController();
  TextEditingController _currentUsernameController = TextEditingController();

 Future<Korisnici?> getUserFromUserId(int userId) async {
    final user = await _userProvider.getById(userId);
    return user;
  }

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      child: Center(
        child: SingleChildScrollView(
          child: _buildBody(),
        ),
      ),
      title: "Edit Credentials",
    );
  }

Widget _buildBody() {
  return Container(
    width: MediaQuery.of(context).size.width * 0.6,
    child: FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column( // Wrap with a Column
        children: [
          // Heading Text
          Text(
            'Uredi Korisničko ime',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
           SizedBox(height: 50,),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: Colors.purple, width: 3.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trenutno Korisničko ime',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  FormBuilderTextField(
                    name: 'currentPassword',
                    controller: _currentUsernameController,
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Novo Korisničko ime',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  FormBuilderTextField(
                    name: 'newUsername',
                    controller: _newUsernameController,
                    validator: (value) {
                      if (_formKey.currentState?.fields['newUsername']?.isDirty ==
                          true) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required!';
                        } else if (value[0] != value[0].toUpperCase()) {
                          return 'Username must start with a capital letter.';
                        }
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _updateUserData,
                      child: Text('Sacuvaj'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


void _updateUserData() async {
  _formKey.currentState?.save();
  Korisnici? korisnik = await getUserFromUserId(widget.userId);

  try {
    final currentFormState = _formKey.currentState;

    if (!_areAllFieldsFilled(currentFormState)) {
      _showAlertDialog("Please enter both current and new usernames!");
      return;
    }

    if (currentFormState != null) {
      if (!currentFormState.validate()) {
        _showAlertDialog("Please enter both current and new usernames!");
        return;
      }
    }

    if (korisnik?.korisnickoIme != _currentUsernameController.text) {
      _showAlertDialog("Current Username is not valid for the logged-in user!");
      return; // Stop further execution if the current username is not valid
    }

    // Call the method to change the password
    await _userProvider.changeUsername(
      widget.userId,
      _newUsernameController.text,
      _currentUsernameController.text,
    );

    Authorization.username = _newUsernameController.text;

    try {
      var data = await _userProvider.get(filter: {
        'IsTrener': "true",
      });

      var userId = widget.userId;

      Provider.of<UserProvider>(context, listen: false)
          .setCurrentUserId(widget.userId);

      if (userId != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomeAuthenticated(
              userId: userId,
              userProvider: _userProvider,
            ),
          ),
        );
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
            )
          ],
        ),
      );
    }
  } catch (error) {
    print('Error updating credentials: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'An error occurred while updating credentials. Check the console for more information.',
        ),
      ),
    );
  }
}

bool _areAllFieldsFilled(FormBuilderState? formState) {
  if (formState == null) return false;

  final currentUsername = _currentUsernameController.text;
  final newUsername = _newUsernameController.text;

  return currentUsername.isNotEmpty && newUsername.isNotEmpty;
}

void _showAlertDialog(String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text("Error"),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("OK"),
        )
      ],
    ),
  );
}


}




