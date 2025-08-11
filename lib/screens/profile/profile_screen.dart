import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../blocs/blocs.dart';
import '../../services/supabase_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _tapCount = 0;
  DateTime? _lastTap;

  void _handleAvatarTap() {
    final now = DateTime.now();
    
    // Reset counter if more than 2 seconds have passed
    if (_lastTap == null || now.difference(_lastTap!).inSeconds > 2) {
      _tapCount = 1;
    } else {
      _tapCount++;
    }
    
    _lastTap = now;
    
    // Open dev utils after 7 taps
    if (_tapCount >= 7) {
      _tapCount = 0;
      context.push('/dev-utils');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.push('/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            // User Header
            _buildUserHeader(context),
            
            const SizedBox(height: AppSpacing.lg),
            
            // Subscription Status
            _buildSubscriptionCard(context),
            
            const SizedBox(height: AppSpacing.lg),
            
            // Stats Grid
            _buildStatsGrid(context),
            
            const SizedBox(height: AppSpacing.lg),
            
            // Menu Items
            _buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final user = SupabaseService.instance.currentUser;
        
        return authState.when(
          initial: () => _buildUserCard(context, null, null),
          loading: () => _buildUserCard(context, null, null),
          authenticated: (userProfile) => _buildUserCard(context, user, userProfile),
          unauthenticated: () => _buildUserCard(context, null, null),
          error: (message, userProfile) => _buildUserCard(context, user, userProfile),
        );
      },
    );
  }

  Widget _buildUserCard(BuildContext context, dynamic user, dynamic profile) {
    // Get user initials
    String initials = 'U';
    final displayNameValue = profile?.displayName;
    if (displayNameValue != null && displayNameValue.isNotEmpty) {
      final names = displayNameValue.split(' ');
      initials = names.length >= 2
          ? '${names[0][0]}${names[1][0]}'.toUpperCase()
          : names[0][0].toUpperCase();
    } else if (user?.email != null && user!.email!.isNotEmpty) {
      initials = user.email![0].toUpperCase();
    }

    // Get display name
    String displayName = profile?.displayName ?? user?.email ?? 'User';
    
    // Get join date
    String joinDate = 'New member';
    if (user?.createdAt != null) {
      final date = DateTime.parse(user!.createdAt);
      joinDate = 'Joined ${_formatDate(date)}';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.softCream,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Column(
        children: [
          // Avatar
          GestureDetector(
            onTap: _handleAvatarTap,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.forestGreen,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 3),
              ),
              child: Center(
                child: Text(
                  initials,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: AppSpacing.md),
          
          // Display Name
          Text(
            displayName,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: AppSpacing.xs),
          
          // Join Date
          Text(
            joinDate,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.mediumGray,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.forestGreen, AppColors.sageGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: AppColors.goldenYellow,
                size: 24,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Free Plan',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppSpacing.sm),
          
          Text(
            'Discover Hidden Gems and share your own finds',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.white,
            ),
          ),
          
          const SizedBox(height: AppSpacing.md),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement premium upgrade
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Premium features coming soon!'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.forestGreen,
              ),
              child: const Text('Upgrade to Premium'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return BlocBuilder<SpotsBloc, SpotsState>(
      builder: (context, spotsState) {
        return spotsState.when(
          initial: () => _buildStatsRow(context, 0, 0, 0),
          loading: () => _buildStatsRow(context, 0, 0, 0),
          loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) {
            final user = SupabaseService.instance.currentUser;
            final userSpotsCount = user != null 
                ? spots.where((spot) => spot.createdBy == user.id).length 
                : 0;
            final bookmarkedCount = bookmarkedSpots.length;
            final visitedCount = visitedSpots.length;
            
            return _buildStatsRow(context, userSpotsCount, visitedCount, bookmarkedCount);
          },
          error: (message, spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) {
            final user = SupabaseService.instance.currentUser;
            final userSpotsCount = user != null && spots != null
                ? spots.where((spot) => spot.createdBy == user.id).length 
                : 0;
            final bookmarkedCount = bookmarkedSpots?.length ?? 0;
            final visitedCount = visitedSpots?.length ?? 0;
            
            return _buildStatsRow(context, userSpotsCount, visitedCount, bookmarkedCount);
          },
        );
      },
    );
  }

  Widget _buildStatsRow(BuildContext context, int spotsAdded, int visited, int saved) {
    return Row(
      children: [
        Expanded(child: _buildStatCard(context, '$spotsAdded', 'Spots Added')),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: _buildStatCard(context, '$visited', 'Visited')),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: _buildStatCard(context, '$saved', 'Saved')),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.forestGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.mediumGray,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem(
          context,
          icon: Icons.help_outline,
          title: 'Help & Support',
          onTap: () {
            // TODO: Implement help screen
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Help & Support coming soon!'),
              ),
            );
          },
        ),
        _buildMenuItem(
          context,
          icon: Icons.info_outline,
          title: 'About',
          onTap: () {
            // TODO: Implement about screen
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('About page coming soon!'),
              ),
            );
          },
        ),
        _buildMenuItem(
          context,
          icon: Icons.logout,
          title: 'Sign Out',
          isDestructive: true,
          onTap: () => _handleSignOut(context),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? AppColors.errorRed : AppColors.charcoal,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: isDestructive ? AppColors.errorRed : AppColors.charcoal,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.mediumGray),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: AppColors.white,
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  Future<void> _handleSignOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    final router = GoRouter.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: AppSpacing.md),
            Text('Signing out...'),
          ],
        ),
      ),
    );

    try {
      // Sign out using AuthBloc
      context.read<AuthBloc>().add(const AuthEvent.signOut());
      
      // Close loading dialog
      navigator.pop();
      
      // Navigate to auth screen
      router.go('/auth');
      
    } catch (e) {
      // Close loading dialog
      navigator.pop();
      
      // Show error message
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Error signing out: ${e.toString()}'),
          backgroundColor: AppColors.errorRed,
        ),
      );
    }
  }
}
