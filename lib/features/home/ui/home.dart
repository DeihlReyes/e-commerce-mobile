import 'dart:async';
import 'package:ecommerce_bloc_project/features/cart/ui/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_bloc_project/features/home/bloc/home_bloc.dart';
import 'package:ecommerce_bloc_project/features/home/ui/product_tile_widget.dart';

import '../../wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();
  Timer? _debounceTimer;
  String _searchQuery = '';

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  void _handleSearchQuery(String value) {
    try {
      setState(() {
        _searchQuery = value;
      });
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF4500),
        title: const Text('JD Shop'),
        actions: [
          IconButton(
            onPressed: _navigateToWishList,
            icon: const Icon(Icons.favorite_border_outlined),
          ),
          IconButton(
            onPressed: _navigateToCartList,
            icon: const Icon(Icons.shopping_bag),
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 0, 35, 102),
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 17),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: TextField(
                  onChanged: _handleSearchQuery,
                  style: const TextStyle(
                    color: Color(0xFFFF4500),
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Icon(Icons.search, color: Color(0xFFFF4500)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 35, 102),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 35, 102),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                bloc: homeBloc,
                builder: (context, state) {
                  final myProducts = state.products ?? [];
                  if (myProducts.isEmpty && _searchQuery.isNotEmpty) {
                    return const Center(
                      child: Text(
                        'No item found',
                        style: TextStyle(
                          color: Colors.white, // Set the text color to white
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.68,
                    ),
                    itemCount: myProducts.length,
                    itemBuilder: (context, index) {
                      final product = myProducts[index];
                      return ProductTileWidget(
                        homeBloc: homeBloc,
                        productDataModel: product,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToWishList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Wishlist()),
    );
  }

  void _navigateToCartList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Cart()),
    );
  }
}
