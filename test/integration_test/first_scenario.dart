import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:daylog/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();
      const createAccBtnKey = Key('CreateAccButton');
      const backToLoginButton = Key('backToLogin');
      const usernameInputField = Key('UsernameInputFieldSignUp');
      const pwdInputField = Key('PasswordInputFieldSignUp');
      const usernameInputFieldLogin = Key('UsernameInputFieldLogin');
      const pwdInputFieldLogin = Key('PasswordInputFieldLogin');

      //tooltip: 'SignUpButton',
      //tooltip: 'LoginButton',

      // verify create account button
      expect(find.byKey(createAccBtnKey), findsOneWidget);

      // Finds the create account button to tap on.
      final Finder textB = find.byKey(createAccBtnKey);

      // Emulate a tap on the create account button.
      await tester.tap(textB);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the app logo.
      expect(find.text('Daily Planner'), findsOneWidget);

      // Enter username into the UsernameInputField.
      await tester.enterText(find.byKey(usernameInputField), 'testuser1');

      await tester.pumpAndSettle();

      // Enter password into the PasswordInputField.
      await tester.enterText(find.byKey(pwdInputField), '12345678');

      await tester.pumpAndSettle();

      // Finds the create signUp button to tap on.
      final Finder signUpBtn = find.byTooltip('SignUpButton');

      // Emulate a tap on the create account button.
      await tester.tap(signUpBtn);

      // Finds the create back to login button to tap on.
      final Finder backBth = find.byKey(backToLoginButton);

      // Emulate a tap on the back to login button.
      await tester.tap(backBth);

      // Enter username into the UsernameInputFieldLogin. (new user credentials)
      await tester.enterText(find.byKey(usernameInputFieldLogin), 'testuser1');

      await tester.pumpAndSettle();

      // Enter password into the PasswordInputFieldLogin. (new user credentials)
      await tester.enterText(find.byKey(pwdInputFieldLogin), '12345678');

      await tester.pumpAndSettle();

      // Finds the create login button to tap on.
      final Finder loginBtn = find.byTooltip('LoginButton');

      // Emulate a tap on the login button.
      await tester.tap(loginBtn);

      

    });
  });
}
