// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:daylog/common/route/router.dart';
import 'package:daylog/common/utils/context_utils.dart';
import 'package:daylog/cubits/auth/auth_cubit.dart';
import 'package:daylog/cubits/auth/auth_state.dart';
import 'package:daylog/pages/login/widgets/bottom_wave.dart';
import 'package:daylog/widgets/loading_indicator/common_loading_indicator.dart';
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
      buttonIsEnabled = _usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty;
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

  void _onCreateAcc() {
    GoRouter.of(context).go(AppRouter.signUp);
  }

  Widget _buildLogo() {
    return Padding(
        padding: EdgeInsets.only(top: 100),
        child: Align(
          child: Text(
            'Daily Planner',
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ));
  }

  Widget _input(Icon icon, String hint, TextEditingController controller, bool obscure) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(fontSize: 20, color: Colors.white),
        decoration: InputDecoration(
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
            hintText: hint,
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 3)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54, width: 1)),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: IconTheme(
                data: IconThemeData(color: Colors.white),
                child: icon,
              ),
            )),
      ),
    );
  }

  Widget _buildButtonLogin(String text, void Function() func) {
    return ElevatedButton(
      onPressed: buttonIsEnabled ? _loginUser : null,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _createAccButton(String text, void Function() func) {
    return TextButton(
      child: Text(
        "Create account",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 15,
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed: _onCreateAcc,
    );
  }

  Widget _form(String label, void Function() func) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 20, top: 10),
          child: _input(
            Icon(Icons.email),
            "Username",
            _usernameController,
            false,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: _input(
            Icon(Icons.lock),
            "Password",
            _passwordController,
            true,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 260),
          child: SizedBox(height: 40, width: MediaQuery.of(context).size.width, child: _createAccButton(label, func)),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SizedBox(height: 50, width: MediaQuery.of(context).size.width, child: _buildButtonLogin(label, func)),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isAuthorized ?? false) {
          _onLogin();
        } else if (state.hasError) {
          context.showError(state.error!.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: CommonLoadingIndicator(
            isLoading: state.isLoading,
            child: Column(
              children: <Widget>[
                _buildLogo(),
                SizedBox(
                  height: 100,
                ),
                _form('LOGIN', _loginUser),
                BottomWave(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 5);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
