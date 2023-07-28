import 'package:ecommerce_bloc_project/features/home/bloc/home_bloc.dart';
import 'package:ecommerce_bloc_project/features/home/models/home_product_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  const ProductTileWidget(
      {required this.homeBloc, required this.productDataModel, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        height: 1000,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black)),
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
              )),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              productDataModel.name,
              style: const TextStyle(
                fontSize: 18,
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          homeBloc.add(HomeProductWishlistButtonClickedEvent(
                              clickedProduct: productDataModel));
                        },
                        icon: const Icon(Icons.favorite_border)),
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          homeBloc.add(HomeProductCartButtonClickedEvent(
                              clickedProduct: productDataModel));
                        },
                        icon: const Icon(Icons.shopping_bag_outlined))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// return Expanded(
//       child: Container(
//         margin: const EdgeInsets.all(10),
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: Colors.black)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 200,
//               width: double.maxFinite,
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                 fit: BoxFit.contain,
//                 image: NetworkImage(productDataModel.imageUrl),
//               )),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Text(
//               productDataModel.name,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(productDataModel.description),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '\$${productDataModel.price.toString()}',
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                         onPressed: () {
//                           homeBloc.add(HomeProductWishlistButtonClickedEvent(
//                               clickedProduct: productDataModel));
//                         },
//                         icon: const Icon(Icons.favorite_border)),
//                     IconButton(
//                         onPressed: () {
//                           homeBloc.add(HomeProductCartButtonClickedEvent(
//                               clickedProduct: productDataModel));
//                         },
//                         icon: const Icon(Icons.shopping_bag_outlined))
//                   ],
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );