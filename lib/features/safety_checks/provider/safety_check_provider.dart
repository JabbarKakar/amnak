

import 'package:amnak/core/api_client.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/safety_checks/model/safety_check_model.dart';
import 'package:get_it/get_it.dart';

import '../../../core/network/network_info.dart';

class SafetyCheckProvider extends ChangeNotifier {
  APIClient apiClient = APIClient(box: GetIt.instance<LocalDataSource>());
  NetworkInfo networkInfo = GetIt.instance<NetworkInfo>();

  SafetyCheckModel? _safetyCheckModel;
  SafetyCheckModel? get safetyCheckModel => _safetyCheckModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchSafetyCheck() async {
    if (await networkInfo.isConnected) {
      try {
        _isLoading = true;
        notifyListeners();

        final response = await apiClient.get(
          url: '/safety_check_items',
        );
        if (response.statusCode == 200) {
          _safetyCheckModel = SafetyCheckModel.fromJson(response.data);
          if (_safetyCheckModel?.messages.isNotEmpty ?? false) {
            print('Messages in RequestDetails provider =====>>>>>: ${_safetyCheckModel?.messages}');
            print('Messages Messages in RequestDetails provider =====>>>>>: ${_safetyCheckModel!.data[0].name}');
          }
        } else {

          throw Exception('Failed to load personal request types');
        }
      } catch (e) {
        print('Error fetching personal request types: $e');
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    } else {
      print('No internet connection');
    }
  }
}