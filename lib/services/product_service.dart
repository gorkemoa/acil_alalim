import 'package:dio/dio.dart';
import 'package:acil_alalim/models/product_model.dart';
import 'package:acil_alalim/models/product_response_model.dart';
import 'package:acil_alalim/app/api_constants.dart';
import 'package:acil_alalim/services/api_client.dart';
import 'package:acil_alalim/services/logger_service.dart';

class ProductService {
  final ApiClient _apiClient = ApiClient();

  Future<ProductResponseModel> getProducts({
    int page = 1,
    int perPage = 20,
    int? categoryId,
    int? provinceId,
    int? districtId,
    String? q,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        ApiConstants.products,
        queryParameters: {
          'page': page,
          'per_page': perPage,
          'category_id': categoryId ?? '',
          'province_id': provinceId ?? '',
          'district_id': districtId ?? '',
          'q': q ?? '',
        },
      );

      if (response.statusCode == 200) {
        return ProductResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load products');
      }
    } on DioException catch (e) {
      logger.e('Get Products Error: ${e.message}');
      rethrow;
    }
  }

  Future<ProductModel> getProductDetail(int id) async {
    try {
      final response = await _apiClient.dio.get('${ApiConstants.products}/$id');

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load product detail');
      }
    } on DioException catch (e) {
      logger.e('Get Product Detail Error: ${e.message}');
      rethrow;
    }
  }

  Future<List<ProductModel>> getMyProducts() async {
    try {
      final response = await _apiClient.dio.get(ApiConstants.myProducts);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ProductModel.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      logger.e('Get My Products Error: ${e.message}');
      rethrow;
    }
  }

  Future<ProductModel> addProduct(Map<String, dynamic> productData) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.products,
        data: productData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ProductModel.fromJson(response.data);
      } else {
        throw Exception('Failed to add product');
      }
    } on DioException catch (e) {
      logger.e('Add Product Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }
}
