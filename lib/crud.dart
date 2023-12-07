import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CrudPage extends StatefulWidget {
  @override
  _CrudPageState createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference data_pembeli =
      FirebaseFirestore.instance.collection("data_pembeli");

  TextEditingController MenuController = TextEditingController();
  TextEditingController _ctrljumlahPembelian = TextEditingController();
  TextEditingController SizeController = TextEditingController();
  TextEditingController TypeOrderController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  int _selectedIndex = 2;
  String? selectedDocumentId;

  Future<void> deleteData(String documentId) async {
    await data_pembeli.doc(documentId).delete();
  }

  Future<void> updateData(
      String documentId, Map<String, dynamic> newData) async {
    await data_pembeli.doc(documentId).update(newData);
    clearTextControllers();
  }

  void clearTextControllers() {
    MenuController.clear();
    _ctrljumlahPembelian.clear();
    SizeController.clear();
    TypeOrderController.clear();
    alamatController.clear();
    selectedDocumentId = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CART'),
        backgroundColor: Color.fromARGB(255, 139, 23, 23),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: data_pembeli.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              return ListTile(
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Menu: ${data['Menu']}'),
                    Text('JumlahPembelian: ${data['jumlahPembelian']}'),
                    Text('Size: ${data['Size']}'),
                    Text('TypeOrder: ${data['TypeOrder']}'),
                    Text('Alamat: ${data['alamat']}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Set nilai controller sesuai data yang akan diubah
                        MenuController.text = data['Menu'];
                        _ctrljumlahPembelian.text =
                            data['jumlahPembelian'].toString();
                        SizeController.text = data['Size'];
                        TypeOrderController.text = data['TypeOrder'];
                        alamatController.text = data['alamat'];

                        // Set document ID yang akan diupdate
                        selectedDocumentId = document.id;

                        // Tampilkan dialog update
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Update Data'),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: MenuController,
                                      decoration:
                                          InputDecoration(labelText: 'Menu'),
                                    ),
                                    TextFormField(
                                      controller: _ctrljumlahPembelian,
                                      decoration: InputDecoration(
                                          labelText: 'Jumlah Pembelian'),
                                      keyboardType: TextInputType.number,
                                    ),
                                    TextFormField(
                                      controller: SizeController,
                                      decoration:
                                          InputDecoration(labelText: 'Size'),
                                    ),
                                    TextFormField(
                                      controller: TypeOrderController,
                                      decoration:
                                          InputDecoration(labelText: 'TypeOrder'),
                                    ),
                                    TextFormField(
                                      controller: alamatController,
                                      decoration:
                                          InputDecoration(labelText: 'Alamat'),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Lakukan update data
                                    updateData(selectedDocumentId!, {
                                      'Menu': MenuController.text,
                                      'jumlah': int.parse(_ctrljumlahPembelian.text),
                                      'Size': SizeController.text,
                                      'TypeOrder': TypeOrderController.text,
                                      'alamat': alamatController.text,
                                    });

                                    // Tutup dialog
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Update'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Tampilkan dialog konfirmasi delete
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Konfirmasi Delete'),
                              content: Text(
                                  'Apakah Anda yakin ingin menghapus data ini?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Lakukan delete data
                                    deleteData(document.id);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Hapus'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
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
