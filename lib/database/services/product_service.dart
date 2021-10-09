import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  static const REFERENCE = 'products';
  final _firestore = FirebaseFirestore.instance.collection(REFERENCE);
  final _firebaseStorage = FirebaseStorage.instance.ref(REFERENCE);

  void createProduct(String name, String description, String category,
      String price, String discount, String quantity, List<String> images) {
    String id = Uuid().v1();
    downloadImgUrl(name);
    Product product = Product(
        id: id,
        name: name,
        description: description,
        category: category,
        price: price,
        discount: discount,
        quantity: quantity,
        images: images);

    _firestore.doc(id).set(product.toJson());
  }

  Future<List<Product>> queryProduct() async {
    QuerySnapshot<Map<String, dynamic>> data = await _firestore.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> queries = data.docs;
    List<Product> products = [];

    for (var snapshot in queries) {
      Map<String, dynamic> data = snapshot.data();
      products.add(Product.fromJson(data));
    }
    return products;
  }

  Future downloadImgUrl(String name) async {
    print('shit');
    try {
      String urls = await _firebaseStorage
          .child('/test1/1_1633328407125439.png')
          .getDownloadURL();
      print(urls);
    } catch (e) {
      print(e.toString());
    }
  }

  Future uploadImage(Map<int, XFile?> imageFile, String name) async {
    List<String> urls = [];
    UploadTask task;
    try {
      for (MapEntry e in imageFile.entries) {
        File imgFile = File(e.value!.path);
        String fileName = '${e.key}_${DateTime.now().microsecondsSinceEpoch}.jpg';
        task = _firebaseStorage.child(name).child(fileName).putFile(imgFile);
        urls.add(await (await task).ref.getDownloadURL());
      }
    } catch (e) {
      print(e.toString());
    }
    return urls;
  }

  Future<List<Product>> searchProducts({required String productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return _firestore
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((result) {
          List<Product> products = [];
          for (QueryDocumentSnapshot<Map<String, dynamic>> product
              in result.docs) {
            Map<String, dynamic> data = product.data();
            products.add(Product.fromJson(data));
          }
          return products;
        });
  }

  List<String> imgMap2List(Map<int, XFile?> imgs) {
    List<String> imgsList = [];
    imgs.forEach((key, value) {
      String imgStr = value!.path;
      imgsList.add(imgStr);
    });
    return imgsList;
  }
}
