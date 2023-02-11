import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/splash.dart';
import 'package:frontend/presentation/views/authentication/home.dart';
import 'package:frontend/presentation/views/authentication/login.view.dart';
import 'package:frontend/presentation/views/authentication/signup.view.dart';

class AppRoute {
  Route? genrateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/splash":
        {
          return MaterialPageRoute(builder: (_) => const SplashScr());
        }
      case "/login":
        {
          return MaterialPageRoute(builder: (_) => LoginPage());
        }
      case "/register":
        {
          return MaterialPageRoute(builder: (_) => RegisterPage());
        }
      case "/home":
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}
