part of 'home_bloc.dart';

class HomeState {
  final List<ProductDataModel>? products;
  final bool loading;
  final bool wishlistButtonNavigation;
  final bool cartButtonNavigation;

  HomeState({
    this.products,
    this.loading = false,
    this.wishlistButtonNavigation = false,
    this.cartButtonNavigation = false,
  });

  HomeState copyWith({
    List<ProductDataModel>? products,
    bool? loading,
    bool? wishlistButtonNavigation,
    bool? cartButtonNavigation,
  }) {
    return HomeState(
      products: products ?? this.products,
      loading: loading ?? this.loading,
      wishlistButtonNavigation:
          wishlistButtonNavigation ?? this.wishlistButtonNavigation,
      cartButtonNavigation: cartButtonNavigation ?? this.cartButtonNavigation,
    );
  }
}
