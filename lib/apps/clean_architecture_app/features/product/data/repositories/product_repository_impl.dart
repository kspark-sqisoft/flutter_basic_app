import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    int? skip,
    int? limit,
  }) async {
    try {
      final products = await remoteDataSource.getProducts(
        skip: skip,
        limit: limit,
      );
      return Right(products); //model to entity
    } on ServerException catch (serverException) {
      return Left(ServerFailure(serverException.message,
          statusCode: serverException.statusCode));
    } on ParsingException {
      return const Left(ParsingFailure('parsing fail'));
    } on UnKnownException {
      return const Left(UnKnownFailure('unknown fail'));
    } on ConnectionException {
      return const Left(ConnectionFailure('connection fail'));
    }
  }
}
