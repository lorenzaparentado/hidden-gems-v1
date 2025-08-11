// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spots_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SpotsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SpotsEvent()';
}


}

/// @nodoc
class $SpotsEventCopyWith<$Res>  {
$SpotsEventCopyWith(SpotsEvent _, $Res Function(SpotsEvent) __);
}


/// Adds pattern-matching-related methods to [SpotsEvent].
extension SpotsEventPatterns on SpotsEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _LoadSpots value)?  loadSpots,TResult Function( _LoadUserSpots value)?  loadUserSpots,TResult Function( _LoadBookmarkedSpots value)?  loadBookmarkedSpots,TResult Function( _LoadVisitedSpots value)?  loadVisitedSpots,TResult Function( _SetCategoryFilter value)?  setCategoryFilter,TResult Function( _SetLocationRadius value)?  setLocationRadius,TResult Function( _ToggleUseLocation value)?  toggleUseLocation,TResult Function( _UpdateDistanceUnit value)?  updateDistanceUnit,TResult Function( _AddSpot value)?  addSpot,TResult Function( _UpdateSpot value)?  updateSpot,TResult Function( _DeleteSpot value)?  deleteSpot,TResult Function( _ToggleBookmark value)?  toggleBookmark,TResult Function( _ToggleVisited value)?  toggleVisited,TResult Function( _RecordVisitWithRating value)?  recordVisitWithRating,TResult Function( _RefreshLocation value)?  refreshLocation,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoadSpots() when loadSpots != null:
return loadSpots(_that);case _LoadUserSpots() when loadUserSpots != null:
return loadUserSpots(_that);case _LoadBookmarkedSpots() when loadBookmarkedSpots != null:
return loadBookmarkedSpots(_that);case _LoadVisitedSpots() when loadVisitedSpots != null:
return loadVisitedSpots(_that);case _SetCategoryFilter() when setCategoryFilter != null:
return setCategoryFilter(_that);case _SetLocationRadius() when setLocationRadius != null:
return setLocationRadius(_that);case _ToggleUseLocation() when toggleUseLocation != null:
return toggleUseLocation(_that);case _UpdateDistanceUnit() when updateDistanceUnit != null:
return updateDistanceUnit(_that);case _AddSpot() when addSpot != null:
return addSpot(_that);case _UpdateSpot() when updateSpot != null:
return updateSpot(_that);case _DeleteSpot() when deleteSpot != null:
return deleteSpot(_that);case _ToggleBookmark() when toggleBookmark != null:
return toggleBookmark(_that);case _ToggleVisited() when toggleVisited != null:
return toggleVisited(_that);case _RecordVisitWithRating() when recordVisitWithRating != null:
return recordVisitWithRating(_that);case _RefreshLocation() when refreshLocation != null:
return refreshLocation(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _LoadSpots value)  loadSpots,required TResult Function( _LoadUserSpots value)  loadUserSpots,required TResult Function( _LoadBookmarkedSpots value)  loadBookmarkedSpots,required TResult Function( _LoadVisitedSpots value)  loadVisitedSpots,required TResult Function( _SetCategoryFilter value)  setCategoryFilter,required TResult Function( _SetLocationRadius value)  setLocationRadius,required TResult Function( _ToggleUseLocation value)  toggleUseLocation,required TResult Function( _UpdateDistanceUnit value)  updateDistanceUnit,required TResult Function( _AddSpot value)  addSpot,required TResult Function( _UpdateSpot value)  updateSpot,required TResult Function( _DeleteSpot value)  deleteSpot,required TResult Function( _ToggleBookmark value)  toggleBookmark,required TResult Function( _ToggleVisited value)  toggleVisited,required TResult Function( _RecordVisitWithRating value)  recordVisitWithRating,required TResult Function( _RefreshLocation value)  refreshLocation,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _LoadSpots():
return loadSpots(_that);case _LoadUserSpots():
return loadUserSpots(_that);case _LoadBookmarkedSpots():
return loadBookmarkedSpots(_that);case _LoadVisitedSpots():
return loadVisitedSpots(_that);case _SetCategoryFilter():
return setCategoryFilter(_that);case _SetLocationRadius():
return setLocationRadius(_that);case _ToggleUseLocation():
return toggleUseLocation(_that);case _UpdateDistanceUnit():
return updateDistanceUnit(_that);case _AddSpot():
return addSpot(_that);case _UpdateSpot():
return updateSpot(_that);case _DeleteSpot():
return deleteSpot(_that);case _ToggleBookmark():
return toggleBookmark(_that);case _ToggleVisited():
return toggleVisited(_that);case _RecordVisitWithRating():
return recordVisitWithRating(_that);case _RefreshLocation():
return refreshLocation(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _LoadSpots value)?  loadSpots,TResult? Function( _LoadUserSpots value)?  loadUserSpots,TResult? Function( _LoadBookmarkedSpots value)?  loadBookmarkedSpots,TResult? Function( _LoadVisitedSpots value)?  loadVisitedSpots,TResult? Function( _SetCategoryFilter value)?  setCategoryFilter,TResult? Function( _SetLocationRadius value)?  setLocationRadius,TResult? Function( _ToggleUseLocation value)?  toggleUseLocation,TResult? Function( _UpdateDistanceUnit value)?  updateDistanceUnit,TResult? Function( _AddSpot value)?  addSpot,TResult? Function( _UpdateSpot value)?  updateSpot,TResult? Function( _DeleteSpot value)?  deleteSpot,TResult? Function( _ToggleBookmark value)?  toggleBookmark,TResult? Function( _ToggleVisited value)?  toggleVisited,TResult? Function( _RecordVisitWithRating value)?  recordVisitWithRating,TResult? Function( _RefreshLocation value)?  refreshLocation,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoadSpots() when loadSpots != null:
return loadSpots(_that);case _LoadUserSpots() when loadUserSpots != null:
return loadUserSpots(_that);case _LoadBookmarkedSpots() when loadBookmarkedSpots != null:
return loadBookmarkedSpots(_that);case _LoadVisitedSpots() when loadVisitedSpots != null:
return loadVisitedSpots(_that);case _SetCategoryFilter() when setCategoryFilter != null:
return setCategoryFilter(_that);case _SetLocationRadius() when setLocationRadius != null:
return setLocationRadius(_that);case _ToggleUseLocation() when toggleUseLocation != null:
return toggleUseLocation(_that);case _UpdateDistanceUnit() when updateDistanceUnit != null:
return updateDistanceUnit(_that);case _AddSpot() when addSpot != null:
return addSpot(_that);case _UpdateSpot() when updateSpot != null:
return updateSpot(_that);case _DeleteSpot() when deleteSpot != null:
return deleteSpot(_that);case _ToggleBookmark() when toggleBookmark != null:
return toggleBookmark(_that);case _ToggleVisited() when toggleVisited != null:
return toggleVisited(_that);case _RecordVisitWithRating() when recordVisitWithRating != null:
return recordVisitWithRating(_that);case _RefreshLocation() when refreshLocation != null:
return refreshLocation(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  loadSpots,TResult Function()?  loadUserSpots,TResult Function()?  loadBookmarkedSpots,TResult Function()?  loadVisitedSpots,TResult Function( SpotCategory? category)?  setCategoryFilter,TResult Function( double radius)?  setLocationRadius,TResult Function()?  toggleUseLocation,TResult Function( String unit)?  updateDistanceUnit,TResult Function( Spot spot)?  addSpot,TResult Function( Spot spot)?  updateSpot,TResult Function( String spotId)?  deleteSpot,TResult Function( String spotId)?  toggleBookmark,TResult Function( String spotId)?  toggleVisited,TResult Function( String spotId,  int? rating,  String? notes)?  recordVisitWithRating,TResult Function()?  refreshLocation,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LoadSpots() when loadSpots != null:
return loadSpots();case _LoadUserSpots() when loadUserSpots != null:
return loadUserSpots();case _LoadBookmarkedSpots() when loadBookmarkedSpots != null:
return loadBookmarkedSpots();case _LoadVisitedSpots() when loadVisitedSpots != null:
return loadVisitedSpots();case _SetCategoryFilter() when setCategoryFilter != null:
return setCategoryFilter(_that.category);case _SetLocationRadius() when setLocationRadius != null:
return setLocationRadius(_that.radius);case _ToggleUseLocation() when toggleUseLocation != null:
return toggleUseLocation();case _UpdateDistanceUnit() when updateDistanceUnit != null:
return updateDistanceUnit(_that.unit);case _AddSpot() when addSpot != null:
return addSpot(_that.spot);case _UpdateSpot() when updateSpot != null:
return updateSpot(_that.spot);case _DeleteSpot() when deleteSpot != null:
return deleteSpot(_that.spotId);case _ToggleBookmark() when toggleBookmark != null:
return toggleBookmark(_that.spotId);case _ToggleVisited() when toggleVisited != null:
return toggleVisited(_that.spotId);case _RecordVisitWithRating() when recordVisitWithRating != null:
return recordVisitWithRating(_that.spotId,_that.rating,_that.notes);case _RefreshLocation() when refreshLocation != null:
return refreshLocation();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  loadSpots,required TResult Function()  loadUserSpots,required TResult Function()  loadBookmarkedSpots,required TResult Function()  loadVisitedSpots,required TResult Function( SpotCategory? category)  setCategoryFilter,required TResult Function( double radius)  setLocationRadius,required TResult Function()  toggleUseLocation,required TResult Function( String unit)  updateDistanceUnit,required TResult Function( Spot spot)  addSpot,required TResult Function( Spot spot)  updateSpot,required TResult Function( String spotId)  deleteSpot,required TResult Function( String spotId)  toggleBookmark,required TResult Function( String spotId)  toggleVisited,required TResult Function( String spotId,  int? rating,  String? notes)  recordVisitWithRating,required TResult Function()  refreshLocation,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _LoadSpots():
return loadSpots();case _LoadUserSpots():
return loadUserSpots();case _LoadBookmarkedSpots():
return loadBookmarkedSpots();case _LoadVisitedSpots():
return loadVisitedSpots();case _SetCategoryFilter():
return setCategoryFilter(_that.category);case _SetLocationRadius():
return setLocationRadius(_that.radius);case _ToggleUseLocation():
return toggleUseLocation();case _UpdateDistanceUnit():
return updateDistanceUnit(_that.unit);case _AddSpot():
return addSpot(_that.spot);case _UpdateSpot():
return updateSpot(_that.spot);case _DeleteSpot():
return deleteSpot(_that.spotId);case _ToggleBookmark():
return toggleBookmark(_that.spotId);case _ToggleVisited():
return toggleVisited(_that.spotId);case _RecordVisitWithRating():
return recordVisitWithRating(_that.spotId,_that.rating,_that.notes);case _RefreshLocation():
return refreshLocation();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  loadSpots,TResult? Function()?  loadUserSpots,TResult? Function()?  loadBookmarkedSpots,TResult? Function()?  loadVisitedSpots,TResult? Function( SpotCategory? category)?  setCategoryFilter,TResult? Function( double radius)?  setLocationRadius,TResult? Function()?  toggleUseLocation,TResult? Function( String unit)?  updateDistanceUnit,TResult? Function( Spot spot)?  addSpot,TResult? Function( Spot spot)?  updateSpot,TResult? Function( String spotId)?  deleteSpot,TResult? Function( String spotId)?  toggleBookmark,TResult? Function( String spotId)?  toggleVisited,TResult? Function( String spotId,  int? rating,  String? notes)?  recordVisitWithRating,TResult? Function()?  refreshLocation,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LoadSpots() when loadSpots != null:
return loadSpots();case _LoadUserSpots() when loadUserSpots != null:
return loadUserSpots();case _LoadBookmarkedSpots() when loadBookmarkedSpots != null:
return loadBookmarkedSpots();case _LoadVisitedSpots() when loadVisitedSpots != null:
return loadVisitedSpots();case _SetCategoryFilter() when setCategoryFilter != null:
return setCategoryFilter(_that.category);case _SetLocationRadius() when setLocationRadius != null:
return setLocationRadius(_that.radius);case _ToggleUseLocation() when toggleUseLocation != null:
return toggleUseLocation();case _UpdateDistanceUnit() when updateDistanceUnit != null:
return updateDistanceUnit(_that.unit);case _AddSpot() when addSpot != null:
return addSpot(_that.spot);case _UpdateSpot() when updateSpot != null:
return updateSpot(_that.spot);case _DeleteSpot() when deleteSpot != null:
return deleteSpot(_that.spotId);case _ToggleBookmark() when toggleBookmark != null:
return toggleBookmark(_that.spotId);case _ToggleVisited() when toggleVisited != null:
return toggleVisited(_that.spotId);case _RecordVisitWithRating() when recordVisitWithRating != null:
return recordVisitWithRating(_that.spotId,_that.rating,_that.notes);case _RefreshLocation() when refreshLocation != null:
return refreshLocation();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements SpotsEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SpotsEvent.started()';
}


}




/// @nodoc


class _LoadSpots implements SpotsEvent {
  const _LoadSpots();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadSpots);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SpotsEvent.loadSpots()';
}


}




/// @nodoc


class _LoadUserSpots implements SpotsEvent {
  const _LoadUserSpots();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadUserSpots);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SpotsEvent.loadUserSpots()';
}


}




/// @nodoc


class _LoadBookmarkedSpots implements SpotsEvent {
  const _LoadBookmarkedSpots();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadBookmarkedSpots);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SpotsEvent.loadBookmarkedSpots()';
}


}




/// @nodoc


class _LoadVisitedSpots implements SpotsEvent {
  const _LoadVisitedSpots();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadVisitedSpots);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SpotsEvent.loadVisitedSpots()';
}


}




/// @nodoc


class _SetCategoryFilter implements SpotsEvent {
  const _SetCategoryFilter({this.category});
  

 final  SpotCategory? category;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetCategoryFilterCopyWith<_SetCategoryFilter> get copyWith => __$SetCategoryFilterCopyWithImpl<_SetCategoryFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetCategoryFilter&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,category);

@override
String toString() {
  return 'SpotsEvent.setCategoryFilter(category: $category)';
}


}

/// @nodoc
abstract mixin class _$SetCategoryFilterCopyWith<$Res> implements $SpotsEventCopyWith<$Res> {
  factory _$SetCategoryFilterCopyWith(_SetCategoryFilter value, $Res Function(_SetCategoryFilter) _then) = __$SetCategoryFilterCopyWithImpl;
@useResult
$Res call({
 SpotCategory? category
});




}
/// @nodoc
class __$SetCategoryFilterCopyWithImpl<$Res>
    implements _$SetCategoryFilterCopyWith<$Res> {
  __$SetCategoryFilterCopyWithImpl(this._self, this._then);

  final _SetCategoryFilter _self;
  final $Res Function(_SetCategoryFilter) _then;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? category = freezed,}) {
  return _then(_SetCategoryFilter(
category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as SpotCategory?,
  ));
}


}

/// @nodoc


class _SetLocationRadius implements SpotsEvent {
  const _SetLocationRadius({required this.radius});
  

 final  double radius;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetLocationRadiusCopyWith<_SetLocationRadius> get copyWith => __$SetLocationRadiusCopyWithImpl<_SetLocationRadius>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetLocationRadius&&(identical(other.radius, radius) || other.radius == radius));
}


@override
int get hashCode => Object.hash(runtimeType,radius);

@override
String toString() {
  return 'SpotsEvent.setLocationRadius(radius: $radius)';
}


}

/// @nodoc
abstract mixin class _$SetLocationRadiusCopyWith<$Res> implements $SpotsEventCopyWith<$Res> {
  factory _$SetLocationRadiusCopyWith(_SetLocationRadius value, $Res Function(_SetLocationRadius) _then) = __$SetLocationRadiusCopyWithImpl;
@useResult
$Res call({
 double radius
});




}
/// @nodoc
class __$SetLocationRadiusCopyWithImpl<$Res>
    implements _$SetLocationRadiusCopyWith<$Res> {
  __$SetLocationRadiusCopyWithImpl(this._self, this._then);

  final _SetLocationRadius _self;
  final $Res Function(_SetLocationRadius) _then;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? radius = null,}) {
  return _then(_SetLocationRadius(
radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class _ToggleUseLocation implements SpotsEvent {
  const _ToggleUseLocation();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleUseLocation);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SpotsEvent.toggleUseLocation()';
}


}




/// @nodoc


class _UpdateDistanceUnit implements SpotsEvent {
  const _UpdateDistanceUnit({required this.unit});
  

 final  String unit;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateDistanceUnitCopyWith<_UpdateDistanceUnit> get copyWith => __$UpdateDistanceUnitCopyWithImpl<_UpdateDistanceUnit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateDistanceUnit&&(identical(other.unit, unit) || other.unit == unit));
}


@override
int get hashCode => Object.hash(runtimeType,unit);

@override
String toString() {
  return 'SpotsEvent.updateDistanceUnit(unit: $unit)';
}


}

/// @nodoc
abstract mixin class _$UpdateDistanceUnitCopyWith<$Res> implements $SpotsEventCopyWith<$Res> {
  factory _$UpdateDistanceUnitCopyWith(_UpdateDistanceUnit value, $Res Function(_UpdateDistanceUnit) _then) = __$UpdateDistanceUnitCopyWithImpl;
@useResult
$Res call({
 String unit
});




}
/// @nodoc
class __$UpdateDistanceUnitCopyWithImpl<$Res>
    implements _$UpdateDistanceUnitCopyWith<$Res> {
  __$UpdateDistanceUnitCopyWithImpl(this._self, this._then);

  final _UpdateDistanceUnit _self;
  final $Res Function(_UpdateDistanceUnit) _then;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? unit = null,}) {
  return _then(_UpdateDistanceUnit(
unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AddSpot implements SpotsEvent {
  const _AddSpot({required this.spot});
  

 final  Spot spot;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddSpotCopyWith<_AddSpot> get copyWith => __$AddSpotCopyWithImpl<_AddSpot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddSpot&&(identical(other.spot, spot) || other.spot == spot));
}


@override
int get hashCode => Object.hash(runtimeType,spot);

@override
String toString() {
  return 'SpotsEvent.addSpot(spot: $spot)';
}


}

/// @nodoc
abstract mixin class _$AddSpotCopyWith<$Res> implements $SpotsEventCopyWith<$Res> {
  factory _$AddSpotCopyWith(_AddSpot value, $Res Function(_AddSpot) _then) = __$AddSpotCopyWithImpl;
@useResult
$Res call({
 Spot spot
});




}
/// @nodoc
class __$AddSpotCopyWithImpl<$Res>
    implements _$AddSpotCopyWith<$Res> {
  __$AddSpotCopyWithImpl(this._self, this._then);

  final _AddSpot _self;
  final $Res Function(_AddSpot) _then;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? spot = null,}) {
  return _then(_AddSpot(
spot: null == spot ? _self.spot : spot // ignore: cast_nullable_to_non_nullable
as Spot,
  ));
}


}

/// @nodoc


class _UpdateSpot implements SpotsEvent {
  const _UpdateSpot({required this.spot});
  

 final  Spot spot;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateSpotCopyWith<_UpdateSpot> get copyWith => __$UpdateSpotCopyWithImpl<_UpdateSpot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateSpot&&(identical(other.spot, spot) || other.spot == spot));
}


@override
int get hashCode => Object.hash(runtimeType,spot);

@override
String toString() {
  return 'SpotsEvent.updateSpot(spot: $spot)';
}


}

/// @nodoc
abstract mixin class _$UpdateSpotCopyWith<$Res> implements $SpotsEventCopyWith<$Res> {
  factory _$UpdateSpotCopyWith(_UpdateSpot value, $Res Function(_UpdateSpot) _then) = __$UpdateSpotCopyWithImpl;
@useResult
$Res call({
 Spot spot
});




}
/// @nodoc
class __$UpdateSpotCopyWithImpl<$Res>
    implements _$UpdateSpotCopyWith<$Res> {
  __$UpdateSpotCopyWithImpl(this._self, this._then);

  final _UpdateSpot _self;
  final $Res Function(_UpdateSpot) _then;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? spot = null,}) {
  return _then(_UpdateSpot(
spot: null == spot ? _self.spot : spot // ignore: cast_nullable_to_non_nullable
as Spot,
  ));
}


}

/// @nodoc


class _DeleteSpot implements SpotsEvent {
  const _DeleteSpot({required this.spotId});
  

 final  String spotId;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteSpotCopyWith<_DeleteSpot> get copyWith => __$DeleteSpotCopyWithImpl<_DeleteSpot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteSpot&&(identical(other.spotId, spotId) || other.spotId == spotId));
}


@override
int get hashCode => Object.hash(runtimeType,spotId);

@override
String toString() {
  return 'SpotsEvent.deleteSpot(spotId: $spotId)';
}


}

/// @nodoc
abstract mixin class _$DeleteSpotCopyWith<$Res> implements $SpotsEventCopyWith<$Res> {
  factory _$DeleteSpotCopyWith(_DeleteSpot value, $Res Function(_DeleteSpot) _then) = __$DeleteSpotCopyWithImpl;
@useResult
$Res call({
 String spotId
});




}
/// @nodoc
class __$DeleteSpotCopyWithImpl<$Res>
    implements _$DeleteSpotCopyWith<$Res> {
  __$DeleteSpotCopyWithImpl(this._self, this._then);

  final _DeleteSpot _self;
  final $Res Function(_DeleteSpot) _then;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? spotId = null,}) {
  return _then(_DeleteSpot(
spotId: null == spotId ? _self.spotId : spotId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ToggleBookmark implements SpotsEvent {
  const _ToggleBookmark({required this.spotId});
  

 final  String spotId;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleBookmarkCopyWith<_ToggleBookmark> get copyWith => __$ToggleBookmarkCopyWithImpl<_ToggleBookmark>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleBookmark&&(identical(other.spotId, spotId) || other.spotId == spotId));
}


@override
int get hashCode => Object.hash(runtimeType,spotId);

@override
String toString() {
  return 'SpotsEvent.toggleBookmark(spotId: $spotId)';
}


}

/// @nodoc
abstract mixin class _$ToggleBookmarkCopyWith<$Res> implements $SpotsEventCopyWith<$Res> {
  factory _$ToggleBookmarkCopyWith(_ToggleBookmark value, $Res Function(_ToggleBookmark) _then) = __$ToggleBookmarkCopyWithImpl;
@useResult
$Res call({
 String spotId
});




}
/// @nodoc
class __$ToggleBookmarkCopyWithImpl<$Res>
    implements _$ToggleBookmarkCopyWith<$Res> {
  __$ToggleBookmarkCopyWithImpl(this._self, this._then);

  final _ToggleBookmark _self;
  final $Res Function(_ToggleBookmark) _then;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? spotId = null,}) {
  return _then(_ToggleBookmark(
spotId: null == spotId ? _self.spotId : spotId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ToggleVisited implements SpotsEvent {
  const _ToggleVisited({required this.spotId});
  

 final  String spotId;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleVisitedCopyWith<_ToggleVisited> get copyWith => __$ToggleVisitedCopyWithImpl<_ToggleVisited>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleVisited&&(identical(other.spotId, spotId) || other.spotId == spotId));
}


@override
int get hashCode => Object.hash(runtimeType,spotId);

@override
String toString() {
  return 'SpotsEvent.toggleVisited(spotId: $spotId)';
}


}

/// @nodoc
abstract mixin class _$ToggleVisitedCopyWith<$Res> implements $SpotsEventCopyWith<$Res> {
  factory _$ToggleVisitedCopyWith(_ToggleVisited value, $Res Function(_ToggleVisited) _then) = __$ToggleVisitedCopyWithImpl;
@useResult
$Res call({
 String spotId
});




}
/// @nodoc
class __$ToggleVisitedCopyWithImpl<$Res>
    implements _$ToggleVisitedCopyWith<$Res> {
  __$ToggleVisitedCopyWithImpl(this._self, this._then);

  final _ToggleVisited _self;
  final $Res Function(_ToggleVisited) _then;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? spotId = null,}) {
  return _then(_ToggleVisited(
spotId: null == spotId ? _self.spotId : spotId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RecordVisitWithRating implements SpotsEvent {
  const _RecordVisitWithRating({required this.spotId, this.rating, this.notes});
  

 final  String spotId;
 final  int? rating;
 final  String? notes;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecordVisitWithRatingCopyWith<_RecordVisitWithRating> get copyWith => __$RecordVisitWithRatingCopyWithImpl<_RecordVisitWithRating>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecordVisitWithRating&&(identical(other.spotId, spotId) || other.spotId == spotId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,spotId,rating,notes);

@override
String toString() {
  return 'SpotsEvent.recordVisitWithRating(spotId: $spotId, rating: $rating, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$RecordVisitWithRatingCopyWith<$Res> implements $SpotsEventCopyWith<$Res> {
  factory _$RecordVisitWithRatingCopyWith(_RecordVisitWithRating value, $Res Function(_RecordVisitWithRating) _then) = __$RecordVisitWithRatingCopyWithImpl;
@useResult
$Res call({
 String spotId, int? rating, String? notes
});




}
/// @nodoc
class __$RecordVisitWithRatingCopyWithImpl<$Res>
    implements _$RecordVisitWithRatingCopyWith<$Res> {
  __$RecordVisitWithRatingCopyWithImpl(this._self, this._then);

  final _RecordVisitWithRating _self;
  final $Res Function(_RecordVisitWithRating) _then;

/// Create a copy of SpotsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? spotId = null,Object? rating = freezed,Object? notes = freezed,}) {
  return _then(_RecordVisitWithRating(
spotId: null == spotId ? _self.spotId : spotId // ignore: cast_nullable_to_non_nullable
as String,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _RefreshLocation implements SpotsEvent {
  const _RefreshLocation();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshLocation);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SpotsEvent.refreshLocation()';
}


}




// dart format on
