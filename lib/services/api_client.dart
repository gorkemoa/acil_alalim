import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'logger_service.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final Dio dio;

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          logger.t('🚀 [${options.method}] ${options.uri}');
          await _addToken(options);
          handler.next(options);
        },
        onResponse: (response, handler) {
          logger.d(
            '✅ [${response.statusCode}] ${response.requestOptions.path}',
          );
          handler.next(response);
        },
        onError: (DioException e, handler) {
          logger.e(
            '❌ [${e.response?.statusCode ?? "ERR"}] ${e.requestOptions.path} | ${e.message}',
          );
          handler.next(e);
        },
      ),
    );
  }

  static String get _baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000/api/';
    }
    return 'http://192.168.1.7:8000/api/';
  }

  Future<void> _addToken(RequestOptions options) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      final cleanToken = token.trim();
      options.headers['Authorization'] = 'Bearer $cleanToken';
    }
  }
}
