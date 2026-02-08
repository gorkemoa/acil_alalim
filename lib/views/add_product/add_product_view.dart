import 'package:flutter/material.dart';
import 'package:acil_alalim/viewmodels/add_product_view_model.dart';
import 'package:acil_alalim/core/responsive/size_config.dart';
import 'package:acil_alalim/core/responsive/size_tokens.dart';
import 'widgets/multi_image_picker_section.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  late AddProductViewModel _viewModel;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _provinceIdController = TextEditingController();
  final TextEditingController _districtIdController = TextEditingController();

  List<String> _base64Images = [];

  @override
  void initState() {
    super.initState();
    _viewModel = AddProductViewModel();
    _viewModel.addListener(_onViewModelUpdate);
    _viewModel.init();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelUpdate);
    _titleController.dispose();
    _descriptionController.dispose();
    _categoryIdController.dispose();
    _provinceIdController.dispose();
    _districtIdController.dispose();
    super.dispose();
  }

  void _onViewModelUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        "title": _titleController.text,
        "description": _descriptionController.text,
        "category_id": int.tryParse(_categoryIdController.text) ?? 15230,
        "latitude": 41.0082,
        "longitude": 28.9784,
        "province_id": int.tryParse(_provinceIdController.text) ?? 34,
        "district_id": int.tryParse(_districtIdController.text) ?? 1421,
        "images": _base64Images,
      };

      final success = await _viewModel.addProduct(data);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('İlan başarıyla eklendi!')),
        );
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Yeni İlan Ver')),
      body: _viewModel.isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('İlanınız yükleniyor, lütfen bekleyin...'),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(SizeTokens.k16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Başlık',
                        hintText: 'Örn: Acil Matkap Lazım',
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Gerekli' : null,
                    ),
                    SizedBox(height: SizeTokens.k16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Açıklama',
                        hintText: 'İhtiyacınızı detaylandırın...',
                      ),
                      maxLines: 3,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Gerekli' : null,
                    ),
                    SizedBox(height: SizeTokens.k16),
                    TextFormField(
                      controller: _categoryIdController,
                      decoration: const InputDecoration(
                        labelText: 'Kategori ID',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: SizeTokens.k16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _provinceIdController,
                            decoration: const InputDecoration(
                              labelText: 'İl ID',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: SizeTokens.k16),
                        Expanded(
                          child: TextFormField(
                            controller: _districtIdController,
                            decoration: const InputDecoration(
                              labelText: 'İlçe ID',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeTokens.k24),
                    MultiImagePickerSection(
                      onImagesChanged: (images) {
                        _base64Images = images;
                      },
                    ),
                    if (_viewModel.errorMessage != null)
                      Padding(
                        padding: EdgeInsets.only(top: SizeTokens.k16),
                        child: Text(
                          _viewModel.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    SizedBox(height: SizeTokens.k32),
                    SizedBox(
                      width: double.infinity,
                      height: SizeConfig.getProportionateScreenHeight(50),
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: const Text('Yayınla'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
