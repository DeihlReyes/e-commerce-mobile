import 'package:ecommerce_bloc_project/features/cart/bloc/cart_bloc.dart';
import 'package:ecommerce_bloc_project/features/home/bloc/home_bloc.dart';
import 'package:ecommerce_bloc_project/features/home/models/home_product_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CartTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;
  const CartTileWidget(
      {required this.cartBloc, required this.productDataModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 211, 211, 211),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(productDataModel.imageUrl),
            )),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productDataModel.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(productDataModel.description),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${productDataModel.price.toString()}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          cartBloc.add(CartRemovedFromCartEvent(
                              clickedProduct: productDataModel));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Item removed from Cart'),
                            duration: Duration(milliseconds: 250),
                          ));
                        },
                        icon: const Icon(Icons.delete_outline)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
