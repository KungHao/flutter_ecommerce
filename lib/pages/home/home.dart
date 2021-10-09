import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/componets/products_gridview.dart';
import 'package:flutter_ecommerce/database/services/product_service.dart';
import 'package:flutter_ecommerce/helpers/app_colors.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:flutter_ecommerce/pages/admin/admin.dart';
import 'package:flutter_ecommerce/pages/user_account.dart';
import 'package:flutter_ecommerce/pages/cart.dart';
import 'package:flutter_ecommerce/provider/app_provider.dart';
import 'package:flutter_ecommerce/provider/auth_provider.dart';
import 'package:flutter_ecommerce/provider/product_provider.dart';
import 'package:flutter_ecommerce/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    
    return DefaultTabController(
        initialIndex: 0,
        length: productProvider.categories.length,
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: primary),
              elevation: 0.1,
              backgroundColor: white,
              title: Material(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[100],
                elevation: 0.0,
                child: TextFormField(
                  controller: null,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      hintText: "Search...",
                      border: InputBorder.none),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "The search field cannot be empty";
                    }
                    return null;
                  },
                ),
              ),
              actions: <Widget>[
                new IconButton(
                    icon: Icon(Icons.search, color: primary), onPressed: () {}),
                new IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: primary,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Cart()));
                    })
              ],
              bottom: TabBar(
                  labelColor: primary,
                  indicatorColor: primary,
                  unselectedLabelColor: grey,
                  controller: null,
                  isScrollable: true,
                  tabs: [
                    for (var tab in productProvider.categories) Tab(text: tab)
                  ]),
            ),
            drawer: Drawer(
              child: StreamBuilder<QuerySnapshot<UserModel>>(
                  builder: (context, snapshot) {
                return ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: primary),
                      accountName: CustomText(
                          text: 'userName',
                          color: white,
                          weight: FontWeight.bold,
                          size: 18),
                      accountEmail: CustomText(text: 'userEmail', color: white),
                      currentAccountPicture: GestureDetector(
                        child: CircleAvatar(
                          backgroundColor: grey,
                          child: Icon(
                            Icons.person,
                            color: white,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ProductService().downloadImgUrl('test1');
                      },
                      child: ListTile(
                        leading: Icon(Icons.home),
                        title: CustomText(text: "My Home"),
                      ),
                    ),
                    InkWell(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Admin()));
                        },
                        leading: Icon(Icons.admin_panel_settings),
                        title: CustomText(text: "Admin"),
                      ),
                    ),
                    InkWell(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserAccount()));
                        },
                        leading: Icon(Icons.settings),
                        title: CustomText(text: "Settings"),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: ListTile(
                        onTap: () {
                          authProvider.signOut();
                        },
                        leading: Icon(Icons.exit_to_app),
                        title: CustomText(text: "Logout"),
                      ),
                    ),
                  ],
                );
              }),
            ),
            body: Column(
              children: <Widget>[
                // carousel slider
                // carouselSlider,

                // Horizontal list view begins here
                // CategoryList(),

                //padding widget
                // Padding(
                //   padding: const EdgeInsets.all(20.0),
                //   child: Text("Recent products"),
                // ),

                //grid view of products
                Flexible(
                    child: ProductsGridView(product: productProvider.products))
              ],
            )));
  }
}
