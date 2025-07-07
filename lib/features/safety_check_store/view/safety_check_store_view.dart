import 'package:amnak/core/feature/data/models/projects_wrapper.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/features/projects/presentation/projects_cubit.dart';
import 'package:amnak/features/safety_check_store/components/custom_card.dart';
import 'package:amnak/features/safety_check_store/provider/safety_check_store_provider.dart';
import 'package:amnak/features/safety_checks/provider/safety_check_items_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

import '../../../export.dart';

class SafetyCheckStoreScreen extends StatefulWidget {
  const SafetyCheckStoreScreen({super.key});

  @override
  State<SafetyCheckStoreScreen> createState() => _SafetyCheckStoreScreenState();
}

class _SafetyCheckStoreScreenState extends State<SafetyCheckStoreScreen> {
  final List<Map<String, dynamic>> handledOptions = [
    {'display': 'Yes', 'value': '1'},
    {'display': 'No', 'value': '0'},
  ];

  int? selectedSafetyItemId;
  int? selectedProjectId;
  String? selectedHandled;
  final TextEditingController _notesController = TextEditingController();
  String? selectedMediaPath;

  final ProjectsCubit projectsCubit = GetIt.instance<ProjectsCubit>()..get();

  void _pickMedia() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'mp4'],
    );
    if (result != null) {
      setState(() {
        selectedMediaPath = result.files.single.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<SafetyCheckItemsProvider>(context, listen: false)
        .fetchSafetyCheck();
  }

  @override
  void dispose() {
    projectsCubit.close();
    _notesController.dispose();
    super.dispose();
  }

  void _submitSafetyCheck() async {
    // Validate inputs
    if (selectedSafetyItemId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a safety check item')),
      );
      return;
    }
    if (selectedProjectId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a project')),
      );
      return;
    }
    if (selectedHandled == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select if the safety check is handled')),
      );
      return;
    }
    if (_notesController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter notes')),
      );
      return;
    }
    if (selectedMediaPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image or video')),
      );
      return;
    }

    // Call the provider to submit the data
    final provider =
        Provider.of<SafetyCheckStoreProvider>(context, listen: false);
    await provider.fetchSafetyCheckDetails(
      safetyCheckItemId: selectedSafetyItemId!,
      projectId: selectedProjectId!,
      notes: _notesController.text.trim(),
      handled: selectedHandled!,
      mediaPath: selectedMediaPath,
    );

    // Handle the response
    if (provider.errorMessage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Safety check submitted successfully')),
      );
      // Optionally, reset the form
      setState(() {
        selectedSafetyItemId = null;
        selectedProjectId = null;
        selectedHandled = null;
        _notesController.clear();
        selectedMediaPath = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.errorMessage!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final safetyCheckProvider = Provider.of<SafetyCheckItemsProvider>(context);

    return LanguageDirection(
      child: Scaffold(
        appBar: AppBar(title: Text(context.t.safetyCheckStore), centerTitle: true),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Safety Check Items Dropdown
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Safety Check Item',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    safetyCheckProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : DropdownButtonFormField<int>(
                      isDense: true,
                      isExpanded: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            value: selectedSafetyItemId,
                            hint: const Text('Choose an item'),
                            items: safetyCheckProvider.safetyCheckModel?.data
                                    .where((item) =>
                                        item.id != null && item.name != null)
                                    .map((item) {
                                  return DropdownMenuItem<int>(
                                    value: item.id!,
                                    child: Text(item.name!),
                                  );
                                }).toList() ??
                                [],
                            onChanged: (value) {
                              setState(() {
                                selectedSafetyItemId = value;
                              });
                            },
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Project Dropdown
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Project',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<ProjectsCubit, BaseState<ProjectsWrapper>>(
                      bloc: projectsCubit,
                      builder: (context, state) {
                        if (state.status == RxStatus.loading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state.status == RxStatus.error) {
                          return Column(
                            children: [
                              Text(
                                state.errorMessage ??
                                    'Failed to to load projects',
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => projectsCubit.get(),
                                child: const Text('Retry'),
                              ),
                            ],
                          );
                        } else if (state.status == RxStatus.success &&
                            state.data?.data != null) {
                          return DropdownButtonFormField<int>(
                            isDense: true,
                            isExpanded: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            value: selectedProjectId,
                            hint: const Text('Choose a project'),
                            items: state.data!.data!
                                .where((project) =>
                                    project.projectDetails?.id != null &&
                                    project.projectDetails?.name != null)
                                .map((project) {
                              return DropdownMenuItem<int>(
                                value: project.projectDetails!.id!,
                                child: Text(project.projectDetails!.name!),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedProjectId = value;
                              });
                            },
                          );
                        }
                        return const Text('No projects available');
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Handled Dropdown
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Safety Check Handled',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      isDense: true,
                      isExpanded: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      value: selectedHandled,
                      hint: const Text('Choose an option'),
                      items: handledOptions.map((option) {
                        return DropdownMenuItem<String>(
                          value: option['value'] as String,
                          child: Text(option['display'] as String),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedHandled = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Notes TextField
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Notes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _notesController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Enter your notes here...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Image/Video Selection
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Image/Video Selection',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectedMediaPath ?? 'No media selected',
                            style: TextStyle(
                              color: selectedMediaPath != null
                                  ? Colors.black87
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _pickMedia,
                          icon: const Icon(Icons.upload_file),
                          label: const Text('Select Media'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              Center(
                child: Consumer<SafetyCheckStoreProvider>(
                  builder: (context, provider, child) {
                    return ElevatedButton(
                      onPressed: provider.isLoading ? null : _submitSafetyCheck,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: provider.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
