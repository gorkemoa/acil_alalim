import 'dart:convert';
import 'package:flutter/material.dart';
import '../../services/api_client.dart';

class ImageUtil {
  static ImageProvider? getImageProvider(String? url) {
    if (url == null || url.isEmpty) return null;

    if (url.startsWith('http')) {
      return NetworkImage(url);
    }

    if (url.startsWith('data:image')) {
      try {
        final base64String = url.split(',').last;
        return MemoryImage(base64Decode(base64String));
      } catch (e) {
        return null;
      }
    }

    // Relative path handling
    final baseUrl = ApiClient.baseUrl;
    // Ensure no double slashes and correct path
    final path = url.startsWith('/') ? url : '/$url';
    return NetworkImage('$baseUrl$path');
  }
}
