import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Metode login
  Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Metode registrasi
  Future<bool> regis(String email, String password, String name) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await authResult.user!.updateProfile(displayName: name);
      // Jika registrasi berhasil, simpan informasi pengguna di sini
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Metode mendapatkan informasi pengguna yang sudah login
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  // Metode logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
