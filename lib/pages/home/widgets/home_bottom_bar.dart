import 'package:daylog/common/utils/context_utils.dart';
import 'package:daylog/pages/about/about_page.dart';
import 'package:daylog/pages/dashboard/dashboard_page.dart';
import 'package:daylog/pages/scheduler/sheduler_page.dart';
import 'package:daylog/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';

List<dynamic> screens = [
  const DashboardPage(),
  const SchedulerPage(),
  const AboutPage(),
  const SettingsPage(),
];

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({
    super.key,
    required this.currentPage,
    required this.onCahngePage,
  });

  final int currentPage;
  final void Function(int) onCahngePage;

  // void _onItemTapped(int index) {
  //   _selectedIndex = index;
  // }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.red),
      child: Padding(
        padding: EdgeInsets.only(bottom: context.bottomPadding),
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            children: [
              _IconButton(
                icon: Icons.dashboard_outlined,
                label: 'Dashboard',
                isSelected: currentPage == 0,
                onTap: () => onCahngePage(0),
              ),
              _IconButton(
                icon: Icons.date_range_outlined,
                label: 'Scheduler',
                isSelected: currentPage == 1,
                onTap: () => onCahngePage(1),
              ),
              const Spacer(),
              _IconButton(
                icon: Icons.info_outline,
                label: 'About',
                isSelected: currentPage == 2,
                onTap: () => onCahngePage(2),
              ),
              _IconButton(
                icon: Icons.settings_applications_outlined,
                label: 'Settings',
                isSelected: currentPage == 3,
                onTap: () => onCahngePage(3),
              ),
            ],
          ),
        ),
      ),
    );

    // return Container(

    //   child: BottomNavigationBar(
    //     // fixedColor: Colors.red,
    //     backgroundColor: Colors.red,
    //     onTap: onCahngePage,
    //     currentIndex: currentPage,
    //     selectedItemColor: Colors.brown[700],
    //     unselectedItemColor: Colors.brown[300],

    //     elevation: 0,

    //     items: List.generate(
    //       _bottomBarIcons.length,
    //       (index) {
    //         final icon = _bottomBarIcons[index];
    //         final label = _bottomBarLabels[index];
    //         return BottomNavigationBarItem(
    //           icon: Icon(icon),
    //           label: label,
    //         );
    //       },
    //     ),
    //   ),
    //);
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
              color: isSelected ? Colors.green : Colors.yellow,
            ),
            Text(label),
          ],
        ),
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
