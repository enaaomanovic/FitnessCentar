import 'package:fitness_admin/providers/user_provider.dart';
import 'package:fitness_admin/screens/homepage.dart';

import 'package:fitness_admin/utils/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController _usernameControler = new TextEditingController();
  TextEditingController _passwordControler = new TextEditingController();
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = context.read<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 700.0),
          child: Text(
            "LogIn",
            style: TextStyle(
              color: Color.fromARGB(255, 221, 158, 214),
              fontSize: 24,
            ),
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
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxHeight: 600, maxWidth: 600),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        ClipOval(
                          child: Container(
                            height: 150,
                            width: 150,
                            child: Image.asset(
                              "assets/images/FitnessLogo.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Username",
                            prefixIcon: Icon(Icons.email),
                          ),
                          controller: _usernameControler,
                        ),
                        SizedBox(height: 30),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.password),
                          ),
                          controller: _passwordControler,
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () async {
                            var username = _usernameControler.text;
                            var password = _passwordControler.text;

                            print("login proceed $username $password");

                           Authorization.username = username;
                           Authorization.password = password;

                            try {
                              await _userProvider.get();

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const HomeAuthenticated(),
                                ),
                              );
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
