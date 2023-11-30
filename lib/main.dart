import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kelompok_c2/Login.dart';
import 'package:kelompok_c2/MainPage.dart';
import 'package:kelompok_c2/firebase_options.dart';


Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),  routes: {
        '/home': (context) => const MainPage(),
        '/login' : (context) => Login(),
      },
      home: const Login(),
    );
  }
}
