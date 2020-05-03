import 'package:flutter/material.dart';

class Skimmer extends StatelessWidget {
  const Skimmer({
    Key key,
    @required this.screenWidth,
  }) : super(key: key);

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color(0xffF8F8F8), borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  backgroundColor: Color(0xffE7E7E7),
                  radius: screenWidth * 0.1,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(5),
                    width: screenWidth * 0.5,
                    height: 30,
                    color: Color(0xffE7E7E7),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: screenWidth * 0.5,
                    height: 30,
                    color: Color(0xffE7E7E7),
                  ),
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.all(5),
            width: double.infinity,
            height: 30,
            color: Color(0xffE7E7E7),
          ),
          Container(
            margin: EdgeInsets.all(5),
            width: double.infinity,
            height: 30,
            color: Color(0xffE7E7E7),
          ),
        ],
      ),
    );
  }
}
