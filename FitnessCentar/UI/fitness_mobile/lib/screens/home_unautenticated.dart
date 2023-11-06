
import 'package:fitness_mobile/screens/login.dart';
import 'package:flutter/material.dart';

class HomeUnauthenticated extends StatelessWidget {
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "Dobrodošli u Fitness Centar!",
        style: TextStyle(
          color: Colors.purple,
          fontSize: 18, // Smanjen font za mobilnu verziju
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
           
          },
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14, // Smanjen font za mobilnu verziju
            ),
          ),
        ),
      ],
    ),
    
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
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Dodajte padding kako bi se elementi centrirali
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Centrirajte elemente horizontalno
          children: [
            ClipOval(
                    child: Image.asset(
                      "assets/images/FitnessLogo.jpg",
                      height: 100, // Prilagodite visinu prema potrebama
                      width: 100, // Prilagodite širinu prema potrebama
                    ),
),
            SizedBox(height: 20),
            Text(
              "Naša priča:\n\nNaš Fitness Centar je mjesto gdje se strast prema fitnessu i zdravlju susreće s vrhunskom opremom, stručnim trenerima i zajednicom koja vas podržava na svakom koraku putovanja prema boljem, zdravijem životu. Naša misija je jednostavna - inspirirati, motivirati i podržaviti vas u postizanju vaših ciljeva. Bez obzira jeste li početnik ili iskusni sportaš, ovdje ćete pronaći sve što vam je potrebno da postignete svoje najbolje rezultate. Ponosno radimo na stvaranju okruženja u kojem se osjećate dobrodošlima i potaknutima na ostvarivanje svojih ciljeva. Naš tim čine stručni treneri i osoblje koji su posvećeni vašem uspjehu. Svi naši treneri su certificirani stručnjaci s bogatim iskustvom u fitness industriji. Rado ćemo vam pružiti individualne savjete, izraditi personalizirane planove treninga i dijete te vam pomoći da ostvarite svoje ciljeve.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16, // Smanjen font za mobilnu verziju
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Dodajte funkcionalnost za login
                  Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0), // Smanjite padding za dugme
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 16, // Smanjen font za mobilnu verziju
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
        ],
  ),);
}
}