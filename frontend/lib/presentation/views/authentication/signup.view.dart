import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/api/api.connection.dart';
import 'package:frontend/domain/auth_cubit/auth.cubit.dart';
import 'package:frontend/domain/auth_cubit/auth.state.dart';
import 'package:frontend/presentation/widgets/snackbar.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthenticationCubit authCubit =
        BlocProvider.of<AuthenticationCubit>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Register"),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/login", (route) => false);
        }),
        body: BlocConsumer<AuthenticationCubit, AuthState>(
            builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: mailController,
                    decoration: const InputDecoration(
                        hintText: "Email or Phone Number"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passController,
                    decoration: const InputDecoration(hintText: "Password"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () async {
                        authCubit.createUser(
                            email: mailController.text,
                            pass: passController.text,
                            context: context);
                      },
                      child: const Text("Register"))
                ],
              ),
            ),
          );
        }, listener: (context, state) {
          if (state is AuthCompleteState) {
            ShowSnackBar().snackBar(state.key, context);
          }
          if (state is AuthErrorState) {
            ShowSnackBar().snackBar(state.error, context);
          }
        }));
  }
}
