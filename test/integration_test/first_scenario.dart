import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:daylog/main.dart' as app;

const createAccBtnKey = Key('CreateAccButton');
const backToLoginButtonKey = Key('backToLogin');
const usernameInputFieldKey = Key('UsernameInputFieldSignUp');
const pwdInputFieldKey = Key('PasswordInputFieldSignUp');
const usernameInputFieldLoginKey = Key('UsernameInputFieldLogin');
const pwdInputFieldLoginKey = Key('PasswordInputFieldLogin');
const schedulerPageKey = Key('scheduler_page_key');
const dashboardPageKey = Key('dashboard_page_key');
const aboutPageKey = Key('about_page_key');
const settingsPageKey = Key('settings_page_key');
const logoutButtonKey = Key('LogoutButton');
const eventItemDashboardKey = Key('eventItem');

//ScheduleLog page
const enterTitleFieldSchedLod = Key('EnterTitleFieldSchedulerLog');
const enterDetailsFieldSchedLod = Key('EnterDetailsFieldSchedulerLog');
const chooseStartDateFieldSchedLod = Key('ChooseStartDateFieldSchedulerLog');
const chooseStartTimeFieldSchedLod = Key('ChooseStartTimeFieldSchedulerLog');
const chooseEndDateFieldSchedLod = Key('ChooseEndDateFieldSchedulerLog');
const daySelectorEveryDaySchedLod = Key('EveryDaySchedulerLog');
const saveButtonSchedulerLogSchedLod = Key('SchedulerLogSaveButton');

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('first scenario', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      //tooltip: 'SignUpButton',
      //tooltip: 'LoginButton',
      // tooltip: 'SchedulerLogButton',  +

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
      await tester.enterText(find.byKey(usernameInputFieldKey), 'new12345678');

      await tester.pumpAndSettle();

      // Enter password into the PasswordInputField.
      await tester.enterText(find.byKey(pwdInputFieldKey), '12345678');

      await tester.pumpAndSettle();

      // Finds the create signUp button to tap on.
      final Finder signUpBtn = find.byTooltip('SignUpButton');

      // // Emulate a tap on the create account button.
      await tester.tap(signUpBtn);

      await tester.pumpAndSettle();

      // // Verify the dashboard page.
      // expect(find.text('Dashboard'), findsOneWidget);

      // Finds the create SchedulerPage button to tap on.
      final Finder schedulerPageButton = find.byKey(schedulerPageKey);

      // Emulate a tap on the Scheduler page button.
      await tester.tap(schedulerPageButton);

      await tester.pumpAndSettle();
      // Finds the create About Page button to tap on.
      final Finder aboutPageButton = find.byKey(aboutPageKey);

      // Emulate a tap on the About Page button.
      await tester.tap(aboutPageButton);

      await tester.pumpAndSettle();

      // Finds the create Settings Page button to tap on.
      final Finder settingsPageButton = find.byKey(settingsPageKey);

      // Emulate a tap on the Settings Page button.
      await tester.tap(settingsPageButton);

      await tester.pumpAndSettle();

      // Finds the create Dashboard Page button to tap on.
      final Finder dashboardPageButton = find.byKey(dashboardPageKey);

      // Emulate a tap on the Dashboard Page button.
      await tester.tap(dashboardPageButton);

      await tester.pumpAndSettle();

      // Emulate a tap on the Scheduler page button.
      await tester.tap(schedulerPageButton);

      await tester.pumpAndSettle();

      // Finds the create SchedulerLog button (+) to tap on.
      final Finder addButton = find.byTooltip('SchedulerLogButton');
      // Emulate a tap on the Dashboard Page button.
      await tester.tap(addButton);

      await tester.pumpAndSettle();

      // Enter title
      await tester.enterText(
          find.byKey(enterTitleFieldSchedLod), 'Integration Test Title');

      await tester.pumpAndSettle();

      // Enter title
      await tester.enterText(
          find.byKey(enterDetailsFieldSchedLod), 'Integration Test Details');

      await tester.pumpAndSettle();

      // Finds the create 'every day' to tap on.
      final Finder everyDay = find.byKey(daySelectorEveryDaySchedLod);
      // Emulate a tap on the 'every day'.
      await tester.tap(everyDay);

      await tester.pumpAndSettle();

      // Finds the create save button to tap on.
      final Finder saveBtnSchedulerLog =
          find.byKey(saveButtonSchedulerLogSchedLod);
      // Emulate a tap on the save button
      await tester.tap(saveBtnSchedulerLog);

      await tester.pumpAndSettle();


      // Emulate a tap on the Settings Page button.
      await tester.tap(settingsPageButton);

      await tester.pumpAndSettle();


      // Finds the create LogOut button to tap on.
      final Finder logoutButton = find.byKey(logoutButtonKey);
      // Emulate a tap on the LogOut button
      await tester.tap(logoutButton);

      await tester.pumpAndSettle();

      // Finds the create event item on Dashboard page to tap on.
      //final Finder eventItemDashboard = find.byKey(eventItemDashboardKey);

      // Emulate a tap on the Dashboard Page button.
      //await tester.tap(eventItemDashboard);

      //await tester.pumpAndSettle();

      //
      //
      //
      //
      //
      //
      //
      //
      //
      //

      // // Finds the create back to login button to tap on.
      // final Finder backBth = find.byKey(backToLoginButton);

      // // Emulate a tap on the back to login button.
      // await tester.tap(backBth);

      // // Enter username into the UsernameInputFieldLogin. (new user credentials)
      // await tester.enterText(find.byKey(usernameInputFieldLogin), 'testuser1');

      // await tester.pumpAndSettle();

      // // Enter password into the PasswordInputFieldLogin. (new user credentials)
      // await tester.enterText(find.byKey(pwdInputFieldLogin), '12345678');

      // await tester.pumpAndSettle();

      // // Finds the create login button to tap on.
      // final Finder loginBtn = find.byTooltip('LoginButton');

      // // Emulate a tap on the login button.
      // await tester.tap(loginBtn);
    });
  });
}
