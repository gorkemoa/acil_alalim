import 'product_model.dart';
import 'meta_model.dart';

class ProductResponseModel {
  final List<ProductModel> data;
  final MetaModel meta;

  ProductResponseModel({required this.data, required this.meta});

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductResponseModel(
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: MetaModel.fromJson(json['meta'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}
