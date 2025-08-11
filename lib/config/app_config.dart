class AppConfig {
  // Development Settings
  static const bool isDevelopmentMode = false; // Set to true for offline development
  
  // Supabase Configuration
  static const String supabaseUrl = 'https://tgtghiyqbejgnbpzokzb.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRndGdoaXlxYmVqZ25icHpva3piIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ2NTg2MzUsImV4cCI6MjA3MDIzNDYzNX0.3PfEWQJOSC586HihRvlOKi1-AEiFMjYAghI9Y2IfXo0';
  
  // App Configuration
  static const String appName = 'Hidden Gems';
  static const String appVersion = '1.0.0';
  
  // Map Configuration
  static const String mapboxAccessToken = 'pk.eyJ1IjoibG9yZW56YXBhcmVudGFkbyIsImEiOiJjbWUzM253YzYwMzU3MmxvaHkzdzZva3dpIn0.N9O4KZEr0ALzc3u9DgiNOw';
  static const double defaultLatitude = 39.9526; // Philadelphia
  static const double defaultLongitude = -75.1652;
  static const double defaultZoom = 12.0;
  static const String mapboxStyleUrl = 'mapbox://styles/mapbox/streets-v12';
  
  // Premium Features
  static const bool isPremiumEnabled = false; // Set to true when ready
  static const int maxFreeSpotsPerUser = 3;
  static const int maxFreeBookmarks = 10;
  
  // Monetization
  static const String premiumSubscriptionId = 'hidden_spots_premium';
  static const double premiumMonthlyPrice = 4.99;
  static const double premiumYearlyPrice = 39.99;
}
