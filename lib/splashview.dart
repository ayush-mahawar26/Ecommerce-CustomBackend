import 'dart:async';

import 'package:ecommerce_custom_backend/constants/size.config.dart';
import 'package:ecommerce_custom_backend/cubits/auth.cubit.dart';
import 'package:ecommerce_custom_backend/services/auth.service.dart';
import 'package:ecommerce_custom_backend/views/authview/auth.signin.dart';
import 'package:ecommerce_custom_backend/views/sellerview/seller.bottomnav.dart';
import 'package:ecommerce_custom_backend/views/userview/user.bottombar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/usermodel.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? token = pref.getString("token");

    if (token != null) {
      // get the user
      UserModel user = await AuthService().getTheUser(token);

      // Set the user
      BlocProvider.of<AuthCubit>(context).user = user;

      print(user.type);

      // Navigate to home
      if (user.type == "user") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeUserView()),
            (route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SellerView()),
            (route) => false);
      }
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignInUser()),
          (route) => false);
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 1), getToken);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Image(
          image: const AssetImage("assets/images/amazonlogo.png"),
          height: SizeConfig.height / 5,
          width: SizeConfig.width / 2,
        ),
      ),
    );
  }
}
