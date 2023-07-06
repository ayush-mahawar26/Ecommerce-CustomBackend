import 'package:ecommerce_custom_backend/cubits/states/get.product.state.dart';
import 'package:ecommerce_custom_backend/models/product.model.dart';
import 'package:ecommerce_custom_backend/services/admin.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GettingProductCubit extends Cubit<GetProductState> {
  GettingProductCubit() : super(GetProductInitialState());

  List allproducts = [];

  List productByUser = [];

  getAllProducts() async {
    emit(GettingProduct());

    try {
      Map resp = await AdminServices().getAllProducts();

      if (resp["getted"]) {
        allproducts.addAll(resp["product"]);
        print(allproducts);
        emit(GotAllProductState(products: resp["product"]));
      } else {
        emit(GetProductErrorState(err: resp["mssg"]));
      }
    } catch (e) {
      emit(GetProductErrorState(err: e.toString()));
    }
  }

  getProductByUser(String username) async {
    Map res = await AdminServices().getProductBySeller(username);

    try {
      if (res["getted"]) {
        productByUser.addAll(res["product"]);
        print(productByUser);
        emit(GotAllProductState(products: productByUser));
      } else {
        emit(GetProductErrorState(err: res["mssg"]));
      }
    } catch (e) {
      emit(GetProductErrorState(err: e.toString()));
    }
  }
}
