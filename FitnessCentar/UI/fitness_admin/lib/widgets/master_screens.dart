import 'package:fitness_admin/screens/user_details_screens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
           IconButton(
            onPressed: () {
              // Dodajte funkcionalnost za logout
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
     
      body: widget.child!,
    );
  }
}
