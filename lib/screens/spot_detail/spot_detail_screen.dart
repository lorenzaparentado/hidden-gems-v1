import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/spot.dart';
import '../../blocs/blocs.dart';
import '../../services/supabase_service.dart';
import '../../services/navigation_service.dart';
import '../../services/location_service.dart';

class SpotDetailScreen extends StatefulWidget {
  final String spotId;

  const SpotDetailScreen({
    super.key,
    required this.spotId,
  });

  @override
  State<SpotDetailScreen> createState() => _SpotDetailScreenState();
}

class _SpotDetailScreenState extends State<SpotDetailScreen> {
  Spot? spot;
  bool isBookmarked = false;
  bool isVisited = false;
  String? distance;

  @override
  void initState() {
    super.initState();
    _loadSpotData();
  }

  Future<void> _loadSpotData() async {
    final spotsBloc = context.read<SpotsBloc>();
    final currentState = spotsBloc.state;
    
    currentState.whenOrNull(
      loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) {
        // Find the spot in the loaded spots
        try {
          final foundSpot = spots.firstWhere((s) => s.id == widget.spotId);
          final visited = visitedSpots.any((s) => s.id == widget.spotId);
          final bookmarked = bookmarkedSpots.any((s) => s.id == widget.spotId);
          setState(() {
            spot = foundSpot;
            isBookmarked = bookmarked;
            isVisited = visited;
          });
          // Calculate distance if location is available
          if (currentPosition != null) {
            _calculateDistance(foundSpot, currentPosition, distanceUnit);
          }
        } catch (e) {
          // Spot not found, try to load it
          context.read<SpotsBloc>().add(const SpotsEvent.loadSpots());
        }
      },
    );
  }

  void _calculateDistance(Spot spot, Position position, String distanceUnit) {
    final locationService = LocationService.instance;
    
    if (distanceUnit == 'miles') {
      final distanceInMiles = locationService.calculateDistanceInMiles(
        position.latitude,
        position.longitude,
        spot.latitude,
        spot.longitude,
      );
      setState(() {
        distance = "${locationService.formatDistanceInMiles(distanceInMiles)} away";
      });
    } else {
      final distanceInMeters = locationService.calculateDistance(
        position.latitude,
        position.longitude,
        spot.latitude,
        spot.longitude,
      );
      setState(() {
        distance = "${locationService.formatDistance(distanceInMeters)} away";
      });
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else if (difference < 30) {
      final weeks = (difference / 7).floor();
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    } else if (difference < 365) {
      final months = (difference / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else {
      final years = (difference / 365).floor();
      return years == 1 ? '1 year ago' : '$years years ago';
    }
  }

  Future<void> _toggleBookmark() async {
    final user = SupabaseService.instance.currentUser;
    if (user == null || spot == null) return;

    try {
      context.read<SpotsBloc>().add(SpotsEvent.toggleBookmark(spotId: spot!.id));
      
      setState(() {
        isBookmarked = !isBookmarked;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating bookmark: ${e.toString()}'),
          backgroundColor: AppColors.errorRed,
        ),
      );
    }
  }

  Future<void> _markVisited() async {
    final user = SupabaseService.instance.currentUser;
    if (user == null || spot == null) return;

    try {
      context.read<SpotsBloc>().add(SpotsEvent.toggleVisited(spotId: spot!.id));
      
      setState(() {
        isVisited = true;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Spot marked as visited!'),
          backgroundColor: AppColors.sageGreen,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error marking as visited: ${e.toString()}'),
          backgroundColor: AppColors.errorRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpotsBloc, SpotsState>(
      listener: (context, state) {
        state.whenOrNull(
          loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) {
            try {
              // Always try to find and update the spot with latest data
              final foundSpot = spots.firstWhere((s) => s.id == widget.spotId);
              final visited = visitedSpots.any((s) => s.id == widget.spotId);
              final bookmarked = bookmarkedSpots.any((s) => s.id == widget.spotId);
              setState(() {
                spot = foundSpot; // Update the entire spot object with latest stats
                isBookmarked = bookmarked;
                isVisited = visited;
              });
              // Recalculate distance if location is available
              if (currentPosition != null) {
                _calculateDistance(foundSpot, currentPosition, distanceUnit);
              }
            } catch (e) {
              // Spot not found in current spots list
              if (spot != null) {
                // Keep existing spot but update bookmark/visit status
                final visited = visitedSpots.any((s) => s.id == widget.spotId);
                final bookmarked = bookmarkedSpots.any((s) => s.id == widget.spotId);
                setState(() {
                  isBookmarked = bookmarked;
                  isVisited = visited;
                });
                // Still try to calculate distance if location is available
                if (currentPosition != null) {
                  _calculateDistance(spot!, currentPosition, distanceUnit);
                }
              }
            }
          },
        );
      },
      child: Scaffold(
        body: spot == null
            ? const Center(child: CircularProgressIndicator())
            : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return CustomScrollView(
      slivers: [
        // App Bar with Image
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                // Background Image
                Container(
                  decoration: BoxDecoration(
                    image: spot!.imageUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(spot!.imageUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: spot!.imageUrl.isEmpty ? AppColors.lightGray : null,
                  ),
                  child: spot!.imageUrl.isEmpty
                      ? const Icon(
                          Icons.image,
                          size: 64,
                          color: AppColors.mediumGray,
                        )
                      : null,
                ),
                
                // Gradient Overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: isBookmarked ? AppColors.goldenYellow : AppColors.white,
              ),
              onPressed: _toggleBookmark,
            ),
          ],
        ),
        
        // Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Category
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            spot!.title,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.forestGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppRadius.small),
                            ),
                            child: Text(
                              spot!.category.displayName,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.forestGreen,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppSpacing.lg),
                
                // Location and Distance
                if (distance != null) ...[
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: AppColors.mediumGray),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        distance!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.mediumGray,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                
                // Description
                Text(
                  'About this spot',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  spot!.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                
                const SizedBox(height: AppSpacing.xl),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await NavigationService.instance.launchNavigation(
                            latitude: spot!.latitude,
                            longitude: spot!.longitude,
                            locationName: spot!.title,
                          );
                        },
                        icon: const Icon(Icons.directions),
                        label: const Text('Get Directions'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.forestGreen,
                          foregroundColor: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: isVisited ? null : _markVisited,
                        icon: Icon(isVisited ? Icons.check : Icons.flag),
                        label: Text(isVisited ? 'Visited' : 'Mark Visited'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: isVisited ? AppColors.sageGreen : AppColors.forestGreen,
                          side: BorderSide(
                            color: isVisited ? AppColors.sageGreen : AppColors.forestGreen,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppSpacing.xl),
                
                // Stats
                _buildStatsCard(),
                
                const SizedBox(height: AppSpacing.lg),
                
                // Date Added
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: AppColors.mediumGray),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      'Added ${_formatDate(spot!.createdAt)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.mediumGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.softCream,
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat('Added by', 'User'),
          _buildStat('Visits', '${spot!.visitCount}'),
          _buildStat('Bookmarks', '${spot!.bookmarkCount}'),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.forestGreen,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
