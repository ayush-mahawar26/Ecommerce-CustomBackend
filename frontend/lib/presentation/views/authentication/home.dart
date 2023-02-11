import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("HomePage"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        DeleteCache.deleteKey(
            "jwt",
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/login", (route) => false));
      }),
      body: const Center(
        child: Text("HomePage"),
      ),
    );
  }
}
