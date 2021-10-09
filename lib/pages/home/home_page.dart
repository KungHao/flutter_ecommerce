import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/pages/account/user_wrapper.dart';
import 'package:flutter_ecommerce/pages/user_account.dart';
import 'package:flutter_ecommerce/pages/home/home.dart';
import 'package:flutter_ecommerce/helpers/app_colors.dart';
import 'package:flutter_ecommerce/pages/admin/admin.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final RestorableInt tabIndex = RestorableInt(0);
  // late TabController _tabController;
  // final CategoryService _categoryService = CategoryService();
  // @override
  // String get restorationId => 'tab_scrollable';

  // @override
  // void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
  //   registerForRestoration(tabIndex, 'tab_index');
  //   _tabController.index = tabIndex.value;
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: 3, vsync: this, initialIndex: 0);

  //   _tabController.addListener(() {
  //     setState(() {
  //       tabIndex.value = _tabController.index;
  //     });
  //   });
  // }
  int _currentIndex = 0; //預設值

  @override
  Widget build(BuildContext context) {
    final pages = [Home(), Admin(), UserWrapper()];
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "首頁"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: "Admin"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "我的帳戶"),
        ],
        currentIndex: _currentIndex,
        fixedColor: primary,
        onTap: _onItemClick,
      ),
    );
  }

  void _onItemClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
