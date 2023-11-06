import 'dart:convert';
import 'dart:ui';


import 'package:fitness_mobile/models/korisnici.dart';
import 'package:fitness_mobile/providers/user_provider.dart';
import 'package:fitness_mobile/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAuthenticated extends StatelessWidget {
  final int? userId;
  final UserProvider userProvider;
 

  const HomeAuthenticated({
    Key? key,
    required this.userId,
    required this.userProvider,
       
  }) : super(key: key);

  Future<Korisnici?> getUserFromUserId(int userId) async {
    final user = await userProvider.getById(userId);
    return user;
  }

   @override
  Widget build(BuildContext context) {
    return _buildHomepage(context);
  }



  Widget _buildHomepage(BuildContext context) {
     
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Fitness Centar"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              // Dodajte funkcionalnost za logout
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/PozdainaD.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.6),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
  children: [
    Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage("assets/images/FitnessLogo.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    ),
    SizedBox(width: 20),
    FutureBuilder<Korisnici?>(
      future: getUserFromUserId(userId ?? 0),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Greška: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          return Text(
            "Dobro došli, ${user.ime} ${user.prezime}",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          return Text('Nema dostupnih podataka');
        }
      },
    ),
    // Dodajte korisnikovu sliku sa desne strane
    SizedBox(width: 10), // Dodajte odgovarajući razmak
  FutureBuilder<Korisnici?>(
  future: getUserFromUserId(userId ?? 0),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Greška: ${snapshot.error}');
    } else if (snapshot.hasData) {
      final user = snapshot.data!;
      //final userImage = imageFromBase64String(user.slika!); 
      final userImage = user.slika != null ? imageFromBase64String(user.slika!) : null;
final userImageBytes = user.slika != null ? Uint8List.fromList(base64Decode(user.slika!)) : null;

     return CircleAvatar(
  backgroundImage: Image.memory(Uint8List.fromList(userImageBytes!)).image,
  radius: 50,
);
    } else {
      return Text('Nema dostupnih podataka');
    }
  },
)


  ],
)
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Prvi red sa tri dugmeta
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  
                    SizedBox(width: 100),
                   
                   
                  ],
                ),
                SizedBox(height: 100),
                // Drugi red sa tri dugmeta
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  
                    SizedBox(width: 100),
                   
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 
}