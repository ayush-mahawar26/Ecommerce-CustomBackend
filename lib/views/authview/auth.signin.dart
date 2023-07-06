import 'package:ecommerce_custom_backend/constants/colors.dart';
import 'package:ecommerce_custom_backend/constants/size.config.dart';
import 'package:ecommerce_custom_backend/cubits/auth.cubit.dart';
import 'package:ecommerce_custom_backend/cubits/states/auth.state.dart';
import 'package:ecommerce_custom_backend/views/sellerview/seller.bottomnav.dart';
import 'package:ecommerce_custom_backend/views/userview/user.bottombar.dart';
import 'package:ecommerce_custom_backend/widgets/custom.widget.dart';
import 'package:ecommerce_custom_backend/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class SignInUser extends StatefulWidget {
  SignInUser({super.key});

  @override
  State<SignInUser> createState() => _SignInUserState();
}

class _SignInUserState extends State<SignInUser> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _name = TextEditingController();

  var _character = "signup";

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: colors.grey,
        title: Image.asset(
          "assets/images/amazonlogo.png",
          width: 100,
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Welcome",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration:
                    BoxDecoration(border: Border.all(color: colors.grey)),
                child: Column(
                  children: [
                    Container(
                      color:
                          (_character == "signin") ? colors.grey : Colors.white,
                      child: Column(
                        children: [
                          ListTile(
                            title: RowText(
                                "Create account.", "New to Amazon?", context),
                            leading: Radio(
                              groupValue: _character,
                              value: "signup",
                              onChanged: (value) {
                                setState(() {
                                  _character = value!;
                                });
                              },
                            ),
                          ),
                          (_character == "signup")
                              ? createAccountFeild(
                                  _name, _email, _pass, context, authCubit)
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color:
                          (_character == "signup") ? colors.grey : Colors.white,
                      child: Column(
                        children: [
                          ListTile(
                            title: RowText(
                                "Sign in.", "Already a Customer?", context),
                            leading: Radio(
                              groupValue: _character,
                              value: "signin",
                              onChanged: (value) {
                                setState(() {
                                  _character = value!;
                                });
                              },
                            ),
                          ),
                          (_character == "signin")
                              ? signinAccount(_email, _pass, context, authCubit)
                              : const SizedBox(),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget RowText(String val1, String val2, BuildContext context) {
  return Row(
    children: [
      Text(
        val1,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      Text(
        val2,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15),
      )
    ],
  );
}

createAccountFeild(TextEditingController name, TextEditingController email,
    TextEditingController pass, BuildContext context, AuthCubit authCubit) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomWidget().customTextFeild(name, "First and last name"),
        const SizedBox(
          height: 10,
        ),
        CustomWidget().customTextFeild(email, "Email Address"),
        const SizedBox(
          height: 10,
        ),
        CustomWidget().customTextFeild(pass, "Password", isPass: true),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Password must contain atleast 6 character",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15),
        ),
        const SizedBox(
          height: 20,
        ),

        BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
          if (state is AuthLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors().golden,
              ),
            );
          }

          if (state is AuthDoneState) {
            return CustomWidget().customMainButton(
                "Create Account", () {}, SizeConfig.width, context);
          }

          if (state is AuthErrorState) {
            return CustomWidget().customMainButton("Create Account", () async {
              String username = name.text.trim();
              String mail = email.text.trim();
              String password = pass.text.trim();
              if (mail.isEmpty || password.isEmpty || username.isEmpty) {
                ShowMessage().showSnackBar("Fill All Credentials", context);
              } else {
                await authCubit.signUpUser(
                    username, mail, password, "user", context);
              }
            }, SizeConfig.width, context);
          }

          return CustomWidget().customMainButton("Create Account", () async {
            String username = name.text.trim();
            String mail = email.text.trim();
            String password = pass.text.trim();

            if (username.isEmpty || mail.isEmpty || password.isEmpty) {
              ShowMessage().showSnackBar("Fill All The Creadentials", context);
            } else {
              await authCubit.signUpUser(
                  username, mail, password, "user", context);
            }
          }, SizeConfig.width, context);
        }, listener: (context, state) {
          if (state is AuthErrorState) {
            ShowMessage().showSnackBar(state.err, context);
          }

          if (state is AuthDoneState) {
            String token = state.user.token!;
            authCubit.saveToken(token);

            ShowMessage().showSnackBar("Successfully Created Account", context);
            if (state.user.type == "user") {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeUserView()),
                  (route) => false);
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const SellerView()),
                  (route) => false);
            }
          }
        })

        // CustomWidget()
        //     .customMainButton("Create Account", () {}, SizeConfig.width, context)
      ],
    ),
  );
}

signinAccount(TextEditingController email, TextEditingController pass,
    BuildContext context, AuthCubit authCubit) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomWidget().customTextFeild(email, "Email Address"),
        const SizedBox(
          height: 10,
        ),
        CustomWidget().customTextFeild(pass, "Password", isPass: true),
        const SizedBox(
          height: 20,
        ),
        BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
          if (state is AuthLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors().golden,
              ),
            );
          }

          if (state is AuthDoneState) {
            return CustomWidget()
                .customMainButton("Sign in", () {}, SizeConfig.width, context);
          }

          if (state is AuthErrorState) {
            return CustomWidget().customMainButton("Sign in", () async {
              String mail = email.text.trim();
              String password = pass.text.trim();
              if (mail.isEmpty || password.isEmpty) {
                ShowMessage().showSnackBar("Fill All Credentials", context);
              } else {
                await authCubit.signInUser(mail, password);
              }
            }, SizeConfig.width, context);
          }

          return CustomWidget().customMainButton("Sign in", () async {
            String mail = email.text.trim();
            String password = pass.text.trim();
            if (mail.isEmpty || password.isEmpty) {
              ShowMessage().showSnackBar("Fill All Credentials", context);
            } else {
              await authCubit.signInUser(mail, password);
            }
          }, SizeConfig.width, context);
        }, listener: (context, state) {
          if (state is AuthErrorState) {
            ShowMessage().showSnackBar(state.err, context);
          }

          if (state is AuthDoneState) {
            String token = state.user.token!;
            authCubit.saveToken(token);
            ShowMessage().showSnackBar("Succesfully Logged In", context);
            if (state.user.type == "user") {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeUserView()),
                  (route) => false);
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const SellerView()),
                  (route) => false);
            }
          }
        }),
        const SizedBox(
          height: 20,
        )
      ],
    ),
  );
}


// BlocConsumer<AuthCubit, AuthState>(
//               listener: (context, state) {
                // if (state is AuthErrorState) {
                //   ShowMessage().showSnackBar(state.err, context);
                // }

                // if (state is AuthDoneState) {
                //   String token = state.user.token!;
                //   authCubit.saveToken(token);
                //   ShowMessage().showSnackBar("Succesfully Logged In", context);
                //   if (state.user.type == "user") {
                //     Navigator.of(context).pushAndRemoveUntil(
                //         MaterialPageRoute(builder: (context) => HomeUserView()),
                //         (route) => false);
                //   } else {
                //     Navigator.of(context).pushAndRemoveUntil(
                //         MaterialPageRoute(builder: (context) => SellerView()),
                //         (route) => false);
                //   }
                // }
//               },
//               builder: (context, state) {
//                 if (state is AuthLoadingState) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }

//                 if (state is AuthDoneState) {
//                   return ElevatedButton(
//                       onPressed: () {}, child: Text("SignIn"));
//                 }
//                 return ElevatedButton(
//                     onPressed: () async {
//                       String email = _email.text.trim();
//                       String pass = _pass.text.trim();

//                       if (email.isEmpty || pass.isEmpty) {
//                         ShowMessage().showSnackBar("Enter All Creds", context);
//                       } else {
//                         await authCubit.signInUser(email, pass);
//                       }
//                     },
//                     child: Text("SignIn"));
//               },
//             )
