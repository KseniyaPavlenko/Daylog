import 'package:daylog/common/route/router.dart';
import 'package:daylog/common/style/app_colors.dart';
import 'package:daylog/widgets/default_app_bar/default_app_bar.dart';
import 'package:daylog/widgets/scaffold/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: Colors.black,
      appBar: const DefaultAppBar(
        title: 'DayLog App',
        backgroundColor: AppColors.darkRed2,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 200),
            child: Text(
              '       Welcome to "Daily Planner"! This app is designed to make your life easier. You can no longer fill your head with your affairs. You just need to open the application and perform a couple of actions. Now all your affairs will be stored in this application.            ',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  iconSize: 10,
                  onPressed: () {},
                  icon: Image.asset(
                    '/Users/kseniapavlenko/src/edu/demoApp/daylog/assets/wireframes/AppStore.png',
                    width: 200,
                    height: 200,
                  ),
                  tooltip: 'Will be ready soon',
                ),
                IconButton(
                  iconSize: 10,
                  onPressed: () => context.go(AppRouter.splash),
                  icon: Image.asset(
                    '/Users/kseniapavlenko/src/edu/demoApp/daylog/assets/wireframes/web2.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    '/Users/kseniapavlenko/src/edu/demoApp/daylog/assets/wireframes/PlayMarket.png',
                    width: 200,
                    height: 200,
                  ),
                  tooltip: 'Will be ready soon',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
