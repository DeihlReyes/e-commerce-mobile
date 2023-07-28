class ProductDataModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    List<dynamic>? imageUrls = json["images"];
    String imageUrl = '';
    if (imageUrls != null && imageUrls.isNotEmpty) {
      imageUrl = imageUrls[0];
    }

    return ProductDataModel(
      id: json["id"],
      name: json["title"] ?? '',
      description: json["description"] ?? '',
      price: json["price"]?.toDouble() ?? 0.0,
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": name,
      "description": description,
      "price": price,
      "images": imageUrl,
    };
  }

  @override
  String toString() {
    return 'ProductDataModel(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl)';
  }
}
