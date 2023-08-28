import 'package:applist2/widgets/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:applist2/data/models/model_data.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Produk (${productProvider.daftarProducts.length})',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari Produk...',
              ),
              onChanged: (value) {
                productProvider.search(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productProvider.results.length,
              itemBuilder: (context, i) {
                final product = productProvider.results[i];
                String? namaProduk = product.namaProduk;

                return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.black12)),
                    ),
                    child: Container(
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://e0.pxfuel.com/wallpapers/688/852/desktop-wallpaper-pin-oleh-aury-otaku-di-doraemon-dengan-gambar-doraemon-kartun-yellow-doraemon.jpg', ),
                                    radius: 50,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        namaProduk!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text('Harga: ${product.harga}'),
                                      Text('Stok: ${product.stock}'),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FormProduct(product: product),
                                        ),
                                      ).then((value) {
                                        if (value != null) {
                                          productProvider.updateProduct(
                                            product.id!,
                                            value,
                                          ); // Update
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.mode_edit_outlined,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Hapus Produk'),
                                            content: Text(
                                                'Yakin Ingin Menghapus Produk??'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context); 
                                                },
                                                child: Text('Batal'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  productProvider.deleteProduct(
                                                    product.id!,
                                                  ); //delete
                                                  Navigator.pop(
                                                      context);
                                                },
                                                child: Text('Hapus'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(25),
                                      child: Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ])));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FormProduct()))
              .then((value) {
            if (value != null) {
              productProvider.create(value);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FormProduct extends StatefulWidget {
  final Product? product;
  const FormProduct({Key? key, this.product}) : super(key: key);

  @override
  State<FormProduct> createState() => _FormProductState();
}

class _FormProductState extends State<FormProduct> {
  final namaProduk = TextEditingController();
  final harga = TextEditingController();
  final stock = TextEditingController();
  final gambar = TextEditingController();

  @override
  void initState() {
    if (widget.product?.id != null) {
      namaProduk.text = widget.product!.namaProduk ?? '';
      harga.text = widget.product!.harga.toString();
      stock.text = widget.product!.stock.toString();
      gambar.text = widget.product!.gambar ?? '';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// ignore: unused_local_variable
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.product?.id == null ? 'Tambah Produk' : 'Edit Produk'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: namaProduk,
            decoration: const InputDecoration(
              hintText: 'Nama Produk...',
              hintStyle: TextStyle(color: Colors.black45),
              contentPadding: EdgeInsets.all(20),
            ),
          ),
          TextField(
            controller: harga,
            decoration: const InputDecoration(
              hintText: 'Harga...',
              hintStyle: TextStyle(color: Colors.black45),
              contentPadding: EdgeInsets.all(20),
            ),
          ),
          TextField(
            controller: stock,
            decoration: const InputDecoration(
              hintText: 'Stok...',
              hintStyle: TextStyle(color: Colors.black45),
              contentPadding: EdgeInsets.all(20),
            ),
          ),
          TextField(
            controller: gambar,
            decoration: const InputDecoration(
              hintText: 'URL Gambar...',
              hintStyle: TextStyle(color: Colors.black45),
              contentPadding: EdgeInsets.all(20),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, {
              'namaProduk': namaProduk.text,
              'harga': int.tryParse(harga.text) ?? 0,
              'stock': int.tryParse(stock.text) ?? 0,
              'gambar': gambar.text,
            });
          },
          child: const Text('Submit'),
        ),
      ),
    );
  }
}
