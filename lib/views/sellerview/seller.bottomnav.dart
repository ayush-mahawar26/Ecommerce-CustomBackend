import 'dart:convert';

import 'package:ecommerce_custom_backend/constants/colors.dart';
import 'package:ecommerce_custom_backend/constants/global.variable.dart';
import 'package:ecommerce_custom_backend/cubits/get.product.cubit.dart';
import 'package:ecommerce_custom_backend/cubits/states/get.product.state.dart';
import 'package:ecommerce_custom_backend/models/product.model.dart';
import 'package:ecommerce_custom_backend/views/sellerview/add.product.view.dart';
import 'package:ecommerce_custom_backend/views/sellerview/seller.home.dart';
import 'package:ecommerce_custom_backend/views/sellerview/sellers.profile.dart';
import 'package:ecommerce_custom_backend/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class SellerView extends StatefulWidget {
  const SellerView({super.key});

  @override
  State<SellerView> createState() => _SellerViewState();
}

class _SellerViewState extends State<SellerView> {
  int _page = 0;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> sellersScreen = [
    SellerHomePage(),
    Scaffold(
      body: Center(
        child: Text("Cart"),
      ),
    ),
    SellersProfile()
  ];

  @override
  Widget build(BuildContext context) {
    GettingProductCubit cubit =
        BlocProvider.of<GettingProductCubit>(context, listen: true);
    return Scaffold(
      body: sellersScreen[_page],
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
