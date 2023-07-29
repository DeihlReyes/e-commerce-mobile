part of 'cart_bloc.dart';

@immutable
class CartState {
  final List<ProductDataModel> cartItems;
  final bool loading;

  const CartState({
    this.cartItems = const [],
    this.loading = false,
  });

  CartState copyWith({
    List<ProductDataModel>? cartItems,
    bool? loading,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      loading: loading ?? this.loading,
    );
  }
}
