import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/helpers/app_colors.dart';
import 'package:flutter_ecommerce/pages/account/login.dart';
import 'package:flutter_ecommerce/pages/account/signup.dart';
import 'package:flutter_ecommerce/provider/auth_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: white,
          iconTheme: IconThemeData(color: primary),
          title: Text('肉兜兜', style: TextStyle(color: primary)),
        ),
        body: SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                child: Column(children: [
                  // Logo
                  Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Container(
                        child: Image.asset(
                          'images/imgs/logo.jpg',
                          width: 300,
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('肉兜兜帳號',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                        child: Container(
                          width: 150.0,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child: Text(
                                '登入',
                                style: TextStyle(
                                    color: primary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                        child: Container(
                          width: 150.0,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text(
                              '註冊',
                              style: TextStyle(
                                  color: primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('其他方式登入',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Mobile Sign in
                        Ink(
                          decoration: ShapeDecoration(
                              shape: CircleBorder(), color: blue),
                          child: IconButton(
                            icon: FaIcon(FontAwesomeIcons.mobileAlt),
                            onPressed: () {},
                            color: white,
                          ),
                        ),
                        // Facebook Sign in
                        Ink(
                          decoration: ShapeDecoration(
                              shape: CircleBorder(), color: blue),
                          child: IconButton(
                            icon: FaIcon(FontAwesomeIcons.facebookSquare),
                            onPressed: () {
                              authProvider.facebookSignIn();
                            },
                            color: white,
                          ),
                        ),
                        // Google Sign in
                        Ink(
                          decoration: ShapeDecoration(
                              shape: CircleBorder(), color: blue),
                          child: IconButton(
                            icon: FaIcon(FontAwesomeIcons.google),
                            onPressed: () {
                              authProvider.googleSignIn();
                            },
                            color: white,
                          ),
                        )
                      ],
                    ),
                  ),
                ]))));
  }
}
