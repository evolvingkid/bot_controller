import 'package:botcontroller/provider/firebase_auth.dart';
import 'package:connection_verify/connection_verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SignInAplicationForm extends StatefulWidget {
  static const routeName = '/SignInAplicationForm';

  @override
  _SignInAplicationFormState createState() => _SignInAplicationFormState();
}

class _SignInAplicationFormState extends State<SignInAplicationForm> {
  TextStyle headingTxt = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xff5933AA));

  String _mobNumber;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map formData = {'name': null, 'gmail': null, 'academic': null};
  bool existsAcc;
  bool _isloading = false;
  final FocusNode _nameNode = FocusNode();
  final FocusNode _gmailNode = FocusNode();
  final FocusNode _academicNode = FocusNode();

  Future<void> _showAlert() async {
    final returnOfShowDialog = showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your account is Registered '),
          content: Text('Please wait for admin to accept'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    returnOfShowDialog.then((_) {
      Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }

  accProcess() async {
    setState(() {
      _isloading = true;
    });
    if (await ConnectionVerify.connectionStatus()) {
      // check acc is exist in db
      // * mob is the doc id in users
      existsAcc = await Provider.of<FirebaseAuth>(context, listen: false)
          .accChecker(_mobNumber);
      // if exist
      if (!existsAcc) {
        //* mob is the doc id in DB of users
        try {
          await Provider.of<FirebaseAuth>(context, listen: false)
              .addAcc(formData, _mobNumber);
          _showAlert();
        } catch (e) {
          print(e);
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Error occured Please try after some times'),
            duration: Duration(seconds: 3),
          ));
        }
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Your account is already registered'),
          duration: Duration(seconds: 3),
        ));
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please check your internet connection'),
        duration: Duration(seconds: 3),
      ));
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  void dispose() {
    _gmailNode.dispose();
    _nameNode.dispose();
    _academicNode.dispose();
    super.dispose();
  }

// focus node chnager
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void didChangeDependencies() {
    _mobNumber = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
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
                            child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: screenWidth * 0.8,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: customInputDecoration(hintText: 'Name'),
                          validator: (_val) {
                            if (_val.isEmpty) {
                              return 'Enter your Name';
                            }
                          },
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, _nameNode, _gmailNode);
                          },
                          onSaved: (_val) {
                            formData['name'] = _val;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: screenWidth * 0.8,
                        child: TextFormField(
                          focusNode: _gmailNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: customInputDecoration(hintText: 'Gmail'),
                          validator: (_val) {
                            if (_val.isEmpty) {
                              return 'Enter yor gmail adress';
                            }
                          },
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(
                                context, _gmailNode, _academicNode);
                          },
                          onSaved: (_val) {
                            formData['gmail'] = _val;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: screenWidth * 0.8,
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          focusNode: _academicNode,
                          decoration:
                              customInputDecoration(hintText: 'Academic'),
                          validator: (_val) {
                            if (_val.isEmpty) {
                              return 'Enter your Academic';
                            }
                          },
                          onSaved: (_val) {
                            formData['academic'] = _val;
                          },
                        ),
                      ),
                      SizedBox(height: 50),
                      _isloading
                          ? Center(child: CircularProgressIndicator())
                          : Container(
                              width: screenWidth * 0.8,
                              child: RaisedButton(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                color: Theme.of(context).accentColor,
                                textColor: Colors.white,
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();

                                    accProcess();
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Text('Done'),
                                ),
                              ),
                            )
                    ],
                  ),
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
