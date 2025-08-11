import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../blocs/blocs.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppColors.softCream,
        foregroundColor: AppColors.charcoal,
      ),
      backgroundColor: AppColors.softCream,
      body: BlocBuilder<SpotsBloc, SpotsState>(
        builder: (context, spotsState) {
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location Settings Section
                _buildSectionHeader('Location Settings'),
                const SizedBox(height: AppSpacing.sm),
                _buildLocationToggle(spotsState),
                const SizedBox(height: AppSpacing.md),
                _buildDistanceUnitToggle(spotsState),
                
                const SizedBox(height: AppSpacing.xl),
                
                // Other Settings Section
                _buildSectionHeader('App Settings'),
                const SizedBox(height: AppSpacing.sm),
                _buildNotificationToggle(),
                
                const Spacer(),
                
                // Save Button
                _buildSaveButton(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.charcoal,
      ),
    );
  }

  Widget _buildLocationToggle(SpotsState spotsState) {
    final useLocation = spotsState.whenOrNull(
      loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) => useLocation,
    ) ?? false;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Use Location',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.charcoal,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Show spots near your current location',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.mediumGray,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: useLocation,
            onChanged: (value) {
              context.read<SpotsBloc>().add(const SpotsEvent.toggleUseLocation());
            },
            activeColor: AppColors.forestGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildDistanceUnitToggle(SpotsState spotsState) {
    final distanceUnit = spotsState.whenOrNull(
      loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) => distanceUnit,
    ) ?? 'km';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Distance Unit',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.charcoal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Currently using ${distanceUnit.toUpperCase()}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.mediumGray,
                  ),
                ),
              ],
            ),
          ),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment<String>(
                value: 'km',
                label: Text('KM'),
              ),
              ButtonSegment<String>(
                value: 'mi',
                label: Text('MI'),
              ),
            ],
            selected: {distanceUnit},
            onSelectionChanged: (Set<String> newSelection) {
              final selectedUnit = newSelection.first;
              context.read<SpotsBloc>().add(
                SpotsEvent.updateDistanceUnit(unit: selectedUnit),
              );
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.forestGreen;
                  }
                  return AppColors.lightGray;
                },
              ),
              foregroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.white;
                  }
                  return AppColors.charcoal;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Push Notifications',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.charcoal,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Get notified about new spots near you',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.mediumGray,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: false, // TODO: Implement notification preferences
            onChanged: (value) {
              // TODO: Implement notification toggle
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notification settings coming soon!'),
                ),
              );
            },
            activeColor: AppColors.forestGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Settings are saved automatically through the bloc
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Settings saved successfully'),
              backgroundColor: AppColors.forestGreen,
            ),
          );
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.forestGreen,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Save Settings',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
