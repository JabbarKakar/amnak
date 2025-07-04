import '../../../export.dart';

class SocialAuth extends StatelessWidget {
  const SocialAuth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Assets.imagesFb),
        24.w.widthBox,
        Image.asset(Assets.imagesApple),
        24.w.widthBox,
        Image.asset(Assets.imagesGoogle),
      ],
    );
  }
}
