import 'package:flutter/material.dart';
import 'package:not_sepeti/db/db_helper.dart';
import 'package:not_sepeti/model/product.dart';
import 'package:not_sepeti/view/activity/product_add.dart';
import 'package:not_sepeti/view/activity/product_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoList extends StatefulWidget {
  @override
  _DoListState createState() => _DoListState();
}

class _DoListState extends State<DoList> {
  var dbHelper = DbHelper();
  List<Product> products;
  int productCount = 0;
  var mySharedPreference;

  @override
  void dispose() {
    mySharedPreference.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getProducts();
    SharedPreferences.getInstance().then((value) => mySharedPreference = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _fabBtn(),
        appBar: _appBar(),
        body: buildListView());
  }

  ListView buildListView() => ListView.builder(
        itemBuilder: (context, index) => Card(
          color: Colors.cyan,
          elevation: 2,
          child: ListTile(
            title: Text(products[index].baslik),
            subtitle: Text(products[index].aciklama),
            leading: CircleAvatar(
                //backgroundColor: Colors.black12,
                backgroundImage: AssetImage('assets/rickmorty.jpg')),
            onTap: () {
              goToDetail(products[index]);
            },
          ),
        ),
        itemCount: productCount,
      );

  AppBar _appBar() {
    String _userName =
        (mySharedPreference as SharedPreferences).getString("myIsim");
    return AppBar(
      title: Text("Merhaba, ${_userName}"),
      centerTitle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(360)),
      elevation: 2,
      backgroundColor: Color(0xffB34180),
    );
  }

  FloatingActionButton _fabBtn() => FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        child: Icon(Icons.add, color: Colors.white),
        tooltip: "Yeni Görev Ekle",
        backgroundColor: Color(0xffB34180),
      );

  void getProducts() async {
    var productFuture = dbHelper.getProducts();
    productFuture.then((value) {
      setState(() {
        products = value;
        productCount = value.length;
      });
    });
  }

  void goToDetail(Product product) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetail(product)));
    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }

  Future<void> goToProductAdd() async {
    bool response = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));

    if (response != null) {
      if (response) {
        getProducts();
      }
    }
  }
}
