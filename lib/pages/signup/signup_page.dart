import 'package:daylog/common/route/router.dart';
import 'package:daylog/cubits/auth/auth_cubit.dart';
import 'package:daylog/cubits/auth/auth_state.dart';
import 'package:daylog/pages/signup/widgets/sign_up_form.dart';
import 'package:daylog/widgets/bottom_wave_clipper/bottom_wave_clipper.dart';
import 'package:daylog/widgets/build_logo/build_logo.dart';
import 'package:daylog/widgets/buttons/default_floating_action_button.dart';
import 'package:daylog/widgets/buttons/default_text_button.dart';
import 'package:daylog/widgets/loading_indicator/common_loading_indicator.dart';
import 'package:daylog/widgets/scaffold/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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

  void _signUpUser() {
    context.read<AuthCubit>().signUp(
          _usernameController.text,
          _passwordController.text,
        );
  }

  void _onLoginPage() => GoRouter.of(context).go(AppRouter.login);

  Widget _backToLoginButton() {
    return DefaultTextButton(
      onPressed: _onLoginPage,
      text: 'Already have an account? Login',
      key: const Key('backToLogin'),
    );
  }

  Widget _form(void Function() func) {
    return SignUpForm(
      usernameController: _usernameController,
      passwordController: _passwordController,
      isEnabled: _buttonIsEnabled,
      onSignUpTap: _signUpUser,
      backToLoginButton: _backToLoginButton(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state.isAuthorized ?? false) {
        context.go(AppRouter.home);
      }
    }, builder: (context_, state) {
      return CommonScaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: CommonLoadingIndicator(
          isLoading: state.isLoading,
          child: Column(
            children: <Widget>[
              const BuildLogo(),
              const SizedBox(height: 100),
              _form(_signUpUser),
              const BottomWave(),
            ],
          ),
        ),
      );
    });
  }
}
