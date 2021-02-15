import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
Küçük verilerle çalışmak için kulanılabilir.
Oluşturulan verileri XML dosyası şeklinde tutar.
sil butonuna || uygulma silinmedikçe veriler orada tutulur. 
*/

class SharedPreferenceKullanimi extends StatefulWidget {
  @override
  _SharedPreferenceKullanimiState createState() =>
      _SharedPreferenceKullanimiState();
}

class _SharedPreferenceKullanimiState extends State<SharedPreferenceKullanimi> {
  String isim;
  int id;
  bool cinsiyet;
  var formKey = GlobalKey<FormState>();
  var mySharedPreference;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) => mySharedPreference = value);
  }

  @override
  void dispose() {
    mySharedPreference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Pref kulanımı"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (val) {
                    isim = val;
                  },
                  decoration: InputDecoration(
                    labelText: "İsim",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (val) {
                    id = int.parse(val);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "ID",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RadioListTile(
                    value: true,
                    groupValue: cinsiyet,
                    onChanged: (val) {
                      setState(() {
                        cinsiyet = val;
                      });
                    },
                    title: Text("Erkek"),
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RadioListTile(
                    value: false,
                    groupValue: cinsiyet,
                    onChanged: (val) {
                      setState(() {
                        cinsiyet = val;
                      });
                    },
                    title: Text("Kadın"),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: _ekle,
                    child: Text("KAYDET"),
                    color: Colors.cyan,
                  ),
                  RaisedButton(
                    onPressed: _goster,
                    child: Text("GOSTER"),
                    color: Colors.cyan,
                  ),
                  RaisedButton(
                    onPressed: _sil,
                    child: Text("SİL"),
                    color: Colors.cyan,
                  ),
                ],
              )
            ])),
      ),
    );
  }

  Future<void> _ekle() async {
    formKey.currentState.save();

    await (mySharedPreference as SharedPreferences).setString("myIsim", isim);
    await (mySharedPreference as SharedPreferences).setInt("myId", id);
    await (mySharedPreference as SharedPreferences)
        .setBool("myCinsiyet", cinsiyet);
  }

// ?? ifadesi Nulable ifade için kullanılır yani _goster degerlerim null ise yapılacak islemi belirtir.
  void _goster() {
    debugPrint("Okunan İsim: " +
            (mySharedPreference as SharedPreferences).getString("myIsim") ??
        "Null");
    debugPrint("Okunan İsim: " +
            (mySharedPreference as SharedPreferences)
                .getInt("myId")
                .toString() ??
        "Null");
    debugPrint("Okunan İsim: " +
            (mySharedPreference as SharedPreferences)
                .getBool("myCinsiyet")
                .toString() ??
        "Null");
  }

  void _sil() {
    (mySharedPreference as SharedPreferences).remove("myIsim");
    (mySharedPreference as SharedPreferences).remove("myId");
    (mySharedPreference as SharedPreferences).remove("myCinsiyet");
  }
}
