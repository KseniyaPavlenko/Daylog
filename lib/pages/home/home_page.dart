import 'package:daylog/common/route/router.dart';
import 'package:daylog/pages/about/about_page.dart';
import 'package:daylog/pages/dashboard/dashboard_page.dart';
import 'package:daylog/pages/home/widgets/home_bottom_bar.dart';
import 'package:daylog/pages/scheduler/scheduler_page.dart';
import 'package:daylog/pages/settings/settings_page.dart';
import 'package:daylog/widgets/scaffold/common_scaffold.dart';
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
  int _currentPage = 0;
  PageController? _pageController;

  final pages = <Widget>[
    const DashboardPage(),
    const SchedulerPage(),
    const AboutPage(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    setState(() => _currentPage = index);
    _pageController?.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _onPageChanged(int index) => setState(() => _currentPage = index);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: PageView.builder(
        itemCount: pages.length,
        itemBuilder: (_, index) => pages[index],
        onPageChanged: _onPageChanged,
        controller: _pageController,
      ),
      bottomBar: HomeBottomBar(
        currentPage: _currentPage,
        onChangePage: _onTap,
      ),
      floatButton: FloatingActionButton(
        onPressed: () => context.pushNamed(
          AppRouter.schedulerLogName,
          params: <String, String>{'id': "-1"},
        ),
        key: const Key('SchedulerLogButton'),
        tooltip: 'Create task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
