import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';

enum ProductsStatus { initial, success, failure }

final class ProductsState extends Equatable {
  const ProductsState(
      {this.status = ProductsStatus.initial,
      this.products = const <Product>[],
      this.hasReachedMax = false});

  final ProductsStatus status;
  final List<Product> products;
  final bool hasReachedMax;

  @override
  List<Object> get props => [status, products, hasReachedMax];

  @override
  String toString() {
    return 'ProductsState(status:$status, products:$products, hasReachedMax:$hasReachedMax)';
  }

  ProductsState copyWith(
      {ProductsStatus? status, List<Product>? products, bool? hasReachedMax}) {
    return ProductsState(
        status: status ?? this.status,
        products: products ?? this.products,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }
}
