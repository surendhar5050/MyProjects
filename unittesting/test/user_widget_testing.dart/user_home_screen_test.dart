import 'package:counterapp_unittesting/user_widget_testing.dart/user_home_screen.dart';
import 'package:counterapp_unittesting/user_widget_testing.dart/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final List<User> users = [
    const User(id: 1, name: "Surendhar", email: "surendhar@gmai.com")
  ];

  Future<List<User>> getuser() async {
    return users;
  }

  testWidgets('Dispaly list of user  from api in show user  name and e-mail',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: UserScreen(
        users: getuser(),
      ),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();
    expect(
      find.byType(ListView),
      findsOneWidget,
    );
    expect(find.byType(ListTile), findsNWidgets(users.length));

    for (var element in users) {
      expect(find.text(element.name), findsOne);
      expect(find.text(element.email), findsOne);
    }
  });
}
