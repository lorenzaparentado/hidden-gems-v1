import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/app_config.dart';
import '../core/models/spot.dart';
import '../core/models/user_profile.dart';

class SupabaseService {
  static SupabaseService? _instance;
  static SupabaseService get instance => _instance ??= SupabaseService._();
  SupabaseService._();

  SupabaseClient get client => Supabase.instance.client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: AppConfig.supabaseUrl,
      anonKey: AppConfig.supabaseAnonKey,
    );
  }

  // Auth Methods
  Future<AuthResponse> signUp(String email, String password) async {
    return await client.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signIn(String email, String password) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }

  User? get currentUser => client.auth.currentUser;

  Stream<AuthState> get authStateChanges => client.auth.onAuthStateChange;

  // Profile Methods
  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      final response = await client
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      
      return UserProfile.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<UserProfile> createUserProfile(UserProfile profile) async {
    final response = await client
        .from('profiles')
        .insert(profile.toJson())
        .select()
        .single();
    
    return UserProfile.fromJson(response);
  }

  Future<UserProfile> updateUserProfile(UserProfile profile) async {
    final response = await client
        .from('profiles')
        .update(profile.toJson())
        .eq('id', profile.id)
        .select()
        .single();
    
    return UserProfile.fromJson(response);
  }

  // Spot Methods
  Future<List<Spot>> getSpots({
    String? category,
    double? latitude,
    double? longitude,
    double? radiusKm,
    int limit = 50,
  }) async {
    // Only use getSpotsNearLocation if category is not 'all' and location is provided
    if (latitude != null && longitude != null && radiusKm != null && category != null && category != 'all') {
      return await getSpotsNearLocation(
        latitude: latitude,
        longitude: longitude,
        radiusMiles: radiusKm * 0.621371, // Convert km to miles
        category: category,
        limit: limit,
      );
    }

    // Otherwise, use the basic query for spots
    var query = client.from('spots').select();

    if (category != null && category != 'all') {
      query = query.eq('category', category);
    }

    final response = await query.limit(limit);
    return (response as List<dynamic>)
        .map((json) => Spot.fromJson(json))
        .toList();
  }

  Future<List<Spot>> getSpotsNearLocation({
    required double latitude,
    required double longitude,
    double radiusMiles = 10,
    String? category,
    int limit = 50,
  }) async {
    try {
      final response = await client.rpc('get_spots_near_location', params: {
        'user_lat': latitude,
        'user_lng': longitude,
        'radius_miles': radiusMiles.round(),
        'category_filter': category ?? 'all',
        'limit_count': limit,
      });

      print("");

      return (response as List<dynamic>)
          .map((json) => Spot.fromJson(json))
          .toList();
    } catch (e) {
      print(e);
      throw Exception('Failed to get spots near location: $e');
    }
  }

  Future<Spot?> getSpot(String id) async {
    try {
      final response = await client
          .from('spots')
          .select()
          .eq('id', id)
          .single();
      
      return Spot.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<Spot> createSpot(Spot spot) async {
    final response = await client
        .from('spots')
        .insert(spot.toJson())
        .select()
        .single();
    
    return Spot.fromJson(response);
  }

  Future<Spot> updateSpot(Spot spot) async {
    final response = await client
        .from('spots')
        .update(spot.toJson())
        .eq('id', spot.id)
        .select()
        .single();
    
    return Spot.fromJson(response);
  }

  Future<void> deleteSpot(String id) async {
    await client.from('spots').delete().eq('id', id);
  }

  Future<List<Spot>> getUserSpots(String userId) async {
    final response = await client
        .from('spots')
        .select()
        .eq('created_by', userId)
        .order('created_at', ascending: false);
    
    return (response as List<dynamic>)
        .map((json) => Spot.fromJson(json))
        .toList();
  }

  // Bookmark Methods
  Future<bool> toggleBookmark(String spotId) async {
    try {
      final response = await client.rpc('toggle_bookmark', params: {
        'spot_id_param': spotId,
      });
      
      return response as bool; // Returns true if bookmarked, false if unbookmarked
    } catch (e) {
      print(e);
      throw Exception('Failed to toggle bookmark: $e');
    }
  }

  Future<void> bookmarkSpot(String userId, String spotId) async {
    // Use the toggle_bookmark function instead
    await toggleBookmark(spotId);
  }

  Future<void> unbookmarkSpot(String userId, String spotId) async {
    // Use the toggle_bookmark function instead
    await toggleBookmark(spotId);
  }

  Future<List<Spot>> getUserBookmarks(String userId) async {
    final response = await client
        .from('bookmarks')
        .select('spots(*)')
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    
    return (response as List<dynamic>)
        .map((json) => Spot.fromJson(json['spots']))
        .toList();
  }

  Future<bool> isSpotBookmarked(String userId, String spotId) async {
    try {
      await client
          .from('bookmarks')
          .select()
          .eq('user_id', userId)
          .eq('spot_id', spotId)
          .single();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Visit Methods
  Future<bool> recordVisit(String userId, String spotId, {int? rating, String? notes}) async {
    try {
      final response = await client.rpc('mark_visited', params: {
        'spot_id_param': spotId,
        'rating_param': rating,
        'notes_param': notes,
      });
      
      return response as bool; // Returns true if new visit, false if updating existing
    } catch (e) {
      print(e);
      throw Exception('Failed to record visit: $e');
    }
  }

  Future<bool> recordVisitWithRating(String spotId, {int? rating, String? notes}) async {
    try {
      final response = await client.rpc('mark_visited', params: {
        'spot_id_param': spotId,
        'rating_param': rating,
        'notes_param': notes,
      });
      
      return response as bool;
    } catch (e) {
      print(e);
      throw Exception('Failed to record visit: $e');
    }
  }

  Future<List<Spot>> getUserVisitedSpots(String userId) async {
    final response = await client
        .from('visits')
        .select('spots(*)')
        .eq('user_id', userId)
        .order('visited_at', ascending: false);
    
    return (response as List<dynamic>)
        .map((json) => Spot.fromJson(json['spots']))
        .toList();
  }

  // Image Upload
  Future<String> uploadSpotImage(String fileName, List<int> fileBytes) async {
    final String filePath = 'spots/$fileName';
    final bytes = Uint8List.fromList(fileBytes);
    
    await client.storage
        .from('spot-images')
        .uploadBinary(filePath, bytes);
    
    return client.storage
        .from('spot-images')
        .getPublicUrl(filePath);
  }

  // Subscription Methods
  Future<Map<String, dynamic>> checkSubscriptionStatus({String? userId}) async {
    try {
      final response = await client.rpc('check_subscription_status', params: {
        'user_id_param': userId,
      });

      final result = response[0]; // Function returns a single row
      return {
        'is_pro': result['is_pro'] ?? false,
        'is_trial': result['is_trial'] ?? false,
        'expires_at': result['expires_at'],
        'days_remaining': result['days_remaining'] ?? 0,
      };
    } catch (e) {
      print(e);
      throw Exception('Failed to check subscription status: $e');
    }
  }

  // Escape Now feature (Pro users only)
  Future<Spot?> getEscapeNowSuggestion({
    required double latitude,
    required double longitude,
    int maxDistanceMiles = 2,
  }) async {
    try {
      final response = await client.rpc('escape_now_suggestion', params: {
        'user_lat': latitude,
        'user_lng': longitude,
        'max_distance_miles': maxDistanceMiles,
      });

      if (response.isEmpty) {
        return null;
      }

      return Spot.fromJson(response[0]);
    } catch (e) {
      if (e.toString().contains('Pro subscription required')) {
        print(e);
        throw Exception('Pro subscription required for Escape Now feature');
      }
      print(e);
      throw Exception('Failed to get escape now suggestion: $e');
    }
  }
}
