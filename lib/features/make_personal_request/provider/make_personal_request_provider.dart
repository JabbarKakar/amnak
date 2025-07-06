import 'package:amnak/core/api_client.dart';
import 'package:amnak/core/network/network_info.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/make_personal_request/model/make_personal_request_model.dart';
import 'package:amnak/features/personal_request/model/personal_request_model.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

// class MakePersonalRequestProvider extends ChangeNotifier {
//   APIClient apiClient = APIClient(box: GetIt.instance<LocalDataSource>());
//   NetworkInfo networkInfo = GetIt.instance<NetworkInfo>();
//
//   MakePersonalRequestModel? _makePersonalRequestModel;
//   MakePersonalRequestModel? get makePersonalRequestModel => _makePersonalRequestModel;
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;
//
//   String? _successMessage;
//   String? get successMessage => _successMessage;
//
//   Future<bool> makePersonalRequest({
//     required int requestType,
//     required String reason,
//     required DateTime startDate,
//     required DateTime endDate,
//   }) async {
//     if (await networkInfo.isConnected) {
//       try {
//         _isLoading = true;
//         _errorMessage = null;
//         _successMessage = null;
//         notifyListeners();
//
//         final response = await apiClient.post(
//           url: '/make_personal_request',
//           params: {
//             'request_type': requestType,
//             'reason': reason,
//             'start_date': DateFormat('yyyy-MM-dd').format(startDate),
//             'end_date': DateFormat('yyyy-MM-dd').format(endDate),
//           },
//         );
//
//         if (response.statusCode == 200) {
//           _makePersonalRequestModel = MakePersonalRequestModel.fromJson(response.data);
//           _successMessage = _makePersonalRequestModel?.messages.join(', ') ?? 'Request created successfully';
//           debugPrint('Request created: $_successMessage');
//           return true;
//         } else {
//           _errorMessage = 'Server error: ${response.statusCode} - ${response.data.toString()}';
//           debugPrint('Failed to create personal request: ${response.statusCode}');
//           debugPrint('Response data: ${response.data}');
//           return false;
//         }
//       } catch (e) {
//         _errorMessage = 'Error creating personal request: $e';
//         debugPrint('Error creating personal request: $e');
//         return false;
//       } finally {
//         _isLoading = false;
//         notifyListeners();
//       }
//     } else {
//       _errorMessage = 'No internet connection';
//       _isLoading = false;
//       debugPrint('No internet connection');
//       notifyListeners();
//       return false;
//     }
//   }
//
//   void reset() {
//     _makePersonalRequestModel = null;
//     _errorMessage = null;
//     _successMessage = null;
//     _isLoading = false;
//     notifyListeners();
//   }
// }


class MakePersonalRequestProvider extends ChangeNotifier {
  APIClient apiClient = APIClient(box: GetIt.instance<LocalDataSource>());
  NetworkInfo networkInfo = GetIt.instance<NetworkInfo>();

  MakePersonalRequestModel? _makePersonalRequestModel;
  MakePersonalRequestModel? get makePersonalRequestModel => _makePersonalRequestModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successMessage;
  String? get successMessage => _successMessage;

  Future<bool> makePersonalRequest({
    required int requestType,
    required String reason,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        _isLoading = true;
        _errorMessage = null;
        _successMessage = null;
        notifyListeners();

        final response = await apiClient.post(
          url: '/make_personal_request',
          params: {
            'request_type': requestType,
            'reason': reason,
            'start_date': DateFormat('yyyy-MM-dd').format(startDate),
            'end_date': DateFormat('yyyy-MM-dd').format(endDate),
          },
        );

        if (response.statusCode == 200) {
          _makePersonalRequestModel = MakePersonalRequestModel.fromJson(response.data);
          _successMessage = _makePersonalRequestModel?.messages.join(', ') ?? 'Request created successfully';
          debugPrint('Request created: $_successMessage');
          return true;
        } else {
          _errorMessage = 'Server error: ${response.statusCode} - ${response.data.toString()}';
          debugPrint('Failed to create personal request: ${response.statusCode}');
          debugPrint('Response data: ${response.data}');
          return false;
        }
      } catch (e) {
        _errorMessage = 'Error creating personal request: $e';
        debugPrint('Error creating personal request: $e');
        return false;
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    } else {
      _errorMessage = 'No internet connection';
      _isLoading = false;
      debugPrint('No internet connection');
      notifyListeners();
      return false;
    }
  }

  void reset() {
    _makePersonalRequestModel = null;
    _errorMessage = null;
    _successMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}