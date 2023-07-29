import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../home/models/home_product_data_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartInitialEvent>(_cartInitialEvent);
    on<CartRemovedFromCartEvent>(_cartRemovedFromCartEvent);
  }

  Future<void> _cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) async {
    final box = Hive.box<ProductDataModel>('cartItems');
    final cartItems = box.values.toList();
    emit(state.copyWith(cartItems: cartItems));
  }

  Future<void> _cartRemovedFromCartEvent(
      CartRemovedFromCartEvent event, Emitter<CartState> emit) async {
    print('Delete Product Clicked');
    final box = Hive.box<ProductDataModel>('cartItems');
    final indexToDelete = box.values
        .toList()
        .indexWhere((item) => item.id == event.clickedProduct.id);
    await box.deleteAt(indexToDelete);
    final cartItems = box.values.toList();
    emit(state.copyWith(cartItems: cartItems));
  }
}
