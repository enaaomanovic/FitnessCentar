import 'package:fitness_mobile/providers/user_provider.dart';
import 'package:fitness_mobile/screens/login.dart';
import 'package:fitness_mobile/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: Color.fromARGB(255, 247, 236, 249),
      appBar: AppBar(
        title: widget.title_widget ?? Text(widget.title ?? "FITNESS CENTAR"),
        actions: [
          IconButton(
            onPressed: () {
              Authorization.username = null;
              Authorization.password = null;

              Provider.of<UserProvider>(context, listen: false)
                  .setCurrentUserId(null);

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: widget.child!,
    );
  }
}
