import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/provider/auth_provider.dart';
import 'package:flutter_ecommerce/helpers/app_colors.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  final Function? toggleScreen;

  const SignUp({Key? key, this.toggleScreen}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    // final user = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: white,
        iconTheme: IconThemeData(color: primary),
        title: Text('註冊肉兜兜帳號', style: TextStyle(color: primary)),
      ),
      body: SingleChildScrollView(
          child: Container(
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    // Logo
                    // Padding(
                    //     padding: EdgeInsets.all(12.0),
                    //     child: Container(
                    //       child: Image.asset(
                    //         'images/imgs/logo.jpg',
                    //         width: 300,
                    //       ),
                    //     )),

                    // name TextField
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 20, 8, 8),
                      child: Material(
                        elevation: 0.0,
                        child: ListTile(
                          title: TextFormField(
                              controller: _name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '姓名',
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                              validator: (name) {
                                if (name!.isEmpty) {
                                  return 'The name field cannot be empty';
                                }
                                return null;
                              }),
                        ),
                      ),
                    ),

                    // Email TextField
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Material(
                        elevation: 0.0,
                        child: ListTile(
                          title: TextFormField(
                              controller: _email,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '電子郵件',
                                prefixIcon: Icon(Icons.mail_outline),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (email) {
                                if (email!.isEmpty) {
                                  return 'The mail cannot be empty';
                                } else {
                                  final bool isValid =
                                      EmailValidator.validate(email);
                                  if (!isValid) {
                                    return 'Please make sure your email address is valid';
                                  }
                                }
                              }),
                        ),
                      ),
                    ),

                    // Password TextField
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Material(
                        elevation: 0.0,
                        child: ListTile(
                          title: TextFormField(
                            controller: _password,
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '密碼',
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  icon: hidePassword
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility)),
                            ),
                            validator: (psw) {
                              if (psw!.isEmpty) {
                                return "The password field cannot be empty";
                              } else if (psw.length < 6) {
                                return "the password has to be at least 6 characters long";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),

                    // Confirm Password TextField
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Material(
                        elevation: 0.0,
                        child: ListTile(
                          title: TextFormField(
                            controller: null,
                            obscureText: hideConfirmPassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '確認密碼',
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hideConfirmPassword =
                                          !hideConfirmPassword;
                                    });
                                  },
                                  icon: hideConfirmPassword
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility)),
                            ),
                            validator: (psw) {
                              if (psw!.isEmpty) {
                                return "The password field cannot be empty";
                              } else if (psw.length < 6) {
                                return "the password has to be at least 6 characters long";
                              } else if (psw != _password.text) {
                                return '密碼不相同';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                      child: ListTile(
                        title: Container(
                          height: 50.0,
                          width:
                              authProvider.isLoading ? null : double.infinity,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                print('Email: ${_email.text}');
                                print('Password: ${_password.text}');
                                if (await authProvider.signUp(
                                    _name.text.trim(),
                                    _email.text.trim(),
                                    _password.text.trim())) {
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(authProvider.errorMessage),
                                    ),
                                  );
                                }
                              }
                            },
                            child: authProvider.isLoading
                                ? CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(white))
                                : Text(
                                    "註冊",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: white),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    // Register Button
                    // Padding(
                    //   padding: EdgeInsets.all(8),
                    //   child: ListTile(
                    //     title: Material(
                    //         borderRadius: BorderRadius.circular(10.0),
                    //         color: black,
                    //         elevation: 0.0,
                    //         child: MaterialButton(
                    //           onPressed: () async {
                    //             if (_formKey.currentState!.validate()) {
                    //               print('Email: ${_email.text}');
                    //               print('Password: ${_password.text}');
                    //               await authProvider.signUp(
                    //                   _name.text.trim(),
                    //                   _email.text.trim(),
                    //                   _password.text.trim());
                    //             }
                    //           },
                    //           minWidth: authProvider.isLoading
                    //               ? null
                    //               : double.infinity,
                    //           child: authProvider.isLoading
                    //               ? CircularProgressIndicator(
                    //                   valueColor:
                    //                       AlwaysStoppedAnimation<Color>(white))
                    //               : Text(
                    //                   "註冊",
                    //                   textAlign: TextAlign.center,
                    //                   style: TextStyle(
                    //                       color: white,
                    //                       fontWeight: FontWeight.bold,
                    //                       fontSize: 20.0),
                    //                 ),
                    //         )),
                    //   ),
                    // ),

                    TextButton(
                      child: Text(
                        "已有帳號",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: () {
                        widget.toggleScreen!();
                      },
                    ),
                  ])))),
    );
  }
}
