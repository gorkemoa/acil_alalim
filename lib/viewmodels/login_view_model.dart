import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;
  String? errorMessage;

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    errorMessage = null;
    try {
      final result = await _authService.login(email, password);
      if (result != null) {
        return true;
      }
      return false;
    } catch (e) {
      errorMessage = 'Giriş yapılamadı: ${e.toString()}';
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
