import 'package:amnak/core/api_client.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/employee_evaluation/model/employee_evaluation_model.dart';
import 'package:get_it/get_it.dart';

import '../../../core/network/network_info.dart';

class EmployeeEvaluationProvider extends ChangeNotifier {
  APIClient apiClient = APIClient(box: GetIt.instance<LocalDataSource>());
  NetworkInfo networkInfo = GetIt.instance<NetworkInfo>();

  EmployeeEvaluationWrapper? _employeeEvaluationWrapper;
  EmployeeEvaluationWrapper? get employeeEvaluationWrapper =>
      _employeeEvaluationWrapper;

  EmployeeEvaluationModel? _selectedEvaluation;
  EmployeeEvaluationModel? get selectedEvaluation => _selectedEvaluation;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingDetails = false;
  bool get isLoadingDetails => _isLoadingDetails;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _errorMessageDetails;
  String? get errorMessageDetails => _errorMessageDetails;

  Future<void> fetchEmployeeEvaluations() async {
    if (await networkInfo.isConnected) {
      try {
        _isLoading = true;
        _errorMessage = null;
        notifyListeners();

        final response = await apiClient.get(
          url: '/employee_evaluation',
        );

        if (response.statusCode == 200) {
          _employeeEvaluationWrapper =
              EmployeeEvaluationWrapper.fromJson(response.data);
          if (_employeeEvaluationWrapper?.messages?.isNotEmpty ?? false) {
            print(
                'Messages in EmployeeEvaluation provider =====>>>>>: ${_employeeEvaluationWrapper?.messages}');
          }
        } else {
          _errorMessage = 'Failed to load employee evaluations';
        }
      } catch (e) {
        print('Error fetching employee evaluations: $e');
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

  Future<void> fetchEvaluationDetails(int evaluationId) async {
    if (await networkInfo.isConnected) {
      try {
        _isLoadingDetails = true;
        _errorMessageDetails = null;
        notifyListeners();

        final response = await apiClient.get(
          url: '/evaluation/$evaluationId',
        );

        if (response.statusCode == 200) {
          // The details API returns a single evaluation object, not a wrapper
          _selectedEvaluation =
              EmployeeEvaluationModel.fromJson(response.data['data']);
          if (response.data['messages']?.isNotEmpty ?? false) {
            print(
                'Messages in Evaluation Details provider =====>>>>>: ${response.data['messages']}');
          }
        } else {
          _errorMessageDetails = 'Failed to load evaluation details';
        }
      } catch (e) {
        print('Error fetching evaluation details: $e');
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

  void clearSelectedEvaluation() {
    _selectedEvaluation = null;
    _errorMessageDetails = null;
    notifyListeners();
  }
}
