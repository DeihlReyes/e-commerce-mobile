part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class WishlistRemovedFromWIshlistEvent extends WishlistEvent {
  final ProductDataModel clickedProduct;
  WishlistRemovedFromWIshlistEvent({required this.clickedProduct});
}
