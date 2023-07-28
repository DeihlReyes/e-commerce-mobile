import 'package:ecommerce_bloc_project/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:ecommerce_bloc_project/features/wishlist/ui/wishlist_tile.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

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
        title: const Text('My Wishlist'),
        backgroundColor: Colors.teal,
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listener: (context, state) {},
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;
              return ListView.builder(
                  itemCount: successState.wishlistItems.length,
                  itemBuilder: ((context, index) {
                    return WishlistTileWidget(
                      wishlistBloc: wishlistBloc,
                      productDataModel: successState.wishlistItems[index],
                    );
                  }));
            case CartProductItemDeletedActionState:
              final successState = state as WishlistSuccessState;
              return ListView.builder(
                  itemCount: successState.wishlistItems.length,
                  itemBuilder: ((context, index) {
                    return WishlistTileWidget(
                      wishlistBloc: wishlistBloc,
                      productDataModel: successState.wishlistItems[index],
                    );
                  }));
            default:
          }
          return Container();
        },
      ),
    );
  }
}
