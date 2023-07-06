import 'package:ecommerce_custom_backend/cubits/auth.cubit.dart';
import 'package:ecommerce_custom_backend/models/usermodel.dart';
import 'package:ecommerce_custom_backend/views/userview/user.account.view.dart';
import 'package:ecommerce_custom_backend/views/userview/user.cart.dart';
import 'package:ecommerce_custom_backend/views/userview/user.home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/colors.dart';

class HomeUserView extends StatefulWidget {
  const HomeUserView({super.key});

  @override
  State<HomeUserView> createState() => _HomeUserViewState();
}

class _HomeUserViewState extends State<HomeUserView> {
  int _page = 0;

  updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> screens = [UserHome(), UserCartView(), UserAccountView()];

  @override
  Widget build(BuildContext context) {
    AuthCubit _authCubit = BlocProvider.of<AuthCubit>(context, listen: true);
    return Scaffold(
      body: screens[_page],
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 1, color: AppColors().grey)),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          onTap: ((value) {
            updatePage(value);
          }),
          currentIndex: _page,
          selectedItemColor: AppColors().selectedItems,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
                label: "",
                icon: Container(
                  height: 40,
                  width: 42,
                  decoration: BoxDecoration(
                      border: Border(
                          top: (_page == 0)
                              ? BorderSide(
                                  color: AppColors().selectedItems,
                                  width: 5,
                                )
                              : BorderSide.none)),
                  child: const Icon(Icons.home_outlined),
                )),
            BottomNavigationBarItem(
                label: "",
                icon: Container(
                  height: 40,
                  width: 42,
                  decoration: BoxDecoration(
                      border: Border(
                          top: (_page == 1)
                              ? BorderSide(
                                  color: AppColors().selectedItems,
                                  width: 5,
                                )
                              : BorderSide.none)),
                  child: const Icon(Icons.shopping_cart_outlined),
                )),
            BottomNavigationBarItem(
                label: "",
                icon: Container(
                  height: 40,
                  width: 42,
                  decoration: BoxDecoration(
                      border: Border(
                          top: (_page == 2)
                              ? BorderSide(
                                  color: AppColors().selectedItems,
                                  width: 5,
                                )
                              : BorderSide.none)),
                  child: const Icon(Icons.person_2_outlined),
                )),
          ],
        ),
      ),
    );
  }
}
