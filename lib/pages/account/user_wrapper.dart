import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/pages/account/account_detail.dart';
import 'package:flutter_ecommerce/pages/user_account.dart';
import 'package:flutter_ecommerce/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class UserWrapper extends StatelessWidget {
  const UserWrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProviver = Provider.of<AuthProvider>(context);
    final status = authProviver.status;

    switch (status) {
      case Status.Uninitialized:
        return UserAccount();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return UserAccount();
      case Status.Authenticated:
        return AccountDetail();
      default:
        return UserAccount();
    }
    if (authProviver.userModel == null) {
      return UserAccount();
    } else {
      return AccountDetail();
    }
  }
}