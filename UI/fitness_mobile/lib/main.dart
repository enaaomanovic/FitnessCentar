
import 'package:fitness_mobile/providers/active_provider.dart';
import 'package:fitness_mobile/providers/comment_provider.dart';
import 'package:fitness_mobile/providers/news_provider.dart';
import 'package:fitness_mobile/providers/pay_provider.dart';
import 'package:fitness_mobile/providers/paymentIntent_provider.dart';
import 'package:fitness_mobile/providers/progress_provider.dart';
import 'package:fitness_mobile/providers/recommender_provider.dart';
import 'package:fitness_mobile/providers/replyToComment.dart';
import 'package:fitness_mobile/providers/reservation_provider.dart';
import 'package:fitness_mobile/providers/schedule_provider.dart';
import 'package:fitness_mobile/providers/seenNews_provider.dart';
import 'package:fitness_mobile/providers/trainer_provider.dart';
import 'package:fitness_mobile/providers/user_provider.dart';
import 'package:fitness_mobile/providers/workout_provider.dart';
import 'package:fitness_mobile/screens/home_unautenticated.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   Stripe.publishableKey="pk_test_51OKr40BH5DqSsJZpQniMBdQ4lW4Mysgp6kR6KBdFmmj5Cqv4CFSgc1Pq9C7KD2wwFdx0eBweBBaarnLFSoKmNVYc00qniwhZgj";
await dotenv.load(fileName:"assets/.env");

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_)=>ProgressProvider()),
      ChangeNotifierProvider(create: (_)=>NewsProvider()),
      ChangeNotifierProvider(create: (_)=>TrainerProvider()),
      ChangeNotifierProvider(create: (_)=>CommentProvider()),
      ChangeNotifierProvider(create: (_)=>ScheduleProvider()),
      ChangeNotifierProvider(create: (_)=>ActiveProvider()),
      ChangeNotifierProvider(create: (_)=>ReservationProvider()),
      ChangeNotifierProvider(create: (_)=>WorkoutProvider()),
      ChangeNotifierProvider(create: (_)=>PayProvider()),
      ChangeNotifierProvider(create: (_)=>PaymentIntentProvider()),
      ChangeNotifierProvider(create: (_)=>ReplyToCommentProvider()),
      ChangeNotifierProvider(create: (_)=>SeenNewsProvider()),
      ChangeNotifierProvider(create: (_)=>RecommenderProvider()),





    ],

   



    child: const MyMaterialApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyMaterialApp(),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RS II MatirialApp",
      theme: ThemeData(primarySwatch: Colors.purple),
      home: HomeUnauthenticated(),
    );
  }
}
