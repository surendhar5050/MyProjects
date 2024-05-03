import 'package:counterapp_unittesting/user_widget_testing.dart/user_model.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {

  Future<List<User>> users;
   UserScreen({super.key,required this.users});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("user Details"),
      ),
      body: FutureBuilder(
        future: widget.users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<User> user = snapshot.data!;
            return ListView.builder(
            itemCount: user.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(user[index].name),
                  subtitle: Text(user[index].email),
                );
              },
            );
          } else if (snapshot.hasData) {
            return const Text("something wrong");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    ));
  }
}
