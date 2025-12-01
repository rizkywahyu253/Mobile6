class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      imageUrl: "https://source.unsplash.com/800x600/?vape,${json['category']}",
    );
  }
}