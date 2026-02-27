import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/app_config.dart';
import '../dio/dio_client.dart';

// =============================================================================
// Task 6.4 Step 2: Create ImageUploadProvider (ImagePickerService)
// Task 6.4 Step 3: Implement pickImage() function
// Task 6.4 Step 4: Add uploadImage() using MultipartRequest
// Task 6.4 Step 5: Create multipart file: http.MultipartFile.fromBytes()
// Task 6.4 Step 6: Attach image to request
// Task 6.4 Step 7: Send request and get response
// Task 6.4 Step 8: Parse response for image URL
// Task 6.4 Step 11: Compress large images before upload (via imageQuality param)
// =============================================================================

/// Service for handling image picking and uploading
class ImagePickerService {
  final ImagePicker _picker;
  final DioClient _dioClient;

  ImagePickerService({
    ImagePicker? picker,
    required DioClient dioClient,
  })  : _picker = picker ?? ImagePicker(),
        _dioClient = dioClient;

  // Task 6.4 Step 3: Implement pickImage() function - from gallery
  // Task 6.4 Step 11: Compress large images before upload with maxWidth, maxHeight, imageQuality
  /// Pick image from gallery
  Future<File?> pickFromGallery({
    int maxWidth = 1024,
    int maxHeight = 1024,
    int imageQuality = 85,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth.toDouble(),
        maxHeight: maxHeight.toDouble(),
        imageQuality: imageQuality,
      );
      
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Task 6.4 Step 3: Implement pickImage() function - from camera
  // Task 6.4 Step 11: Compress large images before upload
  /// Pick image from camera
  Future<File?> pickFromCamera({
    int maxWidth = 1024,
    int maxHeight = 1024,
    int imageQuality = 85,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: maxWidth.toDouble(),
        maxHeight: maxHeight.toDouble(),
        imageQuality: imageQuality,
      );
      
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  /// Pick multiple images from gallery
  Future<List<File>> pickMultipleImages({
    int maxWidth = 1024,
    int maxHeight = 1024,
    int imageQuality = 85,
    int limit = 10,
  }) async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: maxWidth.toDouble(),
        maxHeight: maxHeight.toDouble(),
        imageQuality: imageQuality,
        limit: limit,
      );
      
      return images.map((xFile) => File(xFile.path)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // Task 6.4 Step 4: Add uploadImage() using MultipartRequest
  // Task 6.4 Step 5: Create multipart file: MultipartFile.fromFile()
  // Task 6.4 Step 6: Attach image to request
  // Task 6.4 Step 7: Send request and get response
  // Task 6.4 Step 8: Parse response for image URL
  // Task 6.4 Step 12: Handle errors and show messages
  /// Upload image with progress callback
  Future<ImageUploadResult> uploadImage(
    File imageFile, {
    void Function(double progress)? onProgress,
  }) async {
    try {
      final fileName = imageFile.path.split('/').last;
      
      // Task 6.4 Step 5: Create multipart file
      // Task 6.4 Step 6: Attach image to request via FormData
      final formData = FormData.fromMap({
        'key': AppConfig.imageUploadApiKey,
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      // Task 6.4 Step 7: Send request and get response
      final response = await _dioClient.uploadFile<Map<String, dynamic>>(
        AppConfig.imageUploadUrl,
        formData: formData,
        // Task 6.4 Step 9: Show upload progress callback
        onSendProgress: (sent, total) {
          if (onProgress != null && total > 0) {
            onProgress(sent / total);
          }
        },
      );

      // Task 6.4 Step 8: Parse response for image URL
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data!;
        if (data['success'] == true) {
          // Task 6.4 Step 10: Return image URL for display
          return ImageUploadResult(
            success: true,
            imageUrl: data['data']['url'] as String,
            thumbnailUrl: data['data']['thumb']?['url'] as String?,
          );
        }
      }

      return ImageUploadResult(
        success: false,
        error: 'Upload failed',
      );
    } catch (e) {
      return ImageUploadResult(
        success: false,
        error: e.toString(),
      );
    }
  }
}

/// Result of an image upload operation
class ImageUploadResult {
  final bool success;
  final String? imageUrl;
  final String? thumbnailUrl;
  final String? error;

  ImageUploadResult({
    required this.success,
    this.imageUrl,
    this.thumbnailUrl,
    this.error,
  });
}
