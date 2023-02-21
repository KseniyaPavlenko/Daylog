

import 'package:daylog/common/route/router.dart';
import 'package:daylog/pages/about/about_page.dart';
import 'package:daylog/pages/dashboard/dashboard_page.dart';
import 'package:daylog/pages/home/widgets/home_bottom_bar.dart';
import 'package:daylog/pages/scheduler/sheduler_page.dart';
import 'package:daylog/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final pages = <Widget>[
    const DashboardPage(),
    const SchedulerPage(),
    const AboutPage(),
    const SettingsPage(),
  ];

  static get title => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.brown[600],
      // extendBody: true,
      body: pages[index],
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.red,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.abc), label: '1'),
      //     BottomNavigationBarItem(icon: Icon(Icons.abc), label: '2'),
      //   ],
      // ),
      bottomNavigationBar: HomeBottomBar(
        currentPage: 0,
        onCahngePage: (int) {
          pages[index];
        },
      ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.brown[600],
        child: const Icon(Icons.add),
        onPressed: () => context.push(AppRouter.schedulerLog),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }
}
