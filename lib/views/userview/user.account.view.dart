import 'package:ecommerce_custom_backend/constants/colors.dart';
import 'package:ecommerce_custom_backend/constants/size.config.dart';
import 'package:ecommerce_custom_backend/cubits/auth.cubit.dart';
import 'package:ecommerce_custom_backend/widgets/custom.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAccountView extends StatelessWidget {
  const UserAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit user = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().blue,
        elevation: 0,
        flexibleSpace: Container(
            decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[AppColors().blue, AppColors().lblue]),
        )),
        title: const Image(
          image: AssetImage("assets/images/amazonlogo.png"),
          width: 100,
        ),
        actions: const [
          Icon(
            Icons.notifications_none_outlined,
            color: Colors.black,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(Icons.search, color: Colors.black),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Profile header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Hello, ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    Text(
                      user.user.username.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    )
                  ],
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 25,
                  child: Image.asset("assets/images/amazonlogo.png"),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // 4 button ( order , buy again , your account , Your wishlist)

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomWidget().customAccountButton(
                        "Your Order", () {}, SizeConfig.width / 2.2, context),
                    CustomWidget().customAccountButton(
                        "Buy Again", () {}, SizeConfig.width / 2.2, context),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomWidget().customAccountButton(
                        "Your Account", () {}, SizeConfig.width / 2.2, context),
                    CustomWidget().customAccountButton("Your Wishlist", () {},
                        SizeConfig.width / 2.2, context),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
