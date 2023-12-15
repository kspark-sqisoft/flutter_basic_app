import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/widgets/code.dart';

part 'httpdio_screen.freezed.dart';
part 'httpdio_screen.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String title,
    required String description,
    required double price,
    required double discountPercentage,
    required double rating,
    required int stock,
    required String brand,
    required String category,
    required String thumbnail,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

const limit = 20;

Future<List<Product>> getProductsHttp({
  int page = 1,
}) async {
  final http.Client client = http.Client();
  final response = await client.get(Uri.parse(
      'https://dummyjson.com/products?limit=$limit&skip=${(page - 1) * limit}'));
  //print(response.body.runtimeType); //String
  if (response.statusCode == 200) {
    final responseMap = json.decode(response.body);
    final productList = responseMap['products'] as List;
    final products =
        productList.map((product) => Product.fromJson(product)).toList();

    return products;
  } else {
    final statusCode = response.statusCode;

    throw ServerException(
        statusCode: statusCode, message: response.reasonPhrase);
  }
}

Future<List<Product>> getProductsDio({int page = 1}) async {
  final Dio dio = Dio();
  dio.options = BaseOptions(baseUrl: 'https://dummyjson.com');
  try {
    final response = await dio.get(
      '/products',
      queryParameters: {
        'limit': limit,
        'skip': (page - 1) * limit,
      },
    );
    //print(response.data.runtimeType); //Map 이미 json.decode 가 되어 있다
    final productList = response.data['products'] as List;
    final products =
        productList.map((product) => Product.fromJson(product)).toList();

    return products;
  } on DioException catch (dioException) {
    print(dioException.type);
    switch (dioException.type) {
      case DioExceptionType.connectionError:
        throw SocketException(dioException.message ?? '');
      default:
        throw ServerException(
            statusCode: dioException.response?.statusCode,
            message: dioException.response?.statusMessage);
    }
  }
}

Future<Either<Failure, List<Product>>> getProducts({int page = 1}) async {
  try {
    final products = await getProductsHttp(page: page);
    //final products = await getProductsDio(page: page);
    return Right(products);
  } on ServerException catch (serverException) {
    return Left(ServerFailure(
        message: serverException.message,
        statusCode: serverException.statusCode));
  } on SocketException catch (socketException) {
    //인터넷 연결 에러
    return Left(ConnectionFailure(message: socketException.message));
  }
}

class HttpDioScreen extends StatefulWidget {
  const HttpDioScreen({super.key});

  @override
  State<HttpDioScreen> createState() => _HttpDioScreenState();
}

class _HttpDioScreenState extends State<HttpDioScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    final result = await getProducts(page: 1);
    result.fold(
      (fail) => print(fail),
      (products) => print(products[0]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Http vs Dio')),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Code(
                      r'''
                        Future<List<Product>> getProductsHttp({
                          int page = 1,
                        }) async {
                          final http.Client client = http.Client();
                          final response = await client.get(Uri.parse(
                        'https://dummyjson.com/products?limit=$limit&skip=${(page - 1) * limit}'));
                          //print(response.body.runtimeType); //String
                          if (response.statusCode == 200) {
                            final responseMap = json.decode(response.body);
                            final productList = responseMap['products'] as List;
                            final products =
                          productList.map((product) => Product.fromJson(product)).toList();
                        
                            return products;
                          } else {
                            final statusCode = response.statusCode;
                        
                            throw ServerException(
                          statusCode: statusCode, message: response.reasonPhrase);
                          }
                        }
                        ''',
                      title: 'Http',
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Code(
                      r'''
                            Future<List<Product>> getProductsDio({int page = 1}) async {
                              final Dio dio = Dio();
                              dio.options = BaseOptions(baseUrl: 'https://dummyjson.com');
                              try {
                                final response = await dio.get(
                            '/products',
                            queryParameters: {
                              'limit': limit,
                              'skip': (page - 1) * limit,
                            },
                                );
                                //print(response.data.runtimeType); //Map 이미 json.decode 가 되어 있다
                                final productList = response.data['products'] as List;
                                final products =
                              productList.map((product) => Product.fromJson(product)).toList();
                            
                                return products;
                              } on DioException catch (dioException) {
                                print(dioException.type);
                                switch (dioException.type) {
                            case DioExceptionType.connectionError:
                              throw SocketException(dioException.message ?? '');
                            default:
                              throw ServerException(
                                  statusCode: dioException.response?.statusCode,
                                  message: dioException.response?.statusMessage);
                                }
                              }
                            }
                            ''',
                      title: 'Dio',
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Code('''
Future<Either<Failure, List<Product>>> getProducts({int page = 1}) async {
  try {
    final products = await getProductsHttp(page: page);
    //final products = await getProductsDio(page: page);
    return Right(products);
  } on ServerException catch (serverException) {
    return Left(ServerFailure(
        message: serverException.message,
        statusCode: serverException.statusCode));
  } on SocketException catch (socketException) {
    //인터넷 연결 에러
    return Left(ConnectionFailure(message: socketException.message));
  }
}
''')
            ],
          ),
        ),
      ),
    );
  }
}
