import 'package:fitness_admin/models/korisnici.dart';
import 'package:fitness_admin/models/napredak.dart';
import 'package:fitness_admin/models/napredakreport.dart';
import 'package:fitness_admin/models/placanja.dart';
import 'package:fitness_admin/models/raspored.dart';
import 'package:fitness_admin/models/report.dart';
import 'package:fitness_admin/models/rezervacija.dart';
import 'package:fitness_admin/models/search_result.dart';
import 'package:fitness_admin/models/trening.dart';
import 'package:fitness_admin/providers/pay_provider.dart';
import 'package:fitness_admin/providers/progress_provider.dart';
import 'package:fitness_admin/providers/reservation_provider.dart';
import 'package:fitness_admin/providers/schedule_provider.dart';
import 'package:fitness_admin/providers/workout_provider.dart';
import 'package:fitness_admin/screens/pdfnapredakport/pdfnapredak/pdfnapredakport.dart';
import 'package:fitness_admin/utils/util.dart';
import 'package:fitness_admin/widgets/master_screens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class UserDetalScreen extends StatefulWidget {
  Korisnici? korisnik;
  UserDetalScreen({Key? key, this.korisnik}) : super(key: key);

  @override
  State<UserDetalScreen> createState() => _UserDetalScreenState();
}

class _UserDetalScreenState extends State<UserDetalScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  Image? userImage;
  late ReservationProvider _reservationProvider;
  late ScheduleProvider _scheduleProvider;
  late WorkoutProvider _workoutProvider;
  late ProgressProvider _progressProvider;
  late PayProvider _payProvider;
  List<Napredak>? userProgress;
  bool isLoading = true;
  List<double>? tezineList=[];
  List<DateTime>? datumiList=[];



  @override
  void initState() {
     DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    // TODO: implement initState
    super.initState();
    if ((widget.korisnik?.slika != null &&
        widget.korisnik!.slika!.isNotEmpty)) {
      userImage = imageFromBase64String(widget.korisnik!.slika!);
      _initialValue = {
        'ime': widget.korisnik?.ime,
        'prezime': widget.korisnik?.prezime,
        'korisnickoIme': widget.korisnik?.korisnickoIme,
      'datumRegistracije': dateFormat.format(widget.korisnik!.datumRegistracije!),
            'datumRodjenja': dateFormat.format(widget.korisnik!.datumRodjenja!),
        "pol": widget.korisnik?.pol,
        "telefon": widget.korisnik?.telefon,
        "tezina": widget.korisnik?.tezina.toString(),
        "visina": widget.korisnik?.visina.toString(),
        "email": widget.korisnik?.email,
        "slika": widget.korisnik?.slika
      };
    } else {
      userImage = Image.asset('assets/images/male_icon.jpg');
      _initialValue = {
        'ime': widget.korisnik?.ime,
        'prezime': widget.korisnik?.prezime,
        'korisnickoIme': widget.korisnik?.korisnickoIme,
        'datumRegistracije':
            dateFormat.format(widget.korisnik!.datumRegistracije!),
        'datumRodjenja': dateFormat.format(widget.korisnik!.datumRodjenja!),
        "pol": widget.korisnik?.pol,
        "telefon": widget.korisnik?.telefon,
        "tezina": widget.korisnik?.tezina.toString(),
        "visina": widget.korisnik?.visina.toString(),
        "email": widget.korisnik?.email,
        "slika": widget.korisnik?.slika
      };
    }
    _workoutProvider = context.read<WorkoutProvider>();
    _reservationProvider = context.read<ReservationProvider>();
    _scheduleProvider = context.read<ScheduleProvider>();
    _progressProvider = context.read<ProgressProvider>();
    _payProvider = context.read<PayProvider>();
    initForm();
    _loadData();
    _loadProgressForReport();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<List<Placanja?>> GetPlacanja(int korisnikId) async {
    var searchResult =
        await _payProvider.get(filter: {"korisnikId": korisnikId});

    if (searchResult != null && searchResult.result.isNotEmpty) {
      List<Placanja> data = searchResult.result;

      return data;
    }
    return [];
  }

  Future initForm() async {
    setState(() {
      isLoading = false;
    });
  }

  Future<List<Rezervacija?>> GetRezervacije(int korisnikId) async {
    var searchResult = await _reservationProvider
        .get(filter: {"korisnikId": korisnikId, "status": "Plaćena"});
    if (searchResult != null && searchResult.result.isNotEmpty) {
      List<Rezervacija> data = searchResult.result;
      return data;
    }
    return [];
  }

  Future<List<Rezervacija>> RealRezervacije(int korisnikId) async {
    var placanja = await GetPlacanja(korisnikId);
    var rezervacije = await GetRezervacije(korisnikId);

    List<Rezervacija> validneRezervacije = [];

    if (placanja != null && rezervacije != null) {
      for (var placanje in placanja) {
        for (var rezervacija in rezervacije) {
          if (rezervacija?.placanjeId == placanje?.id) {
            DateTime? datumPlacanja = placanje?.datumPlacanja;
            DateTime trenutniDatum = DateTime.now();
            Duration razlika = trenutniDatum.difference(datumPlacanja!);

            if (razlika.inDays <= 30) {
              validneRezervacije.add(rezervacija!);
            }
          }
        }
      }
    }

    return validneRezervacije;
  }

  void _loadData() async {
    final korisnikid = widget.korisnik!.id;
    var data = await _reservationProvider.get(filter: {
      'korisnikId': korisnikid.toString(),
      'status': "Placena",
    });
  }

  Future<void> _loadProgress() async {
    final korisnikid = widget.korisnik!.id;
    var data = await _progressProvider.get(filter: {
      'korisnikId': korisnikid.toString(),
    });

    setState(() {
      userProgress = data.result;
    });
  }

Future<void> _loadProgressForReport() async {

  final korisnikid = widget.korisnik!.id;
  var data = await _progressProvider.get(filter: {
    'korisnikId': korisnikid.toString(),
  });

  if (data != null && data.result.isNotEmpty) {
    List<double> tezine = [];
    List<DateTime> datumiMjerenja = [];

    for (var progress in data.result) {
   

      // Dodajte provjeru za null datume
      if (progress.tezina != null && progress.datumMjerenja != null) {
        tezine.add(progress.tezina!);
        datumiMjerenja.add(progress.datumMjerenja!);
      }
    }

    setState(() {
      tezineList = tezine;
      datumiList = datumiMjerenja;
    });
  }
}



  Widget _buildResultMessage(double currentWeight, double initialWeight) {
    String resultMessage = '';
    if (userProgress == null || userProgress!.isEmpty) {
      resultMessage = 'Nije došlo do promjene u težini.';
    } else {
      double result = currentWeight - initialWeight;

      if (result > 0) {
        resultMessage = 'Korisnik se udebljao za ${result.abs()} kg!';
      } else if (result < 0) {
        resultMessage = 'Korisnik je smršao za  ${result.abs()} kg!';
      }
    }

    return Text(
      'Rezultat: $resultMessage',
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Future<Raspored?> getRasporedFromId(int rasporedId) async {
    final raspored = await _scheduleProvider.getById(rasporedId);
    return raspored;
  }

  String _dayOfWeekToString(int dan) {
    switch (dan) {
      case 0:
        return 'Ned';
      case 1:
        return 'Ponedjeljak';
      case 2:
        return 'Utorak';
      case 3:
        return 'Srijeda';
      case 4:
        return 'Červrtak';
      case 5:
        return 'Petak';

      default:
        return '';
    }
  }

  Future<Trening?> getTreningFromId(int treningId) async {
    final trening = await _workoutProvider.getById(treningId);

    return trening;
  }

  Future<void> _showReservationPopup(BuildContext context) async {
    List<Rezervacija> userReservations =
        await RealRezervacije(widget.korisnik?.id ?? 0);

    final List<Widget> listTiles = [];

    if (userReservations != null && userReservations.isNotEmpty) {
      await Future.forEach(userReservations, (userReservation) async {
        final raspored =
            await getRasporedFromId(userReservation.rasporedId ?? 0);
        final trening = await getTreningFromId(raspored?.treningId ?? 0);

        final satnicaOd =
            DateFormat.Hm().format(raspored?.datumPocetka ?? DateTime.now());
        final satnicaDo =
            DateFormat.Hm().format(raspored?.datumZavrsetka ?? DateTime.now());

        final dan = _dayOfWeekToString(raspored?.dan ?? 0);

        listTiles.add(
          ListTile(
            title: Text('Trening: ${trening?.naziv}'),
            subtitle: Text('Dan: $dan, Satnica: $satnicaOd - $satnicaDo'),
          ),
        );

        listTiles.add(Divider());
      });
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 400,
            height: 400,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Korisnik je rezervisao sljedeće termine',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.purple),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  if (listTiles.isNotEmpty) ...listTiles,
                  if (userReservations == null || userReservations.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Korisnik još uvijek nema rezervacija.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showNapredakPopup(BuildContext context) async {
    await _loadProgress();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 400,
            height: 400,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Napredak korisnika',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.purple),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  if (widget.korisnik?.tezina != null)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 2.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Težina pri registraciji',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${widget.korisnik!.tezina} kg',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  if (userProgress != null && userProgress!.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 2.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Trenutna težina',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${userProgress!.last.tezina} kg',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  if (userProgress != null && userProgress!.isNotEmpty) ...[
                    SizedBox(height: 16),
                    _buildResultMessage(
                      userProgress!.last.tezina ?? 0,
                      widget.korisnik?.tezina ?? 0,
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreanWidget(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            child: Column(
              children: [
                isLoading ? Container() : _buildForm(),
                _buildButton()
              ],
            ),
          ),
        ),
      ),
      title: (this.widget.korisnik?.ime ?? "") +
          "  " +
          (this.widget.korisnik?.prezime ?? "Users Details"),
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(40.0),
            child: Container(
              decoration: BoxDecoration(),
              child: Align(
                alignment: Alignment.topLeft,
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 400.0,
                      maxHeight: 520.0,
                    ),
                    child: ClipRect(
                      child: userImage != null
                          ? Container(
                              width: 400.0,
                              height: 500.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.purple,
                                  width: 4.0,
                                ),
                              ),
                              child: Image(
                                image: userImage!.image,
                                width: 400.0,
                                height: 400.0,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: 400.0,
                              height: 400.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.purple,
                                  width: 2.0,
                                ),
                              ),
                              child: Image.asset('assets/images/male_icon.jpg'),
                            ),
                    )),
              ),
            ),
          ),
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SizedBox(
              width: 900,
              height: 520,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 20,
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
                                fontSize: 25,
                              ),
                            ),
                            name: "ime",
                            enabled: false,
                          ),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 20,
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
                                fontSize: 25,
                              ),
                            ),
                            name: "prezime",
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
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
                                fontSize: 25,
                              ),
                            ),
                            name: "email",
                            enabled: false,
                          ),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 20,
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
                                fontSize: 25,
                              ),
                            ),
                            name: "telefon",
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 20,
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
                                fontSize: 25,
                              ),
                            ),
                            name: "datumRodjenja",
                            enabled: false,
                          ),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 20,
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
                                fontSize: 25,
                              ),
                            ),
                            name: "datumRegistracije",
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 20,
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
                                fontSize: 25,
                              ),
                            ),
                            name: "korisnickoIme",
                            enabled: false,
                          ),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 20,
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
                                fontSize: 25,
                              ),
                            ),
                            name: "pol",
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 20,
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
                                fontSize: 25,
                              ),
                            ),
                            name: "visina",
                            enabled: false,
                          ),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: FormBuilderTextField(
                            style: TextStyle(
                              fontSize: 20,
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
                                fontSize: 25,
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
          )
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showNapredakPopup(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                "Napredak korisnika",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                _showReservationPopup(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                "Rezervacije korisnika",
                style: TextStyle(fontSize: 18),
              ),
            ), SizedBox(width: 20),
               ElevatedButton(
              onPressed: () async {
                await _loadProgressForReport();
                List<double>? tezine = tezineList;
                List<DateTime>? datumiMjerenja = datumiList;

                NapredakReport napredakReport = NapredakReport(
                  tezine: tezine,
                  datumiMjerenja: datumiMjerenja,
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ExportSparkChart(
                      invoice: napredakReport,
                    ),
                  ),
                );
              
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                "Izvještaj o napretku korisnika",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
      ],
    );
  }
}
