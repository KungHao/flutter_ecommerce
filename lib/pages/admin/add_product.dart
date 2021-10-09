import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/database/services/category_service.dart';
import 'package:flutter_ecommerce/database/services/product_service.dart';

import 'package:flutter_ecommerce/helpers/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final CategoryService _categoryService = CategoryService();
  final ProductService _productService = ProductService();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  List<QueryDocumentSnapshot> categories = <QueryDocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  String? _currentCategory;
  Map<int, XFile?> _imageFile = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCategories();
    // categoriesDropDown = getCategoriesDropdown();
    // _currentCategory = categoriesDropDown[0].value!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.1,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close, color: black)),
        title: Text(
          'Add Product',
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: grey.withOpacity(0.5), width: 2.5)),
                      onPressed: () {
                        _selectImage(
                            ImagePicker()
                                .pickImage(source: ImageSource.gallery),
                            1);
                      },
                      child: _displayChildImg(1),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: grey.withOpacity(0.5), width: 2.5)),
                      onPressed: () {
                        _selectImage(
                            ImagePicker()
                                .pickImage(source: ImageSource.gallery),
                            2);
                      },
                      child: _displayChildImg(2),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: grey.withOpacity(0.5), width: 2.5)),
                      onPressed: () {
                        _selectImage(
                            ImagePicker()
                                .pickImage(source: ImageSource.gallery),
                            3);
                      },
                      child: _displayChildImg(3),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child:
                      Text('商品分類:', style: TextStyle(color: red, fontSize: 14)),
                ),
                DropdownButton(
                  value: _currentCategory,
                  items: categoriesDropDown,
                  onChanged: (String? val) => changeSeletedCategory(val!),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(hintText: '商品名稱'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '請輸入商品名稱';
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '數量',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '請輸入產品數量';
                  } else if (int.parse(value) > 10000) {
                    return '請輸入適當的產品數量';
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '價格',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '請輸入產品價格';
                  } else if (int.parse(value) > 100000) {
                    return '請輸入適當的產品價格';
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _discountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '特價價格',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return '請輸入產品特價價格';
                  } else if (int.parse(value) > 100000) {
                    return '請輸入適當的產品價格';
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(primary))
                  : TextButton(
                      onPressed: () => validateAndUpload(),
                      style: TextButton.styleFrom(backgroundColor: red),
                      child: Text("確認",
                          style: TextStyle(color: white, fontSize: 24.0)),
                    ),
            )
          ],
        ),
      ),
    );
  }

  _getCategories() async {
    List<String> categories =
        await _categoryService.getCategory();

    List<DropdownMenuItem<String>> items = [];
    for (var category in categories) {
      items.add(DropdownMenuItem(
        child: Text(category),
        value: category,
      ));
    }
    setState(() {
      categoriesDropDown = items;
      _currentCategory = categoriesDropDown[0].value!;
    });
  }

  changeSeletedCategory(String selectedCategory) {
    setState(() {
      _currentCategory = selectedCategory;
    });
  }

  void _selectImage(Future<XFile?> pickImage, int index) async {
    XFile? tempImg = await pickImage;
    if (tempImg != null) {
      switch (index) {
        case 1:
          setState(() {
            _imageFile[1] = tempImg;
          });
          break;
        case 2:
          setState(() {
            _imageFile[2] = tempImg;
          });
          break;
        case 3:
          setState(() {
            _imageFile[3] = tempImg;
          });
      }
    }
  }

  Widget _displayChildImg(int index) {
    if (_imageFile[index] == null) {
      return Padding(
        padding: EdgeInsets.fromLTRB(14, 40, 14, 40),
        child: Icon(Icons.add, color: grey),
      );
    } else {
      File imageFile = File(_imageFile[index]!.path);
      return Image.file(
        imageFile,
      );
    }
  }

  void validateAndUpload() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      if (_imageFile[1] != null &&
          _imageFile[2] != null &&
          _imageFile[3] != null) {
        // Upload Images with product name to Firebase storage
        List<String> urls = await _productService.uploadImage(
            _imageFile, _productNameController.text);

        // Upload Product data to firebase
        _productService.createProduct(
            _productNameController.text,
            'discription',
            _currentCategory!,
            _priceController.text,
            _discountController.text,
            _quantityController.text,
            urls);
            
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: '上傳成功');
        _formKey.currentState!.reset();
      } else {
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: '請上傳三張商品圖片');
      }
    }
  }
}
