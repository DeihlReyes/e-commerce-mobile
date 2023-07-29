import 'package:ecommerce_bloc_project/features/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_bloc_project/features/cart/ui/cart_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF4500),
        title: const Text('My Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        bloc: cartBloc,
        builder: (context, state) {
          return Container(
            color: const Color.fromARGB(255, 0, 35, 102),
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 17),
            child: state.cartItems.isEmpty
                ? const Center(
                    child: Text(
                      'No items in cart yet. Add to Cart now!',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final product = state.cartItems[index];
                      return CartTileWidget(
                        cartBloc: cartBloc,
                        productDataModel: product,
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
