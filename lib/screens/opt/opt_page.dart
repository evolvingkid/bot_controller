import 'package:flutter/material.dart';

class OTPPage extends StatefulWidget {
  static const routeName = './OTPPage';

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  Text headingTxt = Text(
    'Verification Code',
    style: TextStyle(
        fontSize: 35, color: Colors.white, fontWeight: FontWeight.w600),
  );

  int addedTile = 1;
  double finalSubmitVal;

  List btnsTap = [
    {'type': 'number', 'value': 1},
    {'type': 'number', 'value': 2},
    {'type': 'number', 'value': 3},
    {'type': 'number', 'value': 4},
    {'type': 'number', 'value': 5},
    {'type': 'number', 'value': 6},
    {'type': 'number', 'value': 7},
    {'type': 'number', 'value': 8},
    {'type': 'number', 'value': 9},
    {'type': 'icon', 'value': Icons.backspace},
    {'type': 'number', 'value': 0},
    {'type': 'icon', 'value': Icons.done},
  ];

  List topValueBar = [
    {'index': 0, 'value': null},
    {'index': 1, 'value': null},
    {'index': 2, 'value': null},
    {'index': 3, 'value': null},
    {'index': 4, 'value': null},
    {'index': 5, 'value': null}
  ];

  addValueToOTP(int _val) {
    // ! if this if condition is removed we will get a bad request error from firstWhere becasue their is no null value
    if (addedTile <= topValueBar.length) {
      dynamic _whereVal =
          topValueBar.firstWhere((element) => element['value'] == null);

      setState(() {
        topValueBar[_whereVal['index']]['value'] = _val;
        addedTile++;
      });
    }
  }

  deleteVal() {
    if (addedTile > 1) {
      var _whereVal =
          topValueBar.lastWhere((element) => element['value'] != null);

      setState(() {
        topValueBar[_whereVal['index']]['value'] = null;
        addedTile--;
      });
    }
  }

  submit() {
    dynamic _val;
    topValueBar.forEach((f) {
      if (f['value'] != null) {
        if (_val != null) {
          _val = '$_val${f['value']}';
        } else {
          _val = f['value'];
        }
      }
    });
    print(_val);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // print(btnsTap[1]['value']);
    return Scaffold(
      backgroundColor: Color(0xff5933AA),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            headingTxt,
            const SizedBox(height: 20),
            // ?param: this recives the mobile number as the secound parameter
            msgBelowHeading(screenWidth, '********15'),

            enteredOTPViewer(screenWidth, topValueBar),
            SizedBox(height: 20),
            Container(
              width: screenWidth * 0.6,
              child: optEneteringBar(),
            )
          ],
        ),
      ),
    );
  }

  GridView optEneteringBar() {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: btnsTap.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
        ),
        itemBuilder: (BuildContext ctxt, int index) {
          if (btnsTap[index]['value'] == Icons.done) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  submit();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    btnsTap[index]['value'],
                    color: Color(0xff5933AA),
                  ),
                ),
              ),
            );
          } else
            return GestureDetector(
              onTap: () {
                if (btnsTap[index]['type'] == 'number') {
                  addValueToOTP(btnsTap[index]['value']);
                }
                if (btnsTap[index]['value'] == Icons.backspace) {
                  deleteVal();
                }
              },
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: btnsTap[index]['type'] == 'number'
                    ? Text(
                        btnsTap[index]['value'].toString(),
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      )
                    : Icon(
                        btnsTap[index]['value'],
                        color: Colors.white,
                      ),
              ),
            );
        });
  }

  Container enteredOTPViewer(double screenWidth, List _topValueBar) {
    return Container(
      width: screenWidth * 0.6,
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (BuildContext ctxt, int index) {
            return CircleAvatar(
              backgroundColor: Color.fromRGBO(255, 255, 255, 0.5),
              child: _topValueBar[index]['value'] == null
                  ? Padding(padding: EdgeInsets.all(10))
                  : FittedBox(
                      child: Text(
                        _topValueBar[index]['value'].toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                      fit: BoxFit.fill,
                    ),
            );
          }),
    );
  }

  Container msgBelowHeading(double screenWidth, String mobileNumber) {
    return Container(
        width: screenWidth * 0.45,
        child: Text(
          'Enter the OTP sent to the mobile number  $mobileNumber',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ));
  }
}
