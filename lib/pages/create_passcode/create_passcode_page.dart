import 'dart:async';

import 'package:daylog/common/route/router.dart';
import 'package:daylog/common/route/router.dart';
import 'package:daylog/common/style/app_colors.dart';
import 'package:daylog/common/utils/secure_storage.dart';
import 'package:daylog/cubits/auth/auth_cubit.dart';
import 'package:daylog/widgets/loading_indicator/common_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';

class PinCodePage extends StatefulWidget {
  const PinCodePage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PassCode'),
        backgroundColor: AppColors.darkRed2,
      ),
      body: FutureBuilder(
          future: DaylogSecureStorage.getPinCodeHash(),
          builder: (context, snapshot) {
            final isNew = snapshot.data?.isEmpty ?? true;
            return CommonLoadingIndicator(
              isLoading: snapshot.connectionState != ConnectionState.done,
              child: PasscodeScreen(
                title: Text(
                  '${isNew ? 'Create' : 'Enter'} App Passcode',
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(color: AppColors.darkRed2, fontSize: 28),
                ),
                circleUIConfig: const CircleUIConfig(
                  borderColor: AppColors.darkRed2,
                  fillColor: AppColors.darkRed2,
                  circleSize: 30,
                ),
                keyboardUIConfig: const KeyboardUIConfig(
                  digitTextStyle: TextStyle(fontSize: 20),
                  digitFillColor: AppColors.darkRed2,
                  digitBorderWidth: 3,
                  primaryColor: AppColors.darkRed2,
                ),
                passwordEnteredCallback: (password) {
                  isNew
                      ? _onPasswordCreate(password)
                      : _onPasscodeEntered(password, snapshot.data!);
                },
                cancelButton: const SizedBox(),
                deleteButton: const Text(
                  'Delete',
                  style: TextStyle(fontSize: 16, color: AppColors.darkRed2),
                  semanticsLabel: 'Delete',
                ),
                shouldTriggerVerification: _verificationNotifier.stream,
                backgroundColor: AppColors.lightRed,
                isValidCallback: _onPasscodeCancelled,
                digits: const [
                  '一',
                  '二',
                  '三',
                  '四',
                  '五',
                  '六',
                  '七',
                  '八',
                  '九',
                  '零'
                ],
                passwordDigits: 6,
                bottomWidget: _buildPasscodeRestoreButton(),
              ),
            );
          }),
    );
  }

  _onPasscodeEntered(String password, String hash) {
    DaylogSecureStorage.encodePincode(password).then((hashPassword) {
      bool isValid = hashPassword == hash;
      _verificationNotifier.add(isValid);
      if (isValid) {
        setState(() {
          isAuthenticated = isValid;
        });
      }
    });
  }

  _onPasswordCreate(String password) {
    DaylogSecureStorage.setPinCode(password).then((_) {
      _verificationNotifier.add(true);
      setState(() {
        isAuthenticated = true;
      });
    });
  }

  _onPasscodeCancelled() {
    context.go(AppRouter.home);
  }

  void _toLogin() => context.go(AppRouter.login);

  void _logout() async {
    await context.read<AuthCubit>().logout();
    _toLogin();
  }

  void _resetPassword() async {
    await DaylogSecureStorage.deleteStorage();
    //TODO: delete session
    _logout();
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  _buildPasscodeRestoreButton() => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10.0, top: 20.0),
          child: TextButton(
            onPressed: _resetPassword,
            //  onPressed: _resetAppPassword,
            child: const Text(
              "Reset passcode",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
            // splashColor: Colors.white.withOpacity(0.4),
            // highlightColor: Colors.white.withOpacity(0.2),
            // ),
          ),
        ),
      );

  _resetAppPassword() {
    Navigator.maybePop(context).then((result) {
      if (!result) {
        return;
      }
      _showRestoreDialog(() {
        Navigator.maybePop(context);
        //TODO: Clear your stored passcode here
      });
    });
  }

  _showRestoreDialog(VoidCallback onAccepted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Reset passcode",
            style: TextStyle(color: Colors.black87),
          ),
          content: const Text(
            "Passcode reset is a non-secure operation!\n\nConsider removing all user data if this action performed.",
            style: TextStyle(color: Colors.black87),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
            TextButton(
              onPressed: onAccepted,
              child: const Text(
                "I understand",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }
}
