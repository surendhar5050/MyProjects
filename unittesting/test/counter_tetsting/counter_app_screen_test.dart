import 'package:counterapp_unittesting/counter_app/counter_app_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('when the counter is start the initial value of the text is 0',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: CounterApp(
      title: "Counter app",
    )));

    final finder = find.text('0');
    expect(finder, findsOneWidget);

final finder3 = find.byKey(Key("increment")); // Find by icon
    expect(finder3, findsNWidgets(1));

    await tester.tap(finder3);
    await tester.pump();

    final finder4 = find.text("1");

    expect(finder4, findsOneWidget);

    // final Finder =
  });
}
