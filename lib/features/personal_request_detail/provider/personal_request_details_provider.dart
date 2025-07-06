

import 'package:amnak/core/api_client.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/personal_request_types/model/personal_request_type_model.dart';
import 'package:amnak/features/personal_request_detail/model/personal_request_detail_model.dart';
import 'package:get_it/get_it.dart';

import '../../../core/network/network_info.dart';

class PersonalRequestDetailProvider extends ChangeNotifier {
  APIClient apiClient = APIClient(box: GetIt.instance<LocalDataSource>());
  NetworkInfo networkInfo = GetIt.instance<NetworkInfo>();

  PersonalRequestDetailModel? _personalRequestDetailModel;
  PersonalRequestDetailModel? get personalRequestDetailModel => _personalRequestDetailModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchPersonalRequestDetail({required int id}) async {
    if (await networkInfo.isConnected) {
      try {
        _isLoading = true;
        notifyListeners();

        final response = await apiClient.get(
          url: '/personal_request_types/$id',
        );
        if (response.statusCode == 200) {
          _personalRequestDetailModel = PersonalRequestDetailModel.fromJson(response.data);
          if (_personalRequestDetailModel?.messages.isNotEmpty ?? false) {
            print('Messages in RequestDetails provider =====>>>>>: ${_personalRequestDetailModel?.messages}');
            print('Messages Messages in RequestDetails provider =====>>>>>: ${_personalRequestDetailModel!.data!.reason}');
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