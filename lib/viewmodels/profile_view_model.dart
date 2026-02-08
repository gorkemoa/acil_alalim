import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../models/user_model.dart';
import '../../services/logger_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;
  String? errorMessage;
  UserModel? userData;

  Future<void> init() async {
    _setLoading(true);
    try {
      userData = await _authService.getProfile();
    } catch (e) {
      errorMessage = e.toString();
      logger.e('Profile Init Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    _setLoading(true);
    try {
      final updatedUser = await _authService.updateProfile(data);
      if (updatedUser != null) {
        userData = updatedUser;
      }
    } catch (e) {
      errorMessage = e.toString();
      logger.e('Update Profile Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteAccount() async {
    _setLoading(true);
    try {
      final success = await _authService.deleteAccount();
      return success;
    } catch (e) {
      errorMessage = 'Hesap silinirken bir hata oluştu.';
      logger.e('Delete Account ViewModel Error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
