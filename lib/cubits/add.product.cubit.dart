import 'dart:io';

import 'package:ecommerce_custom_backend/cubits/states/add.product.state.dart';
import 'package:ecommerce_custom_backend/cubits/states/auth.state.dart';
import 'package:ecommerce_custom_backend/services/admin.services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductAddCubit extends Cubit<AddProductState> {
  ProductAddCubit() : super(IntialAddingState());

  addTheProduct(String author, String name, String descp, int price,
      int quantity, List<File> img, String category) async {
    emit(AddingProductState());

    try {
      Map jsonProduct = await AdminServices()
          .sellProduct(author, name, descp, price, quantity, img, category);

      print(jsonProduct);
      emit(AddedProductState());
    } catch (e) {
      emit(AddingErrorState(err: e.toString()));
    }
  }
}
