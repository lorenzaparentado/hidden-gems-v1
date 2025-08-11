import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../blocs/blocs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Wait for initialization
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      final authState = context.read<AuthBloc>().state;
      
      authState.when(
        initial: () => context.go('/auth'),
        loading: () => context.go('/auth'),
        authenticated: (userProfile) => context.go('/home'),
        unauthenticated: () => context.go('/auth'),
        error: (message, userProfile) => context.go('/auth'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          authenticated: (userProfile) {
            // Navigate to home if authenticated during splash
            if (mounted) {
              context.go('/home');
            }
          },
          unauthenticated: () {
            // Navigate to auth if unauthenticated during splash
            if (mounted) {
              context.go('/auth');
            }
          },
          error: (message, userProfile) {
            // Navigate to auth on error
            if (mounted) {
              context.go('/auth');
            }
          },
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.forestGreen,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.explore,
                size: 120,
                color: AppColors.white,
              ),
              const SizedBox(height: 24),
              Text(
                'Hidden Gems',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Discover your city\'s secret corners',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 48),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
