import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const PICTURE = "picture";
  static const PRICE = "price";
  static const DESCRIPTION = "description";
  static const CATEGORY = "category";
  static const FEATURED = "featured";
  static const QUANTITY = "quantity";
  static const BRAND = "brand";
  static const SALE = "sale";
  static const SIZES = "sizes";
  static const COLORS = "colors";

  late String _id;
  late String _name;
  late String _picture;
  late String _description;
  late String _category;
  late String _brand;
  late int _quantity;
  late int _price;
  late bool _sale;
  late bool _featured;
  late List _colors;
  late List _sizes;

  String get id => _id;

  String get name => _name;

  String get picture => _picture;

  String get brand => _brand;

  String get category => _category;

  String get description => _description;

  int get quantity => _quantity;

  int get price => _price;

  bool get featured => _featured;

  bool get sale => _sale;

  List get colors => _colors;

  List get sizes => _sizes;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = (snapshot.data() as Map)[ID];
    _brand = (snapshot.data() as Map)[BRAND];
    _sale = (snapshot.data() as Map)[SALE];
    _description = (snapshot.data() as Map)[DESCRIPTION] ?? " ";
    _featured = (snapshot.data() as Map)[FEATURED];
    _price = (snapshot.data() as Map)[PRICE].floor();
    _category = (snapshot.data() as Map)[CATEGORY];
    _colors = (snapshot.data() as Map)[COLORS];
    _sizes = (snapshot.data() as Map)[SIZES];
    _name = (snapshot.data() as Map)[NAME];
    _picture = (snapshot.data() as Map)[PICTURE];
    _quantity = (snapshot.data() as Map)[QUANTITY];
  }
}
