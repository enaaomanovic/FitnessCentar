import 'dart:convert';
import 'dart:io';

import 'package:fitness_mobile/providers/user_provider.dart';
import 'package:fitness_mobile/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditCredentials extends StatefulWidget {
  const EditCredentials({Key? key}) : super(key: key);

  @override
  _EditCredentialsState createState() => _EditCredentialsState();
}

class _EditCredentialsState extends State<EditCredentials> {
  final _formKey = GlobalKey<FormBuilderState>();

  late UserProvider _userProvider;

  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _newUsernameController = TextEditingController();

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
      width: MediaQuery.of(context).size.width * 0.85,
      child: FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Card(
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
                  'New Password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FormBuilderTextField(
                  obscureText: true,
                  name: 'newPassword',
                  controller: _newPasswordController,
                //  validator: FormBuilderValidators.required(context),
                ),
                SizedBox(height: 10),
                Text(
                  'New Username',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FormBuilderTextField(
                  name: 'newUsername',
                  controller: _newUsernameController,
              //    validator: FormBuilderValidators.required(context),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _updateUserData,
                    child: Text('Sacuvaj promjene'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateUserData() async {
    _formKey.currentState?.save();

    try {
      if (_formKey.currentState!.validate()) {
        // Add logic for updating password
        if (_newPasswordController.text.isNotEmpty) {
          // await _userProvider.updatePassword(
          //     widget.userId, _newPasswordController.text);
        }

        // Add logic for updating username
        if (_newUsernameController.text.isNotEmpty) {
          // await _userProvider.updateUsername(
          //     widget.userId, _newUsernameController.text);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Credentials updated successfully!'),
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (error) {
      print('Error updating credentials: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'An error occurred while updating credentials. Check the console for more information.'),
        ),
      );
    }
  }
}
