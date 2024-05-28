import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/pages/home.dart';
import 'package:notes/pages/intro.dart';
import 'package:notes/pages/intropage1.dart';
import 'package:notes/pages/intropage2.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "intro",
      routes: {
        "intro":(context)=> Intro(),
        "intro1":(context)=>Intropage1(),
        "intro2":(context)=>Intropage2(),
        "home":(context)=>Home(),
        
      },
    );
  }
}