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
      id: json['id'] is int
          ? json['id']
          : (json['id'] != null ? int.tryParse(json['id'].toString()) ?? 0 : 0),
      needId: json['need_id'] is int
          ? json['need_id']
          : (json['need_id'] != null
                ? int.tryParse(json['need_id'].toString()) ?? 0
                : 0),
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
