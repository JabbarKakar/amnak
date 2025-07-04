import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../export.dart';

class NavPage extends StatelessWidget {
  const NavPage({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: FaIcon(
              FontAwesomeIcons.house,
              size: 24,
              color: kGreyShade,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.house,
              size: 24,
              color: kPrimaryColor,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: FaIcon(
              FontAwesomeIcons.message,
              size: 24,
              color: kGreyShade,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.message,
              size: 24,
              color: kPrimaryColor,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: FaIcon(
              FontAwesomeIcons.walkieTalkie,
              size: 24,
              color: kGreyShade,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.walkieTalkie,
              size: 24,
              color: kPrimaryColor,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: FaIcon(
              FontAwesomeIcons.person,
              size: 24,
              color: kGreyShade,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.person,
              size: 24,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
