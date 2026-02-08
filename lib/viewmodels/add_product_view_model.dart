import 'package:flutter/material.dart';
import 'package:acil_alalim/services/product_service.dart';
import 'package:acil_alalim/services/logger_service.dart';
import 'package:acil_alalim/models/product_model.dart';

class AddProductViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();

  bool isLoading = false;
  String? errorMessage;
  ProductModel? createdProduct;

  void init() {
    errorMessage = null;
    createdProduct = null;
    isLoading = false;
  }

  Future<bool> addProduct(Map<String, dynamic> productData) async {
    _setLoading(true);
    errorMessage = null;
    createdProduct = null;
    try {
      createdProduct = await _productService.addProduct(productData);
      return createdProduct != null;
    } catch (e) {
      errorMessage = e.toString();
      logger.e('VM Add Product Error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void refresh() {
    init();
    notifyListeners();
  }

  void onRetry() {
    // This might be tricky if we don't have the data,
    // but usually onRetry for a form just clears errors and stays on page.
    errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
