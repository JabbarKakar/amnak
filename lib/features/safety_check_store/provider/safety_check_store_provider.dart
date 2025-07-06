import 'package:amnak/core/api_client.dart';
import 'package:amnak/core/network/network_info.dart';
import 'package:get_it/get_it.dart';

import '../../../export.dart';

// class SafetyCheckStoreProvider with ChangeNotifier {
//
//   APIClient apiClient = APIClient(box: GetIt.instance<LocalDataSource>());
//   NetworkInfo networkInfo = GetIt.instance<NetworkInfo>();
//
//   // SafetyCheckDetailsModel? _safetyCheckDetails;
//   bool _isLoading = false;
//   String? _errorMessage;
//
//
//   // SafetyCheckDetailsModel? get safetyCheckDetails => _safetyCheckDetails;
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//
//   Future<void> fetchSafetyCheckDetails() async {
//     if (await networkInfo.isConnected) {
//       try {
//         _isLoading = true;
//         _errorMessage = null; // Reset error message
//         notifyListeners();
//
//         final response = await apiClient.post(url: '/safety_check/store', isParamData: true, params: );
//         if (response.statusCode == 200) {
//
//         } else {
//           _errorMessage = 'Server error: ${response.statusCode}';
//           debugPrint('Failed to load personal request: ${response.statusCode}');
//           debugPrint('Response data: ${response.data}'); // Log response for debugging
//         }
//       } catch (e) {
//         _errorMessage = 'Error fetching personal request: $e';
//         debugPrint('Error fetching personal request: $e');
//       } finally {
//         _isLoading = false;
//         notifyListeners();
//       }
//     } else {
//       _errorMessage = 'No internet connection';
//       _isLoading = false;
//       debugPrint('No internet connection');
//       notifyListeners();
//     }
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

class SafetyCheckStoreProvider with ChangeNotifier {
  APIClient apiClient = APIClient(box: GetIt.instance<LocalDataSource>());
  NetworkInfo networkInfo = GetIt.instance<NetworkInfo>();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchSafetyCheckDetails({
    required int safetyCheckItemId,
    required int projectId,
    required String notes,
    required String handled,
    required String? mediaPath,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        _isLoading = true;
        _errorMessage = null;
        notifyListeners();

        // Prepare the data map
        final data = {
          'safety_check_item_id': safetyCheckItemId,
          'project_id': projectId,
          'notes': notes,
          'handled': handled,
        };

        // Prepare the file if mediaPath is provided
        File? file;
        if (mediaPath != null) {
          file = File(mediaPath);
        }

        // Call the uploadImage method
        final response = await apiClient.uploadImage(
          url: '/safety_check/store',
          user: data,
          file: file,
        );

        if (response.statusCode == 200) {
          // Handle successful response (e.g., store response data if needed)
          debugPrint('Safety check stored successfully: ${response.data}');
        } else {
          _errorMessage = 'Server error: ${response.statusCode}';
          debugPrint('Failed to store safety check: ${response.statusCode}');
          debugPrint('Response data: ${response.data}');
        }
      } catch (e) {
        _errorMessage = 'Error storing safety check: $e';
        debugPrint('Error storing safety check: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    } else {
      _errorMessage = 'No internet connection';
      _isLoading = false;
      debugPrint('No internet connection');
      notifyListeners();
    }
  }
}