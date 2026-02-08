class UserModel {
  final int id;
  final String name;
  final String email;
  final String? surname;
  final String? fullName;
  final String? createdAt;
  final String? profilePhoto;
  final int? provinceId;
  final int? districtId;
  final int? karmaScore;
  final double? latitude;
  final double? longitude;
  final String? phone;
  final String? whatsapp;
  final String? bio;
  final String? website;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.surname,
    this.fullName,
    this.createdAt,
    this.profilePhoto,
    this.provinceId,
    this.districtId,
    this.karmaScore,
    this.latitude,
    this.longitude,
    this.phone,
    this.whatsapp,
    this.bio,
    this.website,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      surname: json['surname'],
      fullName: json['full_name'],
      createdAt: json['created_at'],
      profilePhoto: json['profile_photo'],
      provinceId: json['province_id'],
      districtId: json['district_id'],
      karmaScore: json['karma_score'] is int
          ? json['karma_score']
          : (json['karma_score'] != null
                ? int.tryParse(json['karma_score'].toString())
                : 0),
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
      phone: json['phone'],
      whatsapp: json['whatsapp'],
      bio: json['bio'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'surname': surname,
      'full_name': fullName,
      'created_at': createdAt,
      'profile_photo': profilePhoto,
      'province_id': provinceId,
      'district_id': districtId,
      'karma_score': karmaScore,
      'latitude': latitude,
      'longitude': longitude,
      'phone': phone,
      'whatsapp': whatsapp,
      'bio': bio,
      'website': website,
    };
  }
}
