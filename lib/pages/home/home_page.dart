// ignore_for_file: camel_case_types, unused_element

import 'package:daylog/pages/about/about_page.dart';
import 'package:daylog/pages/dashboard/dashboard_page.dart';
import 'package:daylog/pages/scheduler/sheduler_page.dart';
import 'package:daylog/pages/scheduler_log/s%D1%81heduler_log_page.dart';
import 'package:daylog/pages/settings/settings_page.dart';
import 'package:daylog/widgets/tabbar_widget.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) => Scaffold(
        extendBody: true,
        body: pages[index],
        bottomNavigationBar: TabBarMaterialWidget(
          index: index,
          onChangedTab: onChangedTab,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: const Icon(Icons.add),
          onPressed: () {
            //context.pushNamed(AppRouter.schedulerLog);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SchedulerLogPage()));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );

  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }
}
