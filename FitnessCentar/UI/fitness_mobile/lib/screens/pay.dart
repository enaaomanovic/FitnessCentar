import 'dart:convert';

import 'package:fitness_mobile/models/komentari.dart';
import 'package:fitness_mobile/models/korisnici.dart';
import 'package:fitness_mobile/models/paymentIntent.dart' as model_payment_intent;
import 'package:fitness_mobile/providers/pay_provider.dart';
import 'package:fitness_mobile/providers/user_provider.dart';
import 'package:fitness_mobile/providers/paymentIntent_provider.dart';
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
  const PayScreen({Key? key, required this.amountToPay}) : super(key: key);

  @override
  _PayScreen createState() => _PayScreen();
}

class _PayScreen extends State<PayScreen> {
  late PayProvider _payProvider;
  late PaymentIntentProvider _paymentIntentProvider;

  model_payment_intent.PaymentIntent? paymentIntent;
  calculateAmount(double amount) {
    final calculatedAmount = amount.toInt() * 100;
    return calculatedAmount.toString();
  }



  createPaymentIntent(double amount) async {
    try {
      var request={
        "amount":calculateAmount(amount),
      };
      
      return await _paymentIntentProvider.createPaymentIntent(request);
    
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<void> makePayment(double Amount) async {
    print("uslo");
    try {
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent(Amount);
  print("Ovdje $paymentIntent");
      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!.clientSecret, //Gotten from payment intent
                  style: ThemeMode.light,
                  merchantDisplayName: 'FitnessCentar', billingDetails: const BillingDetails(
          address: Address(
            country: 'BA',
            city: '',
            line1: '',
            line2: '',
            state: '',
            postalCode: '',
          ),
        ),))
          .then((value) {});
      print("printalo $paymentIntent");

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    int? trenutniKorisnikId = userProvider.currentUserId;
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
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

        if (trenutniKorisnikId != null) {
          
          
              var request = <String, dynamic>{
                'korisnikId': trenutniKorisnikId,
                'datumPlacanja': DateTime.now().toIso8601String(),
                'iznos': widget.amountToPay,
                'paymentIntentId': paymentIntent!.id,
                
              };
            
              await _payProvider.insert(request);
          
        }
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
    _payProvider = context.read<PayProvider>();
    _paymentIntentProvider=context.read<PaymentIntentProvider>();
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          // Dodajte logiku koja se izvršava kada se pritisne dugme "Plati"
                          // Na primjer, možete dodati navigaciju na stranicu za plaćanje
                          await makePayment(widget.amountToPay);
                          // ili izvršiti odgovarajuće akcije vezane za plaćanje.
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical:
                                  15), // Prilagodite veličinu dugmeta prema potrebi
                        ),
                        child: Text(
                          "Plati",
                          style: TextStyle(
                              fontSize:
                                  18), // Prilagodite veličinu teksta dugmeta prema potrebi
                        ),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical:
                                  15), // Prilagodite veličinu dugmeta prema potrebi
                        ),
                        child: Text(
                          "Nazad",
                          style: TextStyle(
                              fontSize:
                                  18), // Prilagodite veličinu teksta dugmeta prema potrebi
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
