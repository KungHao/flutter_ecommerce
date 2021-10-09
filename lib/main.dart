import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/helpers/app_colors.dart';
import 'package:flutter_ecommerce/pages/account/account_detail.dart';
import 'package:flutter_ecommerce/pages/authentication/authentication.dart';
import 'package:flutter_ecommerce/pages/home/splash.dart';
import 'package:flutter_ecommerce/pages/account/login.dart';
import 'package:flutter_ecommerce/provider/app_provider.dart';
import 'package:flutter_ecommerce/provider/auth_provider.dart';
import 'package:flutter_ecommerce/pages/home/home_page.dart';
import 'package:flutter_ecommerce/componets/loading.dart';
import 'package:flutter_ecommerce/pages/wrapper.dart';
import 'package:flutter_ecommerce/provider/product_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(
            value: AuthProvider.initialize()),
        ChangeNotifierProvider<AppProvider>.value(
          value: AppProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>.value(
          value: ProductProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: primary),
        home: HomePage(),
      ),
    );
  }
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);

    switch (user.status) {
      case Status.Uninitialized:
        return Authentication();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return HomePage();
      case Status.Authenticated:
        return AccountDetail();
      default:
        return Login();
    }
  }
}
