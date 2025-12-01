class FavoriteModel {
  final int id;
  final String userId;
  final int productId;
  final String title;
  final double price;
  final String imageUrl;
  final DateTime createdAt;

  FavoriteModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.createdAt,
  });

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'],
      userId: map['user_id'],
      productId: map['product_id'],
      title: map['title'],
      price: (map['price'] as num).toDouble(),
      imageUrl: map['image_url'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}