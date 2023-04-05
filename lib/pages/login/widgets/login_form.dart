import 'package:daylog/widgets/buttons/default_floating_action_button.dart';
import 'package:daylog/widgets/input_field/input_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm(
      {Key? key,
      required this.usernameController,
      required this.passwordController,
      required this.createAccButton,
      required this.loginUser,
      required this.isEnabled})
      : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final Widget createAccButton;
  final VoidCallback loginUser;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: InputField(
              key: const Key('UsernameInputFieldLogin'),
              icon: const Icon(Icons.person_outline_sharp),
              hint: "Username",
              controller: usernameController,
              obscure: false,
            ),
          ),
        ),
        SizedBox(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: InputField(
              key: const Key('PasswordInputFieldLogin'),
              icon: const Icon(Icons.lock),
              hint: "Password",
              controller: passwordController,
              obscure: true,
            ),
          ),
        ),
        SizedBox(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.only(left: 260),
            child: SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: createAccButton,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: DefaultFloatingActionButton(
                onTap: loginUser,
                isEnabled: isEnabled,
                text: 'LOGIN',
                key: const Key('LoginButton'),
              ),
            ),
          ),
        )
      ],
    );
  }
}
