import 'package:amnak/export.dart';

class ValidButton extends StatelessWidget {
  const ValidButton({
    super.key,
    required this.isValid,
    required this.text,
    required this.onPressed,
  });

  final ValueNotifier<bool> isValid;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isValid,
      builder: (context, value, child) {
        return RoundedCornerLoadingButton(
          isOutlined: !isValid.value,
          onPressed: isValid.value ? onPressed : null,
          text: text,
        );
      },
    );
  }
}
