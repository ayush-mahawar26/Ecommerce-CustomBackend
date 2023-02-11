import 'dart:async';
import 'dart:math';

import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScr extends StatefulWidget {
  const SplashScr({Key? key}) : super(key: key);

  @override
  State<SplashScr> createState() => _SplashScrState();
}

class _SplashScrState extends State<SplashScr> {
  Future _initalCache() async {
    CacheManagerUtils.conditionalCache(
        key: "jwt",
        valueType: ValueType.StringValue,
        actionIfNull: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/login", (route) => false);
        },
        actionIfNotNull: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/home", (route) => false);
        });
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 2), _initalCache);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Amazon"),
      ),
    );
  }
}
