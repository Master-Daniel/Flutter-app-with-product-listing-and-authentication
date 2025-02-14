import 'package:dio/dio.dart';
import 'package:products/screens/products/model/product_model.dart';

class ProductService {
  final Dio _dio = Dio();
  final String _apiUrl = "https://fakestoreapi.com/products";

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get(_apiUrl);
      if (response.statusCode == 200) {
        List<Product> products = (response.data as List).map((json) => Product.fromJson(json)).toList();
        return products;
      } else {
        throw Exception("Failed to fetch products");
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }
}
