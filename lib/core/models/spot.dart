import 'spot_category.dart';

class Spot {
  final String id;
  final String title;
  final String description;
  final double latitude;
  final double longitude;
  final SpotCategory category;
  final String imageUrl;
  final String createdBy;
  final DateTime createdAt;
  final List<String> tags;
  final int viewCount;
  final int bookmarkCount;
  final int visitCount;

  const Spot({
    required this.id,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.category,
    required this.imageUrl,
    required this.createdBy,
    required this.createdAt,
    this.tags = const [],
    this.viewCount = 0,
    this.bookmarkCount = 0,
    this.visitCount = 0,
  });

  factory Spot.fromJson(Map<String, dynamic> json) {
    return Spot(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      category: _categoryFromString(json['category'] as String),
      imageUrl: json['image_url'] as String,
      createdBy: json['created_by'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      viewCount: json['view_count'] as int? ?? 0,
      bookmarkCount: json['bookmark_count'] as int? ?? 0,
      visitCount: json['visit_count'] as int? ?? 0,
    );
  }

  static SpotCategory _categoryFromString(String category) {
    switch (category.toLowerCase()) {
      case 'quiet':
        return SpotCategory.quiet;
      case 'nature':
        return SpotCategory.nature;
      case 'art':
        return SpotCategory.art;
      case 'views':
        return SpotCategory.views;
      default:
        return SpotCategory.quiet;
    }
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'category': category.toString().split('.').last,
      'image_url': imageUrl,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'tags': tags,
      'view_count': viewCount,
      'bookmark_count': bookmarkCount,
      'visit_count': visitCount,
    };
    
    // Only include id if it's not empty (for updates)
    if (id.isNotEmpty) {
      json['id'] = id;
    }
    
    return json;
  }

  Spot copyWith({
    String? id,
    String? title,
    String? description,
    double? latitude,
    double? longitude,
    SpotCategory? category,
    String? imageUrl,
    String? createdBy,
    DateTime? createdAt,
    List<String>? tags,
    int? viewCount,
    int? bookmarkCount,
    int? visitCount,
  }) {
    return Spot(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      tags: tags ?? this.tags,
      viewCount: viewCount ?? this.viewCount,
      bookmarkCount: bookmarkCount ?? this.bookmarkCount,
      visitCount: visitCount ?? this.visitCount,
    );
  }

  // Convenience getter for backwards compatibility
  String get name => title;
}
