import 'package:botcontroller/screens/signup/siginup_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Color(0xff5933AA)
      ),
      home: SiginUpPage(),
    );
  }
}


