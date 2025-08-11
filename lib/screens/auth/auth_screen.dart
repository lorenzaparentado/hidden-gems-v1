import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../blocs/blocs.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isSignUp = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            authenticated: (userProfile) {
              // Navigate to home on successful auth
              context.go('/home');
            },
            unauthenticated: () {},
            error: (message, userProfile) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: AppColors.errorRed,
                ),
              );
            },
          );
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo and Title
                Icon(
                  Icons.explore,
                  size: 80,
                  color: AppColors.forestGreen,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Hidden Gems',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppColors.forestGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Discover your city\'s secret corners',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.charcoal,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: AppSpacing.xl * 2),
                
                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Toggle Sign In/Sign Up
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () => setState(() => _isSignUp = false),
                              style: TextButton.styleFrom(
                                backgroundColor: !_isSignUp ? AppColors.forestGreen : Colors.transparent,
                                foregroundColor: !_isSignUp ? AppColors.white : AppColors.charcoal,
                              ),
                              child: const Text('Sign In'),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: TextButton(
                              onPressed: () => setState(() => _isSignUp = true),
                              style: TextButton.styleFrom(
                                backgroundColor: _isSignUp ? AppColors.forestGreen : Colors.transparent,
                                foregroundColor: _isSignUp ? AppColors.white : AppColors.charcoal,
                              ),
                              child: const Text('Sign Up'),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Name field (only for sign up)
                      if (_isSignUp) ...[
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Display Name',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (_isSignUp && (value == null || value.isEmpty)) {
                              return 'Please enter your display name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                      ],
                      
                      // Email field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: AppSpacing.md),
                      
                      // Password field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (_isSignUp && value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: AppSpacing.xl),
                      
                      // Submit button
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          final isLoading = state.whenOrNull(loading: () => true) ?? false;
                          
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isLoading ? null : _handleSubmit,
                              child: isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : Text(_isSignUp ? 'Create Account' : 'Sign In'),
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final displayName = _nameController.text.trim();

    if (_isSignUp) {
      context.read<AuthBloc>().add(
        AuthEvent.signUp(
          email: email,
          password: password,
          displayName: displayName,
        ),
      );
    } else {
      context.read<AuthBloc>().add(
        AuthEvent.signIn(
          email: email,
          password: password,
        ),
      );
    }
  }
}
