import 'package:flutter/material.dart';

class SizeConfig {
  static late double height;
  static late double width;

  void init(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }
}
