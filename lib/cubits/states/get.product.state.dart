abstract class GetProductState {}

class GetProductInitialState extends GetProductState {}

class GettingProduct extends GetProductState {}

class GetProductErrorState extends GetProductState {
  String err;
  GetProductErrorState({required this.err});
}

class GotAllProductState extends GetProductState {
  List products;

  GotAllProductState({required this.products});
}
