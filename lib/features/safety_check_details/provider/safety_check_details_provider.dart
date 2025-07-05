import 'package:amnak/features/safety_check_details/model/safety_check_details_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SafetyCheckDetailsProvider with ChangeNotifier {
  SafetyCheckDetailsModel? _safetyCheckDetails;
  bool _isLoading = false;
  String? _errorMessage;

  SafetyCheckDetailsModel? get safetyCheckDetails => _safetyCheckDetails;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://api.amnak.app',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<void> fetchSafetyCheckDetails(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _dio.get('/safety_check/$id');
      if (response.statusCode == 200) {
        _safetyCheckDetails = SafetyCheckDetailsModel.fromJson(response.data);
      } else {
        debugPrint('Failed to load data: ${response.statusCode}');
        _errorMessage = 'Failed to load data: ${response.statusCode}';
      }
    } catch (e) {
      debugPrint('Error fetching safety check details: $e');
      _errorMessage = 'Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}