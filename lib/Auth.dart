import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> regis(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Registrasi berhasil, kembalikan true
      return true;
    } catch (e) {
      // Registrasi gagal, kembalikan false
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Jika berhasil login, kembalikan true
      return userCredential.user != null;
    } catch (e) {
      // Jika terjadi kesalahan atau gagal login, kembalikan false
      return false;
    }
  }
}
