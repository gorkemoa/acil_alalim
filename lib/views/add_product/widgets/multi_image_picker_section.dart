import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:acil_alalim/core/responsive/size_config.dart';
import 'package:acil_alalim/core/responsive/size_tokens.dart';

class MultiImagePickerSection extends StatefulWidget {
  final Function(List<String>) onImagesChanged;

  const MultiImagePickerSection({super.key, required this.onImagesChanged});

  @override
  State<MultiImagePickerSection> createState() =>
      _MultiImagePickerSectionState();
}

class _MultiImagePickerSectionState extends State<MultiImagePickerSection> {
  final List<String> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 800,
    );

    if (image != null) {
      final bytes = await image.readAsBytes();
      final String base64Image =
          'data:image/${image.path.split('.').last};base64,${base64Encode(bytes)}';

      setState(() {
        _images.add(base64Image);
      });
      widget.onImagesChanged(_images);
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
    widget.onImagesChanged(_images);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Görseller',
          style: TextStyle(
            fontSize: SizeTokens.fontL,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SizeTokens.k12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ..._images.asMap().entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.only(right: SizeTokens.k8),
                  child: Stack(
                    children: [
                      Container(
                        width: SizeConfig.getProportionateScreenWidth(100),
                        height: SizeConfig.getProportionateScreenWidth(100),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SizeTokens.r8),
                          image: DecorationImage(
                            image: MemoryImage(
                              base64Decode(entry.value.split(',').last),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: GestureDetector(
                          onTap: () => _removeImage(entry.key),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: SizeConfig.getProportionateScreenWidth(100),
                  height: SizeConfig.getProportionateScreenWidth(100),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(SizeTokens.r8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: const Icon(Icons.add_a_photo, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
