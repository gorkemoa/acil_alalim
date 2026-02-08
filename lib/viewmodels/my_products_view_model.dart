import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';
import '../services/logger_service.dart';

class MyProductsViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  Future<void> init() async {
    await fetchProducts();
  }

  Future<void> fetchProducts() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      _products = await _productService.getMyProducts();
    } catch (e) {
      _errorMessage = 'Ürünler yüklenirken bir hata oluştu.';
      logger.e('MyProductsViewModel Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> refresh() => fetchProducts();

  void onRetry() => fetchProducts();
}
