import 'dart:convert';
import 'dart:ui';

import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/models/report.dart';
import 'package:fitness_admin/providers/user_provider.dart';
import 'package:fitness_admin/screens/add_news.dart';
import 'package:fitness_admin/screens/add_user.dart';
import 'package:fitness_admin/screens/home_unauthenticated.dart';
import 'package:fitness_admin/screens/news_list.dart';
import 'package:fitness_admin/screens/report.dart';
import 'package:fitness_admin/screens/reservation_list.dart';
import 'package:fitness_admin/screens/schedule_list.dart';
import 'package:fitness_admin/screens/treiner_list.dart';
import 'package:fitness_admin/screens/user_details_screens.dart';
import 'package:fitness_admin/screens/user_list.dart';
import 'package:fitness_admin/utils/util.dart';
import 'package:fitness_admin/widgets/master_screens.dart';
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
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
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
              iconSize: 30.0,
            ),
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
                  SizedBox(width: 10),
                  FutureBuilder<Korisnici?>(
                    future: getUserFromUserId(userId ?? 0),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Greška: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final user = snapshot.data!;
                        final userImageBytes = user.slika != null
                            ? Uint8List.fromList(base64Decode(user.slika!))
                            : null;

                        if (userImageBytes != null &&
                            userImageBytes.isNotEmpty) {
                          return CircleAvatar(
                            backgroundImage:
                                Image.memory(Uint8List.fromList(userImageBytes))
                                    .image,
                            radius: 50,
                          );
                        } else {
                          return CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/male_icon.jpg'),
                            radius: 50,
                          );
                        }
                      } else {
                        return Text('Nema dostupnih podataka');
                      }
                    },
                  )
                ],
              )),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddUser(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Dodaj novog člana",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const UserListScrean(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Prikaz postojećih članova",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AddNews(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Dodavanje novosti",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const NewsListScrean(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Pregled novosti",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ScheduleListScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Pregled rasporeda",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ReservationListScrean(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Pregled plaćenih rezervacija",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const TreneriScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Lista trenera",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
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



