import 'package:flutter/material.dart';
import 'package:not_sepeti/view/activity/product_list.dart';
import 'package:not_sepeti/view/register/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var mySharedPreference;
  final _parolaCont = TextEditingController();
  final _isimCont = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) => mySharedPreference = value);
  }

  @override
  void dispose() {
    mySharedPreference.dispose();
    _parolaCont.dispose();
    _isimCont.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                _stackBoyutu(context),
                _backGround(context),
                _welcomeLetter(context),
                _whiteCurve(context),
                _secCruve(context)
              ],
            ),
            _formArea(context),
          ],
        ),
      ),
    );
  }

  Padding _formArea(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            userName(),
            password(),
            SizedBox(height: 13),
            _btns(context)
          ],
        ),
      ),
    );
  }

  Form _btns(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [_loginBtn(), SizedBox(width: 25), _signUpBtn(context)],
      ),
    );
  }

  FlatButton _signUpBtn(BuildContext context) {
    return FlatButton(
        color: Colors.cyan,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUp()));
        },
        child: Text("KAYIT OL"));
  }

  FlatButton _loginBtn() {
    return FlatButton(
        color: Colors.cyan, onPressed: _onPressed, child: Text("GİRİŞ YAP"));
  }

  Positioned _secCruve(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.3,
      left: MediaQuery.of(context).size.width * 0.49,
      child: CircleAvatar(
        radius: 103,
        backgroundColor: Color(0xff1687a7),
      ),
    );
  }

  Positioned _whiteCurve(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.3,
      right: MediaQuery.of(context).size.width * 0.49,
      child: CircleAvatar(
        radius: 103,
        backgroundColor: Colors.white,
      ),
    );
  }

  Positioned _welcomeLetter(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.05,
      top: MediaQuery.of(context).size.height * 0.1,
      child: Container(
        child: Text(
          "HOŞ \nGELDİNİZ!",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
    );
  }

  Container _backGround(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: Color(0xff1687a7),
      ),
    );
  }

  Container _stackBoyutu(BuildContext context) {
    return Container(
      // color: Colors.red,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.58,
    );
  }

  TextField password() {
    return TextField(
      obscureText: true,
      controller: _parolaCont,
      decoration: InputDecoration(
        labelText: "Parola",
      ),
    );
  }

  TextField userName() {
    return TextField(
      controller: _isimCont,
      decoration: InputDecoration(labelText: "Kullanıcı Adı"),
    );
  }

  void _onPressed() {
    if ((_parolaCont.text ==
            (mySharedPreference as SharedPreferences)
                .getString("myPassword")) &&
        (_isimCont.text ==
            (mySharedPreference as SharedPreferences).getString("myIsim"))) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DoList()));
    }
  }
}
