import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/product_service.dart';
import '../models/user_model.dart';
import '../models/product_model.dart';
import '../models/meta_model.dart';

class HomeViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final ProductService _productService = ProductService();

  UserModel? user;
  List<ProductModel> products = [];
  MetaModel? meta;

  bool isLoading = true;
  bool isLoadingMore = false;
  String? errorMessage;

  int page = 1;
  bool hasMore = true;

  Future<void> init() async {
    await fetchAll();
  }

  Future<void> fetchAll() async {
    _setLoading(true);
    errorMessage = null;
    try {
      final results = await Future.wait([
        _authService.getProfile(),
        _productService.getProducts(page: 1),
      ]);

      user = results[0] as UserModel?;
      final productResponse = results[1] as dynamic; // ProductResponseModel
      products = productResponse.data;
      meta = productResponse.meta;
      page = 1;
      hasMore = meta!.page < meta!.totalPages;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refresh() async {
    await fetchAll();
  }

  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;

    _setLoadingMore(true);
    try {
      final response = await _productService.getProducts(page: page + 1);
      products.addAll(response.data);
      meta = response.meta;
      page = response.meta.page;
      hasMore = meta!.page < meta!.totalPages;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoadingMore(false);
    }
  }

  void onRetry() {
    fetchAll();
  }

  Future<void> logout(BuildContext context) async {
    await _authService.logout();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _setLoadingMore(bool value) {
    isLoadingMore = value;
    notifyListeners();
  }
}
