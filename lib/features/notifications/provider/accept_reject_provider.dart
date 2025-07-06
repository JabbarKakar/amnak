import 'package:amnak/core/api_client.dart';
import 'package:amnak/core/network/network_info.dart';
import 'package:get_it/get_it.dart';

import '../../../export.dart';

// class AcceptRejectProvider extends ChangeNotifier {
//   APIClient apiClient = APIClient(box: GetIt.instance<LocalDataSource>());
//   NetworkInfo networkInfo = GetIt.instance<NetworkInfo>();
//
//   bool _isAcceptLoading = false;
//   bool get isAcceptLoading => _isAcceptLoading;
//
//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;
//
//   bool _isRejectLoading = false;
//   bool get isRejectLoading => _isRejectLoading;
//
//   String? _rejectErrorMessage;
//   String? get rejectErrorMessage => _rejectErrorMessage;
//
//   Future<void> accept({required String id}) async {
//     if (await networkInfo.isConnected) {
//       try {
//         _isAcceptLoading = true;
//         _errorMessage = null; // Reset error message
//         notifyListeners();
//
//         final response = await apiClient.get(url: '/hiring/requests/$id/approve');
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
//         _isAcceptLoading = false;
//         notifyListeners();
//       }
//     } else {
//       _errorMessage = 'No internet connection';
//       _isAcceptLoading = false;
//       debugPrint('No internet connection');
//       notifyListeners();
//     }
//   }
//
//   Future<void> reject({required String id}) async {
//     if (await networkInfo.isConnected) {
//       try {
//         _isRejectLoading = true;
//         _rejectErrorMessage = null; // Reset error message
//         notifyListeners();
//
//         final response = await apiClient.get(url: '/hiring/requests/$id/reject');
//         if (response.statusCode == 200) {
//
//         } else {
//           _rejectErrorMessage = 'Server error: ${response.statusCode}';
//           debugPrint('Failed to reject personal request: ${response.statusCode}');
//           debugPrint('Response data: ${response.data}'); // Log response for debugging
//         }
//       } catch (e) {
//         _rejectErrorMessage = 'Error rejecting personal request: $e';
//         debugPrint('Error rejecting personal request: $e');
//       } finally {
//         _isRejectLoading = false;
//         notifyListeners();
//       }
//     } else {
//       _rejectErrorMessage = 'No internet connection';
//       _isRejectLoading = false;
//       debugPrint('No internet connection');
//       notifyListeners();
//     }
//   }
// }

class AcceptRejectProvider extends ChangeNotifier {
  APIClient apiClient = APIClient(box: GetIt.instance<LocalDataSource>());
  NetworkInfo networkInfo = GetIt.instance<NetworkInfo>();

  bool _isAcceptLoading = false;
  bool get isAcceptLoading => _isAcceptLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isRejectLoading = false;
  bool get isRejectLoading => _isRejectLoading;

  String? _rejectErrorMessage;
  String? get rejectErrorMessage => _rejectErrorMessage;

  String? _currentId;
  String? get currentId => _currentId;

  Future<void> accept({required String id}) async {
    if (await networkInfo.isConnected) {
      try {
        _isAcceptLoading = true;
        _currentId = id; // Track the current request ID
        _errorMessage = null; // Reset error message
        notifyListeners();

        final response = await apiClient.get(url: '/hiring/requests/$id/approve');
        if (response.statusCode == 200) {
          // Handle success if needed
        } else {
          _errorMessage = 'Server error: ${response.statusCode}';
          debugPrint('Failed to load personal request: ${response.statusCode}');
          debugPrint('Response data: ${response.data}'); // Log response for debugging
        }
      } catch (e) {
        _errorMessage = 'Error fetching personal request: $e';
        debugPrint('Error fetching personal request: $e');
      } finally {
        _isAcceptLoading = false;
        _currentId = null; // Reset current ID
        notifyListeners();
      }
    } else {
      _errorMessage = 'No internet connection';
      _isAcceptLoading = false;
      _currentId = null; // Reset current ID
      debugPrint('No internet connection');
      notifyListeners();
    }
  }

  Future<void> reject({required String id}) async {
    if (await networkInfo.isConnected) {
      try {
        _isRejectLoading = true;
        _currentId = id; // Track the current request ID
        _rejectErrorMessage = null; // Reset error message
        notifyListeners();

        final response = await apiClient.get(url: '/hiring/requests/$id/reject');
        if (response.statusCode == 200) {
          // Handle success if needed
        } else {
          _rejectErrorMessage = 'Server error: ${response.statusCode}';
          debugPrint('Failed to reject personal request: ${response.statusCode}');
          debugPrint('Response data: ${response.data}'); // Log response for debugging
        }
      } catch (e) {
        _rejectErrorMessage = 'Error rejecting personal request: $e';
        debugPrint('Error rejecting personal request: $e');
      } finally {
        _isRejectLoading = false;
        _currentId = null; // Reset current ID
        notifyListeners();
      }
    } else {
      _rejectErrorMessage = 'No internet connection';
      _isRejectLoading = false;
      _currentId = null; // Reset current ID
      debugPrint('No internet connection');
      notifyListeners();
    }
  }
}