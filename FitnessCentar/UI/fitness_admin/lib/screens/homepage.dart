import 'package:fitness_admin/screens/add_news.dart';
import 'package:fitness_admin/screens/add_user.dart';
import 'package:fitness_admin/screens/news_list.dart';
import 'package:fitness_admin/screens/schedule_list.dart';
import 'package:fitness_admin/screens/user_details_screens.dart';
import 'package:fitness_admin/screens/user_list.dart';
import 'package:fitness_admin/widgets/master_screens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomeAuthenticated extends StatelessWidget {
  const HomeAuthenticated({Key? key}) : super(key: key);

  @override
 Widget build(BuildContext context) {
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
        // Pozadina
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/PozdainaD.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Zatamnjeni div preko pozadine
        Container(
          color: Color.fromRGBO(0, 0, 0, 0.6),
        ),
        // Logo u gornjem lijevom kutu
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
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
        ),
        // Nova dugmad vodoravno centrirana
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Prvi red sa tri dugmeta
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AddUser(),
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
                  SizedBox(width: 100), // Razmak između dugmadi
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
                  SizedBox(width: 100), // Razmak između dugmadi
                  ElevatedButton(
                    onPressed: () {
                      // Dodajte funkcionalnost za dodavanje novosti
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
              SizedBox(height: 100), // Razmak između redova dugmadi
              // Drugi red sa tri dugmeta
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Dodajte funkcionalnost za pregled novosti
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
                  SizedBox(width: 100), // Razmak između dugmadi
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ScheduleListScrean(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Pregled rezervacija",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(width: 100), // Razmak između dugmadi
                  ElevatedButton(
                    onPressed: () {
                      // Dodajte funkcionalnost za pregled plaćanja
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Pregled plaćanja",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
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
