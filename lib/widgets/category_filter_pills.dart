import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../core/models/spot_category.dart';

class CategoryFilterPills extends StatelessWidget {
  final SpotCategory? selectedCategory;
  final Function(SpotCategory?) onCategorySelected;

  const CategoryFilterPills({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // "All" category
          _buildCategoryPill(
            context,
            label: 'All',
            isSelected: selectedCategory == null,
            onTap: () => onCategorySelected(null),
            color: AppColors.forestGreen,
          ),
          const SizedBox(width: AppSpacing.sm),
          
          // Category pills
          ...SpotCategory.values.map((category) => Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: _buildCategoryPill(
              context,
              label: category.displayName,
              isSelected: selectedCategory == category,
              onTap: () => onCategorySelected(category),
              color: AppColors.getCategoryColor(category.toString().split('.').last),
              icon: _getCategoryIcon(category),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildCategoryPill(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required Color color,
    IconData? icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          border: Border.all(
            color: color,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isSelected ? AppColors.white : color,
              ),
              const SizedBox(width: AppSpacing.xs),
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected ? AppColors.white : color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(SpotCategory category) {
    switch (category) {
      case SpotCategory.quiet:
        return Icons.menu_book_outlined;
      case SpotCategory.nature:
        return Icons.park_outlined;
      case SpotCategory.art:
        return Icons.palette_outlined;
      case SpotCategory.views:
        return Icons.camera_alt_outlined;
    }
  }
}
