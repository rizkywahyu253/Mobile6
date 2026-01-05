import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> products = [];
  bool isLoading = false;

  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 400));

    products = [
      ProductModel(
        id: 1,
        title: "Vape Aegis Boost",
        description: "Vape tahan banting dengan performa tinggi",
        category: "Vape",
        price: 350000.0,
        imageUrl: "https://images.unsplash.com/photo-1545095088-26a59e3f2717?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dmFwZXxlbnwwfHwwfHx8MA%3D%3D",
      ),
      ProductModel(
        id: 2,
        title: "Vape Drag X",
        description: "Vape stylish dengan cloud besar",
        category: "Vape",
        price: 420000.0,
        imageUrl: "https://images.unsplash.com/photo-1545095088-26a59e3f2717?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dmFwZXxlbnwwfHwwfHx8MA%3D%3D",
      ),
      ProductModel(
        id: 3,
        title: "Vape Luxe XR",
        description: "Pod modern dengan rasa kuat",
        category: "Vape",
        price: 390000.0,
        imageUrl: "https://images.unsplash.com/photo-1758491251924-d55fa096f649?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dmFwZSUyMGRldmljZXxlbnwwfHwwfHx8MA%3D%3D",
      ),
      ProductModel(
        id: 4,
        title: "Caliburn G2",
        description: "Vape compact untuk harian",
        category: "Vape",
        price: 280000.0,
        imageUrl: "https://images.unsplash.com/photo-1606593955195-6a0a8b48efb3?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2FsaWJ1cm4lMjB2YXBlfGVufDB8fDB8fHww",
      ),
      ProductModel(
        id: 5,
        title: "Vinci Pod",
        description: "Vape pod ringan dan nyaman",
        category: "Vape",
        price: 310000.0,
        imageUrl: "https://images.unsplash.com/photo-1621934785279-5d3746f5680c?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dmFwZSUyMG1vZHxlbnwwfHwwfHx8MA%3D%3D",
      ),

      // ===== LIQUID =====
      ProductModel(
        id: 6,
        title: "Liquid Mango Ice",
        description: "Rasa mangga segar dengan es",
        category: "Liquid",
        price: 120000.0,
        imageUrl: "https://images.unsplash.com/photo-1662735229836-e998b8676807?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8TGlxdWlkJTIwdmFwZXxlbnwwfHwwfHx8MA%3D%3D",
      ),
      ProductModel(
        id: 7,
        title: "Liquid Strawberry Milk",
        description: "Manis creamy favorit",
        category: "Liquid",
        price: 130000.0,
        imageUrl: "https://images.unsplash.com/photo-1618589036063-e78447db6936?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8TGlxdWlkJTIwdmFwZXxlbnwwfHwwfHx8MA%3D%3D",
      ),
      ProductModel(
        id: 8,
        title: "Liquid Coffee Latte",
        description: "Aroma kopi lembut",
        category: "Liquid",
        price: 140000.0,
        imageUrl: "https://images.unsplash.com/photo-1674414719419-623c8612f892?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fExpcXVpZCUyMHZhcGV8ZW58MHx8MHx8fDA%3D",
      ),
      ProductModel(
        id: 9,
        title: "Liquid Grape Ice",
        description: "Anggur dingin menyegarkan",
        category: "Liquid",
        price: 125000.0,
        imageUrl: "https://images.unsplash.com/photo-1601568656042-65dc282bd537?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fExpcXVpZCUyMHZhcGV8ZW58MHx8MHx8fDA%3D",
      ),
      ProductModel(
        id: 10,
        title: "Liquid Vanilla Custard",
        description: "Creamy vanilla klasik",
        category: "Liquid",
        price: 150000.0,
        imageUrl: "https://images.unsplash.com/photo-1708326481491-c89676ebdca5?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fExpcXVpZCUyMHZhcGV8ZW58MHx8MHx8fDA%3D",
      ),
    ];

    isLoading = false;
    notifyListeners();
  }
}
