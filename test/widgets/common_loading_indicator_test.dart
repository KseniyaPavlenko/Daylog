import 'package:daylog/widgets/loading_indicator/common_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyWidget has a title and message', (tester) async {
    await tester.pumpWidget(const CommonLoadingIndicator(isLoading: true,
    child: CircularProgressIndicator(),));

    // final titleFinder = find.text('T');
    // final messageFinder = find.text('M');

    // expect(titleFinder, findsOneWidget);
    // expect(messageFinder, findsOneWidget);
  });
}
