import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../home/models/home_product_data_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(_wishlistInitialEvent);
    on<WishlistRemovedFromWIshlistEvent>(_wishlistRemovedFromWIshlistEvent);
  }

  FutureOr<void> _wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) {
    final box = Hive.box<ProductDataModel>('wishListItems');
    final wishlistItems = box.values.toList();
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }

  FutureOr<void> _wishlistRemovedFromWIshlistEvent(
      WishlistRemovedFromWIshlistEvent event,
      Emitter<WishlistState> emit) async {
    print('Delete Product Clicked');
    final box = Hive.box<ProductDataModel>('wishListItems');
    final indexToDelete = box.values
        .toList()
        .indexWhere((item) => item.id == event.clickedProduct.id);
    await box.deleteAt(indexToDelete);
    final wishlistItems = box.values.toList();
    print(wishlistItems);
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }
}
