import 'package:ecommerce_bloc_project/features/wishlist/ui/wishlist_tile.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_bloc_project/features/wishlist/bloc/wishlist_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF4500),
        title: const Text('Wishlist'),
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        builder: (context, state) {
          return Container(
            color: const Color.fromARGB(255, 0, 35, 102),
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 17),
            child: state.wishlistItems.isNotEmpty
                ? ListView.builder(
                    itemCount: state.wishlistItems.length,
                    itemBuilder: (context, index) {
                      final product = state.wishlistItems[index];
                      return WishlistTileWidget(
                        wishlistBloc: wishlistBloc,
                        productDataModel: product,
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      'No items in wishlist.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
