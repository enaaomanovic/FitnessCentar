// import 'dart:convert';
// import 'dart:ui';
// import 'package:fitness_mobile/models/korisnici.dart';
// import 'package:fitness_mobile/models/napredak.dart';
// import 'package:fitness_mobile/models/search_result.dart';
// import 'package:fitness_mobile/providers/progress_provider.dart';
// import 'package:fitness_mobile/providers/user_provider.dart';
// import 'package:fitness_mobile/screens/edit_user.dart';
// import 'package:fitness_mobile/screens/news_list.dart';
// import 'package:fitness_mobile/screens/trainer_list.dart';
// import 'package:fitness_mobile/screens/user_details.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// typedef void WeightUpdateCallback(double newWeight);

// class HomeAuthenticated extends StatelessWidget {
//   final int? userId;
//   final UserProvider userProvider;
//   final ProgressProvider progressProvider;

//   const HomeAuthenticated({
//     Key? key,
//     required this.userId,
//     required this.userProvider,
//     required this.progressProvider,
//   }) : super(key: key);

//   Future<Korisnici?> getUserFromUserId(int userId) async {
//     final user = await userProvider.getById(userId);
//     return user;
//   }

//   Future<SearchResult<Napredak>> getProgressFromUserId(int userId) async {
//     final progress = await progressProvider.get(filter: {
//       'korisnikId': userId.toString(),
//     });

//     if (progress.result.isEmpty) {
//       return SearchResult<Napredak>();
//     }

//     return progress;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _buildHomepage(context);
//   }

//   Widget _buildHomepage(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/PozdainaD.jpg"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 40.0, left: 10.0),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 100,
//                             height: 100,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               image: DecorationImage(
//                                 image:
//                                     AssetImage("assets/images/FitnessLogo.jpg"),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           FutureBuilder<Korisnici?>(
//                             future: getUserFromUserId(userId ?? 0),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return CircularProgressIndicator();
//                               } else if (snapshot.hasError) {
//                                 return Text('Greška: ${snapshot.error}');
//                               } else if (snapshot.hasData) {
//                                 final user = snapshot.data!;
//                                 return Text(
//                                   " ${user.ime} ${user.prezime}",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 );
//                               } else {
//                                 return Text('Nema dostupnih podataka');
//                               }
//                             },
//                           ),
//                           SizedBox(width: 10),
//                           FutureBuilder<Korisnici?>(
//                             future: getUserFromUserId(userId ?? 0),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return CircularProgressIndicator();
//                               } else if (snapshot.hasError) {
//                                 return Text('Greška: ${snapshot.error}');
//                               } else if (snapshot.hasData) {
//                                 final user = snapshot.data!;
//                                 final userImageBytes = user.slika != null
//                                     ? Uint8List.fromList(
//                                         base64Decode(user.slika!))
//                                     : null;

//                                 if (userImageBytes != null &&
//                                     userImageBytes.isNotEmpty) {
//                                   return CircleAvatar(
//                                     backgroundImage:
//                                         MemoryImage(userImageBytes),
//                                     radius: 30,
//                                   );
//                                 } else {
//                                   return CircleAvatar(
//                                     backgroundImage: AssetImage(
//                                         "assets/images/male_icon.jpg"),
//                                     radius: 30,
//                                   );
//                                 }
//                               } else {
//                                 return Text('Nema dostupnih podataka');
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             height: 20,
//                           ),
//                           _buildProgressSection(),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             _buildBottomNavigationBar(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProgressSection() {
//     return Center(
//       child: SizedBox(
//         height: 550,
//         width: 300,
//         child: ListView(
//           scrollDirection: Axis.vertical,
//           children: [
//             _buildCard(),
//             _buildAddProgressButton(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCard() {
//     return Card(
//       elevation: 6,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildProgressTitle(),
//             SizedBox(height: 10),
//             _buildUserDetails(),
//             SizedBox(height: 10),
//             _buildCurrentWeight(),
//             SizedBox(height: 10),
//             _buildNapredak(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAddProgressButton() {
//     return Positioned(
//       bottom: 20,
//       right: 16,
//       child: Builder(
//         builder: (BuildContext context) {
//           return CircleAvatar(
//             backgroundColor: Colors.purple,
//             radius: 28.0,
//             child: IconButton(
//               onPressed: () {
//                 _showMyDialog(context, (double newWeight) {});
//               },
//               icon: Icon(Icons.add, color: Colors.white),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildProgressTitle() {
//     return Text(
//       "Napredak",
//       style: TextStyle(
//         fontSize: 24,
//         fontWeight: FontWeight.bold,
//         color: Colors.black,
//       ),
//     );
//   }

//   Widget _buildUserDetails() {
//     return FutureBuilder<Korisnici?>(
//       future: getUserFromUserId(userId ?? 0),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text(
//             'Greška: ${snapshot.error}',
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.red,
//               fontWeight: FontWeight.bold,
//             ),
//           );
//         } else if (snapshot.hasData) {
//           final user = snapshot.data!;
//           return Container(
//             margin: EdgeInsets.only(bottom: 10),
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.purple,
//                 width: 2.0,
//               ),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Ime: ${user.ime}",
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   "Prezime: ${user.prezime}",
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   "Visina: ${user.visina} cm",
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   "Početna težina: ${user.tezina} kg",
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           return Text(
//             'Nema dostupnih podataka',
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           );
//         }
//       },
//     );
//   }

//   Widget _buildCurrentWeight() {
//     return FutureBuilder<SearchResult<Napredak?>>(
//       future: getProgressFromUserId(userId ?? 0),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text(
//             'Greška: ${snapshot.error}',
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.red,
//               fontWeight: FontWeight.bold,
//             ),
//           );
//         } else if (snapshot.hasData) {
//           final progress = snapshot.data!;
//           if (progress.result.isNotEmpty &&
//               progress.result.any((napredak) => napredak?.tezina != null)) {
//             final lastProgress = progress.result
//                 .lastWhere((napredak) => napredak!.tezina != null);
//             return Container(
//               margin: EdgeInsets.only(bottom: 10),
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.purple,
//                   width: 2.0,
//                 ),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 "Trenutna težina: ${lastProgress?.tezina} kg",
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             );
//           } else {
//             return Text(
//               "Još niste ostvarili napredak. Unos napretka možete izvršiti na dugme + ispod forme",
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             );
//           }
//         } else {
//           return Text(
//             'Nema dostupnih podataka',
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           );
//         }
//       },
//     );
//   }

//   Widget _buildNapredak() {
//     return Column(
//       children: [
//         SizedBox(height: 40),
//         FutureBuilder<SearchResult<Napredak?>>(
//           future: getProgressFromUserId(userId ?? 0),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text(
//                 'Greška: ${snapshot.error}',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.red,
//                   fontWeight: FontWeight.bold,
//                 ),
//               );
//             } else {
//               final progress = snapshot.data!;
//               if (progress == null || progress.result.isEmpty) {
//                 return Container(
//                   margin: EdgeInsets.only(bottom: 10),
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.purple,
//                       width: 4.0,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     'Nije doslo do promjene u kilaži korisnika',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 );
//               } else {
//                 return FutureBuilder<Korisnici?>(
//                   future: getUserFromUserId(userId ?? 0),
//                   builder: (context, userSnapshot) {
//                     if (userSnapshot.connectionState ==
//                         ConnectionState.waiting) {
//                       return CircularProgressIndicator();
//                     } else if (userSnapshot.hasError) {
//                       return Text(
//                         'Greška: ${userSnapshot.error}',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.red,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       );
//                     } else if (userSnapshot.hasData) {
//                       final user = userSnapshot.data!;
//                       return Container(
//                         margin: EdgeInsets.only(bottom: 10),
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.purple,
//                             width: 4.0,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: _buildResultMessage(
//                           progress.result.last?.tezina ?? 0,
//                           user.tezina ?? 0,
//                         ),
//                       );
//                     } else {
//                       return Text(
//                         'Nije doslo do promjene u kilaži korisnika',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       );
//                     }
//                   },
//                 );
//               }
//             }
//           },
//         ),
//       ],
//     );
//   }

//   Future<void> _showMyDialog(
//       BuildContext context, WeightUpdateCallback callback) async {
//     TextEditingController currentWeightController = TextEditingController();

//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Unesite trenutnu kilažu'),
//           contentPadding:
//               EdgeInsets.only(top: 12.0, left: 24.0, right: 24.0, bottom: 0.0),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TextField(
//                 controller: currentWeightController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Trenutna kilaža'),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   String inputWeight = currentWeightController.text.trim();

//                   if (inputWeight.isEmpty) {
//                     _showErrorDialog(context, 'Morate uneti težinu.');
//                     return;
//                   }

//                   try {
//                     double newWeight = double.parse(inputWeight);

//                     callback(newWeight);

//                     var request = <String, dynamic>{
//                       'korisnikId': userId,
//                       'tezina': inputWeight,
//                     };

//                     await progressProvider.insert(request);

//                     Navigator.pop(context);
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => HomeAuthenticated(
//                           userId: userId,
//                           userProvider: userProvider,
//                           progressProvider: progressProvider,
//                         ),
//                       ),
//                     );
//                   } catch (e) {
//                     _showErrorDialog(context, 'Niste ispravno uneli težinu.');
//                   }
//                 },
//                 child: Text('Sačuvaj'),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Zatvori'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showErrorDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: Text("Greška"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildResultMessage(double currentWeight, double initialWeight) {
//     String resultMessage = '';
//     if (currentWeight == initialWeight) {
//       resultMessage = 'Nije došlo do promjene u težini.';
//     } else {
//       double result = currentWeight - initialWeight;

//       if (result > 0) {
//         resultMessage = 'Udebljali ste se  za ${result.abs()} kg!';
//       } else if (result < 0) {
//         resultMessage = 'Smršali ste za ${result.abs()} kg!';
//       }
//     }

//     return Text(
//       'Rezultat: $resultMessage',
//       style: TextStyle(
//         fontSize: 20,
//         color: Colors.black,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }

//   Widget _buildBottomNavigationBar(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(
//           top: BorderSide(
//             color: Colors.purpleAccent,
//             width: 2.0,
//           ),
//         ),
//       ),
//       child: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home, color: Colors.purple, size: 35),
//             label: "",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.schedule, color: Colors.purple, size: 35),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.newspaper_sharp, color: Colors.purple, size: 35),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person, color: Colors.purple, size: 35),
//             label: '',
//           ),
//         ],
//         onTap: (index) {
//           switch (index) {
//             case 0:
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => HomeAuthenticated(
//                     userId: userId,
//                     userProvider: userProvider,
//                     progressProvider: progressProvider,
//                   ),
//                 ),
//               );
//               break;
//             case 1:
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => TreneriScreen(),
//                 ),
//               );
//               break;
//             case 2:
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => NewsListScreen(),
//                 ),
//               );

//               break;
//             case 3:
//                Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => MobileUserDetailScreen(
//                     userId: userId,
//                   ),
//                 ),
//               );
//               break;
//           }
//         },
//       ),
//     );
//   }
// }




import 'dart:convert';
import 'dart:ui';
import 'package:fitness_mobile/models/korisnici.dart';
import 'package:fitness_mobile/models/napredak.dart';
import 'package:fitness_mobile/models/search_result.dart';
import 'package:fitness_mobile/providers/progress_provider.dart';
import 'package:fitness_mobile/providers/user_provider.dart';
import 'package:fitness_mobile/screens/edit_user.dart';
import 'package:fitness_mobile/screens/news_list.dart';
import 'package:fitness_mobile/screens/trainer_list.dart';
import 'package:fitness_mobile/screens/user_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef void WeightUpdateCallback(double newWeight);

class HomeAuthenticated extends StatefulWidget {
  final int? userId;
  final UserProvider userProvider;
  final ProgressProvider progressProvider;

  const HomeAuthenticated({
    Key? key,
    required this.userId,
    required this.userProvider,
    required this.progressProvider,
  }) : super(key: key);

    @override
  _HomeAuthenticatedState createState() => _HomeAuthenticatedState();
}

class _HomeAuthenticatedState extends State<HomeAuthenticated> {

  Future<Korisnici?> getUserFromUserId(int userId) async {
    final user = await widget.userProvider.getById(userId);
    return user;
  }

    void onUserEdit() {
 
    widget.userProvider.updateUser();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeAuthenticated(
          userId: widget.userId,
          userProvider: widget.userProvider,
          progressProvider: widget.progressProvider,
        ),
      ),
    );
  }

  Future<SearchResult<Napredak>> getProgressFromUserId(int userId) async {
    final progress = await widget.progressProvider.get(filter: {
      'korisnikId': userId.toString(),
    });

    if (progress.result.isEmpty) {
      return SearchResult<Napredak>();
    }

    return progress;
  }

  @override
  Widget build(BuildContext context) {
    return _buildHomepage(context);
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
                      padding: const EdgeInsets.only(top: 40.0, left: 10.0),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image:
                                    AssetImage("assets/images/FitnessLogo.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          FutureBuilder<Korisnici?>(
                            future: getUserFromUserId(widget.userId ?? 0),
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
                            future: getUserFromUserId(widget.userId ?? 0),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Greška: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                final user = snapshot.data!;
                                final userImageBytes = user.slika != null
                                    ? Uint8List.fromList(
                                        base64Decode(user.slika!))
                                    : null;

                                if (userImageBytes != null &&
                                    userImageBytes.isNotEmpty) {
                                  return CircleAvatar(
                                    backgroundImage:
                                        MemoryImage(userImageBytes),
                                    radius: 30,
                                  );
                                } else {
                                  return CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/male_icon.jpg"),
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

  Widget _buildProgressSection() {
    return Center(
      child: SizedBox(
        height: 550,
        width: 300,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            _buildCard(),
           
      
            _buildAddProgressButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildProgressTitle(),
            SizedBox(height: 10),
            _buildUserDetails(),
            SizedBox(height: 10),
            _buildCurrentWeight(),
            SizedBox(height: 10),
            _buildNapredak(),
           

          ],
        ),

      ),
    );
    
  }

  Widget _buildAddProgressButton() {
    return Positioned(
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
    );
  }

  Widget _buildProgressTitle() {
    return Text(
      "Napredak",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildUserDetails() {
    return FutureBuilder<Korisnici?>(
      future: getUserFromUserId(widget.userId ?? 0),
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
    );
  }

  Widget _buildCurrentWeight() {
    return FutureBuilder<SearchResult<Napredak?>>(
      future: getProgressFromUserId(widget.userId ?? 0),
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
          if (progress.result.isNotEmpty &&
              progress.result.any((napredak) => napredak?.tezina != null)) {
            final lastProgress = progress.result
                .lastWhere((napredak) => napredak!.tezina != null);
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
                "Trenutna težina: ${lastProgress?.tezina} kg",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return Text(
              "Još niste ostvarili napredak. Unos napretka možete izvršiti na dugme + ispod forme",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
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
    );
  }

  Widget _buildNapredak() {
    return Column(
      children: [
        SizedBox(height: 40),
        FutureBuilder<SearchResult<Napredak?>>(
          future: getProgressFromUserId(widget.userId ?? 0),
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
            } else {
              final progress = snapshot.data!;
              if (progress == null || progress.result.isEmpty) {
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
                  child: Text(
                    'Nije doslo do promjene u kilaži korisnika',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else {
                return FutureBuilder<Korisnici?>(
                  future: getUserFromUserId(widget.userId ?? 0),
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
                          user.tezina ?? 0,
                        ),
                      );
                    } else {
                      return Text(
                        'Nije doslo do promjene u kilaži korisnika',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  },
                );
              }
            }
          },
        ),
      ],
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
                    _showErrorDialog(context, 'Morate uneti težinu.');
                    return;
                  }

                  try {
                    double newWeight = double.parse(inputWeight);

                    callback(newWeight);

                    var request = <String, dynamic>{
                      'korisnikId': widget.userId,
                      'tezina': inputWeight,
                     'datumMjerenja':DateTime.now().toIso8601String(),
                         

                    };

                    await widget.progressProvider.insert(request);

                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeAuthenticated(
                          userId: widget.userId,
                          userProvider: widget.userProvider,
                          progressProvider: widget.progressProvider,
                        ),
                      ),
                    );
                  } catch (e) {
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
                Navigator.of(context).pop();
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
            color: Colors.purpleAccent,
            width: 2.0,
          ),
        ),
      ),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.purple, size: 35),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule, color: Colors.purple, size: 35),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper_sharp, color: Colors.purple, size: 35),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.purple, size: 35),
            label: '',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomeAuthenticated(
                    userId: widget.userId,
                    userProvider: widget.userProvider,
                    progressProvider: widget.progressProvider,
                  ),
                ),
              );
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

              break;
            case 3:
               Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MobileUserDetailScreen(
                    userId: widget.userId,
                     onUserEdit: onUserEdit,
                  ),
                ),
              );
              break;
          }
        },
      ),
    );
  }





}
