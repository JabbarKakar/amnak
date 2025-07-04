import '../../../export.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: decideOnTheme(kLight, kDark, context: context),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(16), topEnd: Radius.circular(16)),
        ),
      ),
      child: child,
    );
  }
}
