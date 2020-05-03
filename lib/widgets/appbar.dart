import 'package:flutter/material.dart';

AppBar mainAppBar(TextStyle appBarStyle) {
  return AppBar(
    elevation: 5,
    backgroundColor: Color(0xff3700B3),
    title: Text('TinkerHub Bot', style: appBarStyle),
    centerTitle: true,
    actions: <Widget>[
      IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
      CircleAvatar(
          radius: 15,
          backgroundColor: Colors.white,
          child: Icon(Icons.person, color: Color(0xff3700B3))),
    ],
  );
}
