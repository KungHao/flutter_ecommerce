import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/helpers/app_colors.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/pages/product_details.dart';

class ProductsGridView extends StatefulWidget {
  final List<Product> product;
  const ProductsGridView({ Key? key, required this.product }) : super(key: key);

  @override
  _ProductsGridViewState createState() => _ProductsGridViewState(product);
}

class _ProductsGridViewState extends State<ProductsGridView> {
  _ProductsGridViewState(List<Product> product);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.product.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.all(4),
          child: SingleProduct(
            product: widget.product[index],
          ),
        );
      },
    );
  }
}

class SingleProduct extends StatelessWidget {
  final Product product;
  SingleProduct({Key? key, required this.product}): super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: product.id,
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProductDetails(product: product))
              );
            },
            child: GridTile(
              footer: Container(
                color: white70,
                child: ListTile(
                  leading: Text(product.name, style: TextStyle(fontWeight: FontWeight.bold),),
                  title: Text('\$${product.discount}', style: TextStyle(color: red, fontWeight: FontWeight.w800),),
                  subtitle: Text('\$${product.price}', style: TextStyle(color: black54, fontWeight: FontWeight.w800, decoration: TextDecoration.lineThrough),),
                ),
              ),
              child: Image.network(
                product.images[0], fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}