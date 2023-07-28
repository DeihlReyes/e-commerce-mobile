import 'dart:convert';

import 'package:ecommerce_bloc_project/data/grocery_data.dart';

import '../features/home/models/home_product_data_model.dart';
import 'package:http/http.dart' as http;

Future<List<ProductDataModel>> fetchProducts() async {
  try {
    final url = Uri.parse('https://dummyjson.com/products');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var productsJson = jsonData['products'];

      if (productsJson != null) {
        List<ProductDataModel> fetchedProducts = [];
        for (var productJson in productsJson) {
          if (productJson != null) {
            groceryItems.add(ProductDataModel.fromJson(productJson));
          }
        }
        return fetchedProducts;
      } else {
        print('Products data is null.');
      }
    } else {
      print('Failed to fetch products. Status Code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
  }
  return [];
}

List<ProductDataModel> applyFilterLogic(
    List<ProductDataModel> products, String searchQuery) {
  if (searchQuery.isEmpty) {
    // If the search query is empty, return the original products list
    return products;
  } else {
    // Filter the products based on the search query
    String query = searchQuery.toLowerCase();
    var myProduct = products.where((product) {
      String productName = product.name.toLowerCase();
      return productName.contains(query);
    }).toList();
    return myProduct;
  }
}
