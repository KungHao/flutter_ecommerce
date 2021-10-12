import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/provider/auth_provider.dart';
import 'package:flutter_ecommerce/helpers/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final Function? toggleScreen;
  const Login({Key? key, this.toggleScreen}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: white,
        iconTheme: IconThemeData(color: primary),
        title: Text('用肉兜兜帳號登入', style: TextStyle(color: black)),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Logo
                // Padding(
                //     padding: EdgeInsets.all(12.0),
                //     child: Container(
                //       child: Image.asset(
                //         'images/imgs/logo.jpg',
                //         width: 300,
                //       ),
                //     )),

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
                                prefixIcon: Icon(Icons.mail_outline)),
                            keyboardType: TextInputType.emailAddress,
                            validator: (email) {
                              if (email!.isEmpty) {
                                final bool isValid =
                                    EmailValidator.validate(email);
                                if (isValid)
                                  return 'Please make sure your email address is valid';
                                else
                                  return null;
                              }
                            }),
                      )),
                ),

                // Password TextField
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      elevation: 0.0,
                      child: ListTile(
                        title: TextFormField(
                          controller: _password,
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
                          obscureText: hidePassword,
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
                      )),
                ),

                // Login Button
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: black,
                      elevation: 0.0,
                      child: MaterialButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (!await authProvider.mailSignIn(
                                    _email.text.trim(),
                                    _password.text.trim())) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(authProvider.errorMessage),
                                ),
                              );
                            }
                            Navigator.pop(context);
                          }
                        },
                        minWidth:
                            authProvider.isLoading ? null : double.infinity,
                        child: authProvider.isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(white))
                            : Text(
                                "Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                      ),
                )),

                // 底層的文字
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        child: Text(
                          "忘記密碼",
                          style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          child: Text(
                            "註冊帳號",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPressed: () {
                            widget.toggleScreen!();
                          },
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
