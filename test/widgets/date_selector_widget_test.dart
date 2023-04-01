import 'package:daylog/widgets/date_selector/date_selector_widget.dart';
import 'package:daylog/widgets/widget_test/widget_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const keyPreviousDay = Key('dateSelector_prev');
const keyNextDay = Key('dateSelector_next');
const dayText = Key('day');
void main() {
  DateTime selectedDate = DateTime.now();
  String previousDay =
      selectedDate.subtract(const Duration(days: 1)).day.toString();
  selectedDate.add(const Duration(days: 1)).day.toString();

  testWidgets('Go to previous day', (tester) async {
    await tester.pumpWidget(WidgetTest(
      child: DateSelectorWidget(
        date: selectedDate,
        onChange: (_) {},
      ),
    ));

    await tester.tap(find.byKey(keyPreviousDay));

    await tester.pump();

    expect(find.text(previousDay), findsOneWidget);
  });

  testWidgets('MyWidget has a dayText and monthText', (tester) async {
    await tester.pumpWidget(WidgetTest(
      child: DateSelectorWidget(
        date: selectedDate,
        onChange: (_) {},
      ),
    ));

    final dayFinder = find.byKey(dayText);

    //final monthFinder = find.text('MAR');

    expect(dayFinder, findsOneWidget);

    // expect(monthFinder, findsOneWidget);
  });
}

//expect(AppRouter.home, findsOneWidget);
