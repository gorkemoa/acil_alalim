class ProductImageModel {
  final int id;
  final int needId;
  final String? imagePath;
  final int? isMain;
  final String? createdAt;
  final String? imageFile;
  final String? url;

  ProductImageModel({
    required this.id,
    required this.needId,
    this.imagePath,
    this.isMain,
    this.createdAt,
    this.imageFile,
    this.url,
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      id: json['id'],
      needId: json['need_id'],
      imagePath: json['image_path'],
      isMain: json['is_main'],
      createdAt: json['created_at'],
      imageFile: json['image_file'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'need_id': needId,
      'image_path': imagePath,
      'is_main': isMain,
      'created_at': createdAt,
      'image_file': imageFile,
      'url': url,
    };
  }
}
