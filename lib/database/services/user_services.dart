import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce/models/user.dart';

class UserServices {
  final res = FirebaseFirestore.instance.collection('users');

  createUser(UserModel user) {
    res.doc(user.uid).set({'user_detail': user.toJson()});
  }

  Future<UserModel?> queryUser(String uid) async {
    var ds = await res.doc(uid).get();
    Map<String, dynamic>? data = ds.data();

    if (data != null) {
      UserModel user = UserModel.fromJson(data['user_detail']);
      return user;
    } else {
      return null;
    }
  }
}
