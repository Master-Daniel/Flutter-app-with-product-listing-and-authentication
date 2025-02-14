import 'package:flutter/material.dart';
import 'package:products/screens/product_details/views/productDetails.dart';
import 'package:products/screens/products/controllers/ProductsCubit.dart';
import 'package:products/screens/products/model/product_model.dart';
import 'package:products/themes/colors.dart';

Widget buildErrorState(String message, context) {
  return RefreshIndicator(
    onRefresh: () async {
      await Future.delayed(Duration(seconds: 1));
      await context.read<ProductCubit>().fetchProducts();
    },
    child: ListView(
      physics: AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 250),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 50),
              SizedBox(height: 10),
              Text(
                "Oops! Something went wrong.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  message.isNotEmpty
                      ? message
                      : "Unable to load products. Please try again.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await context.read<ProductCubit>().fetchProducts();
                },
                child: Text("Retry"),
              ),
            ],
          ),
        ),
      ],
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
        size: 18,
      );
    }),
  );
}

Widget buildListView(List<Product> products) {
  return ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: products.length,
    itemBuilder: (context, index) {
      return ListTile(
        leading: _buildImageBox(products[index].image, size: 60),
        title: Text(
          _truncateText(products[index].title, 27),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Price: \$${products[index].price.toStringAsFixed(2)}",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            SizedBox(height: 5),
            _buildRatingStars(products[index].rating),
          ],
        ),
        onTap: () => _navigateToProductDetails(context, products[index]),
      );
    },
  );
}

Widget buildProductBox(Product product, BuildContext context) {
  return GestureDetector(
    onTap: () => _navigateToProductDetails(context, product),
    child: Card(
      color: AppColors.primary2,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImageBox(product.image),
            SizedBox(height: 5),
            Text(
              _truncateText(product.title, 15),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(height: 5),
            _buildRatingStars(product.rating),
          ],
        ),
      ),
    ),
  );
}

Widget buildHorizontalProductBox(Product product, BuildContext context) {
  return GestureDetector(
    onTap: () => _navigateToProductDetails(context, product),
    child: Container(
      width: 120,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImageBox(product.image, size: 80),
          SizedBox(height: 5),
          Text(
            _truncateText(product.title, 10),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3),
          Text(
            "\$${product.price.toStringAsFixed(2)}",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ],
      ),
    ),
  );
}

Widget _buildImageBox(String imageUrl, {double size = 100}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(8),
      image: DecorationImage(
        image: NetworkImage(imageUrl),
        fit: BoxFit.cover,
      ),
    ),
  );
}

String _truncateText(String text, int maxLength) {
  return (text.length > maxLength)
      ? "${text.substring(0, maxLength)}..."
      : text;
}

void _navigateToProductDetails(BuildContext context, Product product) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: product)),
  );
}
