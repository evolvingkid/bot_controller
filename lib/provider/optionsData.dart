import 'package:botcontroller/models/option.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OptionData with ChangeNotifier {
  List<Options> options = [
    Options(name: 'Events', icon: Icons.notifications, catergory: 'mainPage'),
    Options(name: 'Group', icon: Icons.people, catergory: 'mainPage'),
    Options(name: 'Polls', icon: Icons.remove_red_eye, catergory: 'mainPage'),
    Options(name: 'Send Message', icon: Icons.edit, catergory: 'mainPage'),
    Options(
        name: 'Memebers', icon: Icons.person_outline, catergory: 'mainPage'),
    Options(name: 'kick Out Users', icon: Icons.close, catergory: 'mainPage'),
    Options(name: 'Report', icon: Icons.report, catergory: 'mainPage'),
    Options(name: 'Statitics', icon: Icons.dashboard, catergory: 'mainPage'),
    Options(name: 'About', icon: Icons.settings, catergory: 'mainPage'),
  ];

  List filteringDatas(String _filterVal) {
    List<Options> filteredData = [];
    options.forEach((data) {
      if (data.catergory == _filterVal) {
        filteredData.add(data);
      }
    });
    return filteredData;
  }
}
