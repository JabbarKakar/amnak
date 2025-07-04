import 'package:amnak/export.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.item,
    this.radius,
    this.fontSize,
  });

  final String item;
  final double? radius;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 30,
      backgroundColor: kWhite,
      child: Text(
        item,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: fontSize,
            color: kPrimaryColor,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
