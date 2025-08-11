enum SpotCategory {
  quiet,
  nature,
  art,
  views;

  String get displayName {
    switch (this) {
      case SpotCategory.quiet:
        return 'Quiet';
      case SpotCategory.nature:
        return 'Nature';
      case SpotCategory.art:
        return 'Art';
      case SpotCategory.views:
        return 'Views';
    }
  }

  String get iconName {
    switch (this) {
      case SpotCategory.quiet:
        return 'book'; // meditation/book icon
      case SpotCategory.nature:
        return 'leaf';
      case SpotCategory.art:
        return 'palette';
      case SpotCategory.views:
        return 'camera'; // eye/camera icon
    }
  }

  static SpotCategory fromString(String category) {
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
}
