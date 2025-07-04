import '../../../export.dart';

class ResponsivePositioned extends StatelessWidget {
  const ResponsivePositioned(
      {super.key,
      required this.child,
      this.sidePadding = 8,
      this.top,
      this.bottom});

  final Widget child;
  final double? sidePadding;
  final double? top;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: isEn() ? sidePadding : null,
      left: isEn() ? null : sidePadding,
      top: top,
      bottom: bottom,
      child: child,
    );
  }
}
