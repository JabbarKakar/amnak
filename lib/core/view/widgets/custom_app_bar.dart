import '../../../export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.searchList,
    this.searchController,
    this.hasNotifications,
  });

  final SearchController? searchController;
  final List? searchList;
  final bool? hasNotifications;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'assets/images/logo.png',
        width: 70,
        height: kToolbarHeight,
      ),
      actions: [
        if (hasNotifications ?? true)
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => context.pushNamed(Routes.notifications),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
