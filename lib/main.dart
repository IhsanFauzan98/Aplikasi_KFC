import 'package:aplikasi_kfc/Input_aplikasi_kfc_page.dart';
import 'package:aplikasi_kfc/firebase_options.dart';
import 'package:aplikasi_kfc/provider/setting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_kfc/Login.dart';
import 'package:aplikasi_kfc/home_page.dart';
import 'package:aplikasi_kfc/introduction_page.dart';
import 'package:aplikasi_kfc/crud.dart';
import 'package:aplikasi_kfc/welcome_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeModeData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeModeData(),
        ),
      ],
      child: Builder(builder: (ctx) {
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  useMaterial3: true,
                  brightness: Brightness.light,
                  textTheme: const TextTheme(
                    headlineLarge: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontFamily: "Serif",
                    ),
                    bodyLarge: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                darkTheme: ThemeData(
                  useMaterial3: false,
                  brightness: Brightness.dark,
                  textTheme: const TextTheme(
                    headlineLarge: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontFamily: "Serif",
                    ),
                    bodyLarge: TextStyle(color: Colors.grey),
                  ),
                ),
                themeMode: Provider.of<ThemeModeData>(ctx).themeMode,
                home: const home_page(),
                routes: {

         '/home': (context) => const home_page(),
        '/intro' : (context) => const IntroductionPage(),
        '/login' : (context) => const Login(),
        '/welcome':(context) => WelcomePage(),
        '/input' : (context) => Input_aplikasi_kfc(),
        '/data' : (context) => CrudPage(),
          
      },
                  
      initialRoute: '/intro',
    );
            } else {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                home: Login(),
              );
               }
          },
        );
      }),
    );
  }
}
