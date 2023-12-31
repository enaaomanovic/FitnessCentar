import 'package:fitness_admin/providers/active_provider.dart';
import 'package:fitness_admin/providers/comment_provider.dart';
import 'package:fitness_admin/providers/news_provider.dart';
import 'package:fitness_admin/providers/pay_provider.dart';
import 'package:fitness_admin/providers/progress_provider.dart';
import 'package:fitness_admin/providers/replyToComment_provider.dart';
import 'package:fitness_admin/providers/reservation_provider.dart';
import 'package:fitness_admin/providers/schedule_provider.dart';
import 'package:fitness_admin/providers/trainer_provider.dart';
import 'package:fitness_admin/providers/user_provider.dart';
import 'package:fitness_admin/providers/workout_provider.dart';
import 'package:fitness_admin/screens/home_unauthenticated.dart';
import 'package:fitness_admin/utils/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => NewsProvider()),
    ChangeNotifierProvider(create: (_)=>ScheduleProvider()),
    ChangeNotifierProvider(create: (_)=>WorkoutProvider()),
    ChangeNotifierProvider(create: (_)=>ActiveProvider()),
    ChangeNotifierProvider(create: (_)=>ReservationProvider()),
    ChangeNotifierProvider(create: (_)=>CommentProvider()),
    ChangeNotifierProvider(create: (_)=>ReplyToCommentProvider()),
    ChangeNotifierProvider(create: (_)=>ProgressProvider()),
    ChangeNotifierProvider(create: (_)=>PayProvider()),
    ChangeNotifierProvider(create: (_)=>TrainerProvider())],
    


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

