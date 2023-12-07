import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_kfc/Auth.dart';

class Input_aplikasi_kfc extends StatefulWidget {
  @override
  __Input_aplikasi_kfc createState() => __Input_aplikasi_kfc();
}

class __Input_aplikasi_kfc extends State<Input_aplikasi_kfc> {
  final TextEditingController _ctrlMenu = TextEditingController();
  final TextEditingController _ctrljumlahPembelian = TextEditingController(text: '0');
  final TextEditingController _ctrlSize = TextEditingController();
  final TextEditingController _ctrlTypeOrder = TextEditingController();
  final TextEditingController _ctrlAlamat = TextEditingController();

  int _selectedIndex = 1;
  int _jumlahPembelian = 0;
  String? _Size = '';
  String? _TypeOrder = '';
  String pilihanMenu = 'Chicken';
  String? _namaPengguna;

  @override
  void dispose() {
    _ctrlMenu.dispose();
    _ctrljumlahPembelian.dispose();
    _ctrlSize.dispose();
    _ctrlTypeOrder.dispose();
    _ctrlAlamat.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _ctrlMenu.addListener(_printLatestMenu);
    _ctrljumlahPembelian.addListener(_printLatestjumlahPembelian);
    _ctrlSize.addListener(_printLatestSize);
    _ctrlTypeOrder.addListener(_printLatestTypeOrder);
    _ctrlAlamat.addListener(_printLatestAlamat);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = await Auth().getCurrentUser();
    setState(() {
      _namaPengguna = user?.displayName;
      _ctrlMenu.text = 'Chicken';
    });
  }

  void _printLatestMenu() {
    print('Menu : ${_ctrlMenu.text}');
  }

  void _printLatestjumlahPembelian() {
  print('jumlahPembelian : $_jumlahPembelian');
}


  void _printLatestSize() {
    print('Size : ${_ctrlSize.text}');
  }

  void _printLatestTypeOrder() {
    print('TypeOrder : ${_ctrlTypeOrder.text}');
  }

  void _printLatestAlamat() {
    print('Alamat : ${_ctrlAlamat.text}');
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference dataPembeli = firestore.collection("data_pembeli");
    // Mendapatkan informasi tentang Size layar menggunakan MediaQuery
    return Scaffold(
      appBar: AppBar(
        title: Text('SHOP'),
        backgroundColor: Color.fromARGB(255, 139, 23, 23),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              TextField(
                readOnly: true,
                controller: TextEditingController(text: _namaPengguna ?? ''),
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              SizedBox(height: 16),
              Text(
                'Menu:',
                style: TextStyle(fontSize: 18),
              ),
              Row(
                children: [
                  Radio(
                    value: "Chicken",
                    groupValue: pilihanMenu,
                    onChanged: (value) {
                      setState(() {
                        pilihanMenu = value!;
                        _ctrlMenu.text = 'Chicken';
                      });
                    },
                  ),
                  Text('Chicken'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: "Burger",
                    groupValue: pilihanMenu,
                    onChanged: (value) {
                      setState(() {
                        pilihanMenu = value!;
                        _ctrlMenu.text = 'Burger';
                      });
                    },
                  ),
                  Text('Burger'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: "BucketBBQ",
                    groupValue: pilihanMenu,
                    onChanged: (value) {
                      setState(() {
                        pilihanMenu = value!;
                        _ctrlMenu.text = 'BucketBBQ';
                      });
                    },
                  ),
                  Text('BucketBBQ'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: "Wingger",
                    groupValue: pilihanMenu,
                    onChanged: (value) {
                      setState(() {
                        pilihanMenu = value!;
                        _ctrlMenu.text = 'Wingger';
                      });
                    },
                  ),
                  Text('Wingger'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: "SuperStar",
                    groupValue: pilihanMenu,
                    onChanged: (value) {
                      setState(() {
                        pilihanMenu = value!;
                        _ctrlMenu.text = 'SuperStar';
                      });
                    },
                  ),
                  Text('SuperStar'),
                ],
              ),
              SizedBox(height: 16),
              const Text('JumlahPembelian:'),
              Row(
                children: [
                   IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (_jumlahPembelian > 1) {
                        setState(() {
                          _jumlahPembelian--;
                          _ctrljumlahPembelian.text = _jumlahPembelian.toString();
                        });
                      }
                    },
                  ),
          Text(_jumlahPembelian.toString()),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _jumlahPembelian++;
                        _ctrljumlahPembelian.text = _jumlahPembelian.toString();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'TypeOrder:',
                style: TextStyle(fontSize: 18),
              ),
              Row(
                children: [
                  Radio(
                    value: 'Dine-In',
                    groupValue: _TypeOrder,
                    onChanged: (value) {
                      setState(() {
                        _TypeOrder = value as String;
                        _ctrlTypeOrder.text = _TypeOrder.toString();
                      });
                    },
                  ),
                  Text('Dine-In'),
                  Radio(
                    value: 'Take Away',
                    groupValue: _TypeOrder,
                    onChanged: (value) {
                      setState(() {
                        _TypeOrder = value as String;
                        _ctrlTypeOrder.text = _TypeOrder.toString();
                      });
                    },
                  ),
                  Text('Take-Away'),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Size:',
                style: TextStyle(fontSize: 18),
              ),
              Row(
                children: [
                  Radio(
                    value: 'Small',
                    groupValue: _Size,
                    onChanged: (value) {
                      setState(() {
                        _Size = value as String;
                        _ctrlSize.text = _Size.toString();
                      });
                    },
                  ),
                  Text('Small'),
                  Radio(
                    value: 'Medium',
                    groupValue: _Size,
                    onChanged: (value) {
                      setState(() {
                        _Size = value as String;
                        _ctrlSize.text = _Size.toString();
                      });
                    },
                  ),
                  Text('Medium'),
                  Radio(
                    value: 'Large',
                    groupValue: _Size,
                    onChanged: (value) {
                      setState(() {
                        _Size = value as String;
                        _ctrlSize.text = _Size.toString();
                      });
                    },
                  ),
                  Text('Large'),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  setState(() {
                  });
                },
                decoration: InputDecoration(labelText: 'Masukkan Alamat Anda'),
                controller: _ctrlAlamat,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  // Tambahkan debug
                  print('Submitting data with Menu: ${_ctrlMenu.text}');
                      if (_ctrlSize.text.isEmpty || _ctrljumlahPembelian.text.isEmpty || _ctrlAlamat.text.isEmpty || _ctrlMenu.text.isEmpty || _ctrlTypeOrder.text.isEmpty) {
      // Tampilkan pesan kesalahan jika Type Order atau Jumlah Pesanan kosong
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Peringatan!!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            content: const Text(
              'Harap Isi Pesanan Terlebih Dahulu.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: EdgeInsets.all(16.0),
          );
        },
      );
      return; // Hentikan proses jika ada field yang belum diisi
    }
                  

                  await dataPembeli.add({
                    'nama': _namaPengguna,
                    'Menu': _ctrlMenu.text,
                    'jumlah': _ctrljumlahPembelian.text,
                    'Size': _ctrlSize.text,
                    'TypeOrder': _ctrlTypeOrder.text,
                    'alamat': _ctrlAlamat.text,
                  });


                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Data telah dikirim',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        content: Text(
                          'Terima Kasih Telah Membeli Produk kami',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/home');
                            },
                            child: Text(
                              'OK',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.all(16.0),
                      );
                    },
                  );
                  // Menampilkan dialog
                  _ctrlMenu.text = '';
                  _ctrljumlahPembelian.text = '';
                  _ctrlSize.text = '';
                  _ctrlTypeOrder.text = '';
                  _ctrlAlamat.text = '';
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
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
