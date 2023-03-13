import 'package:daylog/widgets/date_selector/date_selector_widget.dart';
import 'package:daylog/widgets/widget_test/widget_test.dart';
import 'package:flutter/material.dart';

dynamic testWidget() {
//  testWidgets() {
  DateTime selectedDate = DateTime.now();
  String previousDay =
      selectedDate.subtract(const Duration(days: 1)).toString();
  String nextDay = selectedDate.add(const Duration(days: 1)).toString();
  const keyPreviosDay = Key('dateSelector_prev');
  const keyNextDay = Key('dateSelector_next');
  const dayText = Key('day');

  runApp(WidgetTest(
    child: DateSelectorWidget(
      date: selectedDate,
      onChange: (_) {},
    ),
  ));
}
