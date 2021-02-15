import 'package:flutter/material.dart';
import 'package:not_sepeti/db/db_helper.dart';
import 'package:not_sepeti/model/product.dart';

class ProductAdd extends StatefulWidget {
  @override
  _ProductAddState createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  var dbHelper = DbHelper();
  var txtBaslik;
  var txtAciklama;

  @override
  void initState() {
    super.initState();

    txtBaslik = TextEditingController();
    txtAciklama = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          
          children: [
            _buildTextBaslik(),
            _buildTextAciklama(),
            SizedBox(height: 17),
            _buildSaveBtn()
          ],
        ),
      ),
    );
  }

  FlatButton _buildSaveBtn() => FlatButton(
      onPressed: _addProduct,
      child: Row(
        children: [Text("Kaydet"), Icon(Icons.save)],
      ));

  _addProduct() async {
    var response = await dbHelper.insert(
      Product(
        baslik: txtBaslik.text,
        aciklama: txtBaslik.text,
      ),
    );
    Navigator.pop(context, true);
    return response;
  }

  TextField _buildTextAciklama() {
    return TextField(
      decoration: InputDecoration(labelText: "Açıklama"),
      controller: txtAciklama,
    );
  }

  TextField _buildTextBaslik() {
    return TextField(
      decoration: InputDecoration(labelText: "Başlık"),
      controller: txtBaslik,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Yeni Başlık Ekle"),
    );
  }
}
