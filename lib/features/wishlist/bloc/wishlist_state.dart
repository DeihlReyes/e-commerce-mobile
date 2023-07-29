part of 'wishlist_bloc.dart';

@immutable
class WishlistState {
  final List<ProductDataModel> wishlistItems;
  final bool loading;

  const WishlistState({
    this.wishlistItems = const [],
    this.loading = false,
  });

  WishlistState copyWith({
    List<ProductDataModel>? wishlistItems,
    bool? loading,
  }) {
    return WishlistState(
      wishlistItems: wishlistItems ?? this.wishlistItems,
      loading: loading ?? this.loading,
    );
  }
}
