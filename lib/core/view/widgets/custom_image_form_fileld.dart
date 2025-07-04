import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:amnak/export.dart';

class CustomImageFormField extends StatefulWidget {
  const CustomImageFormField({
    super.key,
    required this.validator,
    required this.onChanged,
    required this.title,
    this.initialValue,
  });
  final String? Function(File?) validator;
  final String title;
  final String? initialValue;
  final Function(File) onChanged;

  @override
  State<CustomImageFormField> createState() => _CustomImageFormFieldState();
}

class _CustomImageFormFieldState extends State<CustomImageFormField> {
  File? _pickedFile;

  @override
  Widget build(BuildContext context) {
    return FormField<File?>(
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        builder: (formFieldState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(widget.title, style: Theme.of(context).textTheme.labelLarge),
              GestureDetector(
                onTap: () async {
                  FilePickerResult? file = await FilePicker.platform
                      .pickFiles(type: FileType.image, allowMultiple: false);
                  if (file != null) {
                    _pickedFile = File(file.files.first.path!);
                    widget.onChanged(_pickedFile!);
                    setState(() {});
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xff707070).withOpacity(0.1),
                  ),
                  child: _pickedFile != null
                      ? Row(
                          children: [
                            Image.file(
                              _pickedFile!,
                              height: 60,
                              width: 60,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            widget.initialValue != null
                                ? Image.network(
                                    widget.initialValue!,
                                    height: 60,
                                    width: 60,
                                  )
                                : const Icon(Icons.upload_file),
                            Text(context.t.idImage),
                          ],
                        ),
                ),
              ),
              if (formFieldState.hasError)
                Text(
                  formFieldState.errorText!,
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 13,
                      color: Colors.red[700],
                      height: 0.5),
                )
            ],
          );
        });
  }
}
