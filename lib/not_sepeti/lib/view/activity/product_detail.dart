import 'package:flutter/material.dart';
import 'package:not_sepeti/db/db_helper.dart';
import 'package:not_sepeti/model/product.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);
  @override
  _ProductDetailState createState() => _ProductDetailState(product);
}

enum Options { delete, update }

class _ProductDetailState extends State<ProductDetail> {
  Product product;
  _ProductDetailState(this.product);

  var dbHelper = DbHelper();
  var txtBaslik = TextEditingController();
  var txtAciklama = TextEditingController();

  @override
  void initState() {
    super.initState();

    txtBaslik.text = product.baslik;
    txtAciklama.text = product.aciklama;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _buildPadding(),
    );
  }

  Padding _buildPadding() => Padding(
        padding: EdgeInsets.all(35),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Konu Başlığı"),
              controller: txtBaslik,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Açıklama"),
              controller: txtAciklama,
            ),
          ],
        ),
      );

  AppBar _appBar() {
    return AppBar(
      title: Text("Konu Başlığı: ${product.baslik}"),
      actions: [
        PopupMenuButton<Options>(
            onSelected: onResponse,
            itemBuilder: (context) => <PopupMenuEntry<Options>>[
                  PopupMenuItem<Options>(
                      value: Options.delete, child: Text("Sil")),
                  PopupMenuItem<Options>(
                      value: Options.update, child: Text("Güncelle")),
                ])
      ],
    );
  }

  void onResponse(Options value) async {
    switch (value) {
      case Options.delete:
        await dbHelper.delete(product.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(Product.withId(
            id: product.id,
            baslik: txtBaslik.text,
            aciklama: txtAciklama.text));
        Navigator.pop(context, true);
        break;
      default:
    }
  }
}
