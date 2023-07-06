abstract class AddProductState {}

class AddingProductState extends AddProductState {}

class IntialAddingState extends AddProductState {}

class AddingErrorState extends AddProductState {
  String err;

  AddingErrorState({required this.err});
}

class AddedProductState extends AddProductState {}
