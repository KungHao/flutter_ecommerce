import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/componets/loading.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Loading()
            ],
          ),
        ],
      ),
    );
  }
}