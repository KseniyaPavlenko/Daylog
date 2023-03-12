import 'package:daylog/widgets/buttons/default_floating_action_button.dart';
import 'package:daylog/widgets/input_field/input_field.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.backToLoginButton,
    required this.onSignUpTap,
    required this.isEnabled,
  }) : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final Widget backToLoginButton;
  final VoidCallback onSignUpTap;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 10),
          child: InputField(
            icon: const Icon(Icons.email),
            hint: "Username",
            controller: usernameController,
            obscure: false,
            key: const Key('UsernameInputFieldSignUp'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: InputField(
            icon: const Icon(Icons.lock),
            hint: "Password",
            controller: passwordController,
            obscure: true,
            key: const Key('PasswordInputFieldSignUp'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 150),
          child: SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: backToLoginButton,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: DefaultFloatingActionButton(
              isEnabled: isEnabled,
              onTap: onSignUpTap,
              text: 'SIGN UP',
              tooltip: 'SignUpButton',
            ),
          ),
        )
      ],
    );
  }
}
