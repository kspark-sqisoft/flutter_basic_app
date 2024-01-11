import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../models/product_model.dart';
import 'product_remote_data_source.dart';

Map<String, dynamic> headers = {
  'accept': 'application/json',
  'content-type': 'application/json'
};

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio client;
  final NetworkInfo networkInfo;
  ProductRemoteDataSourceImpl(
      {required this.client, required this.networkInfo}) {
    /*
    client.options = BaseOptions(
      headers: headers,
    );
    */

    //print('client.options.headers:${client.options.headers}');

    /*
    client.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
    */
  }

  @override
  Future<List<ProductModel>> getProducts({
    int? skip,
    int? limit,
  }) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      throw ConnectionException();
    }
    try {
      final response = await client.get(
        'https://dummyjson.com/products?skip=$skip&limit=$limit',
      );
      return (response.data['products'] as List)
          .map((post) => ProductModel.fromJson(post))
          .toList();
    } on DioException catch (dioException) {
      switch (dioException.type) {
        case DioExceptionType.connectionTimeout:
          throw ServerException();
        case DioExceptionType.sendTimeout:
          throw ServerException();
        case DioExceptionType.receiveTimeout:
          throw ServerException();
        case DioExceptionType.badCertificate:
          throw ServerException();
        case DioExceptionType.badResponse:
          if (dioException.response != null &&
              dioException.response?.statusCode != null &&
              dioException.response?.statusMessage != null) {
            throw ServerException(
                statusCode: dioException.response?.statusCode ?? 0,
                message: dioException.response?.statusMessage ?? "");
          } else {
            throw ServerException();
          }
        case DioExceptionType.cancel:
          throw ServerException();
        case DioExceptionType.connectionError:
          throw ServerException();
        case DioExceptionType.unknown:
          throw ServerException();
        default:
          throw ServerException();
      }
    } on TypeError {
      throw ParsingException();
    } catch (e) {
      throw UnKnownException();
    }
  }
}
