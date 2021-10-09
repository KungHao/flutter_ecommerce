import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  static const ID = 'id';
  static const NAME = 'name';
  static const DESCRIPTION = 'description';
  static const CATEGORY = 'category';
  static const PRICE = 'price';
  static const DISCOUNT = 'discount';
  static const QUANTITY = 'quantity';
  static const IMAGES = 'images';

  final id;
  final String name;
  final String description;
  final String category;
  final String price;
  final String discount;
  final String quantity;
  final List images;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      required this.price,
      required this.discount,
      required this.quantity,
      required this.images});

  factory Product.fromJson(Map<String, dynamic>? json) {
    return Product(
        id: json![ID],
        name: json[NAME],
        description: json[DESCRIPTION],
        category: json[CATEGORY],
        price: json[PRICE],
        discount: json[DISCOUNT],
        quantity: json[QUANTITY],
        images: json[IMAGES]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'discount': discount,
      'quantity': quantity,
      'images': images
    };
  }
}
