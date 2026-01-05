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

  // ===============================
  // 🔥 UNSPLASH OPTIMIZATION BONUS
  // ===============================

  /// Ukuran konsisten, ringan, tidak crop
  String get imageSmall =>
      "$imageUrl?w=300&h=300&fit=contain&auto=format";

  /// Untuk card list / grid
  String get imageMedium =>
      "$imageUrl?w=400&h=400&fit=contain&auto=format";

  /// Untuk detail page
  String get imageLarge =>
      "$imageUrl?w=800&h=800&fit=contain&auto=format";
}
