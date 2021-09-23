import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";

  late String _id;
  late String _description;
  late String _userId;
  late String _status;
  late int _createdAt;
  late int _total;
  late List cart;

  // getters
  String get id => _id;

  String get description => _description;

  String get userId => _userId;

  String get status => _status;

  int get total => _total;

  int get createdAt => _createdAt;

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    _description = (snapshot.data() as Map)[DESCRIPTION];
    _total = (snapshot.data() as Map)[TOTAL];
    _status = (snapshot.data() as Map)[STATUS];
    _userId = (snapshot.data() as Map)[USER_ID];
    _createdAt = (snapshot.data() as Map)[CREATED_AT];
    cart = (snapshot.data() as Map)[CART];
  }
}
