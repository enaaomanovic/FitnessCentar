import 'dart:convert';
import 'package:fitness_mobile/models/paymentIntent.dart'
    as model_payment_intent;
import 'package:fitness_mobile/providers/pay_provider.dart';
import 'package:fitness_mobile/providers/progress_provider.dart';
import 'package:fitness_mobile/providers/user_provider.dart';
import 'package:fitness_mobile/providers/paymentIntent_provider.dart';
import 'package:fitness_mobile/screens/home_authenticated.dart';
import 'package:fitness_mobile/widgets/master_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
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
  late ProgressProvider _progressProvider;

  model_payment_intent.PaymentIntent? paymentIntent;
  calculateAmount(double amount) {
    final calculatedAmount = amount.toInt() * 100;
    return calculatedAmount.toString();
  }

  createPaymentIntent(double amount) async {
    try {
      var request = {
        "amount": calculateAmount(amount),
      };

      return await _paymentIntentProvider.createPaymentIntent(request);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<void> makePayment(double Amount) async {
 
    try {
      paymentIntent = await createPaymentIntent(Amount);
 

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!.clientSecret,
            style: ThemeMode.light,
            merchantDisplayName: 'FitnessCentar',
            billingDetails: const BillingDetails(
              address: Address(
                country: 'BA',
                city: '',
                line1: '',
                line2: '',
                state: '',
                postalCode: '',
              ),
            ),
          ))
          .then((value) {});
   

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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomeAuthenticated(
                userId: trenutniKorisnikId,
                userProvider: userProvider,
                progressProvider: _progressProvider,
              ),
            ),
          );
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
    _paymentIntentProvider = context.read<PaymentIntentProvider>();
    _progressProvider = context.read<ProgressProvider>();
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
                          await makePayment(widget.amountToPay);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                        child: Text(
                          "Plati",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                        child: Text(
                          "Nazad",
                          style: TextStyle(fontSize: 18),
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
