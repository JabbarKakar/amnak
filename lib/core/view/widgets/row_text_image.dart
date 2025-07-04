import '../../../../export.dart';

class RowTextImage extends StatelessWidget {
  const RowTextImage({
    super.key,
    required this.text,
    required this.imagePath,
  });

  final String text;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          height: 20,
        ),
        6.widthBox,
        text.text
      ],
    );
  }
}
