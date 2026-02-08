import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/image_util.dart';

class ProfilePhotoSection extends StatelessWidget {
  final String? imageUrl;
  final Function(String?) onPhotoChanged;

  const ProfilePhotoSection({
    super.key,
    this.imageUrl,
    required this.onPhotoChanged,
  });

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeriden Seç'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 50,
                    maxWidth: 800,
                  );
                  if (image != null) {
                    final bytes = await image.readAsBytes();
                    final String base64Image =
                        'data:image/${image.path.split('.').last};base64,${base64Encode(bytes)}';
                    onPhotoChanged(base64Image);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Kamera ile Çek'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 50,
                    maxWidth: 800,
                  );
                  if (image != null) {
                    final bytes = await image.readAsBytes();
                    final String base64Image =
                        'data:image/${image.path.split('.').last};base64,${base64Encode(bytes)}';
                    onPhotoChanged(base64Image);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = ImageUtil.getImageProvider(imageUrl);

    return Center(
      child: GestureDetector(
        onTap: () => _pickImage(context),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
            image: imageProvider != null
                ? DecorationImage(image: imageProvider, fit: BoxFit.cover)
                : null,
          ),
          child: imageProvider == null
              ? const Icon(Icons.camera_alt, size: 40, color: Colors.grey)
              : null,
        ),
      ),
    );
  }
}
