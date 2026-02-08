import 'package:acil_alalim/models/product_image_model.dart';
import 'package:acil_alalim/models/comment_model.dart';

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
  final List<CommentModel>? comments; // From detail API
  final List<CommentModel>? commentsTree; // From detail API
  final int? commentsCount; // From detail API
  final bool? allowComments; // From detail API

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
    this.comments,
    this.commentsTree,
    this.commentsCount,
    this.allowComments,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] is int
          ? json['id']
          : (json['id'] != null ? int.tryParse(json['id'].toString()) ?? 0 : 0),
      userId: json['user_id'] is int
          ? json['user_id']
          : (json['user_id'] != null
                ? int.tryParse(json['user_id'].toString()) ?? 0
                : 0),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['category_id'] is int
          ? json['category_id']
          : (json['category_id'] != null
                ? int.tryParse(json['category_id'].toString()) ?? 0
                : 0),
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
      images: json['images'] != null && json['images'] is List
          ? (json['images'] as List)
                .map(
                  (e) => e is Map<String, dynamic>
                      ? ProductImageModel.fromJson(e)
                      : ProductImageModel(
                          id: 0,
                          needId: json['id'] is int ? json['id'] : 0,
                          url: e.toString(),
                        ),
                )
                .toList()
          : null,
      comments: json['comments'] != null && json['comments'] is List
          ? (json['comments'] as List)
                .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
      commentsTree:
          json['comments_tree'] != null && json['comments_tree'] is List
          ? (json['comments_tree'] as List)
                .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
      commentsCount: json['comments_count'] is int
          ? json['comments_count']
          : (json['comments_count'] != null
                ? int.tryParse(json['comments_count'].toString())
                : null),
      allowComments: json['allow_comments'] is bool
          ? json['allow_comments']
          : (json['allow_comments'] == 1 || json['allow_comments'] == '1'),
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
      'comments': comments?.map((e) => e.toJson()).toList(),
      'comments_tree': commentsTree?.map((e) => e.toJson()).toList(),
      'comments_count': commentsCount,
      'allow_comments': allowComments,
    };
  }
}
