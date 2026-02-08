class MetaModel {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;

  MetaModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      page: json['page'] ?? 1,
      perPage: json['per_page'] ?? 20,
      total: json['total'] ?? 0,
      totalPages: json['total_pages'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'per_page': perPage,
      'total': total,
      'total_pages': totalPages,
    };
  }
}
