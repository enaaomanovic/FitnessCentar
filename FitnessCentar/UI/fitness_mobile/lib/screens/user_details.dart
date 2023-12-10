import 'package:fitness_mobile/models/korisnici.dart';
import 'package:fitness_mobile/models/search_result.dart';
import 'package:fitness_mobile/providers/progress_provider.dart';
import 'package:fitness_mobile/providers/user_provider.dart';
import 'package:fitness_mobile/screens/home_authenticated.dart';
import 'package:fitness_mobile/screens/news_list.dart';
import 'package:fitness_mobile/screens/trainer_list.dart';
import 'package:fitness_mobile/utils/utils.dart';
import 'package:fitness_mobile/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MobileUserDetailScreen extends StatefulWidget {
  int? userId;
  MobileUserDetailScreen({Key? key, this.userId}) : super(key: key);
  @override
  _MobileUserDetailScreenState createState() => _MobileUserDetailScreenState();
}

class _MobileUserDetailScreenState extends State<MobileUserDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  Image? userImage;
  SearchResult<Korisnici>? result;
    bool isLoading = true;

  late UserProvider _userProvider;
  late ProgressProvider _progressProvider;

  Future<Korisnici?> getKorisnikFromId(int userId) async {
    final korisnik = await _userProvider.getById(userId);
    return korisnik;
  }

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _progressProvider=context.read<ProgressProvider>();
    _loadUserData();
   
  }
  
  void _loadUserData() async {
    try {
      // Dobavi korisnika na osnovu userId-a
      Korisnici? korisnik = await getKorisnikFromId(widget.userId ?? 0);
         

      if (korisnik != null) {
        // Ako korisnik ima sliku, postavi userImage
        if (korisnik.slika != null && korisnik.slika!.isNotEmpty) {
          userImage = imageFromBase64String(korisnik.slika!);
        } else {
          // Ako korisnik nema sliku, postavi zamensku sliku
          userImage = Image.asset('assets/images/male_icon.jpg');
        }
DateFormat dateFormat = DateFormat('yyyy-MM-dd');
        // Postavi vrednosti u _initialValue
        setState(() {
           isLoading = false;
          _initialValue = {
            'ime': korisnik.ime,
            'prezime': korisnik.prezime,
            'korisnickoIme': korisnik.korisnickoIme,
            'datumRegistracije': dateFormat.format(korisnik.datumRegistracije!),
            'datumRodjenja': dateFormat.format(korisnik.datumRodjenja!),

            'pol': korisnik.pol,
            'telefon': korisnik.telefon,
            'tezina': '${korisnik.tezina} kg',
            'visina': '${korisnik.visina} cm',
            'email': korisnik.email,
            'slika': korisnik.slika,
          };
          
        });
      }
    } catch (e) {
      // Handluj greške, na primer, prikaži dijalog sa porukom o grešci
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Greška"),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }
  
 @override
Widget build(BuildContext context) {
  return MasterScreanWidget(
    child: Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: Column(
                    children: [
                      // ... Ostatak koda ...
                      Center(
                        child: isLoading
                            ? Container()
                            : _addForm(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _buildBottomNavigationBar(context),
        ),
      ],
    ),
    title: "Profil",
  );
}

  Widget _addForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
       Padding(
  padding: EdgeInsets.all(5.0),
  child: Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle, // Da biste postavili oblik na krug
      border: Border.all(
        color: Colors.purpleAccent, // Boja granice
        width: 4.0, // Debljina granice
      ),
    ),
    child: Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 130.0, // Maksimalna širina
          maxHeight: 130.0, // Maksimalna visina
        ),
        child: ClipOval(
          child: userImage != null
              ? Container(
                  width: 130,
                  height: 130.0,
                  decoration: BoxDecoration(),
                  child: Image(
                    image: userImage!.image,
                    width: 130.0,
                    height: 130.0,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  width: 130.0,
                  height: 130.0,
                  decoration: BoxDecoration(),
                  child: Image.asset('assets/images/male_icon.jpg'),
                ),
        ),
      ),
    ),
  ),
),

          
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SizedBox(
              width: 350,
              height: 900,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  
                    Row(
                      children: [
                         Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Ime',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(
                                  color: Colors.purpleAccent,
                                  width: 2.0,
                                ),
                              ),


                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            name: "ime",
                            enabled: false,
                          ),

                        ),
                        SizedBox(height: 80),
                      ],
                    ),
                    
                    Row(
                      children: [
                        
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: "Prezime",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.purple,
                                  width: 2.0,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            name: "prezime",
                            enabled: false,
                          ),
                        ),
                        SizedBox(height: 80),

                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 15,
                              color: const Color.fromARGB(255, 14, 11, 11),
                            ),
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.purple,
                                  width: 2.0,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            name: "email",
                            enabled: false,
                          ),
                        ),
                        SizedBox(height: 80),

                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: "Telefon",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.purple,
                                  width: 2.0,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            name: "telefon",
                            enabled: false,
                          ),
                        ),
                        SizedBox(height: 80),

                      ],
                    ),
                  
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: "Datum rodjenja",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.purple,
                                  width: 2.0,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            name: "datumRodjenja",
                            enabled: false,
                          ),
                        ),
                        SizedBox(height: 80),

                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: "Datum registracije",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.purple,
                                  width: 2.0,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            name: "datumRegistracije",
                            enabled: false,
                          ),
                        ),
                        SizedBox(height: 80),

                      ],
                    ),

                    
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: "Korisnicko ime",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.purple,
                                  width: 2.0,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            name: "korisnickoIme",
                            enabled: false,
                          ),
                        ),
                        SizedBox(height: 80),

                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: "Pol",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.purple,
                                  width: 2.0,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            name: "pol",
                            enabled: false,
                          ),
                        ),
                        SizedBox(height: 80),

                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: "Visina",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.purple,
                                  width: 2.0,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            name: "visina",
                            enabled: false,
                          ),
                        ),
                        SizedBox(height: 80),

                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: "Tezina",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.purple,
                                  width: 2.0,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            name: "tezina",
                            enabled: false,
                          ),
                        ),
                        SizedBox(height: 80),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      
    );
  }




Widget _buildBottomNavigationBar(BuildContext context) {
  var userProvider = Provider.of<UserProvider>(context, listen: false);
    int? trenutniKorisnikId = _userProvider.currentUserId;
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
            Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomeAuthenticated(
                    userId: trenutniKorisnikId,
                    userProvider: _userProvider,
                    progressProvider: _progressProvider,
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
            // Navigacija na Pretraga stranicu
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
           Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MobileUserDetailScreen(
                    userId: trenutniKorisnikId,
                  ),
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
