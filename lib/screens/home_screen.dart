import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authService = AuthService();
  UserModel? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfile(); // Implement fetch logic
  }

  Future<void> _fetchProfile() async {
    try {
      final user = await _authService.getProfile();
      if (mounted) {
        setState(() {
          _user = user;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        // Handle error safely
      }
    }
  }

  Future<void> _logout() async {
    await _authService.logout();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _user == null
          ? const Center(child: Text('Kullanıcı bilgisi bulunamadı.'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue.shade100,
                    backgroundImage: _user!.profilePhoto != null
                        ? NetworkImage(_user!.profilePhoto!)
                        : null,
                    child: _user!.profilePhoto == null
                        ? Text(
                            _user!.name[0].toUpperCase(),
                            style: const TextStyle(fontSize: 40),
                          )
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _user!.fullName ?? _user!.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    _user!.email,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.star, color: Colors.amber),
                      title: const Text('Karma Puanı'),
                      trailing: Text(
                        '${_user!.karmaScore ?? 0}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('Kayıt Tarihi'),
                      subtitle: Text(_user!.createdAt ?? '-'),
                    ),
                  ),
                  // Add more fields as needed
                ],
              ),
            ),
    );
  }
}
