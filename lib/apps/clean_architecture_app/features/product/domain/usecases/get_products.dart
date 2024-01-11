import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts extends UseCase<List<Product>, GetProductsParams> {
  final ProductRepository repository;
  GetProducts({required this.repository});

  @override
  Future<Either<Failure, List<Product>>> call(GetProductsParams params) async {
    return await repository.getProducts(
      skip: params.skip,
      limit: params.limit,
    );
  }
}

class GetProductsParams extends Equatable {
  final int skip;
  final int limit;

  const GetProductsParams({
    required this.skip,
    required this.limit,
  });

  @override
  List<Object?> get props => [
        skip,
        limit,
      ];
}
