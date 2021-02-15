import 'package:ea/shered_preference_kullanimi.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      home: SharedPreferenceKullanimi(),
    );
  }
}
