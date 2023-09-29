import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyMaterialApp());
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
home: LoginPage(),
    );
  }
}


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LogIn"),),
      body: 
      Center(
        child: 
        Container(
          constraints: BoxConstraints(maxHeight: 600,maxWidth: 600),
          child: Card(
            
            child:
            Padding( 
              padding:const EdgeInsets.all(16.0),
              child:
              Column(children: [
              Image.network("https://w7.pngwing.com/pngs/1021/266/png-transparent-logo-graphic-designer-fitness-purple-blue-physical-fitness.png",height: 200,width: 200,),
                 SizedBox(height: 50,),
              TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(Icons.email)
                ),
              ),
              SizedBox(height: 30,),
              TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.password)
                ),
              ),
              SizedBox(height: 15,),

              ElevatedButton(onPressed: (){

              }, child: Text("LogIn"))

                          ]),
          ),
        ),
      ),
      ),
    );
  }
}