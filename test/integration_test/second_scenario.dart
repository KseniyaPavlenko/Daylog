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

//DateSelectorWidget
const keyPreviousDay = Key('dateSelector_prev');
const keyNextDay = Key('dateSelector_next');
const dayText = Key('day');

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('second scenario', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      DateTime selectedDate = DateTime.now();
      String previousDay =
          selectedDate.subtract(const Duration(days: 1)).day.toString();
      selectedDate.add(const Duration(days: 1)).day.toString();

      //tooltip: 'SignUpButton',
      //tooltip: 'LoginButton',
      // tooltip: 'SchedulerLogButton',  +

      // verify username field button
      expect(find.byKey(usernameInputFieldLoginKey), findsOneWidget);
      // verify password field button
      expect(find.byKey(pwdInputFieldLoginKey), findsOneWidget);
      // Verify the app logo.
      expect(find.text('Daily Planner'), findsOneWidget);

      // Enter username into the UsernameInputField.
      await tester.enterText(
          find.byKey(usernameInputFieldLoginKey), 'new123456');

      await tester.pumpAndSettle();

      // Enter password into the PasswordInputField.
      await tester.enterText(find.byKey(pwdInputFieldLoginKey), '12345678');

      await tester.pumpAndSettle();

      // Finds the create Login button to tap on.
      final Finder loginBtn = find.byTooltip('LoginButton');

      // // Emulate a tap on the create account button.
      await tester.tap(loginBtn);

      await tester.pumpAndSettle();

      // await tester.pumpWidget(WidgetTest(
      //   child: DateSelectorWidget(
      //     date: selectedDate,
      //     onChange: (_) {},
      //   ),
      // ));

      await tester.tap(find.byKey(keyPreviousDay));

      await tester.pump();

      await tester.tap(find.byKey(keyNextDay));

      await tester.pump();

      await tester.tap(find.byKey(keyNextDay));

      await tester.pump();

      await tester.tap(find.byKey(keyNextDay));

      await tester.pump();

      // Finds the create SchedulerPage button to tap on.
      final Finder schedulerPageButton = find.byKey(schedulerPageKey);

      // Emulate a tap on the Scheduler page button.
      await tester.tap(schedulerPageButton);

      await tester.pumpAndSettle();

      // Finds the create Dashboard Page button to tap on.
      final Finder dashboardPageButton = find.byKey(dashboardPageKey);

      // Emulate a tap on the Dashboard Page button.
      await tester.tap(dashboardPageButton);

      await tester.pumpAndSettle();

      // Finds the create Settings Page button to tap on.
      final Finder settingsPageButton = find.byKey(settingsPageKey);

      // Emulate a tap on the Settings Page button.
      await tester.tap(settingsPageButton);

      await tester.pumpAndSettle();

      // Finds the create LogOut button to tap on.
      final Finder logoutButton = find.byKey(logoutButtonKey);
      // Emulate a tap on the LogOut button
      await tester.tap(logoutButton);

      await tester.pumpAndSettle();

      // // Finds the create About Page button to tap on.
      // final Finder aboutPageButton = find.byKey(aboutPageKey);

      // // Emulate a tap on the About Page button.
      // await tester.tap(aboutPageButton);

      // await tester.pumpAndSettle();

      // // Finds the create Settings Page button to tap on.
      // final Finder settingsPageButton = find.byKey(settingsPageKey);

      // // Emulate a tap on the Settings Page button.
      // await tester.tap(settingsPageButton);

      // await tester.pumpAndSettle();

      // // Emulate a tap on the Scheduler page button.
      // await tester.tap(schedulerPageButton);

      // await tester.pumpAndSettle();

      // // Finds the create SchedulerLog button (+) to tap on.
      // final Finder addButton = find.byTooltip('SchedulerLogButton');
      // // Emulate a tap on the Dashboard Page button.
      // await tester.tap(addButton);

      // await tester.pumpAndSettle();

      // // Enter title
      // await tester.enterText(
      //     find.byKey(enterTitleFieldSchedLod), 'Integration Test Title');

      // await tester.pumpAndSettle();

      // // Enter title
      // await tester.enterText(
      //     find.byKey(enterDetailsFieldSchedLod), 'Integration Test Details');

      // await tester.pumpAndSettle();

      // // Finds the create 'every day' to tap on.
      // final Finder everyDay = find.byKey(daySelectorEveryDaySchedLod);
      // // Emulate a tap on the 'every day'.
      // await tester.tap(everyDay);

      // await tester.pumpAndSettle();

      // // Finds the create save button to tap on.
      // final Finder saveBtnSchedulerLog =
      //     find.byKey(saveButtonSchedulerLogSchedLod);
      // // Emulate a tap on the save button
      // await tester.tap(saveBtnSchedulerLog);

      // await tester.pumpAndSettle();

      // // Emulate a tap on the Settings Page button.
      // await tester.tap(settingsPageButton);

      // await tester.pumpAndSettle();

      // // Finds the create LogOut button to tap on.
      // final Finder logoutButton = find.byKey(logoutButtonKey);
      // // Emulate a tap on the LogOut button
      // await tester.tap(logoutButton);

      // await tester.pumpAndSettle();
    });
  });
}
