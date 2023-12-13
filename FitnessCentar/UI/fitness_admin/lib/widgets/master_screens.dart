import 'package:fitness_admin/screens/home_unauthenticated.dart';
import 'package:fitness_admin/screens/user_details_screens.dart';
import 'package:fitness_admin/utils/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:fitness_admin/providers/user_provider.dart';

import 'package:fitness_admin/screens/login.dart';


import 'package:provider/provider.dart';

class MasterScreanWidget extends StatefulWidget {
  Widget? child;
  String? title;
  Widget? title_widget;
  MasterScreanWidget({this.child, this.title, this.title_widget, super.key});

  @override
  State<MasterScreanWidget> createState() => _MasterScreanWidgetState();
}

class _MasterScreanWidgetState extends State<MasterScreanWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 247, 236, 249), 
      appBar: AppBar(
        title: widget.title_widget ?? Text(widget.title ?? "FITNESS CENTAR"),
actions: [
         Padding(
    padding: const EdgeInsets.only(right: 25.0), // Prilagođava desni razmak
    child: IconButton(
      onPressed: () {
        Authorization.username = null;
        Authorization.password = null;

        Provider.of<UserProvider>(context, listen: false)
            .setCurrentUserId(null);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomeUnauthenticated()),
          (route) => false,
        );
      },
      icon: Icon(Icons.logout),
      iconSize: 30.0, // Prilagođava veličinu ikone
    ),
  ),
        ],
      ),
     
      body: widget.child!,
    );
  }
}
