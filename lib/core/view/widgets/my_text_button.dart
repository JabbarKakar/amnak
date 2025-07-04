import 'package:amnak/export.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    super.key,
    required this.text,
    this.onTap,
  });

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: context.textTheme.bodyMedium?.copyWith(color: kPrimaryColor),
      ),
    );
  }
}
