import 'package:aplikasi_kfc/provider/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_kfc/Auth.dart';
import 'package:provider/provider.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<home_page> {
  String? _userName;
  String? _userEmail;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    // Panggil metode untuk mengambil informasi pengguna saat aplikasi dimulai
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    final user = await Auth().getCurrentUser();
    if (user != null) {
      setState(() {
        _userName = user.displayName;
        _userEmail = user.email;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan informasi tentang ukuran layar menggunakan MediaQuery
    final Size screenSize = MediaQuery.of(context).size;
     final themeModeData = Provider.of<ThemeModeData>(context);

    return Scaffold(
      appBar: AppBar(
        // centerTitle: false,
        backgroundColor: Color.fromARGB(255, 139, 23, 23),
        centerTitle: true,
        title: Text("KFC", style: TextStyle(fontWeight: FontWeight.bold)),
         actions: [
          IconButton(
            icon: Icon(
              themeModeData.isDarkModeActive
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              themeModeData.changeTheme(
                themeModeData.isDarkModeActive
                    ? ThemeMode.light
                    : ThemeMode.dark,
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 139, 23, 23),
              ),
              accountName: Text(_userName ?? 'Nama Pengguna'),
              accountEmail: Text(_userEmail ?? 'Email Pengguna'),
            ),
            Spacer(),
            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
              ),
              title: Text("LogOut"),
              onTap: () {
                Auth().logout();
                Navigator.pushNamed(context, '/login');
              },     
            ),
            
          ],
        ),
      ),

      //PROMOSI 1
      body: ListView(
        children: [
          Container(
            width: screenSize.width, // Lebar container mengikuti lebar layar
            height: screenSize.height *
                0.5, // Tinggi container mengikuti tinggi layar
            margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
            child: Image.asset(
              'assets/promosi.jpg',
              fit: BoxFit.cover,
            ),
          ),

          //PRODUK
          GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            children: [
              // Produk 1
              Container(
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.2,
                margin: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/SuperStar.png',
                ),
              ),

              // Produk 2
              Container(
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.2,
                margin: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/Chikken.png',
                  width: 50, // Lebar
                  height: 50, // Tinggi
                ),
              ),
              // Produk 3
              Container(
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.2,
                margin: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/DonSeries.png',
                  width: 50, // Lebar
                  height: 50, // Tinggi
                ),
              ),
              // Produk 4
              Container(
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.2,
                margin: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/BucketBBQ.png',
                  width: 50, // Lebar
                  height: 50, // Tinggi
                ),
              ),
              // Produk 5
              Container(
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.2,
                margin: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/wingger.png',
                  width: 50, // Lebar
                  height: 50, // Tinggi
                ),
              ),
              // Produk 6
              Container(
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.2,
                margin: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/Burger.png',
                  width: 50, // Lebar
                  height: 50, // Tinggi
                ),
              ),
              // Produk 7
              Container(
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.2,
                margin: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/ManggoFloat.png',
                  width: 50, // Lebar
                  height: 50, // Tinggi
                ),
              ),
              // Produk 8
              Container(
                width: screenSize.width * 0.2,
                height: screenSize.height * 0.2,
                margin: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/HotTea.png',
                  width: 50, // Lebar
                  height: 50, // Tinggi
                ),
              ),
            ],
          ),
        ],
      ),

      //NAVBAR BAWAH
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 139, 23, 23),
        unselectedItemColor: Colors.white,
        selectedItemColor: Color.fromARGB(255, 0, 0, 0),
        currentIndex:
            _selectedIndex, // Gunakan variabel ini untuk menentukan item yang dipilih
        onTap: (index) {
          setState(() {
            _selectedIndex =
                index; // Perbarui indeks item yang dipilih saat salah satu item diklik
          });

          // Navigasi sesuai dengan indeks yang dipilih
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/input');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/data');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopify_outlined),
            label: "Shop",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart_outlined),
            label: "Cart",
          ),
        ],
      ),
    );
  }
}
