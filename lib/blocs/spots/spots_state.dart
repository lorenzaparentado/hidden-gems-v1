import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/models/spot_category.dart';
import '../../core/models/spot.dart';

part 'spots_state.freezed.dart';

@freezed
class SpotsState with _$SpotsState {
  const factory SpotsState.initial() = _Initial;
  const factory SpotsState.loading() = _Loading;
  const factory SpotsState.loaded({
    required List<Spot> spots,
    required List<Spot> userSpots,
    required List<Spot> bookmarkedSpots,
    required List<Spot> visitedSpots,
    SpotCategory? selectedCategory,
    Position? currentPosition,
    @Default(5.0) double locationRadius,
    @Default(true) bool useLocation,
    @Default('miles') String distanceUnit,
  }) = _Loaded;
  const factory SpotsState.error({
    required String message,
    List<Spot>? spots,
    List<Spot>? userSpots,
    List<Spot>? bookmarkedSpots,
    List<Spot>? visitedSpots,
    SpotCategory? selectedCategory,
    Position? currentPosition,
    @Default(5.0) double locationRadius,
    @Default(true) bool useLocation,
    @Default('miles') String distanceUnit,
  }) = _Error;
}
