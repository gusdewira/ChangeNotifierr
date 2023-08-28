import 'package:applist2/data/models/model_data.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> daftarProducts = [
    Product(
      id: 1,
      namaProduk: 'Apple',
      harga: 55000,
      stock: 33,
      gambar: 'https://e0.pxfuel.com/wallpapers/688/852/desktop-wallpaper-pin-oleh-aury-otaku-di-doraemon-dengan-gambar-doraemon-kartun-yellow-doraemon.jpg',
    ),
    Product(
      id: 2,
      namaProduk: 'Orange',
      harga: 70000,
      stock: 50,
      gambar: 'https://example.com/Orange.jpg',
    ),
    Product(
      id: 3,
      namaProduk: 'Grape',
      harga: 60000,
      stock: 40,
      gambar: 'https://example.com/Grape.jpg',
    )
  ];

  List<Product> results = [];

  void search(String value) {
    results = daftarProducts.where((product) {
      return (product.namaProduk ?? '')
              .toLowerCase()
              .contains(value.toLowerCase()) ||
          product.id.toString() == value;
    }).toList();
    notifyListeners();
  }

  void create(Map<String, dynamic> value) {
    try {
      int id = DateTime.now().millisecondsSinceEpoch;
      Map<String, dynamic> data = {...value};
      data['id'] = id;

      final product = Product.fromJson(data);
      daftarProducts.add(product);
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  void updateProduct(int productId, Map<String, dynamic> updatedData) {
    final productIndex =
        daftarProducts.indexWhere((product) => product.id == productId);
    if (productIndex != -1) {
      daftarProducts[productIndex] = Product.fromJson(updatedData);
      notifyListeners();
    }
  }

  void deleteProduct(int productId) {
    daftarProducts.removeWhere((product) => product.id == productId);
    notifyListeners();
  }
}
