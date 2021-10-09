import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/helpers/app_colors.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/pages/cart.dart';
import 'package:flutter_ecommerce/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Product? product;

  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: white,
        iconTheme: IconThemeData(color: primary),
        title: Text('肉兜兜', style: TextStyle(color: black)),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: primary,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              })
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
            child: GridTile(
              child: Container(
                color: white,
                child: Image.network(product!.images[0], fit: BoxFit.cover),
              ),
              footer: Container(
                color: white70,
                child: ListTile(
                  // leading: Text(widget.prodDetailName, style: TextStyle(fontWeight: FontWeight.bold),),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          product!.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '\$${product!.price}',
                          style: TextStyle(
                              color: grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '\$${product!.discount}',
                          style: TextStyle(
                              color: red, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Size'),
                            content: Text('Choose the size'),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text("Close"),
                              )
                            ],
                          );
                        },
                      );
                    },
                    color: white,
                    textColor: grey,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Size'),
                        ),
                        Expanded(
                          child: Icon(Icons.arrow_drop_down),
                        ),
                      ],
                    )),
              ),
              Expanded(
                child: MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Color'),
                            content: Text('Choose the color'),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text("Close"),
                              )
                            ],
                          );
                        },
                      );
                    },
                    color: white,
                    textColor: grey,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Color'),
                        ),
                        Expanded(
                          child: Icon(Icons.arrow_drop_down),
                        ),
                      ],
                    )),
              ),
              Expanded(
                child: MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Quality'),
                            content: Text('Choose the Quality'),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: Text("Close"),
                              )
                            ],
                          );
                        },
                      );
                    },
                    color: white,
                    textColor: grey,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Qty'),
                        ),
                        Expanded(
                          child: Icon(Icons.arrow_drop_down),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  color: red,
                  textColor: white,
                  elevation: 0.2,
                  child: Text('Buy now'),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: red,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border,
                    color: red,
                  ))
            ],
          ),
          Divider(),
          ListTile(
            title: Text("Product Details"),
            subtitle:
                Text('''Cloning into 'complete_flutter_ecommerce'...remote: 
            Enumerating objects: 512, done.
            remote: Counting objects: 100% (173/173), done.
            remote: Compressing objects: 100% (117/117), done.
            remote: Total 512 (delta 88), reused 126 (delta 52), pack-reused 339R
            Receiving objects:  93% (477/512), 2.16 Mi
            Receiving objects: 100% (512/512), 3.84 MiB | 2.80 MiB/s, done.
            Resolving deltas: 100% (221/221), done.'''),
          ),
          Divider(),
          Row(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12, 5, 5, 5),
              child: Text(
                'Product name: ',
                style: TextStyle(color: grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                '${product!.name}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ]),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text('Similar products'),
          ),
          Container(
            height: 360,
            child: SimilarProducts(),
          )
        ],
      ),
    );
  }
}

class SimilarProducts extends StatefulWidget {
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return GridView.builder(
        itemCount: productProvider.products.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return SimilarSingleProduct(product: productProvider.products[index]);
        });
  }
}

class SimilarSingleProduct extends StatelessWidget {
  final Product product;
  const SimilarSingleProduct({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: product.id,
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetails(
                        product: product,
                      )));
            },
            child: GridTile(
              footer: Container(
                color: white70,
                child: ListTile(
                  leading: Text(
                    product.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  title: Text(
                    '\$${product.discount}',
                    style: TextStyle(color: red, fontWeight: FontWeight.w800),
                  ),
                  subtitle: Text(
                    '\$${product.price}',
                    style: TextStyle(
                        color: black54,
                        fontWeight: FontWeight.w800,
                        decoration: TextDecoration.lineThrough),
                  ),
                ),
              ),
              child: Image.network(product.images[0], fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}
