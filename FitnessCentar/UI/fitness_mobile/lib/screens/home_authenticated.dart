import 'dart:convert';
import 'dart:ui';

import 'package:fitness_mobile/models/korisnici.dart';
import 'package:fitness_mobile/models/napredak.dart';
import 'package:fitness_mobile/models/search_result.dart';
import 'package:fitness_mobile/providers/progress_provider.dart';
import 'package:fitness_mobile/providers/user_provider.dart';
import 'package:fitness_mobile/screens/news_list.dart';
import 'package:fitness_mobile/screens/trainer_list.dart';
import 'package:fitness_mobile/screens/user_details.dart';
import 'package:fitness_mobile/utils/utils.dart';
import 'package:fitness_mobile/widgets/master_screens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

typedef void WeightUpdateCallback(double newWeight);

class HomeAuthenticated extends StatelessWidget {
  final int? userId;
  final UserProvider userProvider;
  final ProgressProvider progressProvider;

  const HomeAuthenticated({
    Key? key,
    required this.userId,
    required this.userProvider,
    required this.progressProvider,
  }) : super(key: key);

  Future<Korisnici?> getUserFromUserId(int userId) async {
    final user = await userProvider.getById(userId);
    return user;
  }

  Future<SearchResult<Napredak>> getProgressFromUserId(int userId) async {
    final progress = await progressProvider.get(filter: {
      'korisnikId': this.userId.toString(),
    });
    return progress;
  }

  @override
  Widget build(BuildContext context) {
    return 
    _buildHomepage(context);
  }
Image loadMaleIconImage() {
  return Image.asset('assets/images/male_icon.jpg');
}
Widget _buildHomepage(BuildContext context) {
  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/PozdainaD.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, left: 20.0),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
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
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Greška: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final user = snapshot.data!;
                              return Text(
                                " ${user.ime} ${user.prezime}",
                                style: TextStyle(
                                  fontSize: 20,
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

      if (userImageBytes != null && userImageBytes.isNotEmpty) {
        // Prikazi sliku korisnika ako je dostupna
        return CircleAvatar(
          backgroundImage: MemoryImage(userImageBytes),
          radius: 30,
        );
      } else {
        // Ako korisnik nema sliku, prikaži podrazumevanu sliku
        return CircleAvatar(
          backgroundImage: AssetImage("assets/images/male_icon.jpg"),
          radius: 30,
        );
      }
    } else {
      return Text('Nema dostupnih podataka');
    }
  },
),

                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        _buildProgressSection(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildBottomNavigationBar(context),
        ],
      ),
    ),
  );
}

// Widget _buildProgressSection() {
//   return Center(
//     child: SizedBox(
//       height: 550,
//       width: 300,
//       child: Stack(
//         children: [
//           Card(
//             elevation: 6,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     "Napredak",
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   SizedBox(height: 40),
//                   FutureBuilder<Korisnici?>(
//                     future: getUserFromUserId(userId ?? 0),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState ==
//                           ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       } else if (snapshot.hasError) {
//                         return Text(
//                           'Greška: ${snapshot.error}',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.red,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         );
//                       } else if (snapshot.hasData) {
//                         final user = snapshot.data!;
//                         return Container(
//                           margin: EdgeInsets.only(bottom: 10),
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Colors.purple,
//                               width: 2.0,
//                             ),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Ime: ${user.ime}",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 "Prezime: ${user.prezime}",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 "Visina: ${user.visina} cm",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 "Početna težina: ${user.tezina} kg",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       } else {
//                         return Text(
//                           'Nema dostupnih podataka',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                   SizedBox(height: 40),
//                   FutureBuilder<SearchResult<Napredak?>>(
//                     future: getProgressFromUserId(2),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState ==
//                           ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       } else if (snapshot.hasError) {
//                         return Text(
//                           'Greška: ${snapshot.error}',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.red,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         );
//                       } else if (snapshot.hasData) {
//                         final progress = snapshot.data!;
//                         if (progress.result.isNotEmpty) {
//                           return Container(
//                             margin: EdgeInsets.only(bottom: 10),
//                             padding: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Colors.purple,
//                                 width: 2.0,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               "Trenutna težina: ${progress.result.last?.tezina} kg",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           );
//                         } else {
//                           return Container(
//                             margin: EdgeInsets.only(bottom: 10),
//                             padding: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Colors.purple,
//                                 width: 2.0,
//                               ),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               "Trenutna težina: trenutno nema dostupnih podataka",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           );
//                         }
//                       } else {
//                         return Text(
//                           'Nema dostupnih podataka',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                   SizedBox(height: 40),
//                   FutureBuilder<SearchResult<Napredak?>>(
//                     future: getProgressFromUserId(userId ?? 0),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState ==
//                           ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       } else if (snapshot.hasError) {
//                         return Text(
//                           'Greška: ${snapshot.error}',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.red,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         );
//                       } else if (snapshot.hasData) {
//                         final progress = snapshot.data!;
//                         return FutureBuilder<Korisnici?>(
//                           future: getUserFromUserId(userId ?? 0),
//                           builder: (context, userSnapshot) {
//                             if (userSnapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return CircularProgressIndicator();
//                             } else if (userSnapshot.hasError) {
//                               return Text(
//                                 'Greška: ${userSnapshot.error}',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.red,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               );
//                             } else if (userSnapshot.hasData) {
//                               final user = userSnapshot.data!;
//                               return Container(
//                                 margin: EdgeInsets.only(bottom: 10),
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: Colors.purple,
//                                     width: 4.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: _buildResultMessage(
//                                   progress.result.isNotEmpty
//                                     ? progress.result.last?.tezina ?? 0
//                                     : 0,
//                                   user.tezina ?? 0,
//                                 ),
//                               );
//                             } else {
//                               return Text(
//                                 'Nema dostupnih podataka',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               );
//                             }
//                           },
//                         );
//                       } else {
//                         return Text(
//                           'Nema dostupnih podataka',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             right: 16,
//             child: Builder(
//               builder: (BuildContext context) {
//                 return CircleAvatar(
//                   backgroundColor: Colors.purple,
//                   radius: 28.0,
//                   child: IconButton(
//                     onPressed: () {
//                       _showMyDialog(context, (double newWeight) {});
//                     },
//                     icon: Icon(Icons.add, color: Colors.white),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

  Widget _buildProgressSection() {
    return Center(
      child: SizedBox(
        height: 550,
        width: 300,
        child: Stack(
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Napredak",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 40),
                    FutureBuilder<Korisnici?>(
                      future: getUserFromUserId(userId ?? 0),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                            'Greška: ${snapshot.error}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else if (snapshot.hasData) {
                          final user = snapshot.data!;
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.purple,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ime: ${user.ime}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Prezime: ${user.prezime}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Visina: ${user.visina} cm",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Početna težina: ${user.tezina} kg",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Text(
                            'Nema dostupnih podataka',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 40),
                    FutureBuilder<SearchResult<Napredak?>>(
  future: getProgressFromUserId(2),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text(
        'Greška: ${snapshot.error}',
        style: TextStyle(
          fontSize: 18,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (snapshot.hasData) {
      final progress = snapshot.data!;
      if (progress.result.isNotEmpty) {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.purple,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "Trenutna težina: ${progress.result.last?.tezina} kg",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.purple,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "Trenutna težina: trenutno nema dostupnih podataka",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    } else {
      return Text(
        'Nema dostupnih podataka',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  },
),

                    SizedBox(height: 40),
                    FutureBuilder<SearchResult<Napredak?>>(
                      future: getProgressFromUserId(userId ?? 0),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                            'Greška: ${snapshot.error}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else if (snapshot.hasData) {
                          final progress = snapshot.data!;
                          return FutureBuilder<Korisnici?>(
                            future: getUserFromUserId(userId ?? 0),
                            builder: (context, userSnapshot) {
                              if (userSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (userSnapshot.hasError) {
                                return Text(
                                  'Greška: ${userSnapshot.error}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              } else if (userSnapshot.hasData) {
                                final user = userSnapshot.data!;
                                return Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.purple,
                                      width: 4.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: _buildResultMessage(
                                      progress.result.last?.tezina ?? 0,
                                      user.tezina ?? 0),
                                );
                              } else {
                                return Text(
                                  'Nema dostupnih podataka',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                            },
                          );
                        } else {
                          return Text(
                            'Nema dostupnih podataka',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 16,
              child: Builder(
                builder: (BuildContext context) {
                  return CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: 28.0,
                    child: IconButton(
                      onPressed: () {
                        _showMyDialog(context, (double newWeight) {});
                      },
                      icon: Icon(Icons.add, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

 Future<void> _showMyDialog(
  BuildContext context, WeightUpdateCallback callback) async {
  TextEditingController currentWeightController = TextEditingController();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Unesite trenutnu kilažu'),
        contentPadding:
            EdgeInsets.only(top: 12.0, left: 24.0, right: 24.0, bottom: 0.0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: currentWeightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Trenutna kilaža'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String inputWeight = currentWeightController.text.trim();

                if (inputWeight.isEmpty) {
                  // Prazan unos
                  _showErrorDialog(context, 'Morate uneti težinu.');
                  return;
                }

                try {
                  double newWeight = double.parse(inputWeight);

                  callback(newWeight);

                  var request = <String, dynamic>{
                    'korisnikId': userId,
                    'tezina': inputWeight,
                  };

                  await progressProvider.insert(request);

                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeAuthenticated(
                        userId: userId,
                        userProvider: userProvider,
                        progressProvider: progressProvider,
                      ),
                    ),
                  );
                } catch (e) {
                  // Neispravan unos
                  _showErrorDialog(context, 'Niste ispravno uneli težinu.');
                }
              },
              child: Text('Sačuvaj'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Zatvara dijalog
            },
            child: Text('Zatvori'),
          ),
        ],
      );
    },
  );
}

void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text("Greška"),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("OK"),
        ),
      ],
    ),
  );
}

Widget _buildResultMessage(double currentWeight, double initialWeight) {
  String resultMessage = '';
  if (currentWeight == initialWeight) {
    resultMessage = 'Nije došlo do promjene u težini.';
  } else {
    double result = currentWeight - initialWeight;

    if (result > 0) {
      resultMessage = 'Udebljali ste se  za ${result.abs()} kg!';
    } else if (result < 0) {
      resultMessage = 'Smršali ste za ${result.abs()} kg!';
    }
  }

  return Text(
    'Rezultat: $resultMessage',
    style: TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  );
}

 

Widget _buildBottomNavigationBar(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Colors.purpleAccent, // Boja gornje granice
          width: 2.0, // Debljina gornje granice
        ),
      ),
    ),
    child: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.purple, size: 35),
          label: 'Početna',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule, color: Colors.purple, size: 35),
          label: 'Pretraga',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper_sharp, color: Colors.purple, size: 35),
          label: 'Favoriti',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.purple, size: 35),
          label: 'Profil',
        ),
      ],
      onTap: (index) {
        // Ovde postavite šta želite da se dešava kada se pritisne dugme na donjoj navigaciji
        switch (index) {
          case 0:
          
            // Navigacija na Početnu stranicu
            break;
          case 1:
             Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TreneriScreen(),
            ),
          );
            break;
          case 2:
           Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewsListScreen(),
            ),
          );
            // Navigacija na Favoriti stranicu
            break;
          case 3:
           // Navigacija na Profil stranicu
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MobileUserDetailScreen(userId: userId,),
            ),
          );
            // Navigacija na Profil stranicu
           
            break;
        }
      },
    ),
  );
}




}

