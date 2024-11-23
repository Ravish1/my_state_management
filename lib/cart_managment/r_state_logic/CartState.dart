// lib/cart_state.dart

abstract class CartState {}

class CartInitialState extends CartState {
  final List<String> items;
  final double total;

  CartInitialState({this.items = const [], this.total = 0});
}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {
  final List<String> items;
  final double total;

  CartSuccessState({required this.items, required this.total});
}

class CartFailureState extends CartState {
  final String error;

  CartFailureState({required this.error});
}
