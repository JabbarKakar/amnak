
import 'package:amnak/core/api_client.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/personal_request/model/personal_request_model.dart';
import 'package:get_it/get_it.dart';

import '../../../core/network/network_info.dart';

class PersonalRequestProvider extends ChangeNotifier {
  APIClient apiClient = APIClient(box: GetIt.instance<LocalDataSource>());
  NetworkInfo networkInfo = GetIt.instance<NetworkInfo>();

  PersonalRequestModel? _personalRequestModel;
  PersonalRequestModel? get personalRequestModel => _personalRequestModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPersonalRequest() async {
    if (await networkInfo.isConnected) {
      try {
        _isLoading = true;
        _errorMessage = null; // Reset error message
        notifyListeners();

        final response = await apiClient.get(url: '/personal_requests');
        if (response.statusCode == 200) {
          _personalRequestModel = PersonalRequestModel.fromJson(response.data);
          if (_personalRequestModel?.messages.isNotEmpty ?? false) {
            print('Messages =====>>>>>: ${_personalRequestModel?.messages}');
            print('Messages =====>>>>>: ${_personalRequestModel!.data.length}');
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
}