import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesService {
  static UserPreferencesService? _instance;
  static UserPreferencesService get instance => _instance ??= UserPreferencesService._();
  UserPreferencesService._();

  static const String _locationRadiusKey = 'location_radius_miles';
  static const String _useLocationKey = 'use_location';
  static const String _userLatKey = 'user_latitude';
  static const String _userLonKey = 'user_longitude';
  static const String _distanceUnitKey = 'distance_unit'; // 'miles' or 'km'

  // Default radius in miles
  static const double defaultRadius = 5.0;
  
  // Available radius options in miles
  static const List<double> radiusOptions = [1.0, 5.0, 10.0, 25.0, 50.0];
  
  // Available radius options in kilometers
  static const List<double> radiusOptionsKm = [1.6, 8.0, 16.1, 40.2, 80.5];

  Future<double> getLocationRadius() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_locationRadiusKey) ?? defaultRadius;
  }

  Future<void> setLocationRadius(double radius) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_locationRadiusKey, radius);
  }
  
  // Distance unit preferences
  Future<String> getDistanceUnit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_distanceUnitKey) ?? 'miles'; // Default to miles
  }
  
  Future<void> setDistanceUnit(String unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_distanceUnitKey, unit);
  }
  
  Future<bool> isUsingMiles() async {
    final unit = await getDistanceUnit();
    return unit == 'miles';
  }
  
  // Convert miles to kilometers for API calls
  double milesToKilometers(double miles) {
    return miles * 1.60934;
  }
  
  // Convert kilometers to miles for display
  double kilometersToMiles(double kilometers) {
    return kilometers / 1.60934;
  }

  Future<bool> getUseLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_useLocationKey) ?? true;
  }

  Future<void> setUseLocation(bool useLocation) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_useLocationKey, useLocation);
  }

  Future<void> saveUserLocation(double latitude, double longitude) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_userLatKey, latitude);
    await prefs.setDouble(_userLonKey, longitude);
  }

  Future<Map<String, double>?> getUserLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble(_userLatKey);
    final lon = prefs.getDouble(_userLonKey);
    
    if (lat != null && lon != null) {
      return {'latitude': lat, 'longitude': lon};
    }
    return null;
  }

  Future<void> clearUserLocation() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userLatKey);
    await prefs.remove(_userLonKey);
  }
  
  // Check if this is the first time the user is using location features
  Future<bool> isFirstTimeLocationSetup() async {
    final prefs = await SharedPreferences.getInstance();
    return !prefs.containsKey(_useLocationKey);
  }
}
