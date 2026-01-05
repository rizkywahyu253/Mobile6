import '../models/product_model.dart';

class ProductService {
  Future<List<ProductModel>> fetchProducts() async {
    await Future.delayed(const Duration(milliseconds: 400));

    return [
      ProductModel(
        id: 1,
        title: 'Vape X Pro',
        description: 'Vape premium dengan rasa kuat dan awet.',
        price: 299.000,
        category: 'Device',
        imageUrl: 'assets/images/vape1.png',
      ),
      ProductModel(
        id: 2,
        title: 'Cloud Max Pod',
        description: 'Pod system ringan dan praktis.',
        price: 249.000,
        category: 'Pod',
        imageUrl: 'assets/images/vape2.png',
      ),
      ProductModel(
        id: 3,
        title: 'Nano Coil Kit',
        description: 'Coil berkualitas tinggi untuk rasa maksimal.',
        price: 149.000,
        category: 'Coil',
        imageUrl: 'assets/images/vape3.png',
      ),
    ];
  }
}
