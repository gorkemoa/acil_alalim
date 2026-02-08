class CommentModel {
  final int id;
  final int senderId;
  final int needId;
  final String comment;
  final String createdAt;
  final String userName;
  final String? profilePhoto;
  final String? profilePhotoUrl;
  final List<CommentModel>? replies;

  CommentModel({
    required this.id,
    required this.senderId,
    required this.needId,
    required this.comment,
    required this.createdAt,
    required this.userName,
    this.profilePhoto,
    this.profilePhotoUrl,
    this.replies,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] is int
          ? json['id']
          : (json['id'] != null ? int.tryParse(json['id'].toString()) ?? 0 : 0),
      senderId: json['sender_id'] is int
          ? json['sender_id']
          : (json['sender_id'] != null
                ? int.tryParse(json['sender_id'].toString()) ?? 0
                : 0),
      needId: json['need_id'] is int
          ? json['need_id']
          : (json['need_id'] != null
                ? int.tryParse(json['need_id'].toString()) ?? 0
                : 0),
      comment: json['comment'] ?? '',
      createdAt: json['created_at'] ?? '',
      userName: json['user_name'] ?? 'Misafir',
      profilePhoto: json['profile_photo'],
      profilePhotoUrl: json['profile_photo_url'],
      replies: json['replies'] != null
          ? (json['replies'] as List)
                .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_id': senderId,
      'need_id': needId,
      'comment': comment,
      'created_at': createdAt,
      'user_name': userName,
      'profile_photo': profilePhoto,
      'profile_photo_url': profilePhotoUrl,
      'replies': replies?.map((e) => e.toJson()).toList(),
    };
  }
}
