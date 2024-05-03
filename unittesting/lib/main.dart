import 'package:counterapp_unittesting/user_widget_testing.dart/user_reposistory.dart';
import 'package:flutter/material.dart';

import 'user_widget_testing.dart/user_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const CounterApp(title: 'Flutter Demo Home Page'),

      home:   UserScreen(users: UserRepository().getUSer()),
    );
  }
}

