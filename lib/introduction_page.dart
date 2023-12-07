import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:aplikasi_kfc/welcome_page.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  ThemeData darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  primaryColor: Color.fromARGB(255, 15, 0, 15),
  scaffoldBackgroundColor: Color.fromARGB(255, 15, 0, 15),
  colorScheme: ColorScheme.dark(
    primary: Color.fromARGB(255, 15, 0, 15),
    secondary: Color.fromARGB(255, 170, 14, 47),
  ),
);


    return MaterialApp(
      theme: darkTheme, // Terapkan Dark Theme ke aplikasi
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 15, 0, 15),
          centerTitle: true,
          title: Text("KFC", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: IntroductionScreen(
          showNextButton: true, // Menampilkan tombol "Next"
  showDoneButton: true, // Menampilkan tombol "Finished"
  next: const Text("Next", style: TextStyle(color: Colors.white)), // Atur teks "Next" dengan warna putih
  done: const Text("Finished", style: TextStyle(color: Colors.white)), // Atur teks "Finished" dengan warna putih
          onDone: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return WelcomePage();
                },
              ),
            );
          },
        pages: [
          PageViewModel(
            title: "Pengertian",
            body:
                "KFC bermula dari sebuah stasiun pengisian bensin di Kentucky, tempat Colonel Sanders memasak dan menjual ayam goreng dengan resep khasnya. Kesuksesan awalnya membuatnya membuka restoran pertamanya pada tahun 1930",
            image: Image.asset(
              '../assets/promosi.jpg',
            ),
          ),
          PageViewModel(
            title: "Tujuan aplikasi KFC",
            body: "Model bisnis KFC yang berbasis pada sistem franchise memungkinkan pertumbuhan dan ekspansi global yang cepat. Ini mencakup kerjasama dengan pengusaha lokal untuk membuka dan mengelola restoran. ",
            image: Image.asset(
              '../assets/promosi2.jpg',
            ),
          ),
          PageViewModel(
            title: "Promosi",
            body: "Menyediakan produk dan layanan yang memenuhi atau melebihi harapan pelanggan, menciptakan pengalaman positif, dan membangun loyalitas pelanggan  .",
            image: Image.asset(
              '../assets/promosi3.jpg',
            ),
          ),
          ],
        ),
      ),
    );
  }
}
