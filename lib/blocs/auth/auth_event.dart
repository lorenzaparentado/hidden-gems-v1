import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;
  const factory AuthEvent.signUp({
    required String email,
    required String password,
    required String displayName,
  }) = _SignUp;
  const factory AuthEvent.signIn({
    required String email,
    required String password,
  }) = _SignIn;
  const factory AuthEvent.signOut() = _SignOut;
  const factory AuthEvent.updateProfile({
    required String displayName,
  }) = _UpdateProfile;
  const factory AuthEvent.clearError() = _ClearError;
  const factory AuthEvent.authStateChanged({
    required String? userId,
  }) = _AuthStateChanged;
}
