import 'package:flutter/material.dart';

class ShowMessage {
  showSnackBar(String mssg, BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mssg)));
  }
}
