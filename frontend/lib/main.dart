import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/domain/auth_cubit/auth.cubit.dart';
import 'package:frontend/domain/auth_cubit/auth.state.dart';
import 'package:frontend/routes/app.route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthenticationCubit(AuthInitalState()))
      ],
      child: MaterialApp(
        initialRoute: "/splash",
        onGenerateRoute: AppRoute().genrateRoute,
      ),
    );
  }
}
