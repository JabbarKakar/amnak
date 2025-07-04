import '../../../../export.dart';

class RowTextIcon extends StatelessWidget {
  const RowTextIcon({
    super.key,
    required this.text,
    required this.icon,
    this.iconColor,
    this.textColor,
  });

  final String text;
  final IconData icon;
  final Color? iconColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor ?? kPrimaryColor,
        ),
        6.widthBox,
        text.text
      ],
    );
  }
}
