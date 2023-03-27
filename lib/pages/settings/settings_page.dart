import 'package:daylog/common/route/router.dart';
import 'package:daylog/common/style/app_colors.dart';
import 'package:daylog/cubits/auth/auth_cubit.dart';
import 'package:daylog/pages/settings/widgets/logout_button.dart';
import 'package:daylog/widgets/default_app_bar/default_app_bar.dart';
import 'package:daylog/widgets/scaffold/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  dynamic get _version => null;
  // get _version => null;

  dynamic get _buildNumber => null;
  // get _buildNumber => null;

  final String _text = "LOGOUT";

  void _toLogin() => context.go(AppRouter.login);

  void _onLogout() async {
    await context.read<AuthCubit>().logout();
    _toLogin();
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
              'Version: $_version',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                //color: Colors.white
              ),
            ),
            Text(
              'Build : $_buildNumber',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                // color: Colors.white
              ),
            ),
            LogoutButton(
              _text,
              onPressed: _onLogout,
            )
          ],
        ),
      ),
    );
  }
}
