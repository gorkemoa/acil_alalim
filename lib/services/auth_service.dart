import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'api_client.dart';
import 'logger_service.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await _apiClient.dio.post(
        'auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final token = data['token'];
        final userJson = data['user'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        logger.i('Login Successful: ${userJson['email']}');
        return {'token': token, 'user': UserModel.fromJson(userJson)};
      }
    } on DioException catch (e) {
      logger.e('Login Error', error: e.response?.data ?? e.message);
      rethrow;
    }
    return null;
  }

  Future<Map<String, dynamic>?> register(
    String name,
    String surname,
    String email,
    String password,
  ) async {
    try {
      final response = await _apiClient.dio.post(
        'auth/register',
        data: {
          'name': name,
          'surname': surname,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final token = data['token'];
        final userJson = data['user'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        logger.i('Register Successful: ${userJson['email']}');
        return {'token': token, 'user': UserModel.fromJson(userJson)};
      }
    } on DioException catch (e) {
      logger.e('Register Error', error: e.response?.data ?? e.message);
      rethrow;
    }
    return null;
  }

  Future<UserModel?> getProfile() async {
    try {
      final response = await _apiClient.dio.get('auth/profile');

      if (response.statusCode == 200) {
        final data = response.data;
        return UserModel.fromJson(data);
      }
    } on DioException catch (e) {
      logger.e('Get Profile Error', error: e.response?.data ?? e.message);
      rethrow;
    }
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
