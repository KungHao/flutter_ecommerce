import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            imageLoaction: 'images/cats/tshirt.png', 
            imageCaption: 'shirt'
          ),
          Category(
            imageLoaction: 'images/cats/dress.png', 
            imageCaption: 'dress'
          ),
          Category(
            imageLoaction: 'images/cats/jeans.png', 
            imageCaption: 'pants'
          ),
          Category(
            imageLoaction: 'images/cats/formal.png', 
            imageCaption: 'formal'
          ),
          Category(
            imageLoaction: 'images/cats/informal.png', 
            imageCaption: 'informal'
          ),
          Category(
            imageLoaction: 'images/cats/shoe.png', 
            imageCaption: 'shoes'
          ),
          Category(
            imageLoaction: 'images/cats/accessories.png', 
            imageCaption: 'accessories'
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String imageLoaction;
  final String imageCaption;

  Category({
    required this.imageLoaction,
    required this.imageCaption
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100,
          height: 100,
          child: ListTile(
            title: Image.asset(
              imageLoaction,
              width: 100,
              height: 80,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(imageCaption, style: TextStyle(fontSize: 14)),
            )
          ),
        )
      ),
    );
  }
}