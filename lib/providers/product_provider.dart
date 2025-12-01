import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService service = ProductService();

  List<ProductModel> products = [];
  bool isLoading = false;

  Future<void> loadProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      final data = await service.fetchProducts();
      products = data.map<ProductModel>((p) => ProductModel.fromJson(p)).toList();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }
}