import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/pages/admin/admin.dart';
import 'package:flutter_ecommerce/pages/user_account.dart';
import 'package:flutter_ecommerce/pages/home/home_page.dart';

class BottomNavigationController extends StatefulWidget {
  const BottomNavigationController({Key? key}) : super(key: key);

  @override
  _BottomNavigationControllerState createState() =>
      _BottomNavigationControllerState();
}

class _BottomNavigationControllerState
    extends State<BottomNavigationController> {
  int _currentIndex = 0; //預設值
  final pages = [HomePage(), Admin(), UserAccount()];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "首頁"),
        BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: "Admin"),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "我的帳戶"),
      ],
      currentIndex: _currentIndex,
      fixedColor: Colors.amber,
      onTap: _onItemClick,
    );
  }

  void _onItemClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
