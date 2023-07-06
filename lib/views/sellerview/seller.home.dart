import 'dart:io';

import 'package:ecommerce_custom_backend/constants/colors.dart';
import 'package:ecommerce_custom_backend/cubits/auth.cubit.dart';
import 'package:ecommerce_custom_backend/cubits/get.product.cubit.dart';
import 'package:ecommerce_custom_backend/cubits/states/get.product.state.dart';
import 'package:ecommerce_custom_backend/models/product.model.dart';
import 'package:ecommerce_custom_backend/views/sellerview/add.product.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellerHomePage extends StatefulWidget {
  const SellerHomePage({super.key});

  @override
  State<SellerHomePage> createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  getProducts() async {
    GettingProductCubit product = BlocProvider.of<GettingProductCubit>(context);
    AuthCubit _auth = BlocProvider.of<AuthCubit>(context);

    await product.getProductByUser(_auth.user.username!);
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GettingProductCubit product = BlocProvider.of<GettingProductCubit>(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors().selectedItems,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddProductView()));
        },
        child: Icon(Icons.add),
      ),
      body: BlocConsumer<GettingProductCubit, GetProductState>(
          builder: (context, state) {
            if (state is GetProductErrorState) {
              return const Center(
                child: Text("Error"),
              );
            }

            if (state is GotAllProductState) {
              return Center(
                child: ListView.builder(
                    itemCount: product.productByUser.length,
                    itemBuilder: (context, index) {
                      ProductModel prModel =
                          ProductModel.fromJson(product.productByUser[index]);
                      return Center(
                        child: Text(
                          prModel.name.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(),
                        ),
                      );
                    }),
              );
            }

            return Center(
              child: CircularProgressIndicator(
                color: AppColors().blue,
              ),
            );
          },
          listener: (context, state) {}),
    );
  }
}
