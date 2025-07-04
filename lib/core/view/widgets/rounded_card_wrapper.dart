import '../../../export.dart';

class RoundedCardWrapper extends StatelessWidget {
  const RoundedCardWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(decoration: kRoundedAll, child: child);
  }
}
