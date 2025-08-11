class UserProfile {
  final String id;
  final String email;
  final String displayName;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Subscription info
  final String subscriptionStatus; // 'free', 'pro', 'trial'
  final DateTime? subscriptionExpiresAt;
  final bool trialUsed;
  
  // Stats
  final int spotsAdded;
  final int spotsVisited;
  final int spotsBookmarked;
  
  // Preferences
  final int preferredRadius;
  final bool notificationEnabled;

  const UserProfile({
    required this.id,
    required this.email,
    required this.displayName,
    required this.createdAt,
    required this.updatedAt,
    this.subscriptionStatus = 'free',
    this.subscriptionExpiresAt,
    this.trialUsed = false,
    this.spotsAdded = 0,
    this.spotsVisited = 0,
    this.spotsBookmarked = 0,
    this.preferredRadius = 5,
    this.notificationEnabled = true,
  });

  // Convenience getters
  bool get isPro => subscriptionStatus == 'pro' && 
      (subscriptionExpiresAt == null || subscriptionExpiresAt!.isAfter(DateTime.now()));
  
  bool get isTrial => subscriptionStatus == 'trial' && 
      subscriptionExpiresAt != null && subscriptionExpiresAt!.isAfter(DateTime.now());
  
  bool get hasPremiumAccess => isPro || isTrial;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['display_name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      subscriptionStatus: json['subscription_status'] as String? ?? 'free',
      subscriptionExpiresAt: json['subscription_expires_at'] != null
          ? DateTime.parse(json['subscription_expires_at'] as String)
          : null,
      trialUsed: json['trial_used'] as bool? ?? false,
      spotsAdded: json['spots_added'] as int? ?? 0,
      spotsVisited: json['spots_visited'] as int? ?? 0,
      spotsBookmarked: json['spots_bookmarked'] as int? ?? 0,
      preferredRadius: json['preferred_radius'] as int? ?? 5,
      notificationEnabled: json['notification_enabled'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'display_name': displayName,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'subscription_status': subscriptionStatus,
      'subscription_expires_at': subscriptionExpiresAt?.toIso8601String(),
      'trial_used': trialUsed,
      'spots_added': spotsAdded,
      'spots_visited': spotsVisited,
      'spots_bookmarked': spotsBookmarked,
      'preferred_radius': preferredRadius,
      'notification_enabled': notificationEnabled,
    };
  }

  UserProfile copyWith({
    String? id,
    String? email,
    String? displayName,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? subscriptionStatus,
    DateTime? subscriptionExpiresAt,
    bool? trialUsed,
    int? spotsAdded,
    int? spotsVisited,
    int? spotsBookmarked,
    int? preferredRadius,
    bool? notificationEnabled,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      subscriptionExpiresAt: subscriptionExpiresAt ?? this.subscriptionExpiresAt,
      trialUsed: trialUsed ?? this.trialUsed,
      spotsAdded: spotsAdded ?? this.spotsAdded,
      spotsVisited: spotsVisited ?? this.spotsVisited,
      spotsBookmarked: spotsBookmarked ?? this.spotsBookmarked,
      preferredRadius: preferredRadius ?? this.preferredRadius,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
    );
  }

  bool get canCreateMoreSpots {
    if (hasPremiumAccess) return true;
    return spotsAdded < 3; // Free tier limit
  }

  bool get canBookmarkMoreSpots {
    if (hasPremiumAccess) return true;
    return spotsBookmarked < 10; // Free tier limit
  }
}
