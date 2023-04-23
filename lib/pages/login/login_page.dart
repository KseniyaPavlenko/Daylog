import 'package:daylog/common/route/router.dart';
import 'package:daylog/cubits/auth/auth_cubit.dart';
import 'package:daylog/cubits/auth/auth_state.dart';
import 'package:daylog/pages/login/widgets/login_form.dart';
import 'package:daylog/widgets/bottom_wave_clipper/bottom_wave_clipper.dart';
import 'package:daylog/widgets/build_logo/build_logo.dart';
import 'package:daylog/widgets/buttons/default_text_button.dart';
import 'package:daylog/widgets/scaffold/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _buttonIsEnabled = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_textControllerListener);
    _passwordController.addListener(_textControllerListener);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _textControllerListener() {
    setState(() {
      _buttonIsEnabled = _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  void _loginUser() {
    context.read<AuthCubit>().login(
          _usernameController.text,
          _passwordController.text,
        );
  }

  void _onLogin() {
    GoRouter.of(context).go(AppRouter.home);
  }

  void _toPinCode() {
    GoRouter.of(context).go(AppRouter.pinCode);
  }

  void _onCreateAcc() {
    GoRouter.of(context).go(AppRouter.signUp);
  }

  Widget _createAccButton() {
    return DefaultTextButton(
      onPressed: _onCreateAcc,
      text: 'Create account',
      key: const Key('CreateAccButton'),
    );
  }

  Widget _form(void Function() func) {
    return LoginForm(
      createAccButton: _createAccButton(),
      isEnabled: _buttonIsEnabled,
      loginUser: _loginUser,
      passwordController: _passwordController,
      usernameController: _usernameController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (_, state) {
        if (state.isAuthorized ?? false) {
          // _onLogin();
          _toPinCode();
        }
      },
      builder: (_, state) {
        return CommonScaffold(
          backgroundColor: Theme.of(context).primaryColor,
          isLoading: state.isLoading,
          body: Column(
            children: <Widget>[
              const BuildLogo(),
              const SizedBox(height: 100),
              _form(_loginUser),
              const BottomWave(),
            ],
          ),
        );
      },
    );
  }
}
