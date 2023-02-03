// ignore_for_file: deprecated_member_use, prefer_const_constructors, unused_local_variable

import 'package:daylog/pages/settings/widgets/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  PackageInfo? packageInfo;

  get version => null;

  get buildNumber => null;

  String text = "LOGOUT";
  void getPackage() async {
    packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo!.version;
    String buildNumber = packageInfo!.buildNumber;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Version: $version',
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'Build : $buildNumber',
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              LogoutButton(text)
            ],
          ),
        ),
      );
}
