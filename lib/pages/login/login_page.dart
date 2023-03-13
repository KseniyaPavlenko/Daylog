import 'package:daylog/common/route/router.dart';
import 'package:daylog/cubits/auth/auth_cubit.dart';
import 'package:daylog/cubits/auth/auth_state.dart';
import 'package:daylog/widgets/bottom_wave_clipper/bottom_wave_clipper.dart';
import 'package:daylog/widgets/build_logo/build_logo.dart';
import 'package:daylog/widgets/input_field/input_field.dart';
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

  void _onCreateAcc() {
    GoRouter.of(context).go(AppRouter.signUp);
  }

 

  

  // TODO(Kseniya): вынеси в отдельный файл в state less widget
  Widget _buildButtonLogin(String text, void Function() func) {
    return ElevatedButton(
      onPressed: _buttonIsEnabled ? _loginUser : null,
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

  // TODO(Kseniya): вынеси в отдельный файл в state less widget
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

  // TODO(Kseniya): вынеси в отдельный файл в state less widget
  Widget _form(String label, void Function() func) {
    // Сюда :)
    // final screenWidth = context.width;
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 20, top: 10),
          child: InputField(
            icon: Icon(Icons.email),
            hint: "Username",
            controller: _usernameController,
            obscure: false,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5),
          // TODO(Kseniya): больше двух параметров передавай по имени {}
          child: InputField(
           icon: Icon(Icons.lock),
            hint:"Password",
            controller: _passwordController,
            obscure:true,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 260),
          child: SizedBox(
            height: 40,
          
            // TODO(Kseniya): context.width
            // + можно вынести в переменную выше так как использует больше раза
           width: MediaQuery.of(context).size.width,
           

            child: _createAccButton(label, func),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SizedBox(
            height: 50,
            // TODO(Kseniya): context.width
            // + можно вынести в переменную выше так как использует больше раза
            width: MediaQuery.of(context).size.width,
            child: _buildButtonLogin(label, func),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (_, state) {
        if (state.isAuthorized ?? false) {
          _onLogin();
        }
      },
      builder: (_, state) {
        return CommonScaffold(
          backgroundColor: Theme.of(context).primaryColor,
          isLoading: state.isLoading,
          body: Column(
            children: <Widget>[
              // TODO(Kseniya): переделай в state less widget в отдельном файле
              BuildLogo(),
              SizedBox(height: 100),
              // TODO(Kseniya): переделай в state less widget в отдельном файле
              _form('LOGIN', _loginUser),
              BottomWave(),
            ],
          ),
        );
      },
    );
  }
}
// TODO: п11
//TODO: BottomWaveClipper


// BottomWaveClipper
