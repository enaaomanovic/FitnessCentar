import 'package:fitness_mobile/models/korisnici.dart';
import 'package:fitness_mobile/models/search_result.dart';
import 'package:fitness_mobile/providers/user_provider.dart';
import 'package:fitness_mobile/utils/utils.dart';
import 'package:fitness_mobile/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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

  Future<Korisnici?> getKorisnikFromId(int userId) async {
    final korisnik = await _userProvider.getById(userId);
    return korisnik;
  }

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
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

        // Postavi vrednosti u _initialValue
        setState(() {
           isLoading = false;
          _initialValue = {
            'ime': korisnik?.ime,
            'prezime': korisnik.prezime,
            'korisnickoIme': korisnik.korisnickoIme,
            'datumRegistracije': korisnik.datumRegistracije.toString(),
            'datumRodjenja': korisnik.datumRodjenja.toString(),
            'pol': korisnik.pol,
            'telefon': korisnik.telefon,
            'tezina': korisnik.tezina.toString(),
            'visina': korisnik.visina.toString(),
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
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
           child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              children: [
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
      title: "User",
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
            padding: EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(),
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
                            decoration: BoxDecoration(
                             
                            ),
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
              height: 700,
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
                            decoration: InputDecoration(
                              labelText: "Ime",
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
                            name: "ime",
                            enabled: false,
                          ),

                        ),
                        SizedBox(height: 70),
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
}
