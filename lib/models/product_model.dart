import 'package:acil_alalim/models/product_image_model.dart';

class ProductModel {
  final int id;
  final int userId;
  final String title;
  final String description;
  final int categoryId;
  final String? latitude;
  final String? longitude;
  final int? provinceId;
  final int? districtId;
  final String? status;
  final String? createdAt;
  final int? isSponsor;
  final String? mainImage;
  final String? userName;
  final String? userAvatar;
  final int? karmaScore;
  final int? userKarma; // From detail API
  final String? provinceName;
  final String? districtName;
  final String? categoryName;
  final String? userAvatarUrl;
  final String? mainImageFile;
  final String? mainImageUrl;
  final String? userProvinceName; // From detail API
  final String? userDistrictName; // From detail API
  final List<ProductImageModel>? images; // From detail API

  ProductModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.categoryId,
    this.latitude,
    this.longitude,
    this.provinceId,
    this.districtId,
    this.status,
    this.createdAt,
    this.isSponsor,
    this.mainImage,
    this.userName,
    this.userAvatar,
    this.karmaScore,
    this.userKarma,
    this.provinceName,
    this.districtName,
    this.categoryName,
    this.userAvatarUrl,
    this.mainImageFile,
    this.mainImageUrl,
    this.userProvinceName,
    this.userDistrictName,
    this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['category_id'],
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      provinceId: json['province_id'] is int
          ? json['province_id']
          : (json['province_id'] != null
                ? int.tryParse(json['province_id'].toString())
                : null),
      districtId: json['district_id'] is int
          ? json['district_id']
          : (json['district_id'] != null
                ? int.tryParse(json['district_id'].toString())
                : null),
      status: json['status'],
      createdAt: json['created_at'],
      isSponsor: json['is_sponsor'] is int
          ? json['is_sponsor']
          : (json['is_sponsor'] != null
                ? int.tryParse(json['is_sponsor'].toString())
                : 0),
      mainImage: json['main_image'],
      userName: json['user_name'],
      userAvatar: json['user_avatar'],
      karmaScore: json['karma_score'] is int
          ? json['karma_score']
          : (json['karma_score'] != null
                ? int.tryParse(json['karma_score'].toString())
                : null),
      userKarma: json['user_karma'] is int
          ? json['user_karma']
          : (json['user_karma'] != null
                ? int.tryParse(json['user_karma'].toString())
                : null),
      provinceName: json['province_name'],
      districtName: json['district_name'],
      categoryName: json['category_name'],
      userAvatarUrl: json['user_avatar_url'],
      mainImageFile: json['main_image_file'],
      mainImageUrl: json['main_image_url'],
      userProvinceName: json['user_province_name'],
      userDistrictName: json['user_district_name'],
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ProductImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'category_id': categoryId,
      'latitude': latitude,
      'longitude': longitude,
      'province_id': provinceId,
      'district_id': districtId,
      'status': status,
      'created_at': createdAt,
      'is_sponsor': isSponsor,
      'main_image': mainImage,
      'user_name': userName,
      'user_avatar': userAvatar,
      'karma_score': karmaScore,
      'user_karma': userKarma,
      'province_name': provinceName,
      'district_name': districtName,
      'category_name': categoryName,
      'user_avatar_url': userAvatarUrl,
      'main_image_file': mainImageFile,
      'main_image_url': mainImageUrl,
      'user_province_name': userProvinceName,
      'user_district_name': userDistrictName,
      'images': images?.map((e) => e.toJson()).toList(),
    };
  }
}
