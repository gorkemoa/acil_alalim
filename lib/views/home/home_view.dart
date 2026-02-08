import 'package:flutter/material.dart';
import '../../viewmodels/home_view_model.dart';
import '../auth/login_view.dart';
import '../profile/profile_view.dart';
import '../../core/responsive/size_config.dart';
import '../../core/responsive/size_tokens.dart';
import '../../core/utils/image_util.dart';
import '../my_products/my_products_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
    _viewModel.addListener(_onViewModelUpdate);
    _viewModel.init();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelUpdate);
    super.dispose();
  }

  void _onViewModelUpdate() {
    if (mounted) setState(() {});
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
        title: const Text('Ana Sayfa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileView()),
              );
            },
          ),
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: _viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : user == null
          ? const Center(child: Text('Kullanıcı bilgisi bulunamadı.'))
          : SingleChildScrollView(
              padding: EdgeInsets.all(SizeTokens.k16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: SizeConfig.getProportionateScreenWidth(50),
                    backgroundColor: Colors.blue.shade100,
                    backgroundImage: ImageUtil.getImageProvider(
                      user.profilePhoto,
                    ),
                    child: user.profilePhoto == null
                        ? Text(
                            user.name[0].toUpperCase(),
                            style: TextStyle(fontSize: SizeTokens.fontXXL),
                          )
                        : null,
                  ),
                  SizedBox(height: SizeTokens.k16),
                  Text(
                    user.fullName ?? user.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    user.email,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                  ),
                  SizedBox(height: SizeTokens.k24),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.star, color: Colors.amber),
                      title: const Text('Karma Puanı'),
                      trailing: Text(
                        '${user.karmaScore ?? 0}',
                        style: TextStyle(
                          fontSize: SizeTokens.fontXL,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeTokens.k12),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('Kayıt Tarihi'),
                      subtitle: Text(user.createdAt ?? '-'),
                    ),
                  ),
                  SizedBox(height: SizeTokens.k12),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.list_alt, color: Colors.blue),
                      title: const Text('İlanlarım'),
                      subtitle: const Text('Kendi ilanlarınızı yönetin'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyProductsView(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: SizeTokens.k12),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileView(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Profili Düzenle"),
                  ),
                ],
              ),
            ),
    );
  }
}
