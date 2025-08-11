import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/spot.dart';
import '../../blocs/blocs.dart';
import '../../widgets/spot_card.dart';
import '../../services/supabase_service.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  bool _isGridView = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadBookmarks() async {
    final user = SupabaseService.instance.currentUser;
    if (user == null) return;

    context.read<SpotsBloc>().add(const SpotsEvent.loadBookmarkedSpots());
  }

  List<Spot> _getFilteredSpots(List<Spot> spots) {
    if (_searchQuery.isEmpty) return spots;
    
    return spots.where((spot) {
      return spot.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             spot.description.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookmarks'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () => setState(() => _isGridView = !_isGridView),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search bookmarked spots...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.lightGray.withOpacity(0.3),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          
          // Content
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return BlocBuilder<SpotsBloc, SpotsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) {
            final filteredSpots = _getFilteredSpots(bookmarkedSpots);

            if (bookmarkedSpots.isEmpty) {
              return _buildEmptyState();
            }

            if (filteredSpots.isEmpty) {
              return _buildNoSearchResults();
            }

            return _isGridView 
                ? _buildGridView(filteredSpots) 
                : _buildListView(filteredSpots);
          },
          error: (message, spots, userSpots, bookmarkedSpots, visitedSpots, selectedCategory, currentPosition, locationRadius, useLocation, distanceUnit) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.errorRed,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Error loading bookmarks',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.mediumGray,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ElevatedButton(
                    onPressed: _loadBookmarks,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.bookmark_border,
            size: 64,
            color: AppColors.mediumGray,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'No bookmarks yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Start exploring and bookmark spots you want to visit later',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.mediumGray,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton(
            onPressed: () => context.go('/home'),
            child: const Text('Discover Spots'),
          ),
        ],
      ),
    );
  }

  Widget _buildNoSearchResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off,
            size: 64,
            color: AppColors.mediumGray,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'No results found',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Try adjusting your search terms',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.mediumGray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(List<Spot> spots) {
    return RefreshIndicator(
      onRefresh: () async => _loadBookmarks(),
      child: GridView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .65,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
        ),
        itemCount: spots.length,
        itemBuilder: (context, index) {
          final spot = spots[index];
          return SpotCard(
            spot: spot,
            onTap: () => context.push('/spot/${spot.id}'),
            onBookmarkTap: () => _toggleBookmark(spot),
          );
        },
      ),
    );
  }

  Widget _buildListView(List<Spot> spots) {
    return RefreshIndicator(
      onRefresh: () async => _loadBookmarks(),
      child: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: spots.length,
        itemBuilder: (context, index) {
          final spot = spots[index];
          return _buildListItem(spot);
        },
      ),
    );
  }

  Widget _buildListItem(Spot spot) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppSpacing.md),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: spot.imageUrl.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(spot.imageUrl),
                    fit: BoxFit.cover,
                  )
                : null,
            color: spot.imageUrl.isEmpty ? AppColors.lightGray : null,
          ),
          child: spot.imageUrl.isEmpty
              ? const Icon(Icons.image, color: AppColors.mediumGray)
              : null,
        ),
        title: Text(
          spot.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          spot.description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.mediumGray,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.bookmark, color: AppColors.forestGreen),
              onPressed: () => _toggleBookmark(spot),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
        onTap: () => context.push('/spot/${spot.id}'),
      ),
    );
  }

  Future<void> _toggleBookmark(Spot spot) async {
    final user = SupabaseService.instance.currentUser;
    if (user == null) return;

    try {
      context.read<SpotsBloc>().add(SpotsEvent.toggleBookmark(spotId: spot.id));
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Removed "${spot.title}" from bookmarks'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                context.read<SpotsBloc>().add(SpotsEvent.toggleBookmark(spotId: spot.id));
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error removing bookmark: ${e.toString()}'),
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    }
  }
}
