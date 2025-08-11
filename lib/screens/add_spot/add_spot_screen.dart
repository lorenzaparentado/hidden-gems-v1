import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:typed_data';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/spot_category.dart';
import '../../core/models/spot.dart';
import '../../blocs/blocs.dart';
import '../../services/location_service.dart';
import '../../services/supabase_service.dart';

class AddSpotScreen extends StatefulWidget {
  const AddSpotScreen({super.key});

  @override
  State<AddSpotScreen> createState() => _AddSpotScreenState();
}

class _AddSpotScreenState extends State<AddSpotScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  SpotCategory? _selectedCategory;
  XFile? _selectedImage;
  bool _isLoading = false;
  Position? _currentPosition;
  String? _locationError;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Hidden Spot'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveSpot,
            child: _isLoading 
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo Upload
              _buildPhotoUploadArea(),
              
              const SizedBox(height: AppSpacing.lg),
              
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Spot Name *',
                  hintText: 'What would you call this place?',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name for this spot';
                  }
                  if (value.trim().length < 3) {
                    return 'Name must be at least 3 characters';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppSpacing.md),
              
              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description *',
                  hintText: 'Tell us what makes this spot special...',
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please describe this spot';
                  }
                  if (value.trim().length < 10) {
                    return 'Description must be at least 10 characters';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppSpacing.lg),
              
              // Category Selection
              _buildCategorySelection(),
              
              const SizedBox(height: AppSpacing.lg),
              
              // Location Info
              _buildLocationInfo(),
              
              const SizedBox(height: AppSpacing.xl),
              
              // Terms
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.lightGray.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(AppRadius.small),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppColors.mediumGray,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'By adding this spot, you agree to share it with the community. Make sure you have permission to photograph and share this location.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.mediumGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoUploadArea() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: _selectedImage != null ? null : AppColors.lightGray.withOpacity(0.3),
          border: Border.all(
            color: AppColors.lightGray,
            style: BorderStyle.solid,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(AppRadius.medium),
        ),
        child: _selectedImage != null
            ? Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                    child: FutureBuilder<Uint8List>(
                        future: _selectedImage!.readAsBytes(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Image.memory(
                              snapshot.data!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            );
                          } else {
                            return Container(
                              color: AppColors.lightGray,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      ),
                  ),
                  Positioned(
                    top: AppSpacing.sm,
                    right: AppSpacing.sm,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedImage = null;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.xs),
                        decoration: const BoxDecoration(
                          color: AppColors.charcoal,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: AppColors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 48,
                    color: AppColors.mediumGray,
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    'Add Photo',
                    style: TextStyle(
                      color: AppColors.mediumGray,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildCategorySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          children: SpotCategory.values.map((category) {
            final isSelected = _selectedCategory == category;
            final categoryColor = AppColors.getCategoryColor(category.toString().split('.').last);
            
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? categoryColor : Colors.transparent,
                  border: Border.all(color: categoryColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  category.displayName,
                  style: TextStyle(
                    color: isSelected ? AppColors.white : categoryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (_selectedCategory == null)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Text(
              'Please select a category',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.errorRed,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLocationInfo() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.lightGray.withOpacity(0.3),
        borderRadius: BorderRadius.circular(AppRadius.small),
      ),
      child: Row(
        children: [
          Icon(
            _currentPosition != null 
                ? Icons.location_on 
                : _locationError != null 
                    ? Icons.location_off
                    : Icons.location_searching,
            color: _currentPosition != null 
                ? AppColors.forestGreen
                : _locationError != null
                    ? AppColors.errorRed
                    : AppColors.mediumGray,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _currentPosition != null 
                      ? 'Location Found'
                      : _locationError != null
                          ? 'Location Error'
                          : 'Getting Location...',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  _currentPosition != null 
                      ? 'Lat: ${_currentPosition!.latitude.toStringAsFixed(4)}, Lng: ${_currentPosition!.longitude.toStringAsFixed(4)}'
                      : _locationError != null
                          ? _locationError!
                          : 'Please wait while we get your location...',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.mediumGray,
                  ),
                ),
              ],
            ),
          ),
          if (_locationError != null)
            TextButton(
              onPressed: _getCurrentLocation,
              child: const Text('Retry'),
            ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 85,
    );
    
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      setState(() {
        _locationError = null;
      });

      final locationService = LocationService.instance;
      final position = await locationService.getCurrentPosition();
      
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _locationError = 'Failed to get location: ${e.toString()}';
        });
      }
    }
  }

  Future<void> _saveSpot() async {
    if (!_formKey.currentState!.validate() || _selectedCategory == null || _selectedImage == null) {
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a category')),
        );
      }
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please add a photo')),
        );
      }
      return;
    }

    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location not available. Please wait or try again.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Check if user is authenticated
      final user = SupabaseService.instance.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      String imageUrl = '';
      
      // Upload image if selected
      if (_selectedImage != null) {
        final imageBytes = await _selectedImage!.readAsBytes();
        final fileName = '${DateTime.now().millisecondsSinceEpoch}_${_selectedImage!.name}';
        imageUrl = await SupabaseService.instance.uploadSpotImage(fileName, imageBytes);
      } else {
        // This shouldn't happen due to validation, but provide a fallback
        throw Exception('No image selected');
      }

      // Create the spot object
      final newSpot = Spot(
        id: '', // Will be generated by Supabase
        title: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        imageUrl: imageUrl,
        latitude: _currentPosition!.latitude,
        longitude: _currentPosition!.longitude,
        category: _selectedCategory!,
        createdBy: user.id,
        createdAt: DateTime.now(),
        viewCount: 0,
        visitCount: 0,
        bookmarkCount: 0,
      );

      // Add the spot using the SpotsBloc
      context.read<SpotsBloc>().add(SpotsEvent.addSpot(spot: newSpot));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Spot added successfully!'),
            backgroundColor: AppColors.sageGreen,
          ),
        );
        if (Navigator.of(context).canPop()) {
          context.pop();
        } else {
          context.go('/home');
        }
      }
    } catch (e) {
      print(e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding spot: ${e.toString()}'),
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
