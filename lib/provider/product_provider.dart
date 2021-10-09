import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/database/services/category_service.dart';
import 'package:flutter_ecommerce/database/services/product_service.dart';
import 'package:flutter_ecommerce/models/product.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productServices = ProductService();
  final CategoryService _categoryService = CategoryService();
  List<Product> _products = [];
  List<Product> productsSearched = [];
  List<String> _categories = [];

  List<Product> get products => _products;
  List<String> get categories => _categories;

  ProductProvider() {
    _getProducts();
    _getCategories();
  }

  _getProducts() async {
    _products = await _productServices.queryProduct();
    notifyListeners();
  }

  _getCategories() async {
    _categories = await _categoryService.getCategory();
    notifyListeners();
  }

  Future search({required String productName}) async {
    productsSearched =
        await _productServices.searchProducts(productName: productName);
    notifyListeners();
  }
}
