import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wander/config/app_config.dart';
import 'package:wander/core/theme/app_colors.dart';
import 'package:wander/core/theme/app_theme.dart';
import 'package:wander/blocs/blocs.dart';
import 'package:wander/widgets/spot_card.dart';
import 'coming_soon_screen.dart';

class EscapeNowScreen extends StatefulWidget {
  const EscapeNowScreen({super.key});

  @override
  State<EscapeNowScreen> createState() => _EscapeNowScreenState();
}

class _EscapeNowScreenState extends State<EscapeNowScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadNearbySpots();
    });
  }

  void _loadNearbySpots() {
    context.read<SpotsBloc>().add(const SpotsEvent.loadSpots());
  }

  @override
  Widget build(BuildContext context) {
    // Check if premium is enabled
    if (!AppConfig.isPremiumEnabled) {
      return const ComingSoonScreen(
        feature: 'Escape Now',
        description: 'Find instant adventure within walking distance.',
      );
    }

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return authState.when(
          initial: () => _buildLoadingState(),
          loading: () => _buildLoadingState(),
          authenticated: (userProfile) {
            // Check if user is premium
            if (!userProfile.hasPremiumAccess) {
              return _buildPremiumUpsell();
            }
            return _buildMainContent();
          },
          unauthenticated: () => _buildPremiumUpsell(),
          error: (message, userProfile) => _buildPremiumUpsell(),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escape Now'),
        backgroundColor: AppColors.forestGreen,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildMainContent() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escape Now'),
        backgroundColor: AppColors.forestGreen,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadNearbySpots();
        },
        child: BlocBuilder<SpotsBloc, SpotsState>(
          builder: (context, spotsState) {
            return spotsState.when(
              initial: () => _buildLoadingState(),
              loading: () => _buildLoadingContent(),
              loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) {
                // Filter for nearby spots (within walking distance - e.g., 1km)
                final nearbySpots = spots.where((spot) {
                  // TODO: Implement proper distance filtering based on currentPosition
                  return true; // For now, show all spots
                }).take(5).toList(); // Limit to 5 spots for "escape now"

                if (nearbySpots.isEmpty) {
                  return _buildEmptyState();
                }

                return _buildSpotsList(nearbySpots);
              },
              error: (message, spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) {
                return _buildErrorState(message);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingContent() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: AppSpacing.md),
          Text('Finding nearby adventures...'),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.explore_off,
            size: 80,
            color: AppColors.mediumGray,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'No nearby spots found',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.mediumGray,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Try expanding your search radius or check back later',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.mediumGray,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton(
            onPressed: _loadNearbySpots,
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildSpotsList(List spots) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.forestGreen, AppColors.sageGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppRadius.medium),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adventure Awaits',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Quick escapes within walking distance',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppSpacing.lg),
          
          // Spots Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 2.5,
                mainAxisSpacing: AppSpacing.md,
              ),
              itemCount: spots.length,
              itemBuilder: (context, index) {
                final spot = spots[index];
                return SpotCard(
                  spot: spot,
                  onTap: () {
                    // TODO: Navigate to spot detail
                  },
                  onBookmarkTap: () {
                    context.read<SpotsBloc>().add(SpotsEvent.toggleBookmark(spotId: spot.id));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumUpsell() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escape Now'),
        backgroundColor: AppColors.forestGreen,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 100,
              color: AppColors.goldenYellow,
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Escape Now',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.forestGreen,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Get instant adventure recommendations within walking distance. Perfect for when you need a quick escape.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.mediumGray,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.lightGray.withOpacity(0.3),
                borderRadius: BorderRadius.circular(AppRadius.medium),
              ),
              child: Column(
                children: [
                  _buildFeatureItem('🎯', 'Instant recommendations'),
                  _buildFeatureItem('🚶', 'Walking distance spots'),
                  _buildFeatureItem('⚡', 'Quick adventure ideas'),
                  _buildFeatureItem('📍', 'Location-based suggestions'),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to premium upgrade
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Premium upgrade coming soon!'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.forestGreen,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                ),
                child: const Text(
                  'Upgrade to Premium',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: AppSpacing.sm),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: AppColors.errorRed,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.errorRed,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            error,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.mediumGray,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton(
            onPressed: _loadNearbySpots,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
