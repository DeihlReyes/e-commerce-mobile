import 'package:ecommerce_bloc_project/features/home/bloc/home_bloc.dart';
import 'package:ecommerce_bloc_project/features/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;

  const ProductTileWidget({
    required this.homeBloc,
    required this.productDataModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350, // Adjust the height as needed
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color.fromARGB(255, 0, 35, 102),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(productDataModel.imageUrl),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            width: double.infinity,
            height: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            productDataModel.name,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${productDataModel.price.toString()}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      homeBloc.add(
                        HomeProductWishlistButtonClickedEvent(
                          clickedProduct: productDataModel,
                        ),
                      );
                      _showAddedToWishlistDialog(context);
                    },
                    icon: const Icon(Icons.favorite_outline_rounded),
                    color: const Color(0xFFFF4500),
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      homeBloc.add(
                        HomeProductCartButtonClickedEvent(
                          clickedProduct: productDataModel,
                        ),
                      );
                      _showAddedToCartDialog(context);
                    },
                    icon: const Icon(Icons.shopping_bag),
                    color: const Color(0xFFFF4500),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  void _showAddedToWishlistDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Added to Wishlist'),
          content: const Text('The item has been added to your Wishlist.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 0, 35, 102)),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showAddedToCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Added to Cart'),
          content: const Text('The item has been added to your Cart.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
