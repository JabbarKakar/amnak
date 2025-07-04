import '../../export.dart';

extension NumExtension on num {
  ///same as screenAwareHeight(4, context)
  ///EXAMPLE: 4.rh
  double get rh {
    double drawingHeight = MediaQuery.of(
          navKey.currentContext!,
        ).size.height -
        MediaQuery.of(
          navKey.currentContext!,
        ).padding.top;
    return this * drawingHeight / baseHeight;
  }

  double get rw {
    double drawingWidth = MediaQuery.of(
          navKey.currentContext!,
        ).size.width -
        16;
    return this * drawingWidth / baseWidth;
  }

  SizedBox get widthBox {
    return SizedBox(
      width: toDouble(),
      child: Container(),
    );
  }

  SizedBox get heightBox {
    return SizedBox(
      height: toDouble(),
      child: Container(),
    );
  }
}

extension NumToDouble on num? {
  double get toDouble => (this ?? 0).toDouble();
}
