import 'package:equatable/equatable.dart';
import 'package:products/screens/products/model/product_model.dart';

class ProductInitial extends ProductState {}

// Base state class
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

// Loading state
class ProductLoading extends ProductState {}

// Loaded state
class ProductLoaded extends ProductState {
  final List<Product> products;

  const ProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

// Error state
class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

