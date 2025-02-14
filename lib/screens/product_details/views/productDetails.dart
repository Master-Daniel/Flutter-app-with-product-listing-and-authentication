import 'package:flutter/material.dart';
import 'package:products/screens/products/model/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(product.image, height: 200, fit: BoxFit.cover),
            SizedBox(height: 20),
            Text(product.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Price: \$${product.price}", style: TextStyle(fontSize: 18, color: Colors.green)),
            SizedBox(height: 10),
            _buildRatingStars(product.rating),
            SizedBox(height: 10),
            Text(product.description, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.round() ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        );
      }),
    );
  }
}
