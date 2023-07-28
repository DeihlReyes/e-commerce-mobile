import 'package:hive/hive.dart';

import 'home_product_data_model.dart';

class ProductDataModelAdapter extends TypeAdapter<ProductDataModel> {
  @override
  final int typeId = 0; // Unique ID for the adapter

  @override
  ProductDataModel read(BinaryReader reader) {
    return ProductDataModel(
      id: reader.readInt(),
      name: reader.readString(),
      description: reader.readString(),
      price: reader.readDouble(),
      imageUrl: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductDataModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeDouble(obj.price);
    writer.writeString(obj.imageUrl);
  }
}
