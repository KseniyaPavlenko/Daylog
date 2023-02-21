import 'package:daylog/pages/about/about_page.dart';
import 'package:daylog/pages/dashboard/dashboard_page.dart';
import 'package:daylog/pages/scheduler/sheduler_page.dart';
import 'package:daylog/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';

const _bottomBarIcons = [
  Icons.dashboard_outlined,
  Icons.date_range_outlined,
  Icons.info_outline,
  Icons.settings_applications_outlined,
];

const _bottomBarLabels = [
  'Dashboard',
  'Scheduler',
  'About',
  'Settings',
];

List<dynamic> screens = [
  const DashboardPage(),
  const SchedulerPage(),
  const AboutPage(),
  const SettingsPage(),
];

class HomeBottomBar extends StatelessWidget {
  HomeBottomBar({
    super.key,
    required this.currentPage,
    required this.onCahngePage,
  });

  final int currentPage;
  final void Function(int) onCahngePage;

  int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   _selectedIndex = index;
  // }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // fixedColor: Colors.red,
      backgroundColor: Colors.red,
      onTap: onCahngePage,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.brown[700],
      unselectedItemColor: Colors.brown[300],

      elevation: 0,

      items: List.generate(
        _bottomBarIcons.length,
        (index) {
          final icon = _bottomBarIcons[index];
          final label = _bottomBarLabels[index];
          return BottomNavigationBarItem(
            icon: Icon(icon),
            label: label,
          );
        },
      ),
    );
  }
}



// import 'package:flutter/material.dart';

// const _bottomBarIcons = [
//   Icons.dashboard_outlined,
//   Icons.date_range_outlined,
//   Icons.info_outline,
//   Icons.settings_applications_outlined,
// ];



//  const List<Widget> _widgetOptions = <Widget>[
//     Text(
//       'Index 0: Dashboard',
//     ),
//     Text(
//       'Index 1: Scheduler',
//     ),
//     Text(
//       'Index 2: Add',
//     ),
//     Text(
//       'Index 3: About',
//     ),
//     Text(
//       'Index 4: Settings',
//     ),
//   ];

// class HomeBottomBar extends StatelessWidget {
//    HomeBottomBar({
//     super.key,
//     required this.currentPage,
//     required this.onCahngePage,
//   });

//    final int currentPage = 0;
//  final void Function(int) onCahngePage;


//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       onTap: onCahngePage,
//       items: List.generate(
//         _bottomBarIcons.length,
//         (index) {
//           final icon = _bottomBarIcons[index];
//           return BottomNavigationBarItem(
//             icon: Icon(icon),
//           );
//         },
//       ),
//     );
//   }
// }
