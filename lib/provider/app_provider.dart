import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/database/services/product_service.dart';
import 'package:flutter_ecommerce/models/product.dart';

class AppProvider with ChangeNotifier {
  List<Product> _product = [];
  ProductService _productService = ProductService();

  AppProvider () {
    _getProducts();
  }

  // getter
  List<Product> get products => _product;

  void _getProducts() async {
    _product = await _productService.queryProduct();
    notifyListeners();
  }
}
