import 'package:botcontroller/widgets/appbar.dart';
import 'package:flutter/material.dart';

import 'mainCategory.dart';

class HomeScreen extends StatelessWidget {
  var appBarStyle = TextStyle(
      color: Color.fromRGBO(255, 255, 255, 0.5),
      fontSize: 15,
      fontWeight: FontWeight.w400);

  var mainBoxDecoration = BoxDecoration(
      gradient: LinearGradient(
          colors: [Color(0xff3700B3), Color(0xff6D2EDC)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            offset: Offset(0, 4))
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppBar(appBarStyle),
      drawer: Drawer(child: Container()),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              // * event shower
              // TODO: need to add new events shower in this widgets
              Container(
                width: double.infinity,
                height: 200,
                decoration: mainBoxDecoration,
              ),
              SizedBox(height: 20),
              MainCategory(mainBoxDecoration: mainBoxDecoration)
            ],
          ),
        ),
      ),
    );
  }
}

