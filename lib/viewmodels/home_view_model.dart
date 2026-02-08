import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class HomeViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? user;
  bool isLoading = true;
  String? errorMessage;

  Future<void> init() async {
    _setLoading(true);
    try {
      user = await _authService.getProfile();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout(BuildContext context) async {
    await _authService.logout();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/'); // Or use route name logic
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
