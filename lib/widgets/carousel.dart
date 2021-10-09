// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';

int currentPos = 0;
List<String> imgs = ['images/imgs/m1.jpeg', 'images/imgs/m2.jpg', 'images/imgs/c1.jpg', 'images/imgs/w1.jpeg', 'images/imgs/w3.jpeg'];

// Widget imageCarousel = Container(
//     height: 200.0,
//     child: CarouselSlider(
//       options: CarouselOptions(
//         enlargeCenterPage: true,
//         enableInfiniteScroll: false,
//         autoPlay: true,
//         onPageChanged: (index, reason) {
//           setState(() {
//             currentPos = index;
//           });
//         }
//       ),
//       items: imgs.map((e) => ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: Stack(
//             fit: StackFit.expand,
//             children: <Widget>[
//               Image(image: AssetImage(e), width: 1000, height: 500, fit: BoxFit.cover)
//             ]
//           ),
//         )).toList()
//     )
//   );

// Widget imageRow = Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: imgs.map((url) {
//     int index = imgs.indexOf(url);
//     return Container(
//       width: 8.0,
//       height: 8.0,
//       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: currentPos == index
//             ? Color.fromRGBO(0, 0, 0, 0.9)
//             : Color.fromRGBO(0, 0, 0, 0.4),
//       ),
//     );
//   }).toList(),
// );

Widget carouselSlider = Container(
  height: 250,
  child: CarouselSlider.builder(
    enableAutoSlider: true,
    unlimitedMode: true,
    slideBuilder: (index) {
      return ClipRRect(
        // borderRadius: BorderRadius.circular(20),
        child: Image(image: AssetImage(imgs[index]), width: 1000, height: 350, fit: BoxFit.cover),
      );
    },
    slideTransform: CubeTransform(),
    slideIndicator: CircularSlideIndicator(
      padding: EdgeInsets.only(bottom: 32),
    ),
    itemCount: imgs.length,
    ),
);