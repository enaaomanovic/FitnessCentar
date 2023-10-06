import 'package:fitness_admin/screens/user_details_screens.dart';
import 'package:fitness_admin/widgets/master_screens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class UserListScrean extends StatefulWidget {

  const UserListScrean({super.key});

  @override
  State<UserListScrean> createState() => _UserListScrean();
}

class _UserListScrean extends State<UserListScrean> {
  late UserProvider _userProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProvider=context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      child:Center(
        child: Container(
          constraints: BoxConstraints(maxHeight: 600, maxWidth: 600),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
              
                SizedBox(
                  height: 50,
                ),
             ElevatedButton(onPressed: () async{
                
               var date= await _userProvider.get();
              
              }, 
              child: Text("Details")),

                SizedBox(
                  height: 15,
                ),
              ]),
            ),
          ),
        ),
      ));
  }
}
