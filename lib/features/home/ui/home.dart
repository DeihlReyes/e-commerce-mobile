import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ecommerce_bloc_project/data/grocery_data.dart';
import 'package:ecommerce_bloc_project/features/cart/ui/cart.dart';
import 'package:ecommerce_bloc_project/features/home/bloc/home_bloc.dart';
import 'package:ecommerce_bloc_project/features/home/ui/product_tile_widget.dart';
import 'package:ecommerce_bloc_project/features/wishlist/ui/wishlist.dart';
import 'package:ecommerce_bloc_project/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();
  Timer? _debounceTimer;

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  void _handleSearchQuery(String value) {
    try {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 700), () {
        homeBloc.add(HomeReloadEvent(searchQuery: value));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => const Cart())));
        }
        if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const Wishlist())));
        }
        if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Item Added to Cart'),
            duration: Duration(milliseconds: 250),
          ));
        }
        if (state is HomeProductItemWishListedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Item Added to Wishlist'),
            duration: Duration(milliseconds: 250),
          ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            final myProducts = successState.products.isNotEmpty
                ? successState.products
                : successState.products;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: const Text('Online Shop'),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.shopping_bag_outlined))
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 17),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: TextField(
                          onChanged: _handleSearchQuery,
                          decoration: const InputDecoration(
                            labelText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              2, // Set the number of columns per row here
                          childAspectRatio: 0.76,
                        ),
                        itemCount: myProducts.isNotEmpty
                            ? myProducts.length
                            : successState.products.length,
                        itemBuilder: (context, index) {
                          final product = myProducts.isNotEmpty
                              ? myProducts[index]
                              : successState.products[index];
                          return ProductTileWidget(
                            homeBloc: homeBloc,
                            productDataModel: product,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(child: Text('Error')),
            );
          case HomeNoItemFoundState:
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: const Text('Grocery App'),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.shopping_bag_outlined))
                ],
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: _handleSearchQuery,
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const Expanded(
                      child: Center(
                    child: Text('Item Not Found'),
                  )),
                ],
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
