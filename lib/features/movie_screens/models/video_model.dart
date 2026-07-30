class VideoModel {
  final String key;
  final String name;
  final String type;
  final bool official;
  final String publishedAt;

  VideoModel({
    required this.key,
    required this.name,
    required this.type,
    required this.official,
    required this.publishedAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      key: json['key'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      official: json['official'] ?? false,
      publishedAt: json['published_at'] ?? '',
    );
  }
}