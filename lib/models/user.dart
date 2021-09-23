import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";

  late String _id;
  late String _name;
  late String _email;

//  getters
  String get name => _name;
  String get email => _email;
  String get id => _id;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = (snapshot.data() as Map)[NAME];
    _email = (snapshot.data() as Map)[EMAIL];
    _id = (snapshot.data() as Map)[ID];
  }
}