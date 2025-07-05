

import 'package:amnak/core/api_client.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/personal_request/model/model.dart';
import 'package:get_it/get_it.dart';

import '../../../core/network/network_info.dart';

class PersonalRequestProvider extends ChangeNotifier {
  APIClient apiClient = APIClient(box: GetIt.instance<LocalDataSource>());
  NetworkInfo networkInfo = GetIt.instance<NetworkInfo>();

  PersonalRequestTypeModel? _personalRequestTypeModel;
  PersonalRequestTypeModel? get personalRequestTypeModel => _personalRequestTypeModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchPersonalRequestTypes() async {
    if (await networkInfo.isConnected) {
      try {
        _isLoading = true;
        notifyListeners();

        final response = await apiClient.get(
          url: '/personal_requests_types',
        );
        if (response.statusCode == 200) {
          _personalRequestTypeModel = PersonalRequestTypeModel.fromJson(response.data);
          if (_personalRequestTypeModel?.messages.isNotEmpty ?? false) {
            print('Messages =====>>>>>: ${_personalRequestTypeModel?.messages}');
            print('Messages =====>>>>>: ${_personalRequestTypeModel!.data.length}');
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