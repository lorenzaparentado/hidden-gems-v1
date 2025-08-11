import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../core/models/spot.dart';

class SpotCard extends StatelessWidget {
  final Spot spot;
  final VoidCallback onTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onVisitTap;
  final bool isBookmarked;
  final bool isVisited;
  final String? distance;

  const SpotCard({
    super.key,
    required this.spot,
    required this.onTap,
    this.onBookmarkTap,
    this.onVisitTap,
    this.isBookmarked = false,
    this.isVisited = false,
    this.distance,
  });

  @override
  Widget build(BuildContext context) {
    final categoryColor = AppColors.getCategoryColor(spot.category.toString().split('.').last);
    
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.small),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        spot.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: AppColors.lightGray,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.lightGray,
                            child: const Icon(
                              Icons.image_not_supported,
                              color: AppColors.mediumGray,
                              size: 48,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  // Category indicator
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: categoryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        spot.category.displayName,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppSpacing.sm),
              
              // Title and distance
              Row(
                children: [
                  Expanded(
                    child: Text(
                      spot.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (distance != null)
                    Text(
                      distance!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.mediumGray,
                      ),
                    ),
                ],
              ),
              
              const SizedBox(height: AppSpacing.xs),
              
              // Description
              Text(
                spot.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.mediumGray,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: AppSpacing.md),
              
              // Stats and actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Stats
                  Row(
                    children: [
                      if (spot.visitCount > 0) ...[
                        Icon(
                          Icons.people,
                          color: AppColors.mediumGray,
                          size: 16,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${spot.visitCount}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(width: 8),
                      ],
                      if (spot.bookmarkCount > 0) ...[
                        Icon(
                          Icons.bookmark,
                          color: AppColors.mediumGray,
                          size: 16,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${spot.bookmarkCount}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                  
                  // Action buttons
                  Row(
                    children: [
                      if (onBookmarkTap != null)
                        IconButton(
                          onPressed: onBookmarkTap,
                          icon: Icon(
                            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                            color: isBookmarked ? categoryColor : AppColors.mediumGray,
                          ),
                        ),
                      if (onVisitTap != null)
                        IconButton(
                          onPressed: onVisitTap,
                          icon: Icon(
                            isVisited ? Icons.check_circle : Icons.check_circle_outline,
                            color: isVisited ? AppColors.sageGreen : AppColors.mediumGray,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Premium badge widget (kept for backwards compatibility)
class PremiumBadge extends StatelessWidget {
  final Widget child;

  const PremiumBadge({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.goldenYellow, Colors.orange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            color: AppColors.white,
            size: 12,
          ),
          SizedBox(width: 2),
          Text(
            'Pro',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
