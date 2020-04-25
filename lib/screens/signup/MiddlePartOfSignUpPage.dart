import 'package:botcontroller/screens/application_form/acc_application_form.dart';
import 'package:botcontroller/screens/opt/opt_page.dart';
import 'package:connection_verify/connection_verify.dart';
import 'package:flutter/material.dart';
import '../../core/firebase_mob_auth.dart';

class MiddlePartOfSignUpPage extends StatefulWidget {
  MiddlePartOfSignUpPage(
      {@required this.screenHeight, @required this.screenWidth});

  final double screenHeight;
  final double screenWidth;

  @override
  _MiddlePartOfSignUpPageState createState() => _MiddlePartOfSignUpPageState();
}

class _MiddlePartOfSignUpPageState extends State<MiddlePartOfSignUpPage> {
  double textFeildPostion = 1;
  double textFeildOpacity = 0.0;
  double animatedBtnOpacity = 0.0;
  String _mobNumber;
  bool _isloading = false;
  final _formKey = GlobalKey<FormState>();

  Future animationFunction() async {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        textFeildPostion = 20;
        textFeildOpacity = 1.0;
        animatedBtnOpacity = 1.0;
      });
    });
  }

  optPageRedirect() {
    setState(() {
      _isloading = false;
    });
    Navigator.of(context).pushNamed(OTPPage.routeName,
        arguments: {'type': 'signUp', 'mobileNumber': _mobNumber});
  }

  void submitMobNumber() async {
    setState(() {
      _isloading = true;
    });
    _mobNumber = '+91$_mobNumber';
    var _fetchData;
    if (await ConnectionVerify.connectionStatus()) {
      try {
        _fetchData =
            await FirebaseMobAuth.loginUser(_mobNumber, context, (_val) {
          if (_val) {
            setState(() {
              _isloading = false;
            });
            Navigator.of(context).pushNamed(SignInAplicationForm.routeName,
                arguments: _mobNumber);
            return;
          }
          setState(() {
            _isloading = false;
          });
          final snackBar = SnackBar(
              content: Text('Error Occured Please Re-enter the Mobile Number'));

          Scaffold.of(context).showSnackBar(snackBar);
        }, () {
          optPageRedirect();
        });
      } catch (e) {
        print('error');
        print(e);
      }

      print(_fetchData.toString());
    } else {
      setState(() {
        _isloading = false;
      });

      final snackBar =
          SnackBar(content: Text('Please Check your Internet Connection'));

      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void didChangeDependencies() {
    animationFunction();
    super.didChangeDependencies();
  }

// *build
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        height: widget.screenHeight * 0.6,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                width: screenWidth * 0.7,
                child: Stack(
                  children: <Widget>[
                    siginUpTextFeild(screenWidth),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              tipMsg(screenWidth),
              const SizedBox(height: 50),
              _isloading
                  ? CircularProgressIndicator()
                  : siginupRaisedBtn(screenWidth, context)
            ],
          ),
        ));
  }

  AnimatedOpacity siginupRaisedBtn(double screenWidth, BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: animatedBtnOpacity,
      child: Container(
        width: screenWidth * 0.7,
        child: RaisedButton(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0),
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              submitMobNumber();
            }
          },
          textColor: Colors.white,
          color: Theme.of(context).accentColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: const Text('Proceed'),
          ),
        ),
      ),
    );
  }

  Container tipMsg(double screenWidth) {
    return Container(
        width: screenWidth * 0.6,
        child: Text(
          'We will send One Time Password through sms',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ));
  }

  AnimatedPositioned siginUpTextFeild(double screenWidth) {
    return AnimatedPositioned(
      top: textFeildPostion,
      duration: Duration(milliseconds: 500),
      child: AnimatedOpacity(
        opacity: textFeildOpacity,
        duration: Duration(milliseconds: 500),
        child: Container(
            width: screenWidth * 0.7,
            child: TextFormField(
              onChanged: (val) {
                _mobNumber = val;
              },
              validator: (_value) {
                if (_value.isEmpty) {
                  return 'Enter your mobile number';
                }
                if (_value.length != 10) {
                  return 'Enter correct number';
                }
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: 'India (+91) '),
            )),
      ),
    );
  }
}
