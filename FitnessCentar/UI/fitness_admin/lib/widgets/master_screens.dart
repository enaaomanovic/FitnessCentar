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
      appBar: AppBar(
        title: widget.title_widget ?? Text(widget.title ?? "FITNESS CENTAR"),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
         
          ListTile(
              title: Text("Korisnici"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserDetalScreen(),
                  ),
                );
              }),
               ListTile(
              title: Text("Detalji"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserDetalScreen(),
                  ),
                );
              }),
        ],
      )),
      body: widget.child!,
    );
  }
}
