import 'package:daylog/common/route/router.dart';
import 'package:daylog/common/style/app_colors.dart';
import 'package:daylog/cubits/auth/auth_cubit.dart';
import 'package:daylog/pages/settings/widgets/logout_button.dart';
import 'package:daylog/widgets/default_app_bar/default_app_bar.dart';
import 'package:daylog/widgets/scaffold/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final String _text = "LOGOUT";
  String? _appName;
  // String? _packageName;
  String? _version;
  String? _buildNumber;

  void _toLogin() => context.go(AppRouter.login);

  void _onLogout() async {
    await context.read<AuthCubit>().logout();
    _toLogin();
  }

  Future<void> _getInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _appName = packageInfo.appName;
        // _packageName = packageInfo.packageName;
        _version = packageInfo.version;
        _buildNumber = packageInfo.buildNumber;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: const DefaultAppBar(
        title: 'Settings',
        backgroundColor: AppColors.darkRed2,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'App : $_appName',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Version: $_version',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Build : $_buildNumber',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            LogoutButton(
              key: const Key('LogoutButton'),
              _text,
              onPressed: _onLogout,
            )
          ],
        ),
      ),
    );
  }
}
