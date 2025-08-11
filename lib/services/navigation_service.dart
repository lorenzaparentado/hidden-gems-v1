import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationService {
  static NavigationService? _instance;
  static NavigationService get instance => _instance ??= NavigationService._();
  NavigationService._();

  /// Launch navigation to a specific location
  /// On mobile: Opens default maps app (Apple Maps on iOS, Google Maps on Android)
  /// On desktop/web: Opens Google Maps in browser
  Future<bool> launchNavigation({
    required double latitude,
    required double longitude,
    String? locationName,
  }) async {
    try {
      Uri uri;
      
      if (kIsWeb) {
        // Web platform - always use Google Maps
        uri = _buildGoogleMapsWebUrl(latitude, longitude, locationName);
      } else if (Platform.isIOS) {
        // iOS - use Apple Maps
        uri = _buildAppleMapsUrl(latitude, longitude, locationName);
      } else if (Platform.isAndroid) {
        // Android - use Google Maps
        uri = _buildGoogleMapsAndroidUrl(latitude, longitude, locationName);
      } else {
        // Desktop platforms - use Google Maps web
        uri = _buildGoogleMapsWebUrl(latitude, longitude, locationName);
      }

      return await launchUrl(
        uri,
        mode: kIsWeb ? LaunchMode.externalApplication : LaunchMode.externalApplication,
      );
    } catch (e) {
      print('Error launching navigation: $e');
      return false;
    }
  }

  /// Build Apple Maps URL for iOS
  Uri _buildAppleMapsUrl(double latitude, double longitude, String? locationName) {
    final query = locationName != null 
        ? '?q=${Uri.encodeComponent(locationName)}&ll=$latitude,$longitude'
        : '?ll=$latitude,$longitude';
    
    return Uri.parse('https://maps.apple.com/$query');
  }

  /// Build Google Maps URL for Android
  Uri _buildGoogleMapsAndroidUrl(double latitude, double longitude, String? locationName) {
    final query = locationName != null
        ? '${Uri.encodeComponent(locationName)}@$latitude,$longitude'
        : '$latitude,$longitude';
    
    return Uri.parse('geo:$latitude,$longitude?q=$query');
  }

  /// Build Google Maps web URL for desktop/web
  Uri _buildGoogleMapsWebUrl(double latitude, double longitude, String? locationName) {
    final destination = locationName != null
        ? Uri.encodeComponent(locationName)
        : '$latitude,$longitude';
    
    return Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$destination');
  }

  /// Check if navigation can be launched (for fallback handling)
  Future<bool> canLaunchNavigation() async {
    try {
      if (kIsWeb) {
        return true; // Web can always open URLs
      } else if (Platform.isIOS) {
        return await canLaunchUrl(Uri.parse('https://maps.apple.com/'));
      } else if (Platform.isAndroid) {
        return await canLaunchUrl(Uri.parse('geo:0,0'));
      } else {
        return true; // Desktop can open web URLs
      }
    } catch (e) {
      return false;
    }
  }
}
