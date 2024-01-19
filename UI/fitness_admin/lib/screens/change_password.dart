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

import 'package:http/http.dart' as http;


import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  final int userId;

  const ChangePasswordScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late UserProvider _userProvider;

  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _currentPasswordController = TextEditingController();

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
          child: Column(
            children: [
              Text(
                'Uredi Lozinku',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(
                height: 50,
              ),
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
                  'Trenutna Lozinka',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FormBuilderTextField(
                  obscureText: true,
                  name: 'currentPassword',
                  controller: _currentPasswordController,
                
                ),
                Text(
                  'Nova Lozinka',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FormBuilderTextField(
                  obscureText: true,
                  name: 'newPassword',
                  controller: _newPasswordController,
                  validator: (value) {
                          if (_formKey
                                  .currentState?.fields['newPassword']?.isDirty ==
                              true) {
                            if (value == null || value.isEmpty) {
                              return 'Ovo polje je obavezno!';
                            } else if (value.length < 8 ||
                                !value.contains(RegExp(r'[A-Z]')) ||
                                !value.contains(RegExp(r'[a-z]')) ||
                                !value.contains(RegExp(r'[0-9]'))) {
                              return '8 karaktera,uključujući najmanje jedno veliko slovo (A-Z), jedno malo slovo (a-z) i jednu cifru (0-9)';
                            }
                          }
                          return null;
                        },
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _updatePassword,
                    child: Text('Sacuvaj'),
                  ),
                ),
              ],
            ),
          ),
        ),
        ],)
        
      ),
    );
  }


void _updatePassword() async {
  _formKey.currentState?.save();
  Korisnici? korisnik = await getUserFromUserId(widget.userId);

  try {
    if (_formKey.currentState!.validate()) {
      String newPassword = _newPasswordController.text;
      String currentPassword = _currentPasswordController.text;

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

      // Call the method to change the password
      try {
        await _userProvider.changePassword(
          widget.userId, newPassword, currentPassword,
        );

        Authorization.password = newPassword;

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
      } on FormatException catch (_) {
        
        _showAlertDialog("Invalid password.");
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

  final currentPassword = _currentPasswordController.text;
  final newPassword = _newPasswordController.text;

  return currentPassword.isNotEmpty && newPassword.isNotEmpty;
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

