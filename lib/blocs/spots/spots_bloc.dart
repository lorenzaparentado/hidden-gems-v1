import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/models/spot_category.dart';
import '../../core/models/spot.dart';
import '../../services/supabase_service.dart';
import '../../services/location_service.dart';
import '../../services/user_preferences_service.dart';
import 'spots_event.dart';
import 'spots_state.dart';

class SpotsBloc extends Bloc<SpotsEvent, SpotsState> {
  final SupabaseService _supabaseService = SupabaseService.instance;
  final LocationService _locationService = LocationService.instance;
  final UserPreferencesService _preferencesService = UserPreferencesService.instance;

  SpotsBloc() : super(const SpotsState.initial()) {
    on<SpotsEvent>((event, emit) async {
      await event.when(
        started: () => _onStarted(emit),
        loadSpots: () => _onLoadSpots(emit),
        loadUserSpots: () => _onLoadUserSpots(emit),
        loadBookmarkedSpots: () => _onLoadBookmarkedSpots(emit),
        loadVisitedSpots: () => _onLoadVisitedSpots(emit),
        setCategoryFilter: (category) => _onSetCategoryFilter(emit, category),
        setLocationRadius: (radius) => _onSetLocationRadius(emit, radius),
        toggleUseLocation: () => _onToggleUseLocation(emit),
        updateDistanceUnit: (unit) => _onUpdateDistanceUnit(emit, unit),
        addSpot: (spot) => _onAddSpot(emit, spot),
        updateSpot: (spot) => _onUpdateSpot(emit, spot),
        deleteSpot: (spotId) => _onDeleteSpot(emit, spotId),
        toggleBookmark: (spotId) => _onToggleBookmark(emit, spotId),
        toggleVisited: (spotId) => _onToggleVisited(emit, spotId),
        recordVisitWithRating: (spotId, rating, notes) => _onRecordVisitWithRating(emit, spotId, rating, notes),
        refreshLocation: () => _onRefreshLocation(emit),
      );
    });

    // Initialize
    add(const SpotsEvent.started());
  }

  Future<void> _onStarted(Emitter<SpotsState> emit) async {
    emit(const SpotsState.loading());
    await _loadUserPreferences(emit);
    await _onLoadSpots(emit);
    
    // Load user-specific data if authenticated
    final user = _supabaseService.currentUser;
    if (user != null) {
      await _onLoadUserSpots(emit);
      await _onLoadBookmarkedSpots(emit);
      await _onLoadVisitedSpots(emit);
    }
  }

  Future<void> _loadUserPreferences(Emitter<SpotsState> emit) async {
    try {
      final radius = await _preferencesService.getLocationRadius();
      final unit = await _preferencesService.getDistanceUnit();
      final useLocation = await _preferencesService.getUseLocation();
      
      final currentState = state;
      currentState.when(
        initial: () => {},
        loading: () => {},
        loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, _, __, ___) {
          emit(SpotsState.loaded(
            spots: spots,
            userSpots: userSpots,
            bookmarkedSpots: bookmarkedSpots,
            visitedSpots: visitedSpots,
            selectedCategory: selectedCategory,
            currentPosition: currentPosition,
            locationRadius: radius,
            useLocation: useLocation,
            distanceUnit: unit,
          ));
        },
        error: (message, spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, _, __, ___) {
          emit(SpotsState.error(
            message: message,
            spots: spots ?? [],
            userSpots: userSpots ?? [],
            bookmarkedSpots: bookmarkedSpots ?? [],
            visitedSpots: visitedSpots ?? [],
            selectedCategory: selectedCategory,
            currentPosition: currentPosition,
            locationRadius: radius,
            useLocation: useLocation,
            distanceUnit: unit,
          ));
        },
      );
    } catch (e) {
      // Use defaults if preferences can't be loaded
    }
  }

  Future<void> _onLoadSpots(Emitter<SpotsState> emit) async {
    try {
      final currentState = state;
      
      Position? currentPosition;
      bool useLocation = true;
      double locationRadius = 5.0;
      String distanceUnit = 'miles';
      SpotCategory? selectedCategory;
      
      currentState.when(
        initial: () => {},
        loading: () => {},
        loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, category, position, radius, useLoc, unit) {
          useLocation = useLoc;
          locationRadius = radius;
          distanceUnit = unit;
          selectedCategory = category;
          currentPosition = position;
        },
        error: (message, spots, userSpots, bookmarkedSpots, visitedSpots, category, position, radius, useLoc, unit) {
          useLocation = useLoc;
          locationRadius = radius;
          distanceUnit = unit;
          selectedCategory = category;
          currentPosition = position;
        },
      );

      // Get current location if enabled
      if (useLocation) {
        currentPosition = await _locationService.getCurrentPosition();
      }

      // Load spots
      final spots = await _supabaseService.getSpots(
        category: selectedCategory?.toString().split('.').last,
        latitude: useLocation ? currentPosition?.latitude : null,
        longitude: useLocation ? currentPosition?.longitude : null,
        radiusKm: useLocation ? (distanceUnit == 'miles' 
            ? _preferencesService.milesToKilometers(locationRadius)
            : locationRadius) : null,
      );

      // Sort by distance if we have location and are using location
      if (useLocation && currentPosition != null) {
        spots.sort((a, b) {
          final distanceA = _locationService.calculateDistance(
            currentPosition!.latitude,
            currentPosition!.longitude,
            a.latitude,
            a.longitude,
          );
          final distanceB = _locationService.calculateDistance(
            currentPosition!.latitude,
            currentPosition!.longitude,
            b.latitude,
            b.longitude,
          );
          return distanceA.compareTo(distanceB);
        });
      }

      final currentData = _getCurrentData();
      emit(SpotsState.loaded(
        spots: spots,
        userSpots: currentData.userSpots,
        bookmarkedSpots: currentData.bookmarkedSpots,
        visitedSpots: currentData.visitedSpots,
        selectedCategory: selectedCategory,
        currentPosition: currentPosition,
        locationRadius: locationRadius,
        useLocation: useLocation,
        distanceUnit: distanceUnit,
      ));
    } catch (e) {
      final currentData = _getCurrentData();
      emit(SpotsState.error(
        message: e.toString(),
        spots: currentData.spots,
        userSpots: currentData.userSpots,
        bookmarkedSpots: currentData.bookmarkedSpots,
        visitedSpots: currentData.visitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
    }
  }

  Future<void> _onLoadUserSpots(Emitter<SpotsState> emit) async {
    try {
      final user = _supabaseService.currentUser;
      if (user == null) {
        // User not authenticated, keep empty user spots
        final currentData = _getCurrentData();
        emit(SpotsState.loaded(
          spots: currentData.spots,
          userSpots: [],
          bookmarkedSpots: currentData.bookmarkedSpots,
          visitedSpots: currentData.visitedSpots,
          selectedCategory: currentData.selectedCategory,
          currentPosition: currentData.currentPosition,
          locationRadius: currentData.locationRadius,
          useLocation: currentData.useLocation,
          distanceUnit: currentData.distanceUnit,
        ));
        return;
      }

      final userSpots = await _supabaseService.getUserSpots(user.id);
      final currentData = _getCurrentData();
      
      emit(SpotsState.loaded(
        spots: currentData.spots,
        userSpots: userSpots,
        bookmarkedSpots: currentData.bookmarkedSpots,
        visitedSpots: currentData.visitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
    } catch (e) {
      final currentData = _getCurrentData();
      emit(SpotsState.error(
        message: e.toString(),
        spots: currentData.spots,
        userSpots: currentData.userSpots,
        bookmarkedSpots: currentData.bookmarkedSpots,
        visitedSpots: currentData.visitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
    }
  }

  Future<void> _onLoadBookmarkedSpots(Emitter<SpotsState> emit) async {
    try {
      final user = _supabaseService.currentUser;
      if (user == null) {
        // User not authenticated, keep empty bookmarked spots
        final currentData = _getCurrentData();
        emit(SpotsState.loaded(
          spots: currentData.spots,
          userSpots: currentData.userSpots,
          bookmarkedSpots: [],
          visitedSpots: currentData.visitedSpots,
          selectedCategory: currentData.selectedCategory,
          currentPosition: currentData.currentPosition,
          locationRadius: currentData.locationRadius,
          useLocation: currentData.useLocation,
          distanceUnit: currentData.distanceUnit,
        ));
        return;
      }

      final bookmarkedSpots = await _supabaseService.getUserBookmarks(user.id);
      final currentData = _getCurrentData();
      
      emit(SpotsState.loaded(
        spots: currentData.spots,
        userSpots: currentData.userSpots,
        bookmarkedSpots: bookmarkedSpots,
        visitedSpots: currentData.visitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
    } catch (e) {
      final currentData = _getCurrentData();
      emit(SpotsState.error(
        message: e.toString(),
        spots: currentData.spots,
        userSpots: currentData.userSpots,
        bookmarkedSpots: currentData.bookmarkedSpots,
        visitedSpots: currentData.visitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
    }
  }

  Future<void> _onLoadVisitedSpots(Emitter<SpotsState> emit) async {
    try {
      final user = _supabaseService.currentUser;
      if (user == null) {
        // User not authenticated, keep empty visited spots
        final currentData = _getCurrentData();
        emit(SpotsState.loaded(
          spots: currentData.spots,
          userSpots: currentData.userSpots,
          bookmarkedSpots: currentData.bookmarkedSpots,
          visitedSpots: [],
          selectedCategory: currentData.selectedCategory,
          currentPosition: currentData.currentPosition,
          locationRadius: currentData.locationRadius,
          useLocation: currentData.useLocation,
          distanceUnit: currentData.distanceUnit,
        ));
        return;
      }

      final visitedSpots = await _supabaseService.getUserVisitedSpots(user.id);
      final currentData = _getCurrentData();
      
      emit(SpotsState.loaded(
        spots: currentData.spots,
        userSpots: currentData.userSpots,
        bookmarkedSpots: currentData.bookmarkedSpots,
        visitedSpots: visitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
    } catch (e) {
      final currentData = _getCurrentData();
      emit(SpotsState.error(
        message: e.toString(),
        spots: currentData.spots,
        userSpots: currentData.userSpots,
        bookmarkedSpots: currentData.bookmarkedSpots,
        visitedSpots: currentData.visitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
    }
  }

  Future<void> _onSetCategoryFilter(Emitter<SpotsState> emit, SpotCategory? category) async {
    final currentData = _getCurrentData();
    
    emit(SpotsState.loaded(
      spots: currentData.spots,
      userSpots: currentData.userSpots,
      bookmarkedSpots: currentData.bookmarkedSpots,
      visitedSpots: currentData.visitedSpots,
      selectedCategory: category,
      currentPosition: currentData.currentPosition,
      locationRadius: currentData.locationRadius,
      useLocation: currentData.useLocation,
      distanceUnit: currentData.distanceUnit,
    ));
    
    // Reload spots with new filter
    add(const SpotsEvent.loadSpots());
  }

  Future<void> _onSetLocationRadius(Emitter<SpotsState> emit, double radius) async {
    await _preferencesService.setLocationRadius(radius);
    final currentData = _getCurrentData();
    
    emit(SpotsState.loaded(
      spots: currentData.spots,
      userSpots: currentData.userSpots,
      bookmarkedSpots: currentData.bookmarkedSpots,
      visitedSpots: currentData.visitedSpots,
      selectedCategory: currentData.selectedCategory,
      currentPosition: currentData.currentPosition,
      locationRadius: radius,
      useLocation: currentData.useLocation,
      distanceUnit: currentData.distanceUnit,
    ));
    
    // Reload spots with new radius
    add(const SpotsEvent.loadSpots());
  }

  Future<void> _onToggleUseLocation(Emitter<SpotsState> emit) async {
    final currentData = _getCurrentData();
    final newUseLocation = !currentData.useLocation;
    
    await _preferencesService.setUseLocation(newUseLocation);
    
    emit(SpotsState.loaded(
      spots: currentData.spots,
      userSpots: currentData.userSpots,
      bookmarkedSpots: currentData.bookmarkedSpots,
      visitedSpots: currentData.visitedSpots,
      selectedCategory: currentData.selectedCategory,
      currentPosition: currentData.currentPosition,
      locationRadius: currentData.locationRadius,
      useLocation: newUseLocation,
      distanceUnit: currentData.distanceUnit,
    ));
    
    // Reload spots with new location setting
    add(const SpotsEvent.loadSpots());
  }

  Future<void> _onUpdateDistanceUnit(Emitter<SpotsState> emit, String unit) async {
    await _preferencesService.setDistanceUnit(unit);
    final currentData = _getCurrentData();
    
    emit(SpotsState.loaded(
      spots: currentData.spots,
      userSpots: currentData.userSpots,
      bookmarkedSpots: currentData.bookmarkedSpots,
      visitedSpots: currentData.visitedSpots,
      selectedCategory: currentData.selectedCategory,
      currentPosition: currentData.currentPosition,
      locationRadius: currentData.locationRadius,
      useLocation: currentData.useLocation,
      distanceUnit: unit,
    ));
    
    // Reload spots with new unit
    add(const SpotsEvent.loadSpots());
  }

  Future<void> _onAddSpot(Emitter<SpotsState> emit, Spot spot) async {
    try {
      final addedSpot = await _supabaseService.createSpot(spot);
      final currentData = _getCurrentData();
      
      emit(SpotsState.loaded(
        spots: [...currentData.spots, addedSpot],
        userSpots: [...currentData.userSpots, addedSpot],
        bookmarkedSpots: currentData.bookmarkedSpots,
        visitedSpots: currentData.visitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
    } catch (e) {
      final currentData = _getCurrentData();
      emit(SpotsState.error(
        message: e.toString(),
        spots: currentData.spots,
        userSpots: currentData.userSpots,
        bookmarkedSpots: currentData.bookmarkedSpots,
        visitedSpots: currentData.visitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
    }
  }

  Future<void> _onUpdateSpot(Emitter<SpotsState> emit, Spot spot) async {
    try {
      final updatedSpot = await _supabaseService.updateSpot(spot);
      final currentData = _getCurrentData();
      
      emit(SpotsState.loaded(
        spots: currentData.spots.map((s) => s.id == spot.id ? updatedSpot : s).toList(),
        userSpots: currentData.userSpots.map((s) => s.id == spot.id ? updatedSpot : s).toList(),
        bookmarkedSpots: currentData.bookmarkedSpots.map((s) => s.id == spot.id ? updatedSpot : s).toList(),
        visitedSpots: currentData.visitedSpots.map((s) => s.id == spot.id ? updatedSpot : s).toList(),
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
    } catch (e) {
      final currentData = _getCurrentData();
      emit(SpotsState.error(
        message: e.toString(),
        spots: currentData.spots,
        userSpots: currentData.userSpots,
        bookmarkedSpots: currentData.bookmarkedSpots,
        visitedSpots: currentData.visitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
    }
  }

  Future<void> _onDeleteSpot(Emitter<SpotsState> emit, String spotId) async {
    try {
      await _supabaseService.deleteSpot(spotId);
      final currentData = _getCurrentData();
      
      emit(SpotsState.loaded(
        spots: currentData.spots.where((s) => s.id != spotId).toList(),
        userSpots: currentData.userSpots.where((s) => s.id != spotId).toList(),
        bookmarkedSpots: currentData.bookmarkedSpots.where((s) => s.id != spotId).toList(),
        visitedSpots: currentData.visitedSpots.where((s) => s.id != spotId).toList(),
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
    } catch (e) {
      final currentData = _getCurrentData();
      emit(SpotsState.error(
        message: e.toString(),
        spots: currentData.spots,
        userSpots: currentData.userSpots,
        bookmarkedSpots: currentData.bookmarkedSpots,
        visitedSpots: currentData.visitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
    }
  }

  Future<void> _onToggleBookmark(Emitter<SpotsState> emit, String spotId) async {
    try {
      final user = _supabaseService.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final currentData = _getCurrentData();
      
      // Use the database function which handles stats updates automatically
      final isNowBookmarked = await _supabaseService.toggleBookmark(spotId);
      
      // Update spots in memory immediately
      final updatedSpots = currentData.spots.map((spot) {
        if (spot.id == spotId) {
          return spot.copyWith(
            bookmarkCount: isNowBookmarked 
                ? spot.bookmarkCount + 1 
                : (spot.bookmarkCount > 0 ? spot.bookmarkCount - 1 : 0),
          );
        }
        return spot;
      }).toList();
      
      // Update bookmarked spots list
      List<Spot> updatedBookmarkedSpots;
      if (isNowBookmarked) {
        // Add to bookmarked if not already there
        final spotToAdd = updatedSpots.firstWhere((s) => s.id == spotId);
        updatedBookmarkedSpots = [...currentData.bookmarkedSpots];
        if (!updatedBookmarkedSpots.any((s) => s.id == spotId)) {
          updatedBookmarkedSpots.add(spotToAdd);
        }
      } else {
        // Remove from bookmarked
        updatedBookmarkedSpots = currentData.bookmarkedSpots.where((s) => s.id != spotId).toList();
      }
      
      // Emit updated state immediately
      emit(SpotsState.loaded(
        spots: updatedSpots,
        userSpots: currentData.userSpots,
        bookmarkedSpots: updatedBookmarkedSpots,
        visitedSpots: currentData.visitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
      
    } catch (e) {
      final currentData = _getCurrentData();
      emit(SpotsState.error(
        message: e.toString(),
        spots: currentData.spots,
        userSpots: currentData.userSpots,
        bookmarkedSpots: currentData.bookmarkedSpots,
        visitedSpots: currentData.visitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
    }
  }

  Future<void> _onToggleVisited(Emitter<SpotsState> emit, String spotId) async {
    try {
      final user = _supabaseService.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final currentData = _getCurrentData();
      
      // Check if currently visited
      final isCurrentlyVisited = currentData.visitedSpots.any((s) => s.id == spotId);
      
      // Mark the spot as visited using the Supabase function
      final isNewVisit = await _supabaseService.recordVisit(user.id, spotId);
      
      // Update spots in memory immediately
      final updatedSpots = currentData.spots.map((spot) {
        if (spot.id == spotId && isNewVisit) {
          return spot.copyWith(
            visitCount: spot.visitCount + 1,
          );
        }
        return spot;
      }).toList();
      
      // Update visited spots list
      List<Spot> updatedVisitedSpots;
      if (isNewVisit && !isCurrentlyVisited) {
        // Add to visited if not already there
        final spotToAdd = updatedSpots.firstWhere((s) => s.id == spotId);
        updatedVisitedSpots = [...currentData.visitedSpots, spotToAdd];
      } else {
        updatedVisitedSpots = currentData.visitedSpots;
      }
      
      // Emit updated state immediately
      emit(SpotsState.loaded(
        spots: updatedSpots,
        userSpots: currentData.userSpots,
        bookmarkedSpots: currentData.bookmarkedSpots,
        visitedSpots: updatedVisitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
      
    } catch (e) {
      final currentData = _getCurrentData();
      emit(SpotsState.error(
        message: e.toString(),
        spots: currentData.spots,
        userSpots: currentData.userSpots,
        bookmarkedSpots: currentData.bookmarkedSpots,
        visitedSpots: currentData.visitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
    }
  }

  Future<void> _onRecordVisitWithRating(Emitter<SpotsState> emit, String spotId, int? rating, String? notes) async {
    try {
      final user = _supabaseService.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      // Mark the spot as visited with rating and notes using the Supabase function
      final isNewVisit = await _supabaseService.recordVisitWithRating(spotId, rating: rating, notes: notes);
      
      // Reload visited spots and all spots to reflect the updated visit count
      add(const SpotsEvent.loadVisitedSpots());
      if (isNewVisit) {
        add(const SpotsEvent.loadSpots()); // Refresh to show updated visit count
      }
    } catch (e) {
      final currentData = _getCurrentData();
      emit(SpotsState.error(
        message: e.toString(),
        spots: currentData.spots,
        userSpots: currentData.userSpots,
        bookmarkedSpots: currentData.bookmarkedSpots,
        visitedSpots: currentData.visitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
    }
  }

  Future<void> _onRefreshLocation(Emitter<SpotsState> emit) async {
    try {
      final position = await _locationService.getCurrentPosition();
      final currentData = _getCurrentData();
      
      emit(SpotsState.loaded(
        spots: currentData.spots,
        userSpots: currentData.userSpots,
        bookmarkedSpots: currentData.bookmarkedSpots,
        visitedSpots: currentData.visitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: position,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
      
      // Reload spots with new location
      add(const SpotsEvent.loadSpots());
    } catch (e) {
      final currentData = _getCurrentData();
      emit(SpotsState.error(
        message: e.toString(),
        spots: currentData.spots,
        userSpots: currentData.userSpots,
        bookmarkedSpots: currentData.bookmarkedSpots,
        visitedSpots: currentData.visitedSpots,
        selectedCategory: currentData.selectedCategory,
        currentPosition: currentData.currentPosition,
        locationRadius: currentData.locationRadius,
        useLocation: currentData.useLocation,
        distanceUnit: currentData.distanceUnit,
      ));
    }
  }

  ({
    List<Spot> spots,
    List<Spot> userSpots,
    List<Spot> bookmarkedSpots,
    List<Spot> visitedSpots,
    SpotCategory? selectedCategory,
    Position? currentPosition,
    double locationRadius,
    bool useLocation,
    String distanceUnit,
  }) _getCurrentData() {
    return state.when(
      initial: () => (
        spots: <Spot>[],
        userSpots: <Spot>[],
        bookmarkedSpots: <Spot>[],
        visitedSpots: <Spot>[],
        selectedCategory: null,
        currentPosition: null,
        locationRadius: 5.0,
        useLocation: true,
        distanceUnit: 'miles',
      ),
      loading: () => (
        spots: <Spot>[],
        userSpots: <Spot>[],
        bookmarkedSpots: <Spot>[],
        visitedSpots: <Spot>[],
        selectedCategory: null,
        currentPosition: null,
        locationRadius: 5.0,
        useLocation: true,
        distanceUnit: 'miles',
      ),
      loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) => (
        spots: spots,
        userSpots: userSpots,
        bookmarkedSpots: bookmarkedSpots,
        visitedSpots: visitedSpots,
        selectedCategory: selectedCategory,
        currentPosition: currentPosition,
        locationRadius: locationRadius,
        useLocation: useLocation,
        distanceUnit: distanceUnit,
      ),
      error: (message, spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) => (
        spots: spots ?? <Spot>[],
        userSpots: userSpots ?? <Spot>[],
        bookmarkedSpots: bookmarkedSpots ?? <Spot>[],
        visitedSpots: visitedSpots ?? <Spot>[],
        selectedCategory: selectedCategory,
        currentPosition: currentPosition,
        locationRadius: locationRadius,
        useLocation: useLocation,
        distanceUnit: distanceUnit,
      ),
    );
  }

  // Helper method to get filtered spots (equivalent to the provider's filteredSpots getter)
  List<Spot> getFilteredSpots() {
    final currentData = _getCurrentData();
    List<Spot> filtered = currentData.spots;
    
    // Filter by category if selected
    if (currentData.selectedCategory != null) {
      filtered = filtered.where((spot) => spot.category == currentData.selectedCategory).toList();
    }
    
    // Filter by location radius if location is enabled
    if (currentData.useLocation && currentData.currentPosition != null) {
      filtered = filtered.where((spot) {
        if (currentData.distanceUnit == 'miles') {
          final distanceInMiles = _locationService.calculateDistanceInMiles(
            currentData.currentPosition!.latitude,
            currentData.currentPosition!.longitude,
            spot.latitude,
            spot.longitude,
          );
          return distanceInMiles <= currentData.locationRadius;
        } else {
          final distanceInKm = _locationService.calculateDistance(
            currentData.currentPosition!.latitude,
            currentData.currentPosition!.longitude,
            spot.latitude,
            spot.longitude,
          ) / 1000; // Convert meters to km
          return distanceInKm <= currentData.locationRadius;
        }
      }).toList();
    }
    
    return filtered;
  }
}
