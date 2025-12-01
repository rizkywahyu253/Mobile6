import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../page/detail_page.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  ProductCard({required this.product});

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailPage(product: product)),
      ),
      child: Card(
        child: Column(
          children: [
            Image.network(product.imageUrl, height: 120),
            Text(product.title),
            Text("\$${product.price}"),
          ],
        ),
      ),
    );
  }
}