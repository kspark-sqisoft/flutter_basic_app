import 'dart:convert';

import 'package:flutter_basic_app/apps/clean_architecture_app/features/product/data/models/product_model.dart';
import 'package:flutter_basic_app/apps/clean_architecture_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tProductModel = ProductModel(
      id: 11,
      title: "perfume Oil",
      description:
          "Mega Discount, Impression of Acqua Di Gio by GiorgioArmani concentrated attar perfume Oil",
      price: 13,
      discountPercentage: 8.4,
      rating: 4.26,
      stock: 65,
      brand: "Impression of Acqua Di Gio",
      category: "fragrances",
      thumbnail: "https://i.dummyjson.com/data/products/11/thumbnail.jpg",
      images: [
        "https://i.dummyjson.com/data/products/11/1.jpg",
        "https://i.dummyjson.com/data/products/11/2.jpg",
        "https://i.dummyjson.com/data/products/11/3.jpg",
        "https://i.dummyjson.com/data/products/11/thumbnail.jpg"
      ]);

  group('product_model_test Entity', () {
    test('should be a subclass of Product entity', () async {
      expect(tProductModel, isA<Product>());
    });
  });

  group('product_model_test fromJson', () {
    test('should return a valid model', () {
      final Map<String, dynamic> jsonMap = json.decode(fixture('product.json'));
      final result = ProductModel.fromJson(jsonMap);
      expect(result, tProductModel);
    });
  });

  group('product_model_test toJson', () {
    test('should return a Json map containing the proper data', () {
      final result = tProductModel.toJson();
      final expectedJsonMap = {
        "id": 11,
        "title": "perfume Oil",
        "description":
            "Mega Discount, Impression of Acqua Di Gio by GiorgioArmani concentrated attar perfume Oil",
        "price": 13,
        "discountPercentage": 8.4,
        "rating": 4.26,
        "stock": 65,
        "brand": "Impression of Acqua Di Gio",
        "category": "fragrances",
        "thumbnail": "https://i.dummyjson.com/data/products/11/thumbnail.jpg",
        "images": [
          "https://i.dummyjson.com/data/products/11/1.jpg",
          "https://i.dummyjson.com/data/products/11/2.jpg",
          "https://i.dummyjson.com/data/products/11/3.jpg",
          "https://i.dummyjson.com/data/products/11/thumbnail.jpg"
        ]
      };

      expect(result, expectedJsonMap);
    });
  });
}
