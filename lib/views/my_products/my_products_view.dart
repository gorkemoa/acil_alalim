import 'package:flutter/material.dart';
import '../../core/responsive/size_config.dart';
import '../../core/responsive/size_tokens.dart';
import '../../viewmodels/my_products_view_model.dart';
import 'widgets/product_card.dart';

class MyProductsView extends StatefulWidget {
  const MyProductsView({super.key});

  @override
  State<MyProductsView> createState() => _MyProductsViewState();
}

class _MyProductsViewState extends State<MyProductsView> {
  late MyProductsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MyProductsViewModel();
    _viewModel.addListener(_onViewModelUpdate);
    _viewModel.init();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelUpdate);
    super.dispose();
  }

  void _onViewModelUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(title: const Text('İlanlarım')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_viewModel.errorMessage != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(SizeTokens.k24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: SizeTokens.iconLarge * 1.5,
                color: Colors.red[300],
              ),
              SizedBox(height: SizeTokens.k16),
              Text(
                _viewModel.errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: SizeTokens.fontL),
              ),
              SizedBox(height: SizeTokens.k24),
              ElevatedButton(
                onPressed: _viewModel.onRetry,
                child: const Text('Tekrar Dene'),
              ),
            ],
          ),
        ),
      );
    }

    if (_viewModel.products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: SizeTokens.iconLarge * 2,
              color: Colors.grey[300],
            ),
            SizedBox(height: SizeTokens.k16),
            Text(
              'Henüz ilanınız bulunmamaktadır.',
              style: TextStyle(
                fontSize: SizeTokens.fontL,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _viewModel.refresh,
      child: ListView.builder(
        padding: EdgeInsets.all(SizeTokens.k16),
        itemCount: _viewModel.products.length,
        itemBuilder: (context, index) {
          final product = _viewModel.products[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}
