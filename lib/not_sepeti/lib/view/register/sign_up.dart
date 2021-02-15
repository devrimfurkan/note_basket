import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _formKey = GlobalKey<FormState>();
  var mySharedPreference;
  var _isim;
  var _parola;

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
    return Container(
      decoration: _scaffoldDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _image(context),
              SizedBox(height: 37),
              _signUp(),
            ],
          ),
        ),
      ),
    );
  }

  Padding _signUp() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            userName(),
            password(),
            SizedBox(height: 25),
            FlatButton(
                color: Colors.cyan, onPressed: _kaydet, child: Text("KAYIT OL"))
          ],
        ),
      ),
    );
  }

  Container _image(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/rickmorty.jpg'), fit: BoxFit.cover),
          color: Colors.cyan,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35))),
    );
  }

  BoxDecoration _scaffoldDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topLeft,
      stops: [0.1, 0.5, 0.7, 0.9],
      colors: [
        Color(0xff583d72),
        Color(0xff9f5f80),
        Color(0xffffba93),
        Color(0xffff8e71),
      ],
    ));
  }

  TextFormField password() {
    return TextFormField(
      onSaved: (val) => _parola = val,
      obscureText: true,
      controller: _parola,
      decoration: InputDecoration(labelText: "Parola"),
    );
  }

  TextFormField userName() {
    return TextFormField(
      onSaved: (val) => _isim = val,
      decoration: InputDecoration(labelText: "Kullanıcı Adı"),
    );
  }

  _kaydet() async {
    _formKey.currentState.save();
    await (mySharedPreference as SharedPreferences).setString("myIsim", _isim);
    await (mySharedPreference as SharedPreferences)
        .setString("myPassword", _parola);
    setState(() {
      Navigator.pop(context, true);
    });
  }
}
