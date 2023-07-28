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
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(_homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        _homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(_homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(_homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(_homeCartButtonNavigateEvent);
    on<HomeReloadEvent>(_homeReloadEvent);
  }

  FutureOr<void> _homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    //await Future.delayed(Duration(seconds: 3));
    await fetchProducts();
    print(groceryItems.length);
    emit(HomeLoadedSuccessState(products: groceryItems));
  }

  FutureOr<void> _homeReloadEvent(
      HomeReloadEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    var myProducts = applyFilterLogic(groceryItems, event.searchQuery);
    if (myProducts.isEmpty) {
      emit(HomeNoItemFoundState());
    } else {
      print(myProducts.length);
      emit(HomeLoadedSuccessState(products: myProducts));
    }
  }

  Future<void> _homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event,
      Emitter<HomeState> emit) async {
    print('Wishlist Product Clicked');
    final box = Hive.box<ProductDataModel>('wishListItems');
    await box.add(event.clickedProduct);
    final addedProductIndex = box.length - 1;
    final addedProduct = box.getAt(addedProductIndex);
    print(addedProduct.toString());
    emit(HomeProductItemWishListedActionState());
  }

  FutureOr<void> _homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) async {
    print('Cart Product Clicked');
    final box = Hive.box<ProductDataModel>('cartItems');
    await box.add(event.clickedProduct);
    final addedProductIndex = box.length - 1;
    final addedProduct = box.getAt(addedProductIndex);
    print(addedProduct.toString());
    emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> _homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Wishlist Navigate Clicked');
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> _homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Cart Navigate Clicked');
    emit(HomeNavigateToCartPageActionState());
  }
}
