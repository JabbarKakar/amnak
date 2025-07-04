import 'package:amnak/core/feature/data/models/projects_wrapper.dart';
import 'package:amnak/core/feature/data/models/report_types.dart';
import 'package:amnak/features/projects/domain/usecases/usecases.dart';

import '../../../../../../../export.dart';

class ProjectsCubit extends Cubit<BaseState<ProjectsWrapper>> {
  ProjectsCubit({
    required this.useCase,
  }) : super(const BaseState());
  final ProjectsUseCase useCase;

  Future get() async {
    emit(state.copyWith(status: RxStatus.loading));
    final response = await useCase.get();

    return response.fold((l) {
      emit(state.copyWith(status: RxStatus.error, errorMessage: l.message));
      showSimpleDialog(text: l.message.toString());
    }, (r) {
      if (r.data != null) {
        emit(state.copyWith(status: RxStatus.success, data: r));
      } else
        emit(state.copyWith(
            status: RxStatus.error, errorMessage: r.messages.toString()));
      return r;
    });
  }

  getAmbulancePhone() async {
    final response = await useCase.getAmbulancePhone();
    return response.fold((l) {
      showSimpleDialog(text: l.message.toString());
      return '';
    }, (r) {
      Logger().i(r.data);
      return r.data['ambulance_phone'];
    });
  }

  Future<List<ReportTypeModel>?> getReportTypes() async {
    final response = await useCase.getReportTypes();
    return response.fold((l) {
      showSimpleDialog(text: l.message.toString());
      return null;
    }, (r) {
      return r.data;
    });
  }

  Future addReport(Map data) async {
    final response = await useCase.addReport(data);
    return response.fold((l) {
      showSimpleDialog(text: l.message.toString());
    }, (r) {
      showSuccessSnack(message: navKey.currentContext!.t.success);
      return r;
    });
  }
}
