import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_custom_backend/constants/global.variable.dart';
import 'package:ecommerce_custom_backend/constants/size.config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CrouselImageWidget extends StatelessWidget {
  List images;
  CrouselImageWidget({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: images.map((e) {
          return Builder(builder: ((context) {
            return SizedBox(
              height: 200,
              width: SizeConfig.width,
              child: Image.network(e),
            );
          }));
        }).toList(),
        options: CarouselOptions(height: 200, viewportFraction: 1));
  }
}
