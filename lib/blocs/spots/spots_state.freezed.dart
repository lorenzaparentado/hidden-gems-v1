// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spots_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SpotsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SpotsState()';
}


}

/// @nodoc
class $SpotsStateCopyWith<$Res>  {
$SpotsStateCopyWith(SpotsState _, $Res Function(SpotsState) __);
}


/// Adds pattern-matching-related methods to [SpotsState].
extension SpotsStatePatterns on SpotsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Spot> spots,  List<Spot> userSpots,  List<Spot> bookmarkedSpots,  List<Spot> visitedSpots,  SpotCategory? selectedCategory,  Position? currentPosition,  double locationRadius,  bool useLocation,  String distanceUnit)?  loaded,TResult Function( String message,  List<Spot>? spots,  List<Spot>? userSpots,  List<Spot>? bookmarkedSpots,  List<Spot>? visitedSpots,  SpotCategory? selectedCategory,  Position? currentPosition,  double locationRadius,  bool useLocation,  String distanceUnit)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.spots,_that.userSpots,_that.bookmarkedSpots,_that.visitedSpots,_that.selectedCategory,_that.currentPosition,_that.locationRadius,_that.useLocation,_that.distanceUnit);case _Error() when error != null:
return error(_that.message,_that.spots,_that.userSpots,_that.bookmarkedSpots,_that.visitedSpots,_that.selectedCategory,_that.currentPosition,_that.locationRadius,_that.useLocation,_that.distanceUnit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Spot> spots,  List<Spot> userSpots,  List<Spot> bookmarkedSpots,  List<Spot> visitedSpots,  SpotCategory? selectedCategory,  Position? currentPosition,  double locationRadius,  bool useLocation,  String distanceUnit)  loaded,required TResult Function( String message,  List<Spot>? spots,  List<Spot>? userSpots,  List<Spot>? bookmarkedSpots,  List<Spot>? visitedSpots,  SpotCategory? selectedCategory,  Position? currentPosition,  double locationRadius,  bool useLocation,  String distanceUnit)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.spots,_that.userSpots,_that.bookmarkedSpots,_that.visitedSpots,_that.selectedCategory,_that.currentPosition,_that.locationRadius,_that.useLocation,_that.distanceUnit);case _Error():
return error(_that.message,_that.spots,_that.userSpots,_that.bookmarkedSpots,_that.visitedSpots,_that.selectedCategory,_that.currentPosition,_that.locationRadius,_that.useLocation,_that.distanceUnit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Spot> spots,  List<Spot> userSpots,  List<Spot> bookmarkedSpots,  List<Spot> visitedSpots,  SpotCategory? selectedCategory,  Position? currentPosition,  double locationRadius,  bool useLocation,  String distanceUnit)?  loaded,TResult? Function( String message,  List<Spot>? spots,  List<Spot>? userSpots,  List<Spot>? bookmarkedSpots,  List<Spot>? visitedSpots,  SpotCategory? selectedCategory,  Position? currentPosition,  double locationRadius,  bool useLocation,  String distanceUnit)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.spots,_that.userSpots,_that.bookmarkedSpots,_that.visitedSpots,_that.selectedCategory,_that.currentPosition,_that.locationRadius,_that.useLocation,_that.distanceUnit);case _Error() when error != null:
return error(_that.message,_that.spots,_that.userSpots,_that.bookmarkedSpots,_that.visitedSpots,_that.selectedCategory,_that.currentPosition,_that.locationRadius,_that.useLocation,_that.distanceUnit);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements SpotsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SpotsState.initial()';
}


}




/// @nodoc


class _Loading implements SpotsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SpotsState.loading()';
}


}




/// @nodoc


class _Loaded implements SpotsState {
  const _Loaded({required final  List<Spot> spots, required final  List<Spot> userSpots, required final  List<Spot> bookmarkedSpots, required final  List<Spot> visitedSpots, this.selectedCategory, this.currentPosition, this.locationRadius = 5.0, this.useLocation = true, this.distanceUnit = 'miles'}): _spots = spots,_userSpots = userSpots,_bookmarkedSpots = bookmarkedSpots,_visitedSpots = visitedSpots;
  

 final  List<Spot> _spots;
 List<Spot> get spots {
  if (_spots is EqualUnmodifiableListView) return _spots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_spots);
}

 final  List<Spot> _userSpots;
 List<Spot> get userSpots {
  if (_userSpots is EqualUnmodifiableListView) return _userSpots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userSpots);
}

 final  List<Spot> _bookmarkedSpots;
 List<Spot> get bookmarkedSpots {
  if (_bookmarkedSpots is EqualUnmodifiableListView) return _bookmarkedSpots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookmarkedSpots);
}

 final  List<Spot> _visitedSpots;
 List<Spot> get visitedSpots {
  if (_visitedSpots is EqualUnmodifiableListView) return _visitedSpots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visitedSpots);
}

 final  SpotCategory? selectedCategory;
 final  Position? currentPosition;
@JsonKey() final  double locationRadius;
@JsonKey() final  bool useLocation;
@JsonKey() final  String distanceUnit;

/// Create a copy of SpotsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._spots, _spots)&&const DeepCollectionEquality().equals(other._userSpots, _userSpots)&&const DeepCollectionEquality().equals(other._bookmarkedSpots, _bookmarkedSpots)&&const DeepCollectionEquality().equals(other._visitedSpots, _visitedSpots)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.currentPosition, currentPosition) || other.currentPosition == currentPosition)&&(identical(other.locationRadius, locationRadius) || other.locationRadius == locationRadius)&&(identical(other.useLocation, useLocation) || other.useLocation == useLocation)&&(identical(other.distanceUnit, distanceUnit) || other.distanceUnit == distanceUnit));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_spots),const DeepCollectionEquality().hash(_userSpots),const DeepCollectionEquality().hash(_bookmarkedSpots),const DeepCollectionEquality().hash(_visitedSpots),selectedCategory,currentPosition,locationRadius,useLocation,distanceUnit);

@override
String toString() {
  return 'SpotsState.loaded(spots: $spots, userSpots: $userSpots, bookmarkedSpots: $bookmarkedSpots, visitedSpots: $visitedSpots, selectedCategory: $selectedCategory, currentPosition: $currentPosition, locationRadius: $locationRadius, useLocation: $useLocation, distanceUnit: $distanceUnit)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $SpotsStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Spot> spots, List<Spot> userSpots, List<Spot> bookmarkedSpots, List<Spot> visitedSpots, SpotCategory? selectedCategory, Position? currentPosition, double locationRadius, bool useLocation, String distanceUnit
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of SpotsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? spots = null,Object? userSpots = null,Object? bookmarkedSpots = null,Object? visitedSpots = null,Object? selectedCategory = freezed,Object? currentPosition = freezed,Object? locationRadius = null,Object? useLocation = null,Object? distanceUnit = null,}) {
  return _then(_Loaded(
spots: null == spots ? _self._spots : spots // ignore: cast_nullable_to_non_nullable
as List<Spot>,userSpots: null == userSpots ? _self._userSpots : userSpots // ignore: cast_nullable_to_non_nullable
as List<Spot>,bookmarkedSpots: null == bookmarkedSpots ? _self._bookmarkedSpots : bookmarkedSpots // ignore: cast_nullable_to_non_nullable
as List<Spot>,visitedSpots: null == visitedSpots ? _self._visitedSpots : visitedSpots // ignore: cast_nullable_to_non_nullable
as List<Spot>,selectedCategory: freezed == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as SpotCategory?,currentPosition: freezed == currentPosition ? _self.currentPosition : currentPosition // ignore: cast_nullable_to_non_nullable
as Position?,locationRadius: null == locationRadius ? _self.locationRadius : locationRadius // ignore: cast_nullable_to_non_nullable
as double,useLocation: null == useLocation ? _self.useLocation : useLocation // ignore: cast_nullable_to_non_nullable
as bool,distanceUnit: null == distanceUnit ? _self.distanceUnit : distanceUnit // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Error implements SpotsState {
  const _Error({required this.message, final  List<Spot>? spots, final  List<Spot>? userSpots, final  List<Spot>? bookmarkedSpots, final  List<Spot>? visitedSpots, this.selectedCategory, this.currentPosition, this.locationRadius = 5.0, this.useLocation = true, this.distanceUnit = 'miles'}): _spots = spots,_userSpots = userSpots,_bookmarkedSpots = bookmarkedSpots,_visitedSpots = visitedSpots;
  

 final  String message;
 final  List<Spot>? _spots;
 List<Spot>? get spots {
  final value = _spots;
  if (value == null) return null;
  if (_spots is EqualUnmodifiableListView) return _spots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Spot>? _userSpots;
 List<Spot>? get userSpots {
  final value = _userSpots;
  if (value == null) return null;
  if (_userSpots is EqualUnmodifiableListView) return _userSpots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Spot>? _bookmarkedSpots;
 List<Spot>? get bookmarkedSpots {
  final value = _bookmarkedSpots;
  if (value == null) return null;
  if (_bookmarkedSpots is EqualUnmodifiableListView) return _bookmarkedSpots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Spot>? _visitedSpots;
 List<Spot>? get visitedSpots {
  final value = _visitedSpots;
  if (value == null) return null;
  if (_visitedSpots is EqualUnmodifiableListView) return _visitedSpots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  SpotCategory? selectedCategory;
 final  Position? currentPosition;
@JsonKey() final  double locationRadius;
@JsonKey() final  bool useLocation;
@JsonKey() final  String distanceUnit;

/// Create a copy of SpotsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._spots, _spots)&&const DeepCollectionEquality().equals(other._userSpots, _userSpots)&&const DeepCollectionEquality().equals(other._bookmarkedSpots, _bookmarkedSpots)&&const DeepCollectionEquality().equals(other._visitedSpots, _visitedSpots)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.currentPosition, currentPosition) || other.currentPosition == currentPosition)&&(identical(other.locationRadius, locationRadius) || other.locationRadius == locationRadius)&&(identical(other.useLocation, useLocation) || other.useLocation == useLocation)&&(identical(other.distanceUnit, distanceUnit) || other.distanceUnit == distanceUnit));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_spots),const DeepCollectionEquality().hash(_userSpots),const DeepCollectionEquality().hash(_bookmarkedSpots),const DeepCollectionEquality().hash(_visitedSpots),selectedCategory,currentPosition,locationRadius,useLocation,distanceUnit);

@override
String toString() {
  return 'SpotsState.error(message: $message, spots: $spots, userSpots: $userSpots, bookmarkedSpots: $bookmarkedSpots, visitedSpots: $visitedSpots, selectedCategory: $selectedCategory, currentPosition: $currentPosition, locationRadius: $locationRadius, useLocation: $useLocation, distanceUnit: $distanceUnit)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $SpotsStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message, List<Spot>? spots, List<Spot>? userSpots, List<Spot>? bookmarkedSpots, List<Spot>? visitedSpots, SpotCategory? selectedCategory, Position? currentPosition, double locationRadius, bool useLocation, String distanceUnit
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of SpotsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? spots = freezed,Object? userSpots = freezed,Object? bookmarkedSpots = freezed,Object? visitedSpots = freezed,Object? selectedCategory = freezed,Object? currentPosition = freezed,Object? locationRadius = null,Object? useLocation = null,Object? distanceUnit = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,spots: freezed == spots ? _self._spots : spots // ignore: cast_nullable_to_non_nullable
as List<Spot>?,userSpots: freezed == userSpots ? _self._userSpots : userSpots // ignore: cast_nullable_to_non_nullable
as List<Spot>?,bookmarkedSpots: freezed == bookmarkedSpots ? _self._bookmarkedSpots : bookmarkedSpots // ignore: cast_nullable_to_non_nullable
as List<Spot>?,visitedSpots: freezed == visitedSpots ? _self._visitedSpots : visitedSpots // ignore: cast_nullable_to_non_nullable
as List<Spot>?,selectedCategory: freezed == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as SpotCategory?,currentPosition: freezed == currentPosition ? _self.currentPosition : currentPosition // ignore: cast_nullable_to_non_nullable
as Position?,locationRadius: null == locationRadius ? _self.locationRadius : locationRadius // ignore: cast_nullable_to_non_nullable
as double,useLocation: null == useLocation ? _self.useLocation : useLocation // ignore: cast_nullable_to_non_nullable
as bool,distanceUnit: null == distanceUnit ? _self.distanceUnit : distanceUnit // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
