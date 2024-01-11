import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_basic_app/apps/clean_architecture_app/core/error/exceptions.dart';
import 'package:flutter_basic_app/apps/clean_architecture_app/core/error/failures.dart';
import 'package:flutter_basic_app/apps/clean_architecture_app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:flutter_basic_app/apps/clean_architecture_app/features/product/data/models/product_model.dart';
import 'package:flutter_basic_app/apps/clean_architecture_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockProductRemoteDataSource extends Mock
    implements ProductRemoteDataSource {}

void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDataSource mockProductRemoteDataSource;

  setUp(() {
    mockProductRemoteDataSource = MockProductRemoteDataSource();

    repository = ProductRepositoryImpl(
      remoteDataSource: mockProductRemoteDataSource,
    );
  });

  group('getProducts', () {
    final tResponse = json.decode(fixture('products.json'));
    final tProducts =
        (json.decode(fixture('products.json'))['products'] as List)
            .map((p) => ProductModel.fromJson(p))
            .toList();

    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(() => mockProductRemoteDataSource.getProducts(skip: 10, limit: 10))
            .thenAnswer((_) async => tProducts);
        // act
        final result = await repository.getProducts(skip: 10, limit: 10);
        // assert
        verify(
            () => mockProductRemoteDataSource.getProducts(skip: 10, limit: 10));
        expect(result, equals(Right(tProducts)));
      },
    );

    test(
      'should return server failure when the call to remote data source is ConnectionException',
      () async {
        // arrange
        when(() => mockProductRemoteDataSource.getProducts(skip: 10, limit: 10))
            .thenThrow(ConnectionException());
        // act
        final result = await repository.getProducts(skip: 10, limit: 10);

        // assert
        verify(
            () => mockProductRemoteDataSource.getProducts(skip: 10, limit: 10));
        expect(
            result, equals(const Left(ConnectionFailure('connection fail'))));
      },
    );

    test(
      'should return server failure when the call to remote data source is ServerException',
      () async {
        // arrange
        when(() => mockProductRemoteDataSource.getProducts(skip: 10, limit: 10))
            .thenThrow(ServerException(statusCode: 404, message: 'Not Found'));
        // act
        final result = await repository.getProducts(skip: 10, limit: 10);

        // assert
        verify(
            () => mockProductRemoteDataSource.getProducts(skip: 10, limit: 10));
        expect(result,
            equals(const Left(ServerFailure('Not Found', statusCode: 404))));
      },
    );
    test(
      'should return server failure when the call to remote data source is ParsingException',
      () async {
        // arrange
        when(() => mockProductRemoteDataSource.getProducts(skip: 10, limit: 10))
            .thenThrow(ParsingException());
        // act
        final result = await repository.getProducts(skip: 10, limit: 10);

        // assert
        verify(
            () => mockProductRemoteDataSource.getProducts(skip: 10, limit: 10));
        expect(result, equals(const Left(ParsingFailure('parsing fail'))));
      },
    );

    test(
      'should return server failure when the call to remote data source is UnKnownException',
      () async {
        // arrange
        when(() => mockProductRemoteDataSource.getProducts(skip: 10, limit: 10))
            .thenThrow(UnKnownException());
        // act
        final result = await repository.getProducts(skip: 10, limit: 10);

        // assert
        verify(
            () => mockProductRemoteDataSource.getProducts(skip: 10, limit: 10));
        expect(result, equals(const Left(UnKnownFailure('unknown fail'))));
      },
    );
  });
}
