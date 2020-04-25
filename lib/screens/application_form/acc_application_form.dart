import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInAplicationForm extends StatelessWidget {
  TextStyle headingTxt = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xff5933AA));

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Hero(
                  tag: '1',
                  child: Container(
                    child:
                        SvgPicture.asset('assets/images/login_page_logo.svg'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'TinkerHub Bot',
                  style: headingTxt,
                ),
                SizedBox(height: 30),
                Form(
                    child: Center(
                        child: SingleChildScrollView(
                            child: Column(
                  children: <Widget>[
                    Container(
                      width: screenWidth * 0.8,
                      child: TextFormField(
                        decoration: customInputDecoration(hintText: 'Name'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: screenWidth * 0.8,
                      child: TextFormField(
                        decoration: customInputDecoration(hintText: 'Gmail'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: screenWidth * 0.8,
                      child: TextFormField(
                        decoration: customInputDecoration(hintText: 'Academic'),
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      width: screenWidth * 0.8,
                      child: RaisedButton(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        color: Theme.of(context).accentColor,
                        textColor: Colors.white,
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text('Done'),
                        ),
                      ),
                    )
                  ],
                ))))
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration customInputDecoration({String hintText}) {
    return InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Color(0xff5933AA), width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.black26, width: 1.0),
        ),
        hintText: hintText);
  }
}
