import 'package:dio/dio.dart';
import '../models/product_model.dart';
import '../models/product_response_model.dart';
import '../app/api_constants.dart';
import 'api_client.dart';
import 'logger_service.dart';

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
}
