import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../../../export.dart';

class ProfileImgPicker extends StatefulWidget {
  const ProfileImgPicker({
    super.key,
    this.url,
    this.isEditable = true,
    required this.onChange,
    this.radius = 100,
  });

  final String? url;
  final num radius;
  final Function(File) onChange;
  final bool isEditable;

  @override
  State<ProfileImgPicker> createState() => _ProfileImgPickerState();
}

class _ProfileImgPickerState extends State<ProfileImgPicker> {
  final pickedImg = ValueNotifier<File?>(null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !widget.isEditable
          ? null
          : () async {
              FilePickerResult? file = await FilePicker.platform
                  .pickFiles(type: FileType.image, allowMultiple: false);
              if (file != null) {
                File temp = File(file.files.first.path!);
                pickedImg.value = temp;
                widget.onChange(temp);
              }
            },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              ValueListenableBuilder<File?>(
                valueListenable: pickedImg,
                builder: (context, value, child) {
                  return value == null
                      ? Container(
                          width: widget.radius.toDouble(),
                          height: widget.radius.toDouble(),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              image: DecorationImage(
                                  image: NetworkImage(widget.url ?? ''),
                                  fit: BoxFit.fill,
                                  onError: (exception, stackTrace) =>
                                      Image.asset(
                                        Assets.imagesPersonal,
                                        fit: BoxFit.fill,
                                      ))),
                        )
                      : Container(
                          width: widget.radius.toDouble(),
                          height: widget.radius.toDouble(),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            image: DecorationImage(
                              image: FileImage(value),
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                },
              ).centered(),
              if (widget.isEditable)
                Positioned(
                  bottom: 0,
                  right: 6.w,
                  child: Image.asset(Assets.imagesEditIc),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
