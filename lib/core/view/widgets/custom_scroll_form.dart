import '../../../export.dart';

//لما اكون عايز اخلي widget موجوده ف اخر الشاشه من تحت
// مع العلم ان انها بداخل SingleChildScrollView

class CustomScrollableForm extends StatelessWidget {
  const CustomScrollableForm({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverFillRemaining(
        hasScrollBody: false,
        child: child,
      )
    ]);
  }
}
