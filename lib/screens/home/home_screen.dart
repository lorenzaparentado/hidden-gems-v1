import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/spot_category.dart';
import '../../core/models/spot.dart';
import '../../blocs/blocs.dart';
import '../../services/supabase_service.dart';
import '../../services/location_service.dart';
import '../../widgets/category_filter_pills.dart';
import '../../widgets/spot_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isFilterDrawerOpen = false;
  
  // Local state for filter values (not applied until user clicks Apply)
  String? _tempSelectedCategory;
  double? _tempLocationRadius;
  String? _tempDistanceUnit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final spotsBloc = context.read<SpotsBloc>();
      spotsBloc.add(const SpotsEvent.loadSpots());
      
      // Load user-specific data if authenticated
      final authBloc = context.read<AuthBloc>();
      authBloc.state.whenOrNull(
        authenticated: (userProfile) {
          spotsBloc.add(const SpotsEvent.loadUserSpots());
          spotsBloc.add(const SpotsEvent.loadBookmarkedSpots());
          spotsBloc.add(const SpotsEvent.loadVisitedSpots());
        },
      );
    });
  }

  void _openFilterDrawer() {
    // Initialize temp values with current bloc state
    final state = context.read<SpotsBloc>().state;
    state.whenOrNull(
      loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) {
        setState(() {
          _tempSelectedCategory = selectedCategory?.name ?? 'null';
          _tempLocationRadius = locationRadius;
          _tempDistanceUnit = distanceUnit;
          _isFilterDrawerOpen = true;
        });
      },
    );
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Hidden Spots'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: _openFilterDrawer,
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.go('/profile'),
          ),
        ],
      ),
      endDrawer: _buildFilterDrawer(),
      onEndDrawerChanged: (isOpened) {
        setState(() {
          _isFilterDrawerOpen = isOpened;
        });
      },
      floatingActionButton: !_isFilterDrawerOpen ? FloatingActionButton(
        onPressed: () => context.push('/add-spot'),
        child: const Icon(Icons.add),
      ) : null,
      body: BlocListener<SpotsBloc, SpotsState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message, spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: AppColors.errorRed,
                ),
              );
            },
          );
        },
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<SpotsBloc>().add(const SpotsEvent.loadSpots());
          },
          child: Column(
            children: [
              // Spots Feed
              Expanded(
                child: _buildSpotsFeed(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpotsFeed() {
    return BlocBuilder<SpotsBloc, SpotsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) {
            final filteredSpots = context.read<SpotsBloc>().getFilteredSpots();
            
            if (filteredSpots.isEmpty) {
              return _buildEmptyState();
            }

            return ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: filteredSpots.length,
              itemBuilder: (context, index) {
                final spot = filteredSpots[index];
                return BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState) {
                    final isAuthenticated = authState.whenOrNull(
                      authenticated: (userProfile) => true,
                    ) ?? false;
                    
                    final isBookmarked = bookmarkedSpots.any((s) => s.id == spot.id);
                    final isVisited = visitedSpots.any((s) => s.id == spot.id);
                    
                    return SpotCard(
                      spot: spot,
                      distance: _getDistanceToSpot(spot, currentPosition, distanceUnit),
                      isBookmarked: isBookmarked,
                      isVisited: isVisited,
                      onTap: () => context.push('/spot/${spot.id}'),
                      onBookmarkTap: isAuthenticated ? () => _toggleBookmark(spot) : null,
                      onVisitTap: isAuthenticated ? () => _recordVisit(spot) : null,
                    );
                  },
                );
              },
            );
          },
          error: (message, spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) {
            return _buildErrorState(message);
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.explore_outlined,
            size: 64,
            color: AppColors.mediumGray,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'No spots found nearby',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.mediumGray,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Try adjusting your search radius or category filter',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.mediumGray,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              final isAuthenticated = authState.whenOrNull(
                authenticated: (userProfile) => true,
              ) ?? false;
              
              return ElevatedButton(
                onPressed: () => context.go(isAuthenticated ? '/add-spot' : '/auth'),
                child: Text(isAuthenticated ? 'Add a Spot' : 'Sign In'),
              );
            },
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
            size: 64,
            color: AppColors.errorRed,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
            onPressed: () {
              context.read<SpotsBloc>().add(const SpotsEvent.loadSpots());
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleBookmark(Spot spot) async {
    try {
      final user = SupabaseService.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please sign in to bookmark spots'),
            backgroundColor: AppColors.errorRed,
          ),
        );
        return;
      }

      context.read<SpotsBloc>().add(SpotsEvent.toggleBookmark(spotId: spot.id));
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bookmark updated for ${spot.title}'),
          backgroundColor: AppColors.sageGreen,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update bookmark: ${e.toString()}'),
          backgroundColor: AppColors.errorRed,
        ),
      );
    }
  }

  String? _getDistanceToSpot(Spot spot, Position? currentPosition, String distanceUnit) {
    if (currentPosition == null) return null;
    
    // Calculate distance using location service
    final distanceInMeters = LocationService.instance.calculateDistance(
      currentPosition.latitude,
      currentPosition.longitude,
      spot.latitude,
      spot.longitude,
    );
    
    if (distanceUnit == 'miles') {
      final distanceInMiles = distanceInMeters * 0.000621371;
      return '${distanceInMiles.toStringAsFixed(1)} mi';
    } else {
      final distanceInKm = distanceInMeters / 1000;
      return '${distanceInKm.toStringAsFixed(1)} km';
    }
  }

  Future<void> _recordVisit(Spot spot) async {
    try {
      final user = SupabaseService.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please sign in to track visits'),
            backgroundColor: AppColors.errorRed,
          ),
        );
        return;
      }

      context.read<SpotsBloc>().add(SpotsEvent.toggleVisited(spotId: spot.id));
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Marked ${spot.title} as visited!'),
          backgroundColor: AppColors.sageGreen,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to record visit: ${e.toString()}'),
          backgroundColor: AppColors.errorRed,
        ),
      );
    }
  }

  Widget _buildFilterDrawer() {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: BlocBuilder<SpotsBloc, SpotsState>(
            builder: (context, state) {
              return state.whenOrNull(
                loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Filters', style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: AppSpacing.lg),
                      Text('Category', style: Theme.of(context).textTheme.titleMedium),
                      CategoryFilterPills(
                        selectedCategory: _tempSelectedCategory != null 
                            ? (_tempSelectedCategory == 'null' ? null : SpotCategory.values.firstWhere((c) => c.name == _tempSelectedCategory))
                            : selectedCategory,
                        onCategorySelected: (category) {
                          // Store locally, don't update bloc until Apply is clicked
                          setState(() {
                            _tempSelectedCategory = category?.name ?? 'null';
                          });
                        },
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text('Search Radius', style: Theme.of(context).textTheme.titleMedium),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${(_tempLocationRadius ?? locationRadius).toStringAsFixed(0)} ${(_tempDistanceUnit ?? distanceUnit) == 'miles' ? 'mi' : 'km'}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Row(
                            children: [
                              _buildUnitButton('miles', distanceUnit == 'miles'),
                              const SizedBox(width: AppSpacing.xs),
                              _buildUnitButton('km', distanceUnit == 'km'),
                            ],
                          ),
                        ],
                      ),
                      Slider(
                        value: _tempLocationRadius ?? locationRadius,
                        min: 0,
                        max: (_tempDistanceUnit ?? distanceUnit) == 'miles' ? 50 : 100,
                        label: '${(_tempLocationRadius ?? locationRadius).toStringAsFixed(0)} ${(_tempDistanceUnit ?? distanceUnit) == 'miles' ? 'mi' : 'km'}',
                        onChanged: (value) {
                          // Store locally, don't update bloc until Apply is clicked
                          setState(() {
                            _tempLocationRadius = value;
                          });
                        },
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Apply all temp filter values to bloc
                            final spotsBloc = context.read<SpotsBloc>();
                            if (_tempSelectedCategory != null) {
                              if (_tempSelectedCategory == 'null') {
                                spotsBloc.add(const SpotsEvent.setCategoryFilter(category: null));
                              } else {
                                spotsBloc.add(SpotsEvent.setCategoryFilter(category: SpotCategory.values.firstWhere((c) => c.name == _tempSelectedCategory)));
                              }
                            }
                            if (_tempLocationRadius != null) {
                              spotsBloc.add(SpotsEvent.setLocationRadius(radius: _tempLocationRadius!));
                            }
                            if (_tempDistanceUnit != null) {
                              spotsBloc.add(SpotsEvent.updateDistanceUnit(unit: _tempDistanceUnit!));
                            }
                            
                            // Load spots with new filters
                            spotsBloc.add(const SpotsEvent.loadSpots());
                            
                            // Clear temp values and close drawer
                            setState(() {
                              _tempSelectedCategory = null;
                              _tempLocationRadius = null;
                              _tempDistanceUnit = null;
                              _isFilterDrawerOpen = false;
                            });
                            Navigator.of(context).maybePop();
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('Apply'),
                        ),
                      ),
                    ],
                  );
                },
              ) ?? const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget _buildUnitButton(String unit, bool isSelected) {
    return FilterChip(
      label: Text(unit),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          context.read<SpotsBloc>().add(SpotsEvent.updateDistanceUnit(unit: unit));
        }
      },
    );
  }
}
