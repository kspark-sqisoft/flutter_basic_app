import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/product.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Product {
  const ProductModel({
    super.id,
    super.title,
    super.description,
    super.price,
    super.discountPercentage,
    super.rating,
    super.stock,
    super.brand,
    super.category,
    super.thumbnail,
    super.images,
  });
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
