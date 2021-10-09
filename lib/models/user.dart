import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel extends StatelessWidget {
  final String uid;
  final String userName;
  final String userMail;
  final String createTime;
  final String loginTime;

  const UserModel(
      {Key? key,
      required this.uid,
      required this.userName,
      required this.userMail,
      required this.createTime,
      required this.loginTime})
      : super(key: key);

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    return UserModel(
        uid: json!['uid'],
        userName: json['userName'],
        userMail: json['userMail'],
        createTime: json['createTime'],
        loginTime: json['loginTime']);
  }

  Map<String, dynamic>? toJson() {
    return {
      'uid': uid,
      'userName': userName,
      'userMail': userMail,
      'createTime': createTime,
      'loginTime': loginTime
    };
  }

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future addUser() {
      return users
          .add({
            'uid': uid,
            'userName': userName,
            'userMail': userMail,
            'createTime': createTime,
            'loginTime': loginTime
          })
          .then((value) => print("user added"))
          .catchError((e) => print(e.toString()));
    }

    return TextButton(
      child: Text('Add User'),
      onPressed: () => addUser(),
    );
  }
}
