import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_basic_app/apps/clean_architecture_app/core/error/exceptions.dart';
import 'package:flutter_basic_app/apps/clean_architecture_app/core/network/network_info.dart';
import 'package:flutter_basic_app/apps/clean_architecture_app/features/product/data/datasources/product_remote_data_source_impl.dart';
import 'package:flutter_basic_app/apps/clean_architecture_app/features/product/data/models/product_model.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDioClient extends Mock implements Dio {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockDioClient mockDioClient;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockDioClient = MockDioClient();

    mockNetworkInfo = MockNetworkInfo();
    dataSource = ProductRemoteDataSourceImpl(
        client: mockDioClient, networkInfo: mockNetworkInfo);
  });

  group(
    'product_remote_data_source_test getProducts',
    () {
      final tResponse = json.decode(fixture('products.json'));

      test('should check if the device is online', () async {
        //arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(
          () => mockDioClient.get(
            any(),
          ),
        ).thenThrow(ConnectionException());

        // act

        final call = dataSource.getProducts;

        expect(
          () => call(skip: 10, limit: 10),
          throwsA(
            isA<ConnectionException>(),
          ),
        );
        // assert
        verify(() => mockNetworkInfo.isConnected);
      });

      group('device is online', () {
        // This setUp applies only to the 'device is online' group
        setUp(() {
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });

        test(
          'should preform a GET request on a URL being the endpoint and with application/json header',
          () async {
            //arrange 헤더를 검사하고 싶지만 잘 안된다. (pokedex 처럼)

            when(
              () => mockDioClient.get(
                any(),
              ),
            ).thenAnswer(
              (_) async => Response(
                statusCode: 200,
                data: tResponse,
                requestOptions: RequestOptions(headers: {
                  'accept': 'application/json',
                  'content-type': 'application/json'
                }),
              ),
            );
            // act

            final call = dataSource.getProducts;
            await call(skip: 10, limit: 10);

            // assert

            verify(() => mockDioClient.get(
                  'https://dummyjson.com/products?skip=10&limit=10',
                )).called(1);
          },
        );

        test(
          'should return Products when the response code is 200 (success)',
          () async {
            when(
              () => mockDioClient.get(
                any(),
              ),
            ).thenAnswer(
              (_) async => Response(
                statusCode: 200,
                data: tResponse,
                requestOptions: RequestOptions(),
              ),
            );

            final result = await dataSource.getProducts(limit: 10, skip: 10);

            expect(result, isA<List<ProductModel>>());
          },
        );
        test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
            when(
              () => mockDioClient.get(
                any(),
              ),
            ).thenThrow(
              //? 다른 경우도 테스트 할수 있다. connectionTimeout, sendTimeout
              DioException.badResponse(
                statusCode: 404,
                requestOptions: RequestOptions(),
                response: Response(
                  statusCode: 404,
                  requestOptions: RequestOptions(),
                ),
              ),
            );

            final call = dataSource.getProducts;

            expect(
              () => call(skip: 10, limit: 10),
              throwsA(
                isA<ServerException>(),
              ),
            );
          },
        );

        test(
          'should throw a ParsingException when the json parse',
          () async {
            when(
              () => mockDioClient.get(
                any(),
              ),
            ).thenThrow(
              TypeError(),
            );

            final call = dataSource.getProducts;

            expect(
              () => call(skip: 10, limit: 10),
              throwsA(
                isA<ParsingException>(),
              ),
            );
          },
        );

        test(
          'should throw a UnKnownException when unknown',
          () async {
            when(
              () => mockDioClient.get(
                any(),
              ),
            ).thenThrow(
              Exception(),
            );

            final call = dataSource.getProducts;

            expect(
              () => call(skip: 10, limit: 10),
              throwsA(
                isA<UnKnownException>(),
              ),
            );
          },
        );
      });
    },
  );
}
