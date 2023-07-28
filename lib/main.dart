import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/home/models/product_data_model_adapter.dart';
import 'features/home/models/home_product_data_model.dart';
import 'features/home/ui/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductDataModelAdapter());

  await Hive.openBox<ProductDataModel>('cartItems');
  await Hive.openBox<ProductDataModel>('wishListItems');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      home: Home(),
    );
  }
}
