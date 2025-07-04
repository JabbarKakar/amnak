import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/core/view/widgets/settings_tile.dart';
import 'package:amnak/export.dart';

class BackImageScaffold extends StatelessWidget {
  const BackImageScaffold({
    super.key,
    required this.child,
    this.backTopPadding = 90,
    this.hasBack = true,
  });
  final Widget child;
  final bool hasBack;
  final num backTopPadding;

  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Stack(
        children: [
          Image.asset(
            Assets.imagesLoginBook,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: decideOnTheme(
                  [kWhite.withOpacity(.15), kWhite, kWhite],
                  [kDark.withOpacity(.15), kDark, kDark],
                ),
              ),
            ),
          ),
          Column(
            children: [
              if (hasBack) (backTopPadding - 10).h.heightBox,
              Expanded(child: child),
            ],
          ),
          if (hasBack) MyBackButton(top: backTopPadding.h),
        ],
      ),
    );
  }
}
