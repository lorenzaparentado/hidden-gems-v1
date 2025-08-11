import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../screens/add_spot/add_spot_screen.dart';
import '../../screens/auth/auth_screen.dart';
import '../../screens/bookmarks/bookmarks_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/map/map_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/settings/settings_screen.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/spot_detail/spot_detail_screen.dart';
import '../../screens/escape_now/escape_now_screen.dart';
import '../../screens/dev_utils/dev_utils_screen.dart';
import '../../widgets/main_navigation.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    // Splash Screen
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    
    // Auth Routes
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
    ),

    // Main app with bottom navigation
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainNavigation(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/map',
          builder: (context, state) => const MapScreen(),
        ),
        GoRoute(
          path: '/bookmarks',
          builder: (context, state) => const BookmarksScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),

    // Full screen routes
    GoRoute(
      path: '/add-spot',
      builder: (context, state) => const AddSpotScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/dev-utils',
      builder: (context, state) => const DevUtilsScreen(),
    ),
    GoRoute(
      path: '/spot/:id',
      builder: (context, state) {
        final spotId = state.pathParameters['id']!;
        return SpotDetailScreen(spotId: spotId);
      },
    ),
    GoRoute(
      path: '/escape-now',
      builder: (context, state) => const EscapeNowScreen(),
    ),
  ],
);
