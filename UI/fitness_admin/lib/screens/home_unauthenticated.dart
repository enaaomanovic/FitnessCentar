import 'package:fitness_admin/screens/login.dart';
import 'package:flutter/material.dart';

class HomeUnauthenticated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 600.0),
          child: Text(
            "Dobrodošli u Fitness Centar!",
            style: TextStyle(
              color: Colors.purple,
              fontSize: 24,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
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
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/FitnessLogo.jpg",
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Naša priča:\n\nNaš Fitness Centar je mjesto gdje se strast prema fitnessu i zdravlju susreće s vrhunskom opremom, stručnim trenerima i zajednicom koja vas podržava na svakom koraku putovanja prema boljem, zdravijem životu. Naša misija je jednostavna - inspirirati, motivirati i podržavati vas u postizanju vaših ciljeva. Bez obzira jeste li početnik ili iskusni sportaš, ovdje ćete pronaći sve što vam je potrebno da postignete svoje najbolje rezultate. Ponosno radimo na stvaranju okruženja u kojem se osjećate dobrodošlima i potaknutima na ostvarivanje svojih ciljeva. Naš tim čine stručni treneri i osoblje koji su posvećeni vašem uspjehu. Svi naši treneri su certificirani stručnjaci s bogatim iskustvom u fitness industriji. Rado ćemo vam pružiti individualne savjete, izraditi personalizirane planove treninga i dijete te vam pomoći da ostvarite svoje ciljeve.",
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
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
