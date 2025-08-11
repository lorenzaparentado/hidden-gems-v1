import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/models/spot_category.dart';
import '../../core/models/spot.dart';

part 'spots_event.freezed.dart';

@freezed
class SpotsEvent with _$SpotsEvent {
  const factory SpotsEvent.started() = _Started;
  const factory SpotsEvent.loadSpots() = _LoadSpots;
  const factory SpotsEvent.loadUserSpots() = _LoadUserSpots;
  const factory SpotsEvent.loadBookmarkedSpots() = _LoadBookmarkedSpots;
  const factory SpotsEvent.loadVisitedSpots() = _LoadVisitedSpots;
  const factory SpotsEvent.setCategoryFilter({
    SpotCategory? category,
  }) = _SetCategoryFilter;
  const factory SpotsEvent.setLocationRadius({
    required double radius,
  }) = _SetLocationRadius;
  const factory SpotsEvent.toggleUseLocation() = _ToggleUseLocation;
  const factory SpotsEvent.updateDistanceUnit({
    required String unit,
  }) = _UpdateDistanceUnit;
  const factory SpotsEvent.addSpot({
    required Spot spot,
  }) = _AddSpot;
  const factory SpotsEvent.updateSpot({
    required Spot spot,
  }) = _UpdateSpot;
  const factory SpotsEvent.deleteSpot({
    required String spotId,
  }) = _DeleteSpot;
  const factory SpotsEvent.toggleBookmark({
    required String spotId,
  }) = _ToggleBookmark;
  const factory SpotsEvent.toggleVisited({
    required String spotId,
  }) = _ToggleVisited;
  const factory SpotsEvent.recordVisitWithRating({
    required String spotId,
    int? rating,
    String? notes,
  }) = _RecordVisitWithRating;
  const factory SpotsEvent.refreshLocation() = _RefreshLocation;
}
