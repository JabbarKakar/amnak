import 'package:amnak/core/feature/data/models/projects_wrapper.dart';
import 'package:amnak/core/feature/data/models/report_types.dart';
import 'package:amnak/core/view/widgets/custom_dropdown_field.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/features/projects/presentation/projects_cubit.dart';

import '../../../../../../export.dart';

class AddReportPage extends StatefulWidget {
  const AddReportPage({super.key, required this.project});
  final ProjectModel project;

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  final cubit = sl<ProjectsCubit>()..get();

  final GlobalKey<FormState> formKey = GlobalKey();
  final titleTextController = TextEditingController();
  final messageTextController = TextEditingController();
  String priority = 'Low';
  ReportTypeModel? selectedReportType;
  final ValueNotifier<List<ReportTypeModel>> reportTypes =
      ValueNotifier<List<ReportTypeModel>>([]);

  @override
  void initState() {
    super.initState();
    cubit.getReportTypes().then((r) => reportTypes.value = r ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      20.h.heightBox,
                      Text(
                        context.t.report,
                        style: context.textTheme.headlineMedium,
                      ),
                      20.h.heightBox,
                      ValueListenableBuilder<List<ReportTypeModel>>(
                        valueListenable: reportTypes,
                        builder: (p0, state, child) => state.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : CustomDropdownFormField<ReportTypeModel>(
                                hint: context.t.reportType,
                                validator: (value) =>
                                    value != null ? null : context.t.required,
                                onChanged: (value) =>
                                    selectedReportType = value,
                                items: state),
                      ),
                      20.h.heightBox,
                      CustomDropdownFormField<String>(
                          hint: context.t.priority,
                          validator: (value) =>
                              value != null ? null : context.t.required,
                          onChanged: (value) => priority = value!,
                          items: const ['Low', 'Medium', 'High']),
                      20.h.heightBox,
                      TextInput(
                        controller: titleTextController,
                        inputType: TextInputType.text,
                        hint: context.t.title,
                        validate: (value) =>
                            value!.isNotEmpty ? null : context.t.required,
                      ),
                      20.h.heightBox,
                      TextInput(
                        controller: messageTextController,
                        hint: context.t.message,
                        validate: (value) =>
                            value!.isNotEmpty ? null : context.t.required,
                      ),
                      20.h.heightBox,
                      RoundedCornerLoadingButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await cubit.addReport({
                              "report_type_id": selectedReportType!.id,
                              "project_id": widget.project.projectDetails?.id,
                              "title": titleTextController.text,
                              "priority": priority,
                              "message": messageTextController.text,
                              "latitude": widget.project.projectDetails
                                  ?.zoneCoordinates![0].lat,
                              "longitude": widget.project.projectDetails
                                  ?.zoneCoordinates![0].lng
                            });
                          }
                        },
                        text: context.t.save,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
