import 'package:daylog/common/route/router.dart';
import 'package:daylog/cubits/auth/auth_cubit.dart';
import 'package:daylog/pages/settings/widgets/logout_button.dart';
import 'package:daylog/widgets/scaffold/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  PackageInfo? packageInfo; // TODO(Kseniya): private

  get version => null; // TODO(Kseniya): private

  get buildNumber => null; // TODO(Kseniya): private

  String text = "LOGOUT"; // TODO(Kseniya): private + зачем это ?)

  // TODO(Kseniya): private
  void getPackage() async {
    packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo!.version;
    String buildNumber = packageInfo!.buildNumber;
  }

  void _onLogout() async {
    await context.read<AuthCubit>().logout();
    context.go(AppRouter.login);
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF3E2723),
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min, // TODO(Kseniya): удалить
          children: <Widget>[
            Text(
              'Version: $version',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                //color: Colors.white
              ),
            ),
            Text(
              'Build : $buildNumber',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                // color: Colors.white
              ),
            ),
            LogoutButton(
              text,
              onPressed: _onLogout,
            )
          ],
        ),
      ),
    );
  }
}
