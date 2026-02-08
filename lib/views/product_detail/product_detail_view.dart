import 'package:flutter/material.dart';
import 'package:acil_alalim/viewmodels/product_detail_view_model.dart';
import 'package:acil_alalim/core/responsive/size_config.dart';
import 'package:acil_alalim/core/responsive/size_tokens.dart';
import 'package:acil_alalim/core/utils/image_util.dart';

class ProductDetailView extends StatefulWidget {
  final int productId;

  const ProductDetailView({super.key, required this.productId});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  late ProductDetailViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ProductDetailViewModel();
    _viewModel.addListener(_onViewModelUpdate);
    _viewModel.init(widget.productId);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelUpdate);
    super.dispose();
  }

  void _onViewModelUpdate() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final product = _viewModel.product;

    return Scaffold(
      appBar: AppBar(
        title: const Text('İlan Detayı'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              // TODO: Implement share
            },
          ),
        ],
      ),
      body: _viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _viewModel.errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_viewModel.errorMessage!),
                  ElevatedButton(
                    onPressed: () => _viewModel.onRetry(widget.productId),
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            )
          : product == null
          ? const Center(child: Text('İlan bulunamadı.'))
          : RefreshIndicator(
              onRefresh: _viewModel.refresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImageSection(product),
                    Padding(
                      padding: EdgeInsets.all(SizeTokens.k16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizeTokens.k8,
                                  vertical: SizeTokens.k4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(
                                    SizeTokens.r4,
                                  ),
                                ),
                                child: Text(
                                  product.categoryName ?? 'Kategorisiz',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: SizeTokens.fontXS,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              if (product.isSponsor == 1)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: SizeTokens.k8,
                                    vertical: SizeTokens.k4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.shade100,
                                    borderRadius: BorderRadius.circular(
                                      SizeTokens.r4,
                                    ),
                                  ),
                                  child: Text(
                                    'Sponsorlu',
                                    style: TextStyle(
                                      fontSize: SizeTokens.fontXS,
                                      color: Colors.amber.shade900,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: SizeTokens.k12),
                          Text(
                            product.title,
                            style: TextStyle(
                              fontSize: SizeTokens.fontXXL,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: SizeTokens.k8),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: SizeTokens.iconSmall,
                                color: Colors.grey,
                              ),
                              SizedBox(width: SizeTokens.k4),
                              Text(
                                '${product.provinceName ?? ''} / ${product.districtName ?? ''}',
                                style: TextStyle(
                                  fontSize: SizeTokens.fontS,
                                  color: Colors.grey,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                product.createdAt?.split(' ')[0] ?? '',
                                style: TextStyle(
                                  fontSize: SizeTokens.fontS,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeTokens.k24),
                          Text(
                            'Açıklama',
                            style: TextStyle(
                              fontSize: SizeTokens.fontL,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: SizeTokens.k8),
                          Text(
                            product.description,
                            style: TextStyle(
                              fontSize: SizeTokens.fontM,
                              color: Colors.grey[800],
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: SizeTokens.k32),
                          _buildUserCard(product),
                          SizedBox(height: SizeTokens.k32),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildImageSection(product) {
    final images = product.images ?? [];
    if (images.isEmpty) {
      return Container(
        height: SizeConfig.getProportionateScreenHeight(300),
        width: double.infinity,
        color: Colors.grey[200],
        child: Icon(
          Icons.image_outlined,
          size: SizeTokens.iconLarge * 2,
          color: Colors.grey[400],
        ),
      );
    }

    return SizedBox(
      height: SizeConfig.getProportionateScreenHeight(300),
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Image.network(
            images[index].url ?? '',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[200],
              child: const Icon(Icons.error_outline),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserCard(product) {
    return Container(
      padding: EdgeInsets.all(SizeTokens.k16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(SizeTokens.r12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: SizeConfig.getProportionateScreenWidth(24),
            backgroundImage: ImageUtil.getImageProvider(product.userAvatarUrl),
            child: product.userAvatarUrl == null
                ? Text(product.userName?[0].toUpperCase() ?? '?')
                : null,
          ),
          SizedBox(width: SizeTokens.k12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.userName ?? 'İlan Sahibi',
                  style: TextStyle(
                    fontSize: SizeTokens.fontL,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Karma Puanı: ${product.userKarma ?? product.karmaScore ?? 0}',
                  style: TextStyle(
                    fontSize: SizeTokens.fontS,
                    color: Colors.orange.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Navigate to user profile
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
              elevation: 0,
              side: const BorderSide(color: Colors.blue),
              padding: EdgeInsets.symmetric(horizontal: SizeTokens.k12),
            ),
            child: const Text('Profili Gör'),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(SizeTokens.k16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                // TODO: Message action
              },
              icon: const Icon(Icons.message_outlined),
              label: const Text('Mesaj Gönder'),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: SizeTokens.k12),
              ),
            ),
          ),
          SizedBox(width: SizeTokens.k12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Call action
              },
              icon: const Icon(Icons.phone_outlined),
              label: const Text('Teklif Ver'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: SizeTokens.k12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
