import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/pages/account/login.dart';
import 'package:flutter_ecommerce/pages/account/signup.dart';

class Authentication extends StatefulWidget {
  const Authentication({ Key? key }) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isToggle = false;

  void toggleScreen() {
    setState(() {
      isToggle = !isToggle;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (isToggle) {
      return SignUp(toggleScreen: toggleScreen);
    } 
    else {
      return Login(toggleScreen: toggleScreen);
    }
  }
}