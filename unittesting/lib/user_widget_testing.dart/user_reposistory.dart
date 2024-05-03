import 'dart:convert';

import 'package:counterapp_unittesting/user_widget_testing.dart/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<List<User>> getUSer() async {
    final http.Response response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      final List<dynamic> userList = jsonDecode(response.body);

      return userList.map((e) => User.fromJson(e)).toList();
    } else {
         throw Exception("failed to fetch results");
    }
  }
}
