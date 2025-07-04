import 'package:amnak/export.dart';

class SwitchTile extends StatelessWidget {
  const SwitchTile({
    super.key,
    required this.title,
    this.hasBottomDivider = true,
    this.onChanged,
    required this.value,
    this.titleColor,
  });

  final String title;
  final Color? titleColor;
  final bool value;
  final bool hasBottomDivider;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      dense: true,
      activeColor: kPrimaryColor,
      visualDensity: VisualDensity.compact,
      title: Text(
        title,
        style:
            Theme.of(context).textTheme.labelLarge?.copyWith(color: titleColor),
      ),
      onChanged: onChanged,
    );
  }
}
