import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Edit.dart';

import 'Cart.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                decoration:
                    const BoxDecoration(color: Color.fromARGB(255, 195, 36, 36)),
                child: Image.asset('assets/Logo.png'),
              ),
              ListTile(
                title: const Text("Profile"),
                leading: const Icon(Icons.person),
                onTap: () {},
              ),
              ListTile(
                title: const Text("Cart"),
                leading: const Icon(Icons.shopping_cart),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => cart(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 40, right: 30, top: 50, bottom: 70),
              child: Image.asset(
                "assets/Profile.jpg",
              ),
            ),
            Text('SIGN IN: ${user.email!}'),
            const SizedBox(height: 40),
            MaterialButton(
              height: 50,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Edit(),
                  ),
                );
              },
              color: Colors.red,
              child: const Text(
                'Edit',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              height: 50,
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: Colors.red,
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
