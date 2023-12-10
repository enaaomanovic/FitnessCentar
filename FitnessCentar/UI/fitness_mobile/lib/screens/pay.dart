
import 'dart:convert';

import 'package:fitness_mobile/models/komentari.dart';
import 'package:fitness_mobile/models/korisnici.dart';

import 'package:fitness_mobile/utils/utils.dart';
import 'package:fitness_mobile/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart' as FlutterMaterial;

class PayScreen extends StatefulWidget {
  final double amountToPay;
  const PayScreen({Key? key,required this.amountToPay}) : super(key: key);

  @override
  _PayScreen createState() => _PayScreen();
}

class _PayScreen extends State<PayScreen> {
  
  Map<String, dynamic>? paymentIntent;
  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }
  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

Future<void> makePayment(String Amount) async {
    try {
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent(Amount, 'BAM');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
            
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.light,
                  merchantDisplayName: 'Ikay'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                       Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                    ],
                  ),
                ));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }


  @override
  void initState() {
    super.initState();
 
  }
@override
Widget build(BuildContext context) {
  return MasterScreanWidget(
    title_widget: Text("Plaćanje članarine"),
    child: Column(
      children: [
        Container(
          width: 150,
          height: 150,
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.purple, width: 2),
            image: DecorationImage(
              image: AssetImage("assets/images/FitnessLogo.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: FlutterMaterial.Card(
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Uplatom rezervacije termina, rezervisali ste za sebe treninge za narednih mjesec dana. Napomena: Ne vršimo povrat novca.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Iznos koji trebate uplatiti:",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${widget.amountToPay.toString()} KM",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Dodajte logiku koja se izvršava kada se pritisne dugme "Plati"
                        // Na primjer, možete dodati navigaciju na stranicu za plaćanje
                        // ili izvršiti odgovarajuće akcije vezane za plaćanje.
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Prilagodite veličinu dugmeta prema potrebi
                      ),
                      child: Text(
                        "Plati",
                        style: TextStyle(fontSize: 18), // Prilagodite veličinu teksta dugmeta prema potrebi
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Prilagodite veličinu dugmeta prema potrebi
                      ),
                      child: Text(
                        "Nazad",
                        style: TextStyle(fontSize: 18), // Prilagodite veličinu teksta dugmeta prema potrebi
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}



}
