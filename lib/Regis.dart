import 'package:aplikasi_kfc/Auth.dart';
import 'Login.dart';
import 'package:flutter/material.dart';

class Regis extends StatefulWidget {
  const Regis({Key? key}) : super(key: key);

  @override
  State<Regis> createState() => _RegisState();
}

class _RegisState extends State<Regis> {
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  final TextEditingController _ctrlName = TextEditingController(); // Tambahkan controller untuk nama

  Future<void> _showDialog(String title, String content) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _ctrlEmail.value.text;
    final password = _ctrlPassword.value.text;
    final name = _ctrlName.value.text; // Dapatkan nama dari controller

    setState(() => _loading = true);

    // Call your registration method, assuming it returns a boolean indicating success
    bool registrationSuccess = await Auth().regis(email, password, name);

    setState(() => _loading = false);

    if (registrationSuccess) {
      // Registration successful, show success dialog
      _showDialog('Pendaftaran Berhasil', 'Sekarang Anda dapat masuk dengan akun Anda.');
      // Navigate to the login screen
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      // Registration failed, show error dialog
      _showDialog('Pendaftaran Gagal', 'Akun sudah ada atau pendaftaran gagal. Silakan coba lagi.');
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
                  "Register",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _ctrlName, // Tambahkan field nama
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan Masukkan Nama Lengkap Anda';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nama',
                  ),
                ),
                SizedBox(height: 10),
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
                  foregroundColor: const Color.fromARGB(255, 0, 0, 0),
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
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 139, 23, 23),
                ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text("Sudah Punya Akun? Klik Disini Untuk Login"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
