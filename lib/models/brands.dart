import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  static const ID = "id";
  static const BRAND = "brand";

  late String _id;
  late String _brand;

//  getters
  String get brand => _brand;
  String get id => _id;

  BrandModel.fromSnapshot(DocumentSnapshot snapshot) {
    _brand = (snapshot.data() as Map)[BRAND];
    _id = (snapshot.data() as Map)[ID];
  }
}
