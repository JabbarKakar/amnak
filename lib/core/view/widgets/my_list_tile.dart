import 'package:amnak/export.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({
    super.key,
    this.leading,
    this.children,
    this.trailing,
    this.onTap,
  });

  final Widget? leading;
  final List<Widget>? children;
  final Widget? trailing;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          if (leading != null) leading!,
          8.w.widthBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children ?? [],
            ),
          ),
          8.w.widthBox,
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
