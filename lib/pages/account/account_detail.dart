import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:flutter_ecommerce/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class AccountDetail extends StatelessWidget {
  const AccountDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProviver = Provider.of<AuthProvider>(context);
    UserModel? user = authProviver.userModel;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(user!.userName),
          Text(user.userMail),
          Text(user.loginTime),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              onPressed: () {
                authProviver.signOut();
              },
              child: Text(
                '登出',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              )),
        ],
      ),
    );
  }
}
