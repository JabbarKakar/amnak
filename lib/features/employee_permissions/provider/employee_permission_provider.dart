import 'package:amnak/core/api_client.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/employee_permissions/model/employee_permission_model.dart';
import 'package:get_it/get_it.dart';

import '../../../core/network/network_info.dart';

class EmployeePermissionProvider extends ChangeNotifier {
  APIClient apiClient = APIClient(box: GetIt.instance<LocalDataSource>());
  NetworkInfo networkInfo = GetIt.instance<NetworkInfo>();

  EmployeePermissionWrapper? _employeePermissionWrapper;
  EmployeePermissionWrapper? get employeePermissionWrapper =>
      _employeePermissionWrapper;

  EmployeePermissionModel? _selectedPermission;
  EmployeePermissionModel? get selectedPermission => _selectedPermission;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingDetails = false;
  bool get isLoadingDetails => _isLoadingDetails;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _errorMessageDetails;
  String? get errorMessageDetails => _errorMessageDetails;

  Future<void> fetchEmployeePermissions() async {
    if (await networkInfo.isConnected) {
      try {
        _isLoading = true;
        _errorMessage = null;
        notifyListeners();

        final response = await apiClient.get(
          url: '/employee_permissions',
        );

        if (response.statusCode == 200) {
          _employeePermissionWrapper =
              EmployeePermissionWrapper.fromJson(response.data);
          if (_employeePermissionWrapper?.messages?.isNotEmpty ?? false) {
            print(
                'Messages in EmployeePermission provider =====>>>>>: ${_employeePermissionWrapper?.messages}');
          }
        } else {
          _errorMessage = 'Failed to load employee permissions';
        }
      } catch (e) {
        print('Error fetching employee permissions: $e');
        _errorMessage = 'Error: ${e.toString()}';
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    } else {
      _errorMessage = 'No internet connection';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPermissionDetails(int permissionId) async {
    if (await networkInfo.isConnected) {
      try {
        _isLoadingDetails = true;
        _errorMessageDetails = null;
        notifyListeners();

        final response = await apiClient.get(
          url: '/employee_permission/$permissionId',
        );

        if (response.statusCode == 200) {
          // The details API returns a single permission object, not a wrapper
          _selectedPermission =
              EmployeePermissionModel.fromJson(response.data['data']);
          if (response.data['messages']?.isNotEmpty ?? false) {
            print(
                'Messages in Permission Details provider =====>>>>>: ${response.data['messages']}');
          }
        } else {
          _errorMessageDetails = 'Failed to load permission details';
        }
      } catch (e) {
        print('Error fetching permission details: $e');
        _errorMessageDetails = 'Error: ${e.toString()}';
      } finally {
        _isLoadingDetails = false;
        notifyListeners();
      }
    } else {
      _errorMessageDetails = 'No internet connection';
      _isLoadingDetails = false;
      notifyListeners();
    }
  }

  void clearSelectedPermission() {
    _selectedPermission = null;
    _errorMessageDetails = null;
    notifyListeners();
  }
}
