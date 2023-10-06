import 'package:fitness_admin/widgets/master_screens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserDetalScreen extends StatefulWidget {
  const UserDetalScreen({super.key});

  @override
  State<UserDetalScreen> createState() => _UserDetalScreenState();
}

class _UserDetalScreenState extends State<UserDetalScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(child: Text("Details"),
    title: "Product Details",
    );
  }
}