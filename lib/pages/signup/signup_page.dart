import 'package:daylog/common/route/router.dart';
import 'package:daylog/cubits/auth/auth_cubit.dart';
import 'package:daylog/cubits/auth/auth_state.dart';
import 'package:daylog/widgets/bottom_wave_clipper/bottom_wave_clipper.dart';
import 'package:daylog/widgets/build_logo/build_logo.dart';
import 'package:daylog/widgets/input_field/input_field.dart';
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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool buttonIsEnabled = false;

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
      buttonIsEnabled = _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  void _signUpUser() {
    context.read<AuthCubit>().signUp(
          _usernameController.text,
          _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state.isAuthorized ?? false) {
        context.go(AppRouter.home);
      }
    }, builder: (context, state) {
      return CommonScaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: CommonLoadingIndicator(
          isLoading: state.isLoading,
          child: Column(
            children: <Widget>[
              BuildLogo(),
              SizedBox(height: 100),
              _form('SIGN UP', _signUpUser),
              BottomWave(),
            ],
          ),
        ),
      );
    });
  }

// TODO(Kseniya): вынести в отдельный state less widget + именованные параметры
  Widget _button(String text, void Function() func) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
      ),
      tooltip: 'SignUpButton',
      onPressed: () => _signUpUser(),
    );
  }

// TODO(Kseniya): вынести в отдельный state less widget + именованные параметры
  Widget _backButton(String text, void Function() func) {
    return TextButton(
      key: Key('backToLogin'),
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).primaryColor,
      ),
      child: Text(
        text = "Already have an account? Login",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 15,
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed: _onBack,
    );
  }

  void _onBack() => GoRouter.of(context).go(AppRouter.login);

// TODO(Kseniya): вынести в отдельный state less widget + именованные параметры
  Widget _form(String label, void Function() func) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 20, top: 10),
          child: InputField(
            icon: Icon(Icons.email),
            hint: "Username",
            controller: _usernameController,
            obscure: false,
            key: Key('UsernameInputFieldSignUp'),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: InputField(
            icon: Icon(Icons.lock),
            hint: "Password",
            controller: _passwordController,
            obscure: true,
             key: Key('PasswordInputFieldSignUp'),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 150),
          child: SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: _backButton(label, func),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: _button(label, func),
          ),
        )
      ],
      //  BottomWaveClipper();
    );
  }
}


// BottomWaveClipper();
