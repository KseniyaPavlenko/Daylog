import 'package:daylog/common/style/app_colors.dart';
import 'package:daylog/common/utils/context_utils.dart';
import 'package:daylog/pages/about/about_page.dart';
import 'package:daylog/pages/dashboard/dashboard_page.dart';
import 'package:daylog/pages/scheduler/scheduler_page.dart';
import 'package:daylog/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';

List<dynamic> screens = <dynamic>[
  const DashboardPage(),
  const SchedulerPage(),
  const AboutPage(),
  const SettingsPage(),
];
// List<dynamic> screens = <dynamic>[
//   const DashboardPage(),
//   const SchedulerPage(),
//   const AboutPage(),
//   const SettingsPage(),
// ];

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({
    super.key,
    required this.currentPage,
    required this.onChangePage, 
  });

  final int currentPage;
  final void Function(int) onChangePage;

 
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xFF3E2723)),
      child: Padding(
        padding: EdgeInsets.only(bottom: context.bottomPadding),
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            children: [
              _IconButton(
                key: const Key('dashboard_page_key'),
                icon: Icons.dashboard_outlined,
                label: 'Dashboard',
                isSelected: currentPage == 0,
                onTap: () => onChangePage(0),
              ),
              _IconButton(
                key: const Key('scheduler_page_key'),
                icon: Icons.date_range_outlined,
                label: 'Scheduler',
                isSelected: currentPage == 1,
                onTap: () => onChangePage(1),
              ),
              const Spacer(),
              _IconButton(
                key: const Key('about_page_key'),
                icon: Icons.info_outline,
                label: 'About',
                isSelected: currentPage == 2,
                onTap: () => onChangePage(2),
              ),
              _IconButton(
                key: const Key('settings_page_key'),
                icon: Icons.settings_applications_outlined,
                label: 'Settings',
                isSelected: currentPage == 3,
                onTap: () => onChangePage(3),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.lightBrown : AppColors.middleBrown,
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
