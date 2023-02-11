import 'package:flutter/material.dart';

class ShowSnackBar {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      String text, BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }
}
