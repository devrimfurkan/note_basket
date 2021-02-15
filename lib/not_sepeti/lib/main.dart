import 'package:flutter/material.dart';
import 'package:not_sepeti/view/register/login.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(accentColor: Colors.cyan),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Login(),
        ));
  }
}
