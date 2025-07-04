import '../../../export.dart';

class RoundedCornerButton extends StatelessWidget {
  const RoundedCornerButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
    this.isOutlined = false,
    this.borderColor,
  });

  final Function() onPressed;
  final Color? color;
  final Color? borderColor;
  final Widget child;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: isOutlined
            ? ButtonStyle(
                surfaceTintColor:
                    MaterialStateProperty.all<Color>(color ?? Colors.white),
                backgroundColor:
                    MaterialStateProperty.all<Color>(color ?? Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: const BorderSide(color: kPrimaryColor),
                )))
            : ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(color ?? kPrimaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ))),
        onPressed: onPressed,
        child: child);
  }
}
