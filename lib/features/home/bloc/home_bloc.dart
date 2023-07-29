import 'dart:async';
import 'package:hive/hive.dart';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_bloc_project/data/grocery_data.dart';
import 'package:meta/meta.dart';

import '../../../service/api_service.dart';
import '../models/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeInitialEvent>(_homeInitialEvent);
    on<HomeReloadEvent>(_homeReloadEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        _homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(_homeProductCartButtonClickedEvent);
  }

  Future<void> _homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(loading: true));
    await fetchProducts();
    emit(state.copyWith(products: groceryItems, loading: false));
  }

  Future<void> _homeReloadEvent(
      HomeReloadEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(loading: true));
    var myProducts = applyFilterLogic(groceryItems, event.searchQuery);
    if (myProducts.isEmpty) {
      emit(state.copyWith(products: [], loading: false));
    } else {
      emit(state.copyWith(products: myProducts, loading: false));
    }
  }

  Future<void> _homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event,
      Emitter<HomeState> emit) async {
    final box = Hive.box<ProductDataModel>('wishListItems');
    await box.add(event.clickedProduct);
    final addedProductIndex = box.length - 1;
    final addedProduct = box.getAt(addedProductIndex);
    print(addedProduct.toString());
    emit(state); // Just emit the current state, no changes needed
  }

  Future<void> _homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) async {
    final box = Hive.box<ProductDataModel>('cartItems');
    await box.add(event.clickedProduct);
    final addedProductIndex = box.length - 1;
    final addedProduct = box.getAt(addedProductIndex);
    print(addedProduct.toString());
    emit(state); // Just emit the current state, no changes needed
  }
}
