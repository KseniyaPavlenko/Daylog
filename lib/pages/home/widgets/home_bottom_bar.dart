import 'package:flutter/material.dart';

const _bottomBarIcons = [
  Icons.dashboard_outlined,
  Icons.date_range_outlined,
  Icons.info_outline,
  Icons.settings_applications_outlined,
];

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({
    super.key,
    required this.currentPage,
    required this.onCahngePage,
  });

  final int currentPage;
  final void Function(int) onCahngePage;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onCahngePage,
      items: [],
    );
  }
}
