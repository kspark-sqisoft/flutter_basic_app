import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({
    int? skip,
    int? limit,
  });
}
