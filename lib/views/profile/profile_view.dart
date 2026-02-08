import 'package:flutter/material.dart';
import '../auth/login_view.dart';
import '../../core/responsive/size_config.dart';
import '../../core/responsive/size_tokens.dart';
import '../../viewmodels/profile_view_model.dart';
import 'widgets/profile_form_field.dart'; // We will create this
import 'widgets/profile_photo_section.dart'; // We will create this

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileViewModel _viewModel;

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  // State for IDs (Mocking dropdowns for now as text inputs or simple integers)
  final TextEditingController _provinceIdController = TextEditingController();
  final TextEditingController _districtIdController = TextEditingController();

  String? _currentPhotoUrl;

  @override
  void initState() {
    super.initState();
    _viewModel = ProfileViewModel();
    // In a real app with Provider, we would get this from context.
    // Here we treat it as a local state object for simplicity or use a Service Locator.
    // Given no provider package, I'm instantiating it here and listening.
    _viewModel.addListener(_onViewModelUpdate);
    _viewModel.init();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelUpdate);
    _nameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _websiteController.dispose();
    _provinceIdController.dispose();
    _districtIdController.dispose();
    super.dispose();
  }

  void _onViewModelUpdate() {
    if (mounted) {
      if (_viewModel.userData != null && _nameController.text.isEmpty) {
        // Init controllers once data is loaded
        _nameController.text = _viewModel.userData!.name;
        _phoneController.text = _viewModel.userData!.phone ?? '';
        _bioController.text = _viewModel.userData!.bio ?? '';
        _websiteController.text = _viewModel.userData!.website ?? '';
        _provinceIdController.text =
            _viewModel.userData!.provinceId?.toString() ?? '';
        _districtIdController.text =
            _viewModel.userData!.districtId?.toString() ?? '';

        if (_currentPhotoUrl == null) {
          _currentPhotoUrl = _viewModel.userData!.profilePhoto;
        }
      }
      setState(() {});
    }
  }

  Future<void> _submit() async {
    final data = {
      "name": _nameController.text,
      "province_id": int.tryParse(_provinceIdController.text),
      "district_id": int.tryParse(_districtIdController.text),
      "profile_photo": _currentPhotoUrl,
      "phone": _phoneController.text,
      "whatsapp":
          _phoneController.text, // Assuming same for now as per JSON example
      "bio": _bioController.text,
      "website": _websiteController.text,
    };
    await _viewModel.updateProfile(data);
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profil güncellendi')));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profil Düzenle')),
      body: _viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(SizeTokens.k16),
              child: Column(
                children: [
                  // Photo Section
                  ProfilePhotoSection(
                    imageUrl: _currentPhotoUrl,
                    onPhotoChanged: (base64) {
                      if (base64 != null) {
                        setState(() {
                          _currentPhotoUrl = base64;
                        });
                      }
                    },
                  ),
                  SizedBox(height: SizeTokens.k24),

                  // Form Fields
                  ProfileFormField(
                    label: 'Ad Soyad',
                    controller: _nameController,
                  ),
                  SizedBox(height: SizeTokens.k16),

                  ProfileFormField(
                    label: 'Telefon',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: SizeTokens.k16),

                  Row(
                    children: [
                      Expanded(
                        child: ProfileFormField(
                          label: 'İl ID',
                          controller: _provinceIdController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: SizeTokens.k16),
                      Expanded(
                        child: ProfileFormField(
                          label: 'İlçe ID',
                          controller: _districtIdController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeTokens.k16),

                  ProfileFormField(
                    label: 'Biyografi',
                    controller: _bioController,
                    maxLines: 3,
                  ),
                  SizedBox(height: SizeTokens.k16),

                  ProfileFormField(
                    label: 'Web Sitesi',
                    controller: _websiteController,
                    keyboardType: TextInputType.url,
                  ),
                  SizedBox(height: SizeTokens.k32),

                  SizedBox(
                    width: double.infinity,
                    height: SizeConfig.getProportionateScreenHeight(50),
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Kaydet'),
                    ),
                  ),
                  SizedBox(height: SizeTokens.k16),
                  TextButton(
                    onPressed: _showDeleteAccountDialog,
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Hesabımı Sil'),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _showDeleteAccountDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hesabı Sil'),
        content: const Text(
          'Hesabınızı silmek istediğinize emin misiniz? Bu işlem geri alınamaz.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Vazgeç'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final success = await _viewModel.deleteAccount();
      if (success && mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginView()),
          (route) => false,
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_viewModel.errorMessage ?? 'Bir hata oluştu')),
        );
      }
    }
  }
}
