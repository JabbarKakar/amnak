import 'package:amnak/core/api_client.dart';
import 'package:amnak/core/feature/data/datasources/local_data_source.dart';
import 'package:amnak/core/network/network_info.dart';
import 'package:amnak/features/safety_check_details/model/safety_check_details_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SafetyCheckDetailsProvider with ChangeNotifier {

  APIClient apiClient = APIClient(box: GetIt.instance<LocalDataSource>());
  NetworkInfo networkInfo = GetIt.instance<NetworkInfo>();

  SafetyCheckDetailsModel? _safetyCheckDetails;
  bool _isLoading = false;
  String? _errorMessage;


  SafetyCheckDetailsModel? get safetyCheckDetails => _safetyCheckDetails;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // final Dio _dio = Dio(BaseOptions(
  //   baseUrl: 'https://api.amnak.app',
  //   connectTimeout: const Duration(seconds: 10),
  //   receiveTimeout: const Duration(seconds: 10),
  // ));

  Future<void> fetchSafetyCheckDetails({required String id}) async {
    if (await networkInfo.isConnected) {
      try {
        _isLoading = true;
        _errorMessage = null; // Reset error message
        notifyListeners();

        final response = await apiClient.get(url: '/safety_check/$id');
        if (response.statusCode == 200) {
          _safetyCheckDetails = SafetyCheckDetailsModel.fromJson(response.data);
          if (_safetyCheckDetails?.messages.isNotEmpty ?? false) {
            print('Messages =====>>>>>: ${_safetyCheckDetails?.messages}');
            print('Messages =====>>>>>: ${_safetyCheckDetails!.data!.projectDetails!.projectName}');
          }
        } else {
          _errorMessage = 'Server error: ${response.statusCode}';
          debugPrint('Failed to load personal request: ${response.statusCode}');
          debugPrint('Response data: ${response.data}'); // Log response for debugging
        }
      } catch (e) {
        _errorMessage = 'Error fetching personal request: $e';
        debugPrint('Error fetching personal request: $e');
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

  // Future<void> fetchSafetyCheckDetails(String id) async {
  //   _isLoading = true;
  //   _errorMessage = null;
  //   notifyListeners();
  //
  //   try {
  //     final response = await _dio.get('/safety_check/$id');
  //     if (response.statusCode == 200) {
  //       _safetyCheckDetails = SafetyCheckDetailsModel.fromJson(response.data);
  //     } else {
  //       debugPrint('Failed to load data: ${response.statusCode}');
  //       _errorMessage = 'Failed to load data: ${response.statusCode}';
  //     }
  //   } catch (e) {
  //     debugPrint('Error fetching safety check details: $e');
  //     _errorMessage = 'Error: $e';
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
}