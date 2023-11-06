import 'package:collection/collection.dart';
import 'package:fitness_mobile/providers/user_provider.dart';
import 'package:fitness_mobile/screens/home_authenticated.dart';
import 'package:fitness_mobile/utils/utils.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key});

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late UserProvider _userProvider;

@override
Widget build(BuildContext context) {
  _userProvider = context.read<UserProvider>();
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.purple,
      ),
      title: Text(
        "LogIn",
        style: TextStyle(
          color: Colors.purple,
          fontSize: 18, 
        ),
      ),
    ),
    body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/images/PozdainaD.jpg",
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Container(
          color: Color.fromRGBO(0, 0, 0, 0.6),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0), 
                  child: Column(
                    children: [
                      ClipOval(
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            "assets/images/FitnessLogo.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20), 
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Username",
                          prefixIcon: Icon(Icons.email),
                        ),
                        controller: _usernameController,
                      ),
                      SizedBox(height: 10), 
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                        ),
                        controller: _passwordController,
                      ),
                      SizedBox(height: 10), 
                      ElevatedButton(
                        onPressed: () async {
                          var username = _usernameController.text;
                          var password = _passwordController.text;

                          Authorization.username = username;
                          Authorization.password = password;

                          try {
                            var data = await _userProvider.get(filter: {
                              'IsTrener': "false",
                            });

                            var user = data.result.firstWhereOrNull((x) =>
                                x.korisnickoIme?.toLowerCase() ==
                                username.toLowerCase());

                            var userId = user?.id;

                            if (user != null) {
                              Provider.of<UserProvider>(context, listen: false)
                                  .setCurrentUserId(user.id);
                            }

                            if (data != null) {
                              if (data.result.firstWhereOrNull((x) =>
                                      x.korisnickoIme?.toLowerCase() ==
                                      username.toLowerCase()) ==
                                  null) {
                                throw Exception("Korisnik ne postoji");
                              }
                            }

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
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}