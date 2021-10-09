import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/helpers/app_colors.dart';

class CartProducts extends StatefulWidget {
  const CartProducts({ Key? key }) : super(key: key);

  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var productsInCart = [
    {
      'name': "Blazer",
      'picture': 'images/products/blazer1.jpeg',
      'price': 85,
      'size': "M",
      'color': 'Red',
      'quantity': 2
    },
    {
      'name': "Red dress",
      'picture': 'images/products/dress1.jpeg',
      'price': 50,
      'size': "M",
      'color': 'Red',
      'quantity': 2
    },
    {
      'name': "Blazer 2",
      'picture': 'images/products/blazer2.jpeg',
      'price': 50,
      'size': "M",
      'color': 'Red',
      'quantity': 2
    },
    {
      'name': "Dress2",
      'picture': 'images/products/dress2.jpeg',
      'price': 50,
      'size': "M",
      'color': 'Red',
      'quantity': 2
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productsInCart.length,
      itemBuilder: (context, index) {
        return SingleCartProduct(
          prodName: productsInCart[index]['name'], 
          prodPicture: productsInCart[index]['picture'], 
          prodPrice: productsInCart[index]['price'], 
          prodSize: productsInCart[index]['size'], 
          prodColor: productsInCart[index]['color'], 
          prodQty: productsInCart[index]['quantity']);
      },
    );
  }
}

class SingleCartProduct extends StatelessWidget {
  final prodName;
  final prodPicture;
  final prodPrice;
  final prodSize;
  final prodColor;
  final prodQty;


  SingleCartProduct({
    required this.prodName,
    required this.prodPicture,
    required this.prodSize,
    required this.prodPrice,
    required this.prodColor,
    required this.prodQty,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(prodPicture),
        title: Text(prodName),
        subtitle: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(0),
                  child: Text('Size:'),
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(prodSize, style: TextStyle(color: red),),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                  child: Text('Color:'),
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(prodColor),
                ),
              ],
            ),

            Container(
              alignment: Alignment.topLeft,
              child: Text('\$$prodPrice', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: red),),
            )
          ],
        ),
        trailing: Container(
              width: 120,
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5.0),
                          topLeft: Radius.circular(5.0)),
                      color: Colors.black.withOpacity(0.7),
                    ),
                    child: Center(
                      child: Icon(Icons.remove,color: Colors.white),
                    ),
                    width: 40,
                  ),
                  Container(
                    width: 40,
                    color: Colors.white,
                    child: Center(
                      child: Text('0', style: TextStyle(fontSize: 16),),
                    ),
                  ),
                  Container(
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(5.0),
                          topRight: Radius.circular(5.0)),
                      color: Colors.black.withOpacity(0.7),
                    ),
                    child: Center(
                      child: Icon(Icons.add, color: Colors.white,),
                    ),
                  )
                ],
              )),
      ),
    );
  }

  
}