import 'package:flutter/material.dart';
import 'package:aplikasi_kfc/Login.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationSize;
  late Animation<double> _animationOffset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animationSize = Tween<double>(
      begin: 200.0,
      end: 400.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _animationOffset = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Mulai animasi saat halaman pertama kali ditampilkan
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 139, 23, 23),
        centerTitle: true,
        title: Text("KFC", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return AnimatedContainer(
                    duration: Duration(seconds: 1),
                    width: _animationSize.value,
                    height: _animationSize.value,
                    child: Image.asset('assets/logo.jpg'), // Ganti dengan gambar Anda.
                  );
                },
              ),
              SizedBox(height: _animationOffset.value),
              Text(
                'WELCOME TO KFC',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 600 ? 36 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Tambahkan logika untuk pergi ke halaman home atau halaman berikutnya
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 139, 23, 23),
                ),
                child: Text('Masuk'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
