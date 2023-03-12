import 'package:daylog/widgets/date_selector/date_selector_widget.dart';
import 'package:daylog/widgets/widget_test/widget_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DateTime selectedDate = DateTime.now();
  String previousDay =
      selectedDate.subtract(const Duration(days: 1)).day.toString();
  String nextDay = selectedDate.add(const Duration(days: 1)).day.toString();
  const keyPreviosDay = Key('dateSelector_prev');
  const keyNextDay = Key('dateSelector_next');
  const dayText = Key('day');

  testWidgets('Go to previous day', (tester) async {
    await tester.pumpWidget(WidgetTest(
      child: DateSelectorWidget(
        date: selectedDate,
        onChange: (_) {},
      ),
    ));

    await tester.tap(find.byKey(keyPreviosDay));

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
