import 'package:equatable/equatable.dart';
import '../models/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class InitialProductState extends ProductState {}

class LoadingProductState extends ProductState {}

class LoadedProductState extends ProductState {
  final List<Product> productList;

  const LoadedProductState({required this.productList});

  @override
  List<Object> get props => [productList];
}

class ErrorProductState extends ProductState {
  final String errorMessage;

  const ErrorProductState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
