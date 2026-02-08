import 'package:flutter/material.dart';
import 'package:acil_alalim/viewmodels/home_view_model.dart';
import 'package:acil_alalim/views/auth/login_view.dart';
import 'package:acil_alalim/views/profile/profile_view.dart';
import 'package:acil_alalim/core/responsive/size_config.dart';
import 'package:acil_alalim/core/responsive/size_tokens.dart';
import 'package:acil_alalim/core/utils/image_util.dart';
import 'package:acil_alalim/views/my_products/my_products_view.dart';
import 'package:acil_alalim/views/home/widgets/product_card.dart';
import 'package:acil_alalim/views/product_detail/product_detail_view.dart';
import 'package:acil_alalim/views/add_product/add_product_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel _viewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
    _viewModel.addListener(_onViewModelUpdate);
    _viewModel.init();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelUpdate);
    _scrollController.dispose();
    super.dispose();
  }

  void _onViewModelUpdate() {
    if (mounted) setState(() {});
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _viewModel.loadMore();
    }
  }

  Future<void> _logout() async {
    await _viewModel.logout(context);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final user = _viewModel.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acil Alalım'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      drawer: _buildDrawer(context, user),
      body: _viewModel.isLoading && _viewModel.products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : _viewModel.errorMessage != null && _viewModel.products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_viewModel.errorMessage!),
                  ElevatedButton(
                    onPressed: _viewModel.onRetry,
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _viewModel.refresh,
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(SizeTokens.k16),
                itemCount:
                    _viewModel.products.length + (_viewModel.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < _viewModel.products.length) {
                    final product = _viewModel.products[index];
                    return ProductCard(
                      product: product,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailView(productId: product.id),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductView()),
          );
          if (result == true) {
            _viewModel.refresh();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, user) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user?.fullName ?? user?.name ?? 'Misafir'),
            accountEmail: Text(user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              backgroundImage: ImageUtil.getImageProvider(user?.profilePhoto),
              child: user?.profilePhoto == null
                  ? Text(
                      user?.name?[0].toUpperCase() ?? '?',
                      style: TextStyle(fontSize: SizeTokens.fontXXL),
                    )
                  : null,
            ),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profilim'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileView()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('İlanlarım'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyProductsView()),
              );
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Çıkış Yap', style: TextStyle(color: Colors.red)),
            onTap: _logout,
          ),
          SizedBox(height: SizeTokens.k16),
        ],
      ),
    );
  }
}
