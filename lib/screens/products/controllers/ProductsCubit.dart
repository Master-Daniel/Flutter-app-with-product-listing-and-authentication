import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/screens/products/controllers/product_state.dart';
import 'package:products/screens/products/services/products_service.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductService _productService;

  ProductCubit(this._productService) : super(ProductInitial()) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    emit(ProductLoading());

    try {
      final products = await _productService.fetchProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
