import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/helpers/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          color: white,
          child: SpinKitFadingCircle(
            color: black,
            size: 30,
          )
      ),
    );
  }
}