import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/database/services/category_service.dart';
import 'package:flutter_ecommerce/helpers/app_colors.dart';
import 'package:flutter_ecommerce/pages/admin/add_product.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum Page { dashboard, manage }

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  Page _selectedPage = Page.dashboard;
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  CategoryService _categodyService = CategoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    _selectedPage = Page.dashboard;
                  });
                },
                icon: Icon(
                  Icons.dashboard,
                  color: _selectedPage == Page.dashboard ? active : notActive,
                ),
                label: Text("Dashboard"),
              ),
            ),
            Expanded(
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    _selectedPage = Page.manage;
                  });
                },
                icon: Icon(
                  Icons.sort,
                  color: _selectedPage == Page.manage ? active : notActive,
                ),
                label: Text("Manage"),
              ),
            )
          ],
        ),
        elevation: 0.0,
        backgroundColor: white,
      ),
      body: _loadScreen(),
    );
  }

  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: [
            ListTile(
              subtitle: TextButton.icon(
                onPressed: null,
                icon: Icon(
                  Icons.attach_money,
                  size: 30.0,
                  color: green,
                ),
                label: Text(
                  '12,000',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, color: green),
                ),
              ),
              title: Text('Revenue',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, color: grey)),
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: [
                  Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: TextButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.person_outline),
                            label: Text("Users")),
                        subtitle: Text(
                          '7',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 60.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                        title: TextButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.category),
                            label: Text("Categories")),
                        subtitle: Text(
                          '23',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 60.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      case Page.manage:
        return ListView(
          children: [
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add product'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AddProduct()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.change_history),
              title: Text('Product List'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text('Add Category'),
              onTap: () {
                _categoryAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Category List'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text('Brand List'),
              onTap: () {},
            ),
            Divider(),
          ],
        );
      default:
        return Container();
    }
  }

  void _categoryAlert() {
    var alert = AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: categoryController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Category cannot be empty';
            }
          },
          decoration: InputDecoration(hintText: 'Add Category'),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              if (_categoryFormKey.currentState!.validate()) {
                _categodyService.createCategory(categoryController.text);
                Fluttertoast.showToast(msg: 'category is added');
                Navigator.pop(context);
                categoryController.clear();
              }
            },
            child: Text("Add")),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel")),
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }
}
