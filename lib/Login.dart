// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:aplikasi_kfc/Auth.dart';
import 'Regis.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();

  handleSubmit() async {
  if (!_formKey.currentState!.validate()) return;
  final email = _ctrlEmail.value.text;
  final password = _ctrlPassword.value.text;
  setState(() => _loading = true);

  final loginResult = await Auth().login(email, password);
  setState(() => _loading = false);

  if (loginResult) {
    Navigator.pushReplacementNamed(context, '/home');
  } else {
    // Jika gagal login, tampilkan pesan dan arahkan untuk mendaftar
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Gagal'),
          content: Text('Password atau Akun yang Anda masukkan salah. Silakan coba lagi.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Kosongkan field password
                _ctrlPassword.clear();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(               
                  controller: _ctrlEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan Masukkan Email Anda';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _ctrlPassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan Masukkan Password Anda';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 139, 23, 23),
                ),
                  onPressed: () => handleSubmit(),
  
                  child: _loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                          ),
                        )
                      : Text("Submit"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                ),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Regis()));
                  },
                  child: Text(
                      "Belum Punya Akun? Klik Disini Untuk Register" ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
