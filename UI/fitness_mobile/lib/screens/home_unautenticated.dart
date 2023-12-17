import 'package:fitness_mobile/screens/login.dart';
import 'package:flutter/material.dart';

class HomeUnauthenticated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/PozdainaD.jpg",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.6),
          ),
          SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Container(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Dobrodošli u Fitness Centar!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  actions: [],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromARGB(100, 155, 39, 176),
                            width: 6.0,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/FitnessLogo.jpg",
                            height: 150,
                            width: 150,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Naša priča:\n\nNaš Fitness Centar je mjesto gdje se strast prema fitnessu i zdravlju susreće s vrhunskom opremom, stručnim trenerima i zajednicom koja vas podržava na svakom koraku putovanja prema boljem, zdravijem životu. Naša misija je jednostavna - inspirirati, motivirati i podržaviti vas u postizanju vaših ciljeva. Bez obzira jeste li početnik ili iskusni sportaš, ovdje ćete pronaći sve što vam je potrebno da postignete svoje najbolje rezultate.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
