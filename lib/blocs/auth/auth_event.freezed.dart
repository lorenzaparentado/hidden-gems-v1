// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _SignUp value)?  signUp,TResult Function( _SignIn value)?  signIn,TResult Function( _SignOut value)?  signOut,TResult Function( _UpdateProfile value)?  updateProfile,TResult Function( _ClearError value)?  clearError,TResult Function( _AuthStateChanged value)?  authStateChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _SignUp() when signUp != null:
return signUp(_that);case _SignIn() when signIn != null:
return signIn(_that);case _SignOut() when signOut != null:
return signOut(_that);case _UpdateProfile() when updateProfile != null:
return updateProfile(_that);case _ClearError() when clearError != null:
return clearError(_that);case _AuthStateChanged() when authStateChanged != null:
return authStateChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _SignUp value)  signUp,required TResult Function( _SignIn value)  signIn,required TResult Function( _SignOut value)  signOut,required TResult Function( _UpdateProfile value)  updateProfile,required TResult Function( _ClearError value)  clearError,required TResult Function( _AuthStateChanged value)  authStateChanged,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _SignUp():
return signUp(_that);case _SignIn():
return signIn(_that);case _SignOut():
return signOut(_that);case _UpdateProfile():
return updateProfile(_that);case _ClearError():
return clearError(_that);case _AuthStateChanged():
return authStateChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _SignUp value)?  signUp,TResult? Function( _SignIn value)?  signIn,TResult? Function( _SignOut value)?  signOut,TResult? Function( _UpdateProfile value)?  updateProfile,TResult? Function( _ClearError value)?  clearError,TResult? Function( _AuthStateChanged value)?  authStateChanged,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _SignUp() when signUp != null:
return signUp(_that);case _SignIn() when signIn != null:
return signIn(_that);case _SignOut() when signOut != null:
return signOut(_that);case _UpdateProfile() when updateProfile != null:
return updateProfile(_that);case _ClearError() when clearError != null:
return clearError(_that);case _AuthStateChanged() when authStateChanged != null:
return authStateChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String email,  String password,  String displayName)?  signUp,TResult Function( String email,  String password)?  signIn,TResult Function()?  signOut,TResult Function( String displayName)?  updateProfile,TResult Function()?  clearError,TResult Function( String? userId)?  authStateChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _SignUp() when signUp != null:
return signUp(_that.email,_that.password,_that.displayName);case _SignIn() when signIn != null:
return signIn(_that.email,_that.password);case _SignOut() when signOut != null:
return signOut();case _UpdateProfile() when updateProfile != null:
return updateProfile(_that.displayName);case _ClearError() when clearError != null:
return clearError();case _AuthStateChanged() when authStateChanged != null:
return authStateChanged(_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String email,  String password,  String displayName)  signUp,required TResult Function( String email,  String password)  signIn,required TResult Function()  signOut,required TResult Function( String displayName)  updateProfile,required TResult Function()  clearError,required TResult Function( String? userId)  authStateChanged,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _SignUp():
return signUp(_that.email,_that.password,_that.displayName);case _SignIn():
return signIn(_that.email,_that.password);case _SignOut():
return signOut();case _UpdateProfile():
return updateProfile(_that.displayName);case _ClearError():
return clearError();case _AuthStateChanged():
return authStateChanged(_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String email,  String password,  String displayName)?  signUp,TResult? Function( String email,  String password)?  signIn,TResult? Function()?  signOut,TResult? Function( String displayName)?  updateProfile,TResult? Function()?  clearError,TResult? Function( String? userId)?  authStateChanged,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _SignUp() when signUp != null:
return signUp(_that.email,_that.password,_that.displayName);case _SignIn() when signIn != null:
return signIn(_that.email,_that.password);case _SignOut() when signOut != null:
return signOut();case _UpdateProfile() when updateProfile != null:
return updateProfile(_that.displayName);case _ClearError() when clearError != null:
return clearError();case _AuthStateChanged() when authStateChanged != null:
return authStateChanged(_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements AuthEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.started()';
}


}




/// @nodoc


class _SignUp implements AuthEvent {
  const _SignUp({required this.email, required this.password, required this.displayName});
  

 final  String email;
 final  String password;
 final  String displayName;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpCopyWith<_SignUp> get copyWith => __$SignUpCopyWithImpl<_SignUp>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUp&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,displayName);

@override
String toString() {
  return 'AuthEvent.signUp(email: $email, password: $password, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$SignUpCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$SignUpCopyWith(_SignUp value, $Res Function(_SignUp) _then) = __$SignUpCopyWithImpl;
@useResult
$Res call({
 String email, String password, String displayName
});




}
/// @nodoc
class __$SignUpCopyWithImpl<$Res>
    implements _$SignUpCopyWith<$Res> {
  __$SignUpCopyWithImpl(this._self, this._then);

  final _SignUp _self;
  final $Res Function(_SignUp) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? displayName = null,}) {
  return _then(_SignUp(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SignIn implements AuthEvent {
  const _SignIn({required this.email, required this.password});
  

 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInCopyWith<_SignIn> get copyWith => __$SignInCopyWithImpl<_SignIn>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignIn&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthEvent.signIn(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$SignInCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$SignInCopyWith(_SignIn value, $Res Function(_SignIn) _then) = __$SignInCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class __$SignInCopyWithImpl<$Res>
    implements _$SignInCopyWith<$Res> {
  __$SignInCopyWithImpl(this._self, this._then);

  final _SignIn _self;
  final $Res Function(_SignIn) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(_SignIn(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SignOut implements AuthEvent {
  const _SignOut();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.signOut()';
}


}




/// @nodoc


class _UpdateProfile implements AuthEvent {
  const _UpdateProfile({required this.displayName});
  

 final  String displayName;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateProfileCopyWith<_UpdateProfile> get copyWith => __$UpdateProfileCopyWithImpl<_UpdateProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateProfile&&(identical(other.displayName, displayName) || other.displayName == displayName));
}


@override
int get hashCode => Object.hash(runtimeType,displayName);

@override
String toString() {
  return 'AuthEvent.updateProfile(displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$UpdateProfileCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$UpdateProfileCopyWith(_UpdateProfile value, $Res Function(_UpdateProfile) _then) = __$UpdateProfileCopyWithImpl;
@useResult
$Res call({
 String displayName
});




}
/// @nodoc
class __$UpdateProfileCopyWithImpl<$Res>
    implements _$UpdateProfileCopyWith<$Res> {
  __$UpdateProfileCopyWithImpl(this._self, this._then);

  final _UpdateProfile _self;
  final $Res Function(_UpdateProfile) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? displayName = null,}) {
  return _then(_UpdateProfile(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ClearError implements AuthEvent {
  const _ClearError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.clearError()';
}


}




/// @nodoc


class _AuthStateChanged implements AuthEvent {
  const _AuthStateChanged({required this.userId});
  

 final  String? userId;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateChangedCopyWith<_AuthStateChanged> get copyWith => __$AuthStateChangedCopyWithImpl<_AuthStateChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthStateChanged&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'AuthEvent.authStateChanged(userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$AuthStateChangedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$AuthStateChangedCopyWith(_AuthStateChanged value, $Res Function(_AuthStateChanged) _then) = __$AuthStateChangedCopyWithImpl;
@useResult
$Res call({
 String? userId
});




}
/// @nodoc
class __$AuthStateChangedCopyWithImpl<$Res>
    implements _$AuthStateChangedCopyWith<$Res> {
  __$AuthStateChangedCopyWithImpl(this._self, this._then);

  final _AuthStateChanged _self;
  final $Res Function(_AuthStateChanged) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = freezed,}) {
  return _then(_AuthStateChanged(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
