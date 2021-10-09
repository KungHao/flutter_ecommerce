import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/componets/cart_products.dart';
import 'package:flutter_ecommerce/helpers/app_colors.dart';

class Cart extends StatefulWidget {
  const Cart({ Key? key }) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close, color: primary)),
        elevation: 0.2,
        backgroundColor: white,
        title: Text("購物車", style: TextStyle(color: primary),textAlign: TextAlign.center),
      ),

      body: CartProducts(),

      bottomNavigationBar: Container(
        color: white,
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text("Total:"),
                subtitle: Text('\$230'),
              ),
            ),

            Expanded(
              child: MaterialButton(
                onPressed: () {},
                child: Text("Check out", style: TextStyle(color: white),),
                color: red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}