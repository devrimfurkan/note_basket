class Product {
  int id;
  String baslik;
  String aciklama;

  Product({this.baslik, this.aciklama});
  Product.withId({this.id, this.baslik, this.aciklama});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    baslik = json['baslik'];
    aciklama = json['aciklama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['baslik'] = this.baslik;
    data['aciklama'] = this.aciklama;
    return data;
  }
}
