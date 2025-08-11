import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/spot.dart';
import '../../blocs/blocs.dart';
import '../../services/supabase_service.dart';
import '../../utils/seed_data.dart';

class DevUtilsScreen extends StatefulWidget {
  const DevUtilsScreen({super.key});

  @override
  State<DevUtilsScreen> createState() => _DevUtilsScreenState();
}

class _DevUtilsScreenState extends State<DevUtilsScreen> {
  bool _isSeeding = false;
  String? _seedingStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🛠️ Developer Utils'),
        backgroundColor: AppColors.charcoal,
        foregroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.charcoal,
              AppColors.charcoal.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(),
                
                const SizedBox(height: AppSpacing.xl),
                
                // Seeding Section
                _buildSeedingSection(),
                
                const SizedBox(height: AppSpacing.lg),
                
                // Database Section
                _buildDatabaseSection(),
                
                const Spacer(),
                
                // Warning Footer
                _buildWarningFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(
          color: AppColors.white.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Development Tools',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Tools for testing and development. Use with caution!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeedingSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(
          color: AppColors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🌱 Seed Data',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Add comprehensive sample spots throughout Philadelphia for testing purposes. Includes university areas, downtown landmarks, and neighborhood gems.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.white.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          
          if (_seedingStatus != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: _seedingStatus!.contains('Error') 
                    ? AppColors.errorRed.withOpacity(0.2)
                    : AppColors.sageGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppRadius.small),
                border: Border.all(
                  color: _seedingStatus!.contains('Error') 
                      ? AppColors.errorRed
                      : AppColors.sageGreen,
                ),
              ),
              child: Text(
                _seedingStatus!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: _seedingStatus!.contains('Error') 
                      ? AppColors.errorRed
                      : AppColors.sageGreen,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isSeeding ? null : _showSeedConfirmation,
              icon: _isSeeding 
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.cloud_upload),
              label: Text(_isSeeding ? 'Seeding...' : 'Seed Philadelphia Spots'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.forestGreen,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatabaseSection() {
    return BlocBuilder<SpotsBloc, SpotsState>(
      builder: (context, spotsState) {
        final spotsCount = spotsState.whenOrNull(
          loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) => spots.length,
        ) ?? 0;

        return Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(AppRadius.medium),
            border: Border.all(
              color: AppColors.white.withOpacity(0.1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '📊 Database Info',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              
              _buildInfoRow('Total Spots', '$spotsCount'),
              _buildInfoRow('Current User', SupabaseService.instance.currentUser?.email ?? 'Not logged in'),
              
              const SizedBox(height: AppSpacing.lg),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<SpotsBloc>().add(const SpotsEvent.loadSpots());
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh Data'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dustyBlue,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.white.withOpacity(0.7),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningFooter() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.errorRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.small),
        border: Border.all(
          color: AppColors.errorRed.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning,
            color: AppColors.errorRed,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'These tools are for development only. Do not use in production!',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.errorRed,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSeedConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('⚠️ Seed Database'),
          content: const Text(
            'This will add ~100 sample spots throughout Philadelphia to the database. Duplicates will be automatically skipped. This action cannot be undone easily.\n\nAre you sure you want to continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _seedSpots();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.forestGreen,
                foregroundColor: AppColors.white,
              ),
              child: const Text('Seed Database'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _seedSpots() async {
    setState(() {
      _isSeeding = true;
      _seedingStatus = null;
    });

    try {
      final user = SupabaseService.instance.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      setState(() {
        _seedingStatus = 'Preparing seed data...';
      });

      // Get current spots to check for duplicates
      final currentState = context.read<SpotsBloc>().state;
      final existingSpots = currentState.whenOrNull(
        loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) => spots,
      ) ?? <Spot>[];

      // Get seed spots
      final seedSpots = SeedData.getPhiladelphiaSpots();
      
      // Filter out spots that might already exist (by title)
      final existingTitles = existingSpots.map((s) => s.title.toLowerCase()).toSet();
      final newSeedSpots = seedSpots
          .where((seedSpot) => !existingTitles.contains(seedSpot.title.toLowerCase()))
          .toList();
      
      if (newSeedSpots.isEmpty) {
        setState(() {
          _seedingStatus = 'No new spots to add. All seed data appears to already exist.';
        });
        return;
      }

      setState(() {
        _seedingStatus = 'Creating ${newSeedSpots.length} new spots (${seedSpots.length - newSeedSpots.length} duplicates skipped)...';
      });

      int successCount = 0;
      int errorCount = 0;
      const uuid = Uuid();

      // Process spots in batches to avoid overwhelming the database
      const batchSize = 3; // Reduced batch size for better reliability
      for (int i = 0; i < newSeedSpots.length; i += batchSize) {
        final batch = newSeedSpots.skip(i).take(batchSize);
        
        for (final seedSpot in batch) {
          try {
            // Create a new spot with a new ID and current user as creator
            final newSpot = Spot(
              id: uuid.v4(),
              title: seedSpot.title,
              description: seedSpot.description,
              latitude: seedSpot.latitude,
              longitude: seedSpot.longitude,
              category: seedSpot.category,
              imageUrl: seedSpot.imageUrl,
              createdBy: user.id,
              createdAt: DateTime.now(),
              tags: seedSpot.tags,
              viewCount: 0, // Start with 0 views for new spots
              bookmarkCount: 0, // Start with 0 bookmarks
              visitCount: 0, // Start with 0 visits
            );

            // Add the spot through the bloc
            context.read<SpotsBloc>().add(SpotsEvent.addSpot(spot: newSpot));
            successCount++;
            
            // Update progress more frequently
            setState(() {
              _seedingStatus = 'Created $successCount/${newSeedSpots.length} spots... (${seedSpot.title})';
            });
            
            // Small delay between individual spots to avoid rate limiting
            await Future.delayed(const Duration(milliseconds: 300));
          } catch (e) {
            print('Error creating spot ${seedSpot.title}: $e');
            errorCount++;
            setState(() {
              _seedingStatus = 'Created $successCount/${newSeedSpots.length} spots... Error on ${seedSpot.title}';
            });
          }
        }

        // Longer delay between batches
        if (i + batchSize < newSeedSpots.length) {
          await Future.delayed(const Duration(milliseconds: 1000));
        }
      }

      setState(() {
        if (errorCount == 0) {
          _seedingStatus = '✅ Seeding complete! Successfully created $successCount spots.';
        } else {
          _seedingStatus = '⚠️ Seeding finished with issues. Created $successCount spots, $errorCount errors occurred.';
        }
      });

      // Small delay before refreshing to let the database process
      await Future.delayed(const Duration(milliseconds: 1000));
      
      // Refresh the spots list to ensure UI is updated
      context.read<SpotsBloc>().add(const SpotsEvent.loadSpots());

    } catch (e) {
      setState(() {
        _seedingStatus = '❌ Error seeding spots: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isSeeding = false;
      });
    }
  }
}
