import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/spot_category.dart';
import '../../core/models/spot.dart';
import '../../blocs/blocs.dart';
import '../../services/location_service.dart';
import '../../widgets/category_filter_pills.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = MapController();
  bool _isLoadingLocation = false;
  List<Spot> _mapSpots = [];
  DateTime? _lastLocationUpdate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSpots();
    });
  }

  void _loadSpots() {
    final spotsBloc = context.read<SpotsBloc>();
    final currentState = spotsBloc.state;
    currentState.whenOrNull(
      loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) {
        setState(() {
          _mapSpots = spotsBloc.getFilteredSpots();
        });
      },
    );
  }

  Widget _buildTileLayer() {
    // Using OpenStreetMap tiles - completely free, no API limits
    // Provides excellent street-level detail for spot discovery
    return TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      maxZoom: 18.0,
      keepBuffer: 5, // Cache tiles for better performance
      panBuffer: 2, // Preload surrounding tiles
      retinaMode: false, // Standard resolution for efficiency
      userAgentPackageName: 'com.example.wander',
    );
  }

  List<Marker> _buildMarkers(SpotsState spotsState) {
    final List<Marker> markers = [];
    
    spotsState.whenOrNull(
      loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) {
        // Add current location marker if available
        if (useLocation && currentPosition != null) {
          markers.add(
            Marker(
              point: LatLng(
                currentPosition.latitude,
                currentPosition.longitude,
              ),
              width: 50,
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.forestGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.my_location,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          );
        }
      },
    );
    
    // Add spot markers
    markers.addAll(_mapSpots.map((spot) {
      return Marker(
        point: LatLng(spot.latitude, spot.longitude),
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () => _showSpotBottomSheet(spot),
          child: Container(
            decoration: BoxDecoration(
              color: _getCategoryColor(spot),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              _getCategoryIcon(spot),
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      );
    }));
    
    return markers;
  }

  Color _getCategoryColor(Spot spot) {
    switch (spot.category) {
      case SpotCategory.quiet:
        return AppColors.dustyBlue;
      case SpotCategory.nature:
        return AppColors.forestBrown;
      case SpotCategory.art:
        return AppColors.terracotta;
      case SpotCategory.views:
        return AppColors.goldenYellow;
    }
  }

  IconData _getCategoryIcon(Spot spot) {
    switch (spot.category) {
      case SpotCategory.quiet:
        return Icons.book;
      case SpotCategory.nature:
        return Icons.nature;
      case SpotCategory.art:
        return Icons.palette;
      case SpotCategory.views:
        return Icons.camera_alt;
    }
  }

  void _showSpotBottomSheet(Spot spot) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spot.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      spot.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to spot detail
                          context.push('/spot/${spot.id}');
                          // Navigate to spot detail
                        },
                        child: const Text('View Details'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _centerOnCurrentLocation() async {
    // Debounce location requests to reduce API calls
    final now = DateTime.now();
    if (_lastLocationUpdate != null && 
        now.difference(_lastLocationUpdate!).inSeconds < 10) {
      return; // Skip if last update was less than 10 seconds ago
    }
    
    setState(() => _isLoadingLocation = true);
    
    try {
      final locationService = LocationService.instance;
      final position = await locationService.getCurrentPosition();
      
      if (position != null && mounted) {
        mapController.move(
          LatLng(position.latitude, position.longitude),
          15.0, // Zoom level for current location
        );
        _lastLocationUpdate = now;
        
        // Update location in bloc
        context.read<SpotsBloc>().add(SpotsEvent.setLocationRadius(radius: 5.0));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to get location: $e'),
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingLocation = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<SpotsBloc>().add(const SpotsEvent.loadSpots());
              _loadSpots();
            },
          ),
        ],
      ),
      body: BlocListener<SpotsBloc, SpotsState>(
        listener: (context, state) {
          state.whenOrNull(
            loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) {
              _loadSpots();
            },
          );
        },
        child: BlocBuilder<SpotsBloc, SpotsState>(
          builder: (context, spotsState) {
            return Stack(
              children: [
                // Flutter Map with OpenStreetMap tiles
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: LatLng(
                      39.9526, // Philadelphia latitude
                      -75.1652, // Philadelphia longitude
                    ),
                    initialZoom: 12.0,
                    minZoom: 5.0, // Increased from 3.0 to reduce tile requests
                    maxZoom: 16.0, // Reduced from 18.0 to save API calls
                    // Reduce unnecessary map updates
                    interactionOptions: const InteractionOptions(
                      enableMultiFingerGestureRace: false,
                    ),
                  ),
                  children: [
                    _buildTileLayer(),
                    MarkerLayer(
                      markers: _buildMarkers(spotsState),
                    ),
                  ],
                ),
                
                // Category filters overlay
                Positioned(
                  top: AppSpacing.md,
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.charcoal.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: BlocSelector<SpotsBloc, SpotsState, SpotCategory?>(
                      selector: (state) => state.whenOrNull(
                        loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) => selectedCategory,
                      ),
                      builder: (context, selectedCategory) {
                        return CategoryFilterPills(
                          selectedCategory: selectedCategory,
                          onCategorySelected: (category) {
                            context.read<SpotsBloc>().add(SpotsEvent.setCategoryFilter(category: category));
                          },
                        );
                      },
                    ),
                  ),
                ),
                
                // Current location button
                Positioned(
                  bottom: 100, // Above bottom navigation
                  right: AppSpacing.md,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.forestGreen,
                    onPressed: _isLoadingLocation ? null : _centerOnCurrentLocation,
                    child: _isLoadingLocation
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.my_location),
                  ),
                ),
                
                // Zoom controls
                Positioned(
                  bottom: 160, // Above current location button
                  right: AppSpacing.md,
                  child: Column(
                    children: [
                      // Zoom in button
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.charcoal.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              final currentZoom = mapController.camera.zoom;
                              mapController.move(
                                mapController.camera.center,
                                (currentZoom + 1).clamp(5.0, 16.0),
                              );
                            },
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: AppColors.forestGreen,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      // Divider
                      Container(
                        width: 40,
                        height: 1,
                        color: AppColors.lightGray,
                      ),
                      // Zoom out button
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.charcoal.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              final currentZoom = mapController.camera.zoom;
                              mapController.move(
                                mapController.camera.center,
                                (currentZoom - 1).clamp(5.0, 16.0),
                              );
                            },
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: AppColors.forestGreen,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Spots count indicator
                // Positioned(
                //   bottom: 160,
                //   left: AppSpacing.md,
                //   child: BlocSelector<SpotsBloc, SpotsState, int>(
                //     selector: (state) => state.whenOrNull(
                //       loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) {
                //         return context.read<SpotsBloc>().getFilteredSpots().length;
                //       },
                //     ) ?? 0,
                //     builder: (context, spotsCount) {
                //       return Container(
                //         padding: const EdgeInsets.symmetric(
                //           horizontal: AppSpacing.md,
                //           vertical: AppSpacing.sm,
                //         ),
                //         decoration: BoxDecoration(
                //           color: AppColors.white,
                //           borderRadius: BorderRadius.circular(20),
                //           boxShadow: [
                //             BoxShadow(
                //               color: AppColors.charcoal.withOpacity(0.1),
                //               blurRadius: 8,
                //               offset: const Offset(0, 2),
                //             ),
                //           ],
                //         ),
                //         child: Text(
                //           '$spotsCount spots',
                //           style: Theme.of(context).textTheme.bodySmall?.copyWith(
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
