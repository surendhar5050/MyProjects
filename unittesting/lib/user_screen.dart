import 'package:counterapp_unittesting/user.dart';
import 'package:counterapp_unittesting/user_resposisitory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("User detials"),
      ),
      body: FutureBuilder(
        future: USerReposistory(Client()).getUSer(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              var user = snapshot.data as User;
              return Center(
                child: Column(
                  children: [Text(user.name),Text(user.email),Text(user.phone),],
                ),
              );
            default:return const Center(
                child: Text("user not found"),
              );
          }
        },
      ),
    ));
  }
}
