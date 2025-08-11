import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import '../../core/models/user_profile.dart';
import '../../services/supabase_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SupabaseService _supabaseService = SupabaseService.instance;
  late StreamSubscription<AuthState> _authSubscription;

  AuthBloc() : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.when(
        started: () => _onStarted(emit),
        signUp: (email, password, displayName) => _onSignUp(emit, email, password, displayName),
        signIn: (email, password) => _onSignIn(emit, email, password),
        signOut: () => _onSignOut(emit),
        updateProfile: (displayName) => _onUpdateProfile(emit, displayName),
        clearError: () => _onClearError(emit),
        authStateChanged: (userId) => _onAuthStateChanged(emit, userId),
      );
    });

    // Initialize and listen to auth state changes
    add(const AuthEvent.started());
    _listenToAuthStateChanges();
  }

  void _listenToAuthStateChanges() {
    _supabaseService.authStateChanges.listen((authState) {
      final user = authState.session?.user;
      add(AuthEvent.authStateChanged(userId: user?.id));
    });
  }

  Future<void> _onStarted(Emitter<AuthState> emit) async {
    final currentUser = _supabaseService.currentUser;
    if (currentUser != null) {
      await _loadUserProfile(emit, currentUser.id);
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onSignUp(
    Emitter<AuthState> emit,
    String email,
    String password,
    String displayName,
  ) async {
    emit(const AuthState.loading());
    
    try {
      final response = await _supabaseService.signUp(email, password);
      if (response.user != null) {
        // Profile will be created when auth state changes
        // For now, emit unauthenticated as they need to verify email
        emit(const AuthState.unauthenticated());
      } else {
        emit(const AuthState.error(message: 'Failed to create account'));
      }
    } catch (e) {
      emit(AuthState.error(message: e.toString()));
    }
  }

  Future<void> _onSignIn(
    Emitter<AuthState> emit,
    String email,
    String password,
  ) async {
    emit(const AuthState.loading());
    
    try {
      final response = await _supabaseService.signIn(email, password);
      if (response.user != null) {
        await _loadUserProfile(emit, response.user!.id);
      } else {
        emit(const AuthState.error(message: 'Invalid email or password'));
      }
    } catch (e) {
      emit(AuthState.error(message: e.toString()));
    }
  }

  Future<void> _onSignOut(Emitter<AuthState> emit) async {
    try {
      await _supabaseService.signOut();
      emit(const AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.error(message: e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
    Emitter<AuthState> emit,
    String displayName,
  ) async {
    final currentState = state;
    currentState.when(
      initial: () => {},
      loading: () => {},
      authenticated: (userProfile) async {
        emit(const AuthState.loading());
        
        try {
          final updatedProfile = userProfile.copyWith(
            displayName: displayName,
          );
          final profile = await _supabaseService.updateUserProfile(updatedProfile);
          emit(AuthState.authenticated(userProfile: profile));
        } catch (e) {
          emit(AuthState.error(
            message: e.toString(),
            userProfile: userProfile,
          ));
        }
      },
      unauthenticated: () => {},
      error: (message, userProfile) => {},
    );
  }

  Future<void> _onClearError(Emitter<AuthState> emit) async {
    final currentState = state;
    currentState.when(
      initial: () => emit(const AuthState.unauthenticated()),
      loading: () => {},
      authenticated: (userProfile) => emit(AuthState.authenticated(userProfile: userProfile)),
      unauthenticated: () => emit(const AuthState.unauthenticated()),
      error: (message, userProfile) => {
        if (userProfile != null) {
          emit(AuthState.authenticated(userProfile: userProfile))
        } else {
          emit(const AuthState.unauthenticated())
        }
      },
    );
  }

  Future<void> _onAuthStateChanged(Emitter<AuthState> emit, String? userId) async {
    if (userId != null) {
      await _loadUserProfile(emit, userId);
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _loadUserProfile(Emitter<AuthState> emit, String userId) async {
    try {
      final profile = await _supabaseService.getUserProfile(userId);
      if (profile != null) {
        emit(AuthState.authenticated(userProfile: profile));
      } else {
        // Create new profile if it doesn't exist
        final user = _supabaseService.currentUser!;
        final newProfile = UserProfile(
          id: user.id,
          email: user.email!,
          displayName: user.userMetadata?['display_name'] ?? user.email!.split('@')[0],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        final createdProfile = await _supabaseService.createUserProfile(newProfile);
        emit(AuthState.authenticated(userProfile: createdProfile));
      }
    } catch (e) {
      emit(AuthState.error(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
