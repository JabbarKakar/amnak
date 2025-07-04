import 'package:amnak/export.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  const CustomDropdownFormField({
    super.key,
    required this.validator,
    required this.onChanged,
    this.hint,
    this.title,
    required this.items,
    this.initialItem,
  });
  final String? Function(T?) validator;
  final String? hint;
  final String? title;
  final List<T> items;
  final T? initialItem;
  final dynamic Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null) ...[
          Text(title!, style: Theme.of(context).textTheme.bodySmall),
          4.h.heightBox,
        ],
        CustomDropdown<T>(
          items: items,
          decoration: CustomDropdownDecoration(
            closedFillColor: Colors.transparent,
            closedBorder: Border.all(color: kPrimaryColor),
          ),
          hintBuilder: (context, _, item) => Text(
            hint ?? item.toString(),
          ),
          initialItem: initialItem,
          closedHeaderPadding: const EdgeInsets.all(16),
          validateOnChange: true,
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
