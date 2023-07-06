import 'package:ecommerce_custom_backend/constants/theme.dart';
import 'package:ecommerce_custom_backend/cubits/add.product.cubit.dart';
import 'package:ecommerce_custom_backend/cubits/auth.cubit.dart';
import 'package:ecommerce_custom_backend/cubits/get.product.cubit.dart';
import 'package:ecommerce_custom_backend/splashview.dart';
import 'package:ecommerce_custom_backend/views/authview/auth.signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
          BlocProvider<ProductAddCubit>(create: (context) => ProductAddCubit()),
          BlocProvider<GettingProductCubit>(
              create: (context) => GettingProductCubit()),
        ],
        child: MaterialApp(
          home: SplashView(),
          theme: AppTheme().customAppTheme(),
        ));
  }
}
