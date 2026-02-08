import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:acil_alalim/models/user_model.dart';
import 'package:acil_alalim/app/api_constants.dart';
import 'package:acil_alalim/services/api_client.dart';
import 'package:acil_alalim/services/logger_service.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final token = data['token'];
        final userJson = data['user'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        logger.i('Login: ${userJson['email']}');
        return {'token': token, 'user': UserModel.fromJson(userJson)};
      }
    } on DioException catch (e) {
      logger.e('Login Data Error: ${e.response?.data ?? e.message}');
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
        ApiConstants.register,
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

        logger.i('Registered: ${userJson['email']}');
        return {'token': token, 'user': UserModel.fromJson(userJson)};
      }
    } on DioException catch (e) {
      logger.e('Register Data Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
    return null;
  }

  Future<UserModel?> getProfile() async {
    try {
      final response = await _apiClient.dio.get(ApiConstants.profile);

      if (response.statusCode == 200) {
        final data = response.data;
        return UserModel.fromJson(data);
      }
    } on DioException catch (e) {
      logger.e('Profile Error: ${e.message}');
      rethrow;
    }
    return null;
  }

  Future<UserModel?> updateProfile(Map<String, dynamic> profileData) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConstants.profile,
        data: profileData,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return UserModel.fromJson(data);
      }
    } on DioException catch (e) {
      logger.e('Update Profile Error: ${e.response?.data ?? e.message}');
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

  Future<bool> deleteAccount() async {
    try {
      final response = await _apiClient.dio.delete(ApiConstants.deleteAccount);
      if (response.statusCode == 200 || response.statusCode == 204) {
        await logout();
        return true;
      }
      return false;
    } on DioException catch (e) {
      logger.e('Delete Account Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }
}
