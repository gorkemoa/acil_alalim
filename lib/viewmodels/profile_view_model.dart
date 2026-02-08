import 'dart:math' as logger;

import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../models/user_model.dart';

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
      logger.e;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
