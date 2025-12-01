import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  final String apiUrl = "https://fakestoreapi.com/products";

  Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception("Gagal fetch data produk");
  }
}