import 'package:flutter/material.dart';
import 'package:acil_alalim/services/product_service.dart';
import 'package:acil_alalim/models/product_model.dart';

class ProductDetailViewModel extends ChangeNotifier {
  final ProductService _productService = ProductService();

  ProductModel? product;
  bool isLoading = true;
  String? errorMessage;

  Future<void> init(int id) async {
    await fetchDetail(id);
  }

  Future<void> fetchDetail(int id) async {
    _setLoading(true);
    errorMessage = null;
    try {
      product = await _productService.getProductDetail(id);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refresh() async {
    if (product != null) {
      await fetchDetail(product!.id);
    }
  }

  void onRetry(int id) {
    fetchDetail(id);
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
