part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemovedFromCartEvent extends CartEvent {
  final ProductDataModel clickedProduct;
  CartRemovedFromCartEvent({required this.clickedProduct});
}
