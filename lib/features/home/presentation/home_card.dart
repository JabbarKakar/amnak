import 'package:amnak/export.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.onTap,
  });
  final String title;
  final String imagePath;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  width: 150,
                  child: Image.asset(imagePath),
                ),
                Text(
                  title,
                  style: context.textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
